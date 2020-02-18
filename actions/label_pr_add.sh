#!/bin/bash
set -e

label_pr_add() {


    if [[ -z "${ADD_LABEL}" ]]; then
      echo "Set the ADD_LABEL env variable."
      exit 1
    fi

    echo "This action will add the label ${ADD_LABEL} to the PR ${number}"

    local response=$(curl -sSL \
        -H "${AUTH_HEADER}" \
        -H "${API_HEADER}" \
        -X POST \
        -H "Content-Type: application/json" \
        -d "{\"labels\":[\"${ADD_LABEL}\"]}" \
        "${URI}/repos/${GITHUB_REPOSITORY}/issues/${number}/labels")

    echo "response: ${response}"

}