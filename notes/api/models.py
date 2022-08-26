from django.db import models

# Create your models here.

class Note(models.Model):

    title = models.TextField()
    content = models.TextField()
    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)
    owner = models.ForeignKey('auth.User', related_name='products',on_delete=models.CASCADE)

    def __str__(self):
        return self.content[0:50]

    class Meta:
        ordering = ['-updated']