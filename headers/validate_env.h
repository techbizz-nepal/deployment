################################################
# Function to update or add a variable in the .env file
update_env_var() {
    local var_name=$1
    local var_value=$2
    local file=$3

    # Check if the variable exists in the file
    if grep -q "^$var_name=" "$file"; then
        # Replace the blank or existing value with the new value
        if grep -q "^$var_name=$" "$file"; then
            sed -i "s/^$var_name=.*$/$var_name=$var_value/" "$file"
        else
            sed -i "s/^$var_name=.*$/$var_name=$var_value/" "$file"
        fi
    else
        #Append the new variable if it does not exist
        echo "$var_name=$var_value" >> "$file"
    fi
}