from rest_framework import serializers


class SignUpUserSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=256, allow_blank=False, required=True)
    password = serializers.CharField(max_length=256, allow_blank=False, required=True)
    email = serializers.EmailField(max_length=100, allow_blank=False, required=True)
    birthyear = serializers.IntegerField(allow_null=True, required=False)


class SignInUserSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=256, allow_blank=False, required=True)
    password = serializers.CharField(max_length=256, allow_blank=False, required=True)


class UpdatePasswordSerializer(serializers.Serializer):
    username = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    now_password = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    new_password = serializers.CharField(allow_blank=False, allow_null=False, required=True)


class UpdateEmailSerializer(serializers.Serializer):
    username = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    password = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    new_email = serializers.EmailField(allow_blank=False, allow_null=False, required=True)


class UpdateBirthYearSerializer(serializers.Serializer):
    username = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    password = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    birthyear = serializers.IntegerField(allow_null=True, required=False)
