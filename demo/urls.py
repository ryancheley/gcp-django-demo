from django.urls import path

from .views import DemoDetailView, DemoListView, DemoCreateView, DemoDeleteView


app_name = "demo"

urlpatterns = [
    path("", DemoListView.as_view(), name="list"),
    path("detail/<int:pk>", DemoDetailView.as_view(), name="detail"),
    path("create/", DemoCreateView.as_view(), name="create"),
    path("delete/<int:pk>", DemoDeleteView.as_view(), name="delete"),
    
]