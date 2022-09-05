from rest_framework.serializers import ModelSerializer
from rest_framework import serializers
from django.contrib.auth.models import User

from .models import Note

class NoteSerializer(ModelSerializer):

    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Note
        fields = ['id','title','content','updated','created','owner']


class UserSerializer(ModelSerializer):

    password = serializers.CharField(write_only=True)
    class Meta:
        model = User
        fields = ['id','username','password','email']

    def create(self, validated_data):
        user =  User.objects.create(
            username = validated_data['username'],
            email = validated_data['email']   
        )
        user.set_password(
            validated_data['password']
        )
        user.save()

        return user