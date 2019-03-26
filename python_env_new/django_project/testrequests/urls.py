from django.urls import path
from . import views

# routes from localhost:<portnum>/e/macid/testreq/testget/?name=v1&age=v2
#             localhost:<portnum>/e/macid/testreq/testpost/

urlpatterns = [
    path('lab7/', views.post_view , name = 'testrequests.lab7'),
]
