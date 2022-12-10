# kuncen-aws-iam

kuncen-aws-iam is a tool that can be used to check age of AWS IAM key.

This tool can be as simple checker or notification as part of your AWS IAM compliance

By default kuncen-aws-iam will check and send output of IAM key that age has exceed 90 days

## Prerequisites

To run kuncen-aws-iam, you must follow these prerequisites:

- Have [Docker Engine](https://docs.docker.com/engine/install/) installed or run on your environment
- Pull [lanandra/steampipe-container-agent](https://hub.docker.com/r/lanandra/steampipe-container-agent) container image. This container will utilize [Steampipe](https://steampipe.io/) for querying AWS IAM API
- Have AWS API credentials (such as: AWS Access Key and AWS Secret Key) that have privilege to AWS IAM service

## How to Use

1. From your terminal, export AWS credentials (AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY)

```
export AWS_ACCESS_KEY_ID="AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="AWS_SECRET_ACCESS_KEY"
```

2. Go to directory where kuncen-aws-iam resided. Then run the script

```
cd path/to/kuncen-aws-iam/

./kuncen-aws-iam.sh
```

3. Or if you want to run kuncen-aws-iam anywhere in your terminal, please create symlink to this script. Example:

```
sudo ln -s path/to/kuncen-aws-iam/kuncen-aws-iam.sh /usr/local/bin/kuncen-aws-iam
```

4. Example output of kuncen-aws-iam

```
[Sat Dec 10 20:34:25 WIB 2022] generating information...
+----------------------+----------------------------+----------------------+
| access_key_id        | user_name                  | create_date          |
+----------------------+----------------------------+----------------------+
| AKIAYIWMH5EKIBRL45O8 | billing-admin              | 2022-08-31T05:45:18Z |
| AKIAYIWMH5EKNK4O6NXS | container-admin            | 2022-03-26T14:43:06Z |
| AKIAYIWMH5EKAZBVBZDJ | observability-admin        | 2022-05-21T14:50:10Z |
+----------------------+----------------------------+----------------------+
[Sat Dec 10 20:34:25 WIB 2022] finished
```

## Notes

- As mentioned above, kuncen-aws-iam will check and send output of IAM key that age has exceed 90 days. But if you need to adjust the interval days, you can set it by set this environment variable below:

```
export KUNCEN_AWS_IAM_INTERVAL=int

example:
export KUNCEN_AWS_IAM_INTERVAL=180
```

- As mentioned above, kuncen-aws-iam utilize Steampipe for querying AWS IAM API. By default Steampipe will output a query with table format. But Steampipe offers some output format such as: line, csv, json or table. If you need kuncen-aws-iam send output with different output other than table, you can set it by set this environment variable below:

```
export KUNCEN_AWS_IAM_OUTPUT=string

example:
export KUNCEN_AWS_IAM_OUTPUT=json
```

example output:

```
[Sat Dec 10 20:55:50 WIB 2022] generating information...
[
 {
  "access_key_id": "AKIAYIWMH5EKIBRL45O8",
  "create_date": "2022-08-31T05:45:18Z",
  "user_name": "billing-admin"
 },
  "access_key_id": "AKIAYIWMH5EKNK4O6NXS",
  "create_date": "2022-03-26T14:43:06Z",
  "user_name": "container-admin"
 },
 {
  "access_key_id": "AKIAYIWMH5EKAZBVBZDJ",
  "create_date": "2022-05-21T14:50:10Z",
  "user_name": "observability-admin"
 },
]
[Sat Dec 10 20:55:50 WIB 2022] finished
```
