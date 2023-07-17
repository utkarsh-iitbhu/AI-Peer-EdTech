from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from rest_framework import generics, permissions, status
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from rest_framework import status, permissions
from rest_framework.response import Response
from rest_framework.generics import GenericAPIView
from .models import Summary, Generation, Similarity
from .serializers import SummarySerializer, GenerationSerializer, SimilaritySerializer
from rest_framework.decorators import api_view
from rest_framework import status

# Create your views here.

class SummaryCreateView(GenericAPIView):
    permission_classes = (permissions.AllowAny,)
    # pylint: disable=no-member
    queryset = Summary.objects.all()
    serializer_class = SummarySerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            # change this one.
            # 
            # UTKARSH
            # 
            # change this one.
            serializer.validated_data['summary'] = 'summary'
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SummaryListView(generics.ListAPIView):
    queryset = Summary.objects.all()
    permission_classes = (permissions.AllowAny,)
    serializer_class = SummarySerializer

class GenerationCreateView(GenericAPIView):
    permission_classes = (permissions.AllowAny,)
    # pylint: disable=no-member
    queryset = Generation.objects.all()
    serializer_class = GenerationSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            # change this one.
            # 
            # UTKARSH
            # 
            # change this one.
            serializer.validated_data['generation'] = 'generation'
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class GenerationListView(generics.ListAPIView):
    queryset = Generation.objects.all()
    permission_classes = (permissions.AllowAny,)
    serializer_class = GenerationSerializer

class SimilarityCreateView(GenericAPIView):
    permission_classes = (permissions.AllowAny,)
    # pylint: disable=no-member
    queryset = Similarity.objects.all()
    serializer_class = SimilaritySerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            # change this one.
            # 
            # UTKARSH
            # 
            # change this one.
            serializer.validated_data['similarity'] = 'similarity'
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SimilarityListView(generics.ListAPIView):
    queryset = Similarity.objects.all()
    permission_classes = (permissions.AllowAny,)
    serializer_class = SimilaritySerializer