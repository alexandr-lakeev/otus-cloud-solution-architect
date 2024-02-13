import json
import boto3
import time
import requests

def lambda_handler(event, context):
    client_ip = event['requestContext']['identity']['sourceIp']

    location = get_location(client_ip)

    item = {
        'location': {'S': location['city']},
        'timestamp': {'N': str(int(time.time()))},
        'ip': {'S': client_ip}
    }

    try:
        dynamodb = boto3.client('dynamodb')

        response = dynamodb.put_item(
            TableName='StatsTable',
            Item=item
        )

        lambda_client = boto3.client('lambda', region_name='eu-central-1')

        payload = '{"location":"'+location['city']+'"}'

        response = lambda_client.invoke(
            FunctionName='weather_lambda_function',
            InvocationType='RequestResponse',
            Payload=payload.encode()
        )

        return {
            'statusCode': 200,
            'body': response["Payload"].read()
        }
    except Exception as e:
        print('error:', e)
        return {
            'statusCode': 500,
            'body': json.dumps(str(e))
        }


def get_location(client_ip):
    response = requests.get(f'http://ip-api.com/json/{client_ip}').json()

    print("response", response)

    location_data = {
        "city": response.get("city"),
        "country": response.get("country")
    }

    return location_data