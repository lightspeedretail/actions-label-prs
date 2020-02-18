#!/bin/bash
set -e


label_pr_when_approved() {
    echo "This action will label a PR when approved"

    if [[ -z "${ADD_LABEL}" ]]; then
      echo "Set the ADD_LABEL or the LABEL_NAME env variable."
      exit 1
    fi

    echo "::set-output name=isApproved::false"
    if [[ "${state}" == "approved" ]]; then

        body=$(curl -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" "${URI}/repos/${GITHUB_REPOSITORY}/pulls/${number}/reviews?per_page=100")
        reviews=$(echo "$body" | jq --raw-output '.[] | {state: .state} | @base64')

        approvals=0

        for r in ${reviews}; do
          review="$(echo "$r" | base64 -d)"
          rState=$(echo "${review}" | jq --raw-output '.state')

          if [[ "$rState" == "APPROVED" ]]; then
            approvals=$((approvals+1))
          fi

          echo "${approvals}/${APPROVALS} approvals"

          if [[ "${approvals}" == "${APPROVALS}" ]]; then
            echo "Labeling pull request"

            local response=$(curl -sSL \
              -H "${AUTH_HEADER}" \
              -H "${API_HEADER}" \
              -X POST \
              -H "Content-Type: application/json" \
              -d "{\"labels\":[\"${ADD_LABEL}\"]}" \
              "${URI}/repos/${GITHUB_REPOSITORY}/issues/${number}/labels")

             echo "response: ${response}"
             echo "::set-output name=isApproved::true"
            break
          fi
        done

        time=$(date)
        echo "::set-output name=time::${time}"
    else
        echo "Ignoring event ${action} ${state}"
    fi
}