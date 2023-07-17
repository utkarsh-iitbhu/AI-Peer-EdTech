from rest_framework import serializers
from .models import Summary, Generation, Similarity

class SummarySerializer(serializers.ModelSerializer):
    class Meta:
        model = Summary
        fields = ('text', 'summary')

class GenerationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Generation
        fields = ('text', 'generation')

class SimilaritySerializer(serializers.ModelSerializer):
    class Meta:
        model = Similarity
        fields = ('text1', 'text2', 'similarity')