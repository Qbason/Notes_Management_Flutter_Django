from rest_framework.response import Response
from rest_framework import permissions
from rest_framework import viewsets
from rest_framework.exceptions import PermissionDenied

from django.shortcuts import get_object_or_404
from django.contrib.auth.models import User
#from api.serializers import UserSerializer
from api.models import Note
from api.serializers import NoteSerializer, UserSerializer
#from api.permissions import IsOwner

from django.contrib.auth.models import User

from oauth2_provider.contrib.rest_framework import TokenHasReadWriteScope, TokenHasScope,OAuth2Authentication

# from notes.api import serializers


class NotesViewSet(viewsets.ModelViewSet):
    queryset = Note.objects.all()
    serializer_class = NoteSerializer
    authentication_classes = [OAuth2Authentication]
    permission_classes = [TokenHasScope]
    required_scopes = ['read']

    def perform_create(self, serializer):
        return serializer.save(owner=self.request.user)

    def list(self,request,format=None):
        query_set_only_user_content = self.queryset.filter(owner=self.request.user)
        serializer = NoteSerializer(query_set_only_user_content,many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk,format=None,*args, **kwargs):
        queryset_only_user = get_object_or_404(self.queryset,pk=pk,owner=self.request.user)
        serializer = NoteSerializer(queryset_only_user,many=False)
        return Response(serializer.data)

class UserViewSet(viewsets.ViewSet):

    queryset = Note.objects.all()
    serializer_class = UserSerializer
    authentication_classes = []
    permission_classes = []

    def create(self, request):
        validated_data = request.data



        user =  User.objects.create(
            username = validated_data['username'],
            email = validated_data['email']   
        )
        user.set_password(
            validated_data['password']
        )
        user.save()

        user_serializered = UserSerializer(
            user
        )



        return Response(user_serializered.data)


