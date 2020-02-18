# actions-label-prs

This github actions allows you to add labels to your prs based on the number of pr reviews or simple add or remove a given label.

Usage:

The action has one argument `task` that defines the action to be done. The values allowed are 
- `label_pr_add`
- `label_pr_remove`
- `label_pr_when_approved`

## label_pr_add
This GitHub Action applies a label of your choice to a pull requests.

The action requires one environment variables – the label name to add `ADD_LABEL`.

``` yaml
name: Actions when a PR is open
on:
  pull_request:
    types: [opened, reopened]

jobs:
  label_pr_when_open:
    runs-on: ubuntu-latest
    name: Add the ready label when a pr is open
    steps:
      - name: Label a pr when opened
        id: approved
        uses: lightspeedretail/actions-label-prs@v1
        with:
          task: 'label_pr_add'
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          ADD_LABEL: "ready for review"
```

## label_pr_remove
This GitHub Action removes a label of your choice in a pull requests, if it exists.

The action requires one environment variables – the label name to remove `REMOVE_LABEL`.

``` yaml
name: Label prs based on reviews
on: 
  pull_request_review:
    types: [dismissed]

jobs:
  label_pr_when_dismissed:
    - name: Remove the approved label
        id: remove_label_approved
        uses: lightspeedretail/actions-label-prs@v1
        with:
          task: 'label_pr_remove'
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          REMOVE_LABEL: "approved"
```

## label_pr_when_approved

This GitHub Action applies a label of your choice to pull requests that reach a specified number of approvals.

The action requires two environment variables – the label name to add `ADD_LABEL` and the number of required approvals `APPROVALS`.

``` yaml
name: Label prs based on reviews
on: [pull_request_review, pull_request_review_comment]

jobs:
  label_pr_when_approved:
    runs-on: ubuntu-latest
    name: A job to label prs according with approvals
    steps:
      - name: Label a pr when approved
        id: approved
        uses: lightspeedretail/actions-label-prs@v1
        with:
          task: 'label_pr_when_approved'
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          APPROVALS: "1"
          ADD_LABEL: "approved"
```