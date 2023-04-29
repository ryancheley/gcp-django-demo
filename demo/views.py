from django.views.generic import DetailView, ListView, CreateView, DeleteView

from .models import Demo

class DemoDetailView(DetailView):
    model = Demo


class DemoListView(ListView):
    model = Demo


class DemoCreateView(CreateView):
    model = Demo
    fields = ['name', ]

class DemoDeleteView(DeleteView):
    model = Demo
    fields = ['name', ]
    success_url = "/"
