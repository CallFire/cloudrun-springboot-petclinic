_SEC_PROJECT_ID=prj-d-secrets-2bcb

gcp-project-init:
	gcloud config set project prj-sre-d-sb-cloudrun-24f7

gcp-secret-key:
	gcloud --project=${_SEC_PROJECT_ID} \
          secrets versions access latest \
          --secret=sre-sb-cloudrun-project-sa-enc-key-secret \
          --format='get(payload.data)' | tr '_-' '/+' | base64 -d

gcp-secret-pass:
	gcloud --project=${_SEC_PROJECT_ID} \
          secrets versions access latest \
          --secret=sre-sb-cloudrun-sqldb-app-secret \
          --format='get(payload.data)' | tr '_-' '/+' | base64 -d

gcp-sql-setup: gcp-project-init
	gcloud sql databases create petclinic --instance my-db-f4f38aae

gcp-sql-getInstance: gcp-project-init
	gcloud sql instances describe sb-cloudrun-db-93cff361
	# gcloud sql instances describe sb-cloudrun-db-93cff361 | grep connectionName

gcp-sql-connect: gcp-project-init
	gcloud beta sql connect sb-cloudrun-db-93cff361 --user=root

#gcloud-run-deploy:
#	gcloud run deploy my-springboot-service --image=gcr.io/prj-sre-d-sandbox-run-c366/deploy/cloudrun-example --platform=managed --region=us-central1

gcp-iam-cloudbuild:
	gcloud projects get-iam-policy prj-sre-d-sandbox-run-c366 --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:195303305359@cloudbuild"

gcp-iam-project-service-account:
	gcloud projects get-iam-policy prj-sre-d-sandbox-run-c366 --flatten="bindings[].members" --format='table(bindings.role)' --filter="bindings.members:project-service-account"
