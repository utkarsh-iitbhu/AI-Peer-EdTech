from django.db import models

# Create your models here.

class Summary(models.Model):
    text = models.TextField(blank=True, null=True)
    summary = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.text

class Generation(models.Model):
    text = models.TextField(blank=True, null=True)
    generation = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.text

class Similarity(models.Model):
    text1 = models.TextField(blank=True, null=True)
    text2 = models.TextField(blank=True, null=True)
    similarity = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.text