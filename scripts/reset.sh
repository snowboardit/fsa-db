#!/bin/bash

# This script does the following:
# 1. Drops the existing database using $DB_NAME
# 2. Creates a new database named $DB_NAME
# 3. Creates new tables using $SQL_SCRIPT

# Assumptions:
# - mysql cli is installed or accessible

# Make sure to:
# - Set configuration variables below
# - Add execution permissions to this script using `chmod +x scripts/reset.sh`
# - Run from the root project directory

# Configuration
DB_USER="root"
DB_NAME="fsa"
SQL_SCRIPT="sql/setup.sql"

# Confirmation prompt
read -p "This script will drop the '${DB_NAME}' database and recreate it. Are you sure you want to continue? (y/n): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Reset operation cancelled."
    exit 0
fi

# Drop the existing database if it exists
echo "Dropping the existing database..."
mysql -u ${DB_USER} -p -e "DROP DATABASE IF EXISTS ${DB_NAME};"

# Create a new database
echo "Creating a new database..."
mysql -u ${DB_USER} -p -e "CREATE DATABASE ${DB_NAME};"

# Load the SQL script to create the tables
echo "Loading SQL script to create tables..."
mysql -u ${DB_USER} -p ${DB_NAME} < "${SQL_SCRIPT}"

echo "Database reset complete!"
