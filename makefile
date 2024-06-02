# run terraform fmt command for all directories in project add .phony to avoid conflicts with files of the same name
.PHONY: fmt
fmt:
	terraform fmt -recursive .
plan:
	terraform plan
apply:
	terraform apply