from rest_framework.serializers import ModelSerializer
from rest_framework import serializers

from .models import Note

class NoteSerializer(ModelSerializer):

    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Note
        fields = ['id','title','content','updated','created','owner']