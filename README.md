<img src="/gitbleed_icon.png" width="200" alt="logo"/>

# GitBleed Tools - for extracting data from mirrorred git repositories
## About
This repositories includes shell scripts that can be used to download and analyze differences between cloned and mirror Git repositories. For more information about the underlying quirk in Git behavior, please visit [read our blog post](TBD).

## What Do These Scripts Do? 
These scripts will clone a copy of the given Git repository, both as regular clone and mirrored ("--mirror") option. It will then create a delta between the two, seeking to find the parts of the repository that are only available in mirror mode. Last, gitleaks will be run to see if any secrets are present in the delta portion, and "git log" will be used to create a single file containing the bodies of the commits so they can be analyzed easier.

Please note that since this script creates three copies of the repository, it may consume a lot of disk space.

## Requirements
You will need [Git](https://git-scm.com/), [Python 3](https://www.python.org/). [GitLeaks](https://github.com/zricethezav/gitleaks) and [git-filter-repo](https://github.com/newren/git-filter-repo) to be installed. Here is an example of installing these on MacOS:
```
brew install git python3 gitleaks git-filter-repo
```

## How to Install and Run
You can run this againt a repository as follows:
```
git clone https://github.com/nightwatchcybersecurity/gitbleed_tools.git
cd gitbleed_tools
./gitbleed.sh https://github.com/nightwatchcybersecurity/gitbleed_tools.git example
```
This will create an example folder containing three subfolders:
   * clone - contains the cloned repository
   * delta - contains the mirrrored repository minus all of the commits in the "clone"
   * mirror - contains the mirrored repository cloned with the "--mirror" option

There are also three files created:
   * clone_hashes.done.txt - list of hashes in the cloned repository
   * gitleaks.json - results from running gitleaks
   * gitlog.txt - all commits from the delta folder concatenated into a single file

# Development Information

## Reporting bugs and feature requests
Please use the GitHub issue tracker to report issues or suggest features:
https://github.com/nightwatchcybersecurity/gitbleed_tools

You can also send emai to ***research /at/ nightwatchcybersecurity [dot] com***

## Wishlist
- TBD
