# Generated by Django 2.0.1 on 2018-01-21 04:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('FiNote_API', '0002_movie_user_onomatopoeia_created_at'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='authuser',
            name='img',
        ),
    ]