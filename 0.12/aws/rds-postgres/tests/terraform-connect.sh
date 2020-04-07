rds_db_host="$(cat terraform-outputs.json | jq -r .rds_db_host.value)"
rds_postgres_username="$(cat terraform-outputs.json | jq -r .rds_postgres_username.value)"
rds_postgres_password="$(cat terraform.tfvars.json | jq -r .rds_postgres_password)"

for i in {1..50}
do
  PGPASSWORD=${rds_postgres_password} \
    pg_isready -h ${rds_db_host} -U ${rds_postgres_username} && break
  sleep 10
done
