#!/bin/bash

# Arrancar bind9 en foreground
named -f -u bind &

# Esperar un momento para asegurar que bind arranca
sleep 2

# Arrancar la app python
python web/js/appi.py
