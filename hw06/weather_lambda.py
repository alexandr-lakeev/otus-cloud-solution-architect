import json
import boto3
import time
import requests

def lambda_handler(event, context):
    token = '716d204d36a94952a4c215201241202'

    try:
        weather = get_weather(token, event['location'])

        return {
            'statusCode': 200,
            'body': weather
        }
    except Exception as e:
        print('error:', e)
        return {
            'statusCode': 500,
            'body': json.dumps('error')
        }

def get_weather(token, location):
    response = requests.get(f'https://api.weatherapi.com/v1/current.json?key={token}&q={location}').json()

    print("response", response['current']['temp_c'])

    weather_data = {
        "t": response['current']['temp_c'],
        "wind_kph": response['current']['wind_kph'],
        "humidity": response['current']['humidity']
    }

    return weather_data