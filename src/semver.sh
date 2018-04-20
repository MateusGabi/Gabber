#!/usr/bin/env bash

package="Gabber: ./semver.sh"

function print {
    if [[ "$VERBOSE" ]]; then
        echo "** $1"
    fi
}

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo " "
                        echo "$package developed by Mateus Gabi Moreira https://twitter.com/matgabi17"
                        echo " "
                        echo "Use: ./semver.sh [options]"
                        echo " "
                        echo "options:"
                        echo "-h, --help                show brief help"
                        echo "--generate                major | minor | patch"
                        echo "--verbose                 print messages at every step time"
                        echo "--sha                     add commit sha on version"
                        echo "--date                    add commit date on version"
                        echo "--build-number            add a magic number as build id on version"
                        exit 0
                        ;;
                --generate*)
                        export MODE=`echo $1 | sed -e 's/^[^=]*=//g'`
                        export GENERATE=true
                        shift
                        ;;
                --next*)
                        export MODE=`echo $1 | sed -e 's/^[^=]*=//g'`
                        export NEXT=true
                        shift
                        ;;
                --verbose)
                        export VERBOSE=true
                        shift
                        ;;
                --sha)
                        export SHA=true
                        shift
                        ;;
                --date)
                        export DATE=true
                        shift
                        ;;
                --build-number)
                        export BUILD=true
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done

DIR=$PWD

# First commit
FIRST_COMMIT_DATE=$(git log --pretty=format:%cd --date=short | tail -1)
LAST_COMMIT_DATE=$(git log -1 --pretty=format:%cd --date=short)
LAST_COMMIT_HASH=$(git log -1 --pretty=format:%h)
GIT_TAG=$(git tag | tail -1)
LAST_COMMIT_HASH_WITH_TAG=$(git rev-list -n 1 $GIT_TAG --pretty=format:%h | tail -1)


print "Generate: $MODE"
print "Tag: $GIT_TAG"
print "Last Commit Hash: $LAST_COMMIT_HASH"
print "Last Tag Hash: $LAST_COMMIT_HASH_WITH_TAG"



##
## Avoiding duplicate tags on same commits
if [[ "$LAST_COMMIT_HASH" = "$LAST_COMMIT_HASH_WITH_TAG" ]]; then
    echo "You cannot tag one commit with two version"
    exit 1
fi


if [[ "$GIT_TAG" = "" ]]; then
    export LATEST_MAJOR_VERSION=0
    export LATEST_MINOR_VERSION=0
    export LATEST_PATCH_VERSION=0

else
    tag=${GIT_TAG//v}
    print "STAG $tag"
    i=1
    for x in $(echo $tag | tr "." "\n")
    do
        if [[ "$i" = 1 ]]; then
            export LATEST_MAJOR_VERSION=$x
            print "LATEST_MAJOR_VERSION: $x"
        elif [[ "$i" = 2 ]]; then
            export LATEST_MINOR_VERSION=$x
            print "LATEST_MINOR_VERSION: $x"
        elif [[ "$i" = 3 ]]; then
            export LATEST_PATCH_VERSION=$x
            print "LATEST_PATCH_VERSION: $x"
        fi
        i=$(($i + 1))
    done

fi

print "Latest version: $LATEST_MAJOR_VERSION.$LATEST_MINOR_VERSION.$LATEST_PATCH_VERSION"

# upgrade version
if [[ "$MODE" = "patch" ]]; then
    export LATEST_PATCH_VERSION=$(($LATEST_PATCH_VERSION + 1))
elif [[ "$MODE" = "minor" ]]; then
    export LATEST_MINOR_VERSION=$(($LATEST_MINOR_VERSION + 1))
    export LATEST_PATCH_VERSION=0
elif [[ "$MODE" = "major" ]]; then
    export LATEST_MAJOR_VERSION=$(($LATEST_MAJOR_VERSION + 1))
    export LATEST_MINOR_VERSION=0
    export LATEST_PATCH_VERSION=0
else
    echo "Generate mode not found"
    exit 1
fi


version="$LATEST_MAJOR_VERSION.$LATEST_MINOR_VERSION.$LATEST_PATCH_VERSION"

if [[ "$BUILD" ]]; then
    # Build number is generated by:
    # daysDiff(last_commit - first_commit) * (24 / 8) * number_of_commit

    let DIFF=(`date +%s -d ${LAST_COMMIT_DATE//-}`-`date +%s -d ${FIRST_COMMIT_DATE//-}`)/86400

    print "Project days: $DIFF"

    let commits=(`git rev-list --all --count`)

    print "Git commits: $commits"

    let calc=$DIFF*3*$commits

    print "Build Number: $calc"

    version="$version-$calc"
fi

if [[ "$DATE" ]]; then
    version="$version-${LAST_COMMIT_DATE//-}"
fi

if [[ "$SHA" ]]; then
    version="$version+sha.$LAST_COMMIT_HASH"
fi


##
## Creating tag

if [[ "$GENERATE" ]]; then
    command=$(git tag -a v"$version" -m '[Gabber] Tag automatically generated')
    print "Tag v$version created on commit $LAST_COMMIT_HASH"

    echo "Version: $version"

    echo ""
    echo "      Use: git push origin --tags"
elif [[ "$NEXT" ]]; then
    
    echo ""
    echo "      Next $MODE version is v$version"
fi
