#!/bin/sh
j2000=6600
aptly repo remove -dry-run miktex-xenial "miktex (< 2.9.$j2000)"
