#!/bin/bash

# Check for required environment argument
if [[ -z "$1" ]]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

env="$1"

# Use fzf to select a service, then describe that service
service_name=$(aws ecs list-services --cluster "$env" --no-cli-pager \
  | sed -n 's/^.*service\/'"$env"'\/\(.*\)\".*/\1/p' \
  | fzf --header "Select ECS service in $env environment" --layout=reverse)

# Exit if no selection was made
if [[ -z "$service_name" ]]; then
  echo "No service selected."
  exit 1
fi

# Get service description JSON
service_json=$(aws ecs describe-services --cluster "$env" --services "$service_name")

# Extract rollout state and updatedAt of the PRIMARY deployment
rollout_state=$(echo "$service_json" | jq -r '.services[0].deployments[] | select(.status == "PRIMARY") | .rolloutState')
updated_at_raw=$(echo "$service_json" | jq -r '.services[0].deployments[] | select(.status == "PRIMARY") | .updatedAt')

# Preprocess timestamp to remove fractional seconds and colon in timezone
clean_timestamp=$(echo "$updated_at_raw" | sed -E 's/\.[0-9]+//' | sed -E 's/:(..)$/\1/')

# Format date (macOS / BSD date)
updated_at_fmt=$(date -j -f "%Y-%m-%dT%H:%M:%S%z" "$clean_timestamp" "+%Y-%m-%d %H:%M:%S %Z")

# Final output
echo "Latest deployment rollout state for $service_name in $env: $rollout_state"
echo "Last updated at: $updated_at_fmt"

if [[ "$rollout_state" == "COMPLETED" ]]; then
  echo "✅ Deployment completed successfully."
else
  echo "⚠️ Deployment is still in progress or failed: $rollout_state"
fi
