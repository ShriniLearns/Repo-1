set -e

REPO_OWNER=$1
REPO_NAME=$2
REPO_TOKEN=$3

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
