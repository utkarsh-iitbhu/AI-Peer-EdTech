from django.contrib import admin
from .models import Summary, Generation, Similarity

# Register your models here.

admin.site.register(Summary)
admin.site.register(Generation)
admin.site.register(Similarity)