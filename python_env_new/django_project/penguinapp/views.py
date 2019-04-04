from django.http import HttpResponse
from .models import Penguin
import json

def penguin_view(request):
    allPenguins = Penguin.objects.all()
    print(allPenguins)
    return HttpResponse("That's a lot of Penguins")

def add_penguin(request):
    penguin_dat = json.loads(request.body)
    pname = penguin_dat.get("name","")
    page = penguin_dat.get("age",0)

    if name != "":
        newPeng = Penguin(name = pname, age = page)
        newPeng.save()

    return HttpResponse("Success")