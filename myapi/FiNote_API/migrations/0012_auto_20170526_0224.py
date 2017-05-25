# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-05-25 17:24
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('FiNote_API', '0011_auto_20170521_2108'),
    ]

    operations = [
        migrations.AlterField(
            model_name='backup',
            name='add_day',
            field=models.IntegerField(default=26),
        ),
        migrations.AlterField(
            model_name='movie',
            name='genre',
            field=models.ManyToManyField(related_name='genres', to='FiNote_API.Genre'),
        ),
    ]
