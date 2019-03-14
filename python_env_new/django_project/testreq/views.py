from django.shortcuts import render
from django.http import HttpResponse

def hello(request):
    return HttpResponse("Hello")

def gettest(request):
    keys = request.GET
    name = keys.get("name", default="")
    age = keys.get("age", default="")
    return HttpResponse("Hello " + name + " your " + age + " years old!")

def posttest(request):
    keys = request.POST
    name = keys.get("name", default="")
    age = keys.get("age", default="")
    return HttpResponse("Hello " + name + " your " + age + " years old!\n")   