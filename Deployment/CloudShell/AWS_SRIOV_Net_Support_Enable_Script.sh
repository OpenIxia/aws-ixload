#!/bin/bash

# Input Argument Processing
ARGV_EC2_INSTANCE_ID="i-00000000000000000"
ARGV_VERBOSE_OUTPUT="true"
ARGV_OTHER_ARGUMENTS=()


# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        --instance-id=*)
        ARGV_EC2_INSTANCE_ID="${arg#*=}"
        shift # Remove from processing
        ;;
        --verbose-output=*)
        ARGV_VERBOSE_OUTPUT="${arg#*=}"
        shift # Remove from processing
        ;;
        *)
        ARGV_OTHER_ARGUMENTS+=("$1")
        shift # Remove from processing
        ;;
    esac
done


# Variable Initialization
AWS_EC2_INSTANCE_ID=$ARGV_EC2_INSTANCE_ID
AWS_VERBOSE_OUTPUT=$ARGV_VERBOSE_OUTPUT

# Variable Logging
if [ "$AWS_VERBOSE_OUTPUT" == "true" ];
then
echo "% AWS_EC2_INSTANCE_ID=$AWS_EC2_INSTANCE_ID"
echo "%"
fi


# SRIOV Net Support Enable
if [ "$AWS_VERBOSE_OUTPUT" == "true" ];
then
echo -e "% aws ec2 modify-instance-attribute\n\
%	--instance-id $AWS_EC2_INSTANCE_ID\n\
%	--sriov-net-support simple\n"
fi
aws ec2 modify-instance-attribute \
	--instance-id $AWS_EC2_INSTANCE_ID \
	--sriov-net-support simple

if [ "$AWS_VERBOSE_OUTPUT" == "true" ];
then
echo -e "% /usr/local/bin/aws ec2 describe-instance-attribute \n\
%	--instance-id $AWS_EC2_INSTANCE_ID\n\
%	--attribute sriovNetSupport\n"
fi
aws ec2 describe-instance-attribute \
	--instance-id $AWS_EC2_INSTANCE_ID \
	--attribute sriovNetSupport
#eof