#!/bin/bash
#
# This shell script will download both the regular and mirrored clones
# of the given Git repository, create the delta between the two
# and scan it for secrets using gitleaks.
#
# Usage:
#   ./gitbleed.sh [git url] [directory]
#
# For example:
#   ./gitbleed.sh https://github.com/nightwatchcybersecurity/gitbleed_tools.git
#

echo Processing $1 into directory $2
mkdir -p $2
cd $2

echo
echo Cloning repo...
if [[ -d clone/ ]]; then
  echo "--- Already cloned, skipping"
else
  git clone $1 clone/
fi

echo
echo Cloning mirror
if [[ -d "mirror/" ]]; then
  echo "--- Already mirrored, skipping"
else
  git clone --mirror $1 mirror/
fi

echo
echo Copying mirror before trimming
if [[ -d delta/ ]]; then
  echo "--- Already trimmed, skipping"
else
  cp -R mirror/ delta/
fi

echo
echo Extracting list of commits from clone
if [[ -f "clone_hashes.txt" ]] || [[ -f "clone_hashes.done.txt" ]]; then
  echo "-- Already extracted, skipping"
else
  cd clone
  git rev-list --objects --all --no-object-names >../clone_hashes.txt
  cd ..
fi

echo
echo Deleting clone commits from mirror
if [[ -f "clone_hashes.done.txt" ]]; then
  echo "-- Already deleted, skipping"
else
  cd delta
  git filter-repo --strip-blobs-with-ids ../clone_hashes.txt
  mv ../clone_hashes.txt ../clone_hashes.done.txt
  cd ..
fi

echo
echo Run GitLeaks to check for secrets
if [[ -f "gitleaks.json" ]]; then
  echo "-- Already checked, skipping"
else
  cd delta
  gitleaks detect -v -r ../gitleaks.json
  cd ..
fi

echo
echo Run git log to extract all commits
if [[ -f "gitlog.txt" ]]; then
  echo "-- Already ran, skipping"
else
  cd delta
  git log --graph --all -p >../gitlog.txt
  cd ..
fi

echo
echo Done!
