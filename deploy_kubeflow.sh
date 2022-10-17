#!/usr/bin/env bash

juju deploy kubeflow --trust

juju config dex-auth static-username=admin
juju config dex-auth static-password=admin

