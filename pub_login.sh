# This script creates/updates credentials.json file which is used
# to authorize publisher when publishing packages to pub.dev

WriteToXdgConfigHome(){
cat <<EOF > "$XDG_CONFIG_HOME"/dart/pub-credentials.json
{
  "accessToken":"${PUB_DEV_PUBLISH_ACCESS_TOKEN}",
  "refreshToken":"${PUB_DEV_PUBLISH_REFRESH_TOKEN}",
  "tokenEndpoint":"${PUB_DEV_PUBLISH_TOKEN_ENDPOINT}",
  "scopes":["https://www.googleapis.com/auth/userinfo.email","openid"],
  "expiration":${PUB_DEV_PUBLISH_EXPIRATION}
}
EOF
}

WriteToHome(){
cat <<EOF > "$HOME"/.config/dart/pub-credentials.json
{
  "accessToken":"${PUB_DEV_PUBLISH_ACCESS_TOKEN}",
  "refreshToken":"${PUB_DEV_PUBLISH_REFRESH_TOKEN}",
  "tokenEndpoint":"${PUB_DEV_PUBLISH_TOKEN_ENDPOINT}",
  "scopes":["https://www.googleapis.com/auth/userinfo.email","openid"],
  "expiration":${PUB_DEV_PUBLISH_EXPIRATION}
}
EOF
}

# Checking whether the secrets are available as environment
# variables or not.
if [ -z "${PUB_DEV_PUBLISH_ACCESS_TOKEN}" ]; then
  echo "Missing PUB_DEV_PUBLISH_ACCESS_TOKEN environment variable"
  exit 1
fi

if [ -z "${PUB_DEV_PUBLISH_REFRESH_TOKEN}" ]; then
  echo "Missing PUB_DEV_PUBLISH_REFRESH_TOKEN environment variable"
  exit 1
fi

if [ -z "${PUB_DEV_PUBLISH_TOKEN_ENDPOINT}" ]; then
  echo "Missing PUB_DEV_PUBLISH_TOKEN_ENDPOINT environment variable"
  exit 1
fi

if [ -z "${PUB_DEV_PUBLISH_EXPIRATION}" ]; then
  echo "Missing PUB_DEV_PUBLISH_EXPIRATION environment variable"
  exit 1
fi

#mkdir -p ~/.pub-cache

if $XDG_CONFIG_HOME
then
    mkdir -p "$XDG_CONFIG_HOME"/dart
    WriteToXdgConfigHome
else
    # shellcheck disable=SC2086
    mkdir -p $HOME/.config/dart
    WriteToHome
fi

pwd
find . -type d