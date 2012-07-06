from django.template import RequestContext
from django.shortcuts import render_to_response,redirect
from django.core.urlresolvers import reverse
from django.conf import settings

from os.path import join
import pygeoip
import urllib

def frontpage(request):
    #lookup IP and redirect user to correct state
    #using free MaxMind GeoLiteCity db
    geoip = pygeoip.GeoIP(join(settings.MEDIA_ROOT,'GeoLiteCity.dat'))
    ip_addr = request.META.get('HTTP_X_FORWARDED_FOR', '') or request.META.get('REMOTE_ADDR')
    params = {}
    try:
        result = geoip.record_by_addr(ip_addr)
    except pygeoip.GeoIPError:
        result = None
    if result:
        params['state'] = result['region_name']
        return redirect(reverse('registrant.views.register')+
            "?"+urllib.urlencode(params))
    else:
        return redirect(reverse('registrant.views.map'))

def rtv_iframe_test(request):
    layout = request.GET.get('layout')
    context = {'layout':layout}
    return render_to_response('rtv_iframe_test.html',context,
                context_instance=RequestContext(request))
