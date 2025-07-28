def handler(event, context):
    print("✅ Hello from Lambda via module!")
    return {
        "statusCode": 200,
        "body": "Hello from Lambda via module!"
    }