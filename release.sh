git tag $(echo release-$(date '+%Y-%m-%dT%H-%M'))
git push
git push --tags
