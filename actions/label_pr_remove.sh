#!/bin/bash
set -e

label_pr_remove() {

    if [[ -z "${REMOVE_LABEL}" ]]; then
      echo "Set the REMOVE_LABEL env variable."
      exit 1
    fi

    echo "This action will remove the label ${REMOVE_LABEL} of the PR ${number}, if it exists."

    local status=$(curl -sSL \
      -H "${AUTH_HEADER}" \
      -H "${API_HEADER}" \
      -X DELETE \
      "${URI}/repos/${GITHUB_REPOSITORY}/issues/${number}/labels/${REMOVE_LABEL}")

     echo "response: ${status}"

}