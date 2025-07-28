import boto3
import json
import os

dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('DYNAMODB_TABLE', 'UserData')
table = dynamodb.Table(table_name)

def handler(event, context):
    # Example: Add an item
    if event.get("httpMethod") == "POST":
        body = json.loads(event.get("body", "{}"))
        item_id = body.get("id", "123")
        name = body.get("name", "Unknown")
        table.put_item(Item={"id": item_id, "name": name})
        return {
            "statusCode": 200,
            "body": json.dumps({"message": f"Item {item_id} saved"})
        }

    # Example: Get all items
    if event.get("httpMethod") == "GET":
        response = table.scan()
        return {
            "statusCode": 200,
            "body": json.dumps(response["Items"])
        }

    return {"statusCode": 400, "body": "Unsupported method"}
