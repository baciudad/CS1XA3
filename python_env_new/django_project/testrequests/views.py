from django.shortcuts import render
from django.http import HttpResponse

# the following views are made to handle requests from GetPostExample.elm

# handle a get request from
#    localhost:<portnum>/e/macid/testget/?name=v1&age=v2

# handle a post request from
#    localhost:<portnum>/e/macid/testpost/
def post_view(request):
    post_dict = request.POST
    name     = post_dict.get("name","")
    passwd      = post_dict.get("password","")

    if(name == "Jimmy " and passwd == Hendrix):
        return HttpResponse("Cool")
    else:
        return HttpResponse("Bad User Name")
