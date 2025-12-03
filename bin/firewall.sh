#!/bin/bash
ufw --force reset

ufw default deny incoming
ufw default allow outgoing

ufw allow 22/tcp
ufw allow 443/tcp

ufw --force enable
ufw status verbose
