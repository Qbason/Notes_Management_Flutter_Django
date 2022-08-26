from django.urls import path,include
from api import views
from rest_framework.routers import DefaultRouter
from rest_framework.documentation import include_docs_urls
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import IsAuthenticated

router = DefaultRouter()

router.register(
    r'notes',
    views.NotesViewSet,
    basename='notes'
)


urlpatterns = [
    path('',include(router.urls)),
    path(r'docs/', include_docs_urls(title='Polls API',public=True,authentication_classes=[BasicAuthentication],permission_classes=[IsAuthenticated]))

]