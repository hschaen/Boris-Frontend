from django.template import RequestContext
from django.shortcuts import render_to_response,redirect
from django.core.urlresolvers import reverse
from django.conf import settings

from os.path import join
import pygeoip
import urllib

from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def frontpage(request):
    params = {}

    #geolocation didn't help, turn it off
    #lookup IP and redirect user to correct state
    #using free MaxMind GeoLiteCity db
    #geoip = pygeoip.GeoIP(join(settings.MEDIA_ROOT,'GeoLiteCity.dat'))
    #ip_addr = request.META.get('HTTP_X_FORWARDED_FOR', '') or request.META.get('REMOTE_ADDR')
    #try:
    #    result = geoip.record_by_addr(ip_addr)
    #except pygeoip.GeoIPError:
    #    result = None
    #if result and result.has_key('region_name'):
    #    redirect_url = reverse('registrant.views.register')
    #    params['state'] = result['region_name']

    #now everybody redirects to first step
    redirect_url = reverse('registrant.views.map2')

    #preserve the get parameters in redirect
    #to be backwards compatible with old rocky frontend
    if request.GET.get('partner'):
        params['partner'] = request.GET.get('partner')
    if request.GET.get('source'):
        params['source'] = request.GET.get('source')

    if params:
        redirect_url += "?"+urllib.urlencode(params)
    return redirect(redirect_url)

def static_redirect(request,path):
    return redirect(settings.STATIC_URL+path)

def rtv_iframe_test(request):
    layout = request.GET.get('layout')
    context = {'layout':layout}
    return render_to_response('rtv_iframe_test.html',context,
                context_instance=RequestContext(request))
                
