from django.urls import path
from . import views

urlpatterns = [
    path('', hviews.hello_world , name='helloapp-hello_world'),
]