#!/bin/bash

#This script is to fetch the repos from command line interface
#
#
#owner: Tarakananda
#

#helper()

#GitHub API Url

API_URL="https://api.github.com"

#GitHub user name and personal acees tokens (Not HardCoded)
#
USERNAME=$username
TOKEN=$token

#User and repository information

REPO_OWNER=$1
REPO_NAME=$2


function git_api_allocator {
	local endpoint="$1"
	local url="${API_URL}/${endpoint}"
	curl -s -u "{USERNAME}:${TOKEN}" "$url"
}

function checking_users_with_read_access {
	local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
	collaborators="$(git_api_allocator "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"
	if [[ -z "$collaborators" ]]; then
		echo "No Users with read access found"
	else
		echo "Users with read access are mentioned below"
		echo "$collaborators"
	fi
}

checking_users_with_read_access
