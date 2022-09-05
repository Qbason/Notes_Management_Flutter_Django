# Flutter + Django Rest Api + OAuth2
## Flutter, Dart, Django, Django REST framework, Python, OAuth2, SQLite

## SQLite - ORM Django

Model created by my own

title -> type TextField  
content -> type TextField  
updated -> type DateTimeField + autogenerated, when created  
created -> DateTimeField + autogenerated, when changed  
owner -> ForeignKey to User (from django.contrib.auth.User)  

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

## Django - REST API

### Created three main endpoints:  
1. notes
2. user
3. docs/ -> only Authenticated user (by username and password) has access


### Code:

    router = DefaultRouter()

    router.register(
        r'notes',
        views.NotesViewSet,
        basename='notes'
    )
    router.register(
        r'user',
        views.UserViewSet,
        basename='user'
    )

    urlpatterns = [
        path('',include(router.urls)),# include two endpoints
        path(r'docs/', include_docs_urls(title='Polls API',public=True,authentication_classes=[BasicAuthentication],permission_classes=[IsAuthenticated]))
        # endpoint for testing, which generates 'docs' 

    ]

### Created serializers:

    class NoteSerializer(ModelSerializer):

        #display owner as a username
        owner = serializers.ReadOnlyField(source='owner.username')
        class Meta:
            model = Note
            #decide, which fields we represent
            fields = ['id','title','content','updated','created','owner']

    class UserSerializer(ModelSerializer):

        #we cannot read password field! only write
        password = serializers.CharField(write_only=True)
        class Meta:
            model = User
            #decide, which fields we represent
            fields = ['id','username','password','email']

### Created views
I set, that NoteViewSet operates on Note objects.  
I defined, which serializer should be applied.  
For authenticating I chose OAuth2Authentication.  
Only users, which token has scope 'read' can access to notes.(authorization)  
To show only specific content to user I filtered all notes or note by owner.  
Reponse get using created serializer.

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


ViewSet only consist of 'create' action.  
Using set_password for encryption password.  
Return Respone generated by serializer data.
    
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


## Flutter view
## Login page
<img src="https://github.com/Qbason/Notes_Management_Flutter_Django/blob/main/images/1.png" width="350">

## Registration 
<img src="https://github.com/Qbason/Notes_Management_Flutter_Django/blob/main/images/5.png" width="350">

## All notes 
<img src="https://github.com/Qbason/Notes_Management_Flutter_Django/blob/main/images/2.png" width="350">

## Editing note
<img src="https://github.com/Qbason/Notes_Management_Flutter_Django/blob/main/images/3.png" width="350">

## Create new note
<img src="https://github.com/Qbason/Notes_Management_Flutter_Django/blob/main/images/4.png" width="350">



