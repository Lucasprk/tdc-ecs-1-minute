#!/bin/bash
key="$1"
case $key in
  -p|--profile)
    PROFILE="$2"
    ;;
  *)
    echo "Please inform the profile option. Like: ./init.sh -p qa"
    exit
esac

case $PROFILE in
  qa)
    shift
    shift
    ;;
  prod)
    shift
    shift
    ;;
  *)
    echo "Invalid Option! The options are: qa, prod"
    exit
    ;;
esac

echo "OK"