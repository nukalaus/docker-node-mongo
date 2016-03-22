#!/bin/bash

service mongodb start

cd /opt/app
npm rebuild
