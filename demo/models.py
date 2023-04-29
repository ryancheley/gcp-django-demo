from django.db import models
from django.urls import reverse

class Demo(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self) -> str:
        return self.name
    
    def get_absolute_url(self):
        return reverse("demo:list")
    

    