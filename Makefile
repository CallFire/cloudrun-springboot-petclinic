gcloud-setup:
	gcloud config set project prj-sre-d-sandbox-run-c366

gcp-sql-setup:
	gcloud sql databases create petclinic --instance my-db-f4f38aae

gcp-sql-getInstance:
	gcloud sql instances describe my-db-f4f38aae | grep connectionName

#gcloud-run-deploy:
#	gcloud run deploy my-springboot-service --image=gcr.io/prj-sre-d-sandbox-run-c366/deploy/cloudrun-example --platform=managed --region=us-central1

gcp-iam-cloudbuild:
	gcloud projects get-iam-policy prj-sre-d-sandbox-run-c366 --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:195303305359@cloudbuild"

gcp-iam-project-service-account:
	gcloud projects get-iam-policy prj-sre-d-sandbox-run-c366 --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:project-service-account"
