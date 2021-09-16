"""
WSGI config for tesis_proyecto project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/3.1/howto/deployment/wsgi/
"""

import os
import sys
import site

# Add the site-packages of the chosen virtualenv to work with
site.addsitedir('C:/Users/Sol/AppData/Local/Programs/Python/Python39/Lib/site-packages')

# Add the app's directory to the PYTHONPATH
sys.path.append('C:/Users/Sol/Desktop/proyecto')
sys.path.append('C:/Users/Sol/Desktop/proyecto/tesis_proyecto')

os.environ['DJANGO_SETTINGS_MODULE'] = 'tesis_proyecto.settings'
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "tesis_proyecto.settings")

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()