upload_artifacts(){
  echo "Report Name is : $1"
  curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer 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"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/repos/ShriniLearns/GHA-GitHubActions/actions/workflows/upload_artifact.yml/dispatches \
  -d '{"ref":"main","inputs":{"reportName":"'"$1"'"}}'
}
