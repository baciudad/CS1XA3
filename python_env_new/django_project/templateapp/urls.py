from django.urls import path
from . import views

# routed from e/macid/templateapp/
urlpatterns = [
    path('incr/',views.session_incr, name = "session_incr"),
    path('get/', views.session_get, name = "session_get"),
    path('addUser/', views.add_user, name = "add_user"),
    path('logout/', views.login_user, name = "login_user"),
    path('login/', views.logout_usesr, name = "logout_user"),
]
