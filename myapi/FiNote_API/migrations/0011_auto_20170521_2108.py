# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-05-21 12:08
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('FiNote_API', '0010_auto_20170514_1105'),
    ]

    operations = [
        migrations.AlterField(
            model_name='authuser',
            name='email',
            field=models.EmailField(default='email', max_length=100, unique=True),
        ),
        migrations.AlterField(
            model_name='authuser',
            name='username',
            field=models.CharField(default='username', max_length=100, unique=True),
        ),
        migrations.AlterField(
            model_name='backup',
            name='add_day',
            field=models.IntegerField(default=21),
        ),
    ]
