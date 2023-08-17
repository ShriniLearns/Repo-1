set -e

REPO_OWNER=$1
REPO_NAME=$2
REPO_TOKEN=$3

Print_Message(){
echo "BAT Cycle is running"
}

wait_in_seconds() {
  echo "Sleeping for "20" seconds"
  sleep 20
}

upload_artifacts(){
  echo "Report Name is : $1"
  curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $REPO_TOKEN"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/repos/ShriniLearns/GHA-GitHubActions/actions/workflows/upload_artifact.yml/dispatches \
  -d '{"ref":"main","inputs":{"reportName":"'"$1"'"}}'
}

wait_for_work_flow_to_complete() {
  workflow_conclusion=null
  workflow_status=null
  while [[ "$workflow_conclusion" == "null" && "$workflow_status" != "completed" ]]; do
    workflow_id=$(get_workflow_id)
    workflow_conclusion=$(get_workflow_conclusion "$workflow_id")
    workflow_status=$(get_workflow_status "$workflow_id")
    echo "Work flow id is : $workflow_id"
    echo "Checking the work flow conclusion is : $workflow_conclusion"
    echo "Checking the work flow status is : $workflow_status"
    wait_in_seconds "20"
  done

  if [[ "$workflow_conclusion" == "success" && "$workflow_status" == "completed" ]]; then
    echo "The workflow execution is $workflow_conclusion & promoting the build to QA."
  else
    echo "Work flow is not finished and the conclusion is : $workflow_conclusion"
  fi
}

wait_for_work_flow_to_complete
