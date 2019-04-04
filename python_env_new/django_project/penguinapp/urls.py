from django.urls import path
from . import views

urlpatterns = [
    path('addPenguin/', views.addPenguin, name='penguinapp-add'),
    path('getPenguin/', views.getPenguin, name='penguinapp-get'),
    path('', views.penguin_view , name='penguinapp-penguin_view'),
]