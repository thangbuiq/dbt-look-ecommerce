#!/bin/bash
# example usage: bash dbt_yml_generator.sh ecommerce intermediate
# with the above command, the script will generate a yml file for all the models in the intermediate layer
# and save it as _int_ecommerce__models.yml in the intermediate/ecommerce folder

dbt_projects_list=$(ls -d models/{intermediate,staging,marts}/*/ | sed -E 's/models\/(intermediate|staging|marts)\///g' | sed 's/\///g' | sort -u)
PS3="Enter (number only): "

# make user choose from the projects list and assign to dbt_project
echo "Choose a dbt project from the list below:"
select dbt_project in $dbt_projects_list; do
    if [ -n "$dbt_project" ]; then
        echo "You chose: $dbt_project"
        echo ""
        break
    else
        echo "Invalid selection"
    fi
done

# make user choose from the model layers list and assign to dbt_model_layer
echo "Choose a dbt model layer from the list below:"
select dbt_model_layer in "staging" "intermediate" "mart"; do
    if [ -n "$dbt_model_layer" ]; then
        echo "You chose: $dbt_model_layer"
        echo ""
        break
    else
        echo "Invalid selection"
    fi
done

if [ $dbt_model_layer = "intermediate" ]; then
    dbt_output_prefix="int"
elif [ $dbt_model_layer = "staging" ]; then
    dbt_output_prefix="stg"
elif [ $dbt_model_layer = "marts" ]; then
    dbt_output_prefix=""
else
    echo "Invalid model layer"
    exit 1
fi

sql_files=$(ls models/$dbt_model_layer/$dbt_project/*.sql)
model_names=$(echo $sql_files | sed 's/models\/'$dbt_model_layer'\///g' | sed 's/.sql//g')
dbt_output_file_path=models/$dbt_model_layer/$dbt_project/_$dbt_output_prefix"_"$dbt_project"__models.yml"
if [ -f $dbt_output_file_path ]; then
    rm $dbt_output_file_path
fi

echo "version: 2" > $dbt_output_file_path
echo "models:" >> $dbt_output_file_path
for model_name in $model_names; do
    echo "  - name: $model_name" >> $dbt_output_file_path
    echo "    description: \"\"" >> $dbt_output_file_path
    echo "" >> $dbt_output_file_path
done

if [ -f $dbt_output_file_path ]; then
    echo "YML file generated successfully at $dbt_output_file_path"
else
    echo "Failed to generate YML file"
fi