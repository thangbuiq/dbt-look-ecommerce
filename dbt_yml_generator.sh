#!/bin/bash
# example usage: bash dbt_yml_generator.sh intermediate int_ecommerce
# with the above command, the script will generate a yml file for all the models in the intermediate layer
# and save it as int_ecommerce.yml in the intermediate folder

dbt_model_layer=$1
dbt_output_file=$2
sql_files=$(ls models/$dbt_model_layer/*.sql)
model_names=$(echo $sql_files | sed 's/models\/'$dbt_model_layer'\///g' | sed 's/.sql//g')
dbt_output_file_path=models/$dbt_model_layer/$dbt_output_file.yml

dbt clean
dbt deps

if [ -f $dbt_output_file_path ]; then
  rm $dbt_output_file_path
fi

# create merged string of model names
joined=""
for model_name in $model_names; do
  joined+="\"$model_name\","
done

# into a single string, then echo it to the output file
yml_content=$(dbt --quiet run-operation generate_model_yaml --args "{\"model_names\": [$joined]}")
echo "$yml_content" > $dbt_output_file_path