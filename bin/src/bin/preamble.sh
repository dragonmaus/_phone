#!/bin/sh
home="$( dirname "$0" )/.."
home="$( cd "$home" && env - "PATH=$PATH" pwd )"
