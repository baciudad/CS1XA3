from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.models import user
from django.contrib.auth import authenticate, login, logout

import json

def session_incr(request):
    i = request.session.get('counter',0)
    request.session['counter'] = i+1

    return HttpResponse("Counter = " + str(request.session['counter']))

def session_get(request):
    return HttpResponse("Counter = " + str(request.session['counter']))

def add_user(request):
    json_req = json.loads(request.body)
    uname = json_req.get('username','')
    passw = json_req.get('password','')

    if uname != '':
        user = User.objects.create_user(username=uname, password=passw)
        return HttpResponse('Success')

    else:
        return HttpResponse('InvalidUser')

def login_user(request):
    json_req = json.loads(request.body)
    uname = json_req.get('username','')
    passw = json_req.get('password','')

    user = authenticate(request, username=uname, password=passw)

    if user is not None:
        login(request, user)
        HttpResponse("Login Successful")
    else:
        HttpResponse("User is INVALID")

def logout_user(request):
    logout(request)
    return HttpResponse("Logout Successful")