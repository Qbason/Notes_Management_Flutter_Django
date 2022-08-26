import requests
import json
from requests.auth import HTTPDigestAuth


content = {
    "grant_type":"password",
    "username":"test",
    "password":"test",

}

new_request_post = requests.post(
    'http://127.0.0.1:8000/o/token/',
    data=content,
    auth=('VwFdM3jEyOZSjjcRXuz0aFzdtUSOS3lYGTMJ12ZN','LRKeTZGwzvlKnrvHiYpmsll1qyHmPWK7hT9A90vgjbGPd8rILS3s8SDvnJnz0oqloDP90d38XXSnb2923w5V3kk6UBEHVnKqqYbxzImxI6FdOoslNmWsgYAnRsahTogh')
    )

print(
    new_request_post.text
)
print(
    new_request_post.status_code
)


# new_request_get = requests.get(
#     'http://127.0.0.1:8000/products/',
#     headers={"Authorization": "Bearer ev5RsKOUxllJqiCpAOohry8WPY0pOi"}
#     )
# print(
#     new_request_get.json()[0]
# )
# id:VwFdM3jEyOZSjjcRXuz0aFzdtUSOS3lYGTMJ12ZN
# secret:LRKeTZGwzvlKnrvHiYpmsll1qyHmPWK7hT9A90vgjbGPd8rILS3s8SDvnJnz0oqloDP90d38XXSnb2923w5V3kk6UBEHVnKqqYbxzImxI6FdOoslNmWsgYAnRsahTogh
# accesss token: qADL75Dc3vHZM8jKOwQvkEzSwfaqhQ
# refresh token: 9EtcOzwuQgc1Dt1Hzowa2YjN9VGVJ8