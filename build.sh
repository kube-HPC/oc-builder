PACKAGE_VERSION=$(node -p -e "require('./package.json').version")
VERSION=v${PACKAGE_VERSION}
docker build -t hkube/oc-builder:${VERSION} .
docker push hkube/oc-builder:${VERSION}