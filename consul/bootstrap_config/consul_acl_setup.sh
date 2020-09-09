#!/bin/sh

# Setup Consul ACLs on servers and clients

CONSUL_DIR=config.json

NUM_CLIENTS=$(consul members | grep "alive"| grep "client" | wc -l)
NUM_SERVERS=$(consul members | grep "alive"| grep "server" | wc -l)

SERVER=server_bootstrap:8500

function create_agent_token() {

    MASTER_TOKEN=$(grep "acl_master_token" $CONSUL_DIR | awk -F'"' '{print $4}')
    NUM_SERVERS=$(consul members  | grep "alive"| grep "server" | wc -l)

    echo "ACL_MASTER_TOKEN:   $MASTER_TOKEN"

    echo "Create an Agent Rule ..."

        for servers in $(consul operator raft list-peers -token $MASTER_TOKEN | grep leader | awk -F ":" '{print $1;}' | awk '{ print $3}')
            do
                curl -s -X PUT -H "X-Consul-Token: $MASTER_TOKEN" -d '{"Name": "Agent Token '$i'","Type": "client","Rules": "node \"\" { policy = \"write\" } service \"\" { policy = \"read\" }"}' http://$servers:8500/v1/acl/create -o "acl_agent_token"

                sleep 1;

                CLIENT_TOKEN=`awk -F'"' '{ print $4 }' acl_agent_token`
        done

    echo "Agent Token created."

    acl_agent_token

}

function acl_agent_token() {

    MASTER_TOKEN=$(grep "acl_master_token" $CONSUL_DIR | awk -F'"' '{print $4}')
    CLIENT_TOKEN=`awk -F'"' '{ print $4 }' acl_agent_token`

    echo "ACL agent token setting";

        for servers in $(consul members -token $MASTER_TOKEN | grep "alive"| grep "server" | awk -F ":" '{print $1;}' | awk '{ print $2}')
            do
            curl -X PUT -H "X-Consul-Token: $MASTER_TOKEN" -d '{ "Token": "'$CLIENT_TOKEN'" }' http://$servers:8500/v1/agent/token/acl_agent_token
        done

    echo "Agent Token Set."

    enable_acl_clients
}

function enable_acl_clients() {

    MASTER_TOKEN=$(grep "acl_master_token" $CONSUL_DIR | awk -F'"' '{print $4}')
    CLIENT_TOKEN=`awk -F'"' '{ print $4 }' acl_agent_token`

    echo "Enable ACLs on the Consul Clients";

        for clients in $(consul members -token $MASTER_TOKEN | grep "alive" | grep "client" | awk -F ":" '{print $1;}' | awk '{ print $2}')
            do
                curl -X PUT -H "X-Consul-Token: ${MASTER_TOKEN}" -d '{ "Token": "'${CLIENT_TOKEN}'" }' http://$clients:8500/v1/agent/token/acl_agent_token
                sleep 1;
        done

    echo "ACL Clients enabled."

    cleanup

}

function cleanup () {
    rm -f client_token*
    if [ $? -eq 0 ]; then
        echo "Tokens file removed!"
    fi
}

function java_mailing_acl () {

    MASTER_TOKEN=$(grep "acl_master_token" $CONSUL_DIR | awk -F'"' '{print $4}')
    CLIENT_TOKEN=`awk -F'"' '{ print $4 }' acl_agent_token`
    JAVA_MAILING_ACL="Batch_Mailer"

    echo "Creating Java Mailing ACL ..."

    echo -e "${JAVA_MAILING_ACL}: "
    curl -s -X PUT -d \
    '{"Name": "'${JAVA_MAILING_ACL}'","Type": "client","Rules": "key \"\" { policy = \"read\" } key \"service/\" { policy = \"read\" } key \"service/batch_mailing/\" { policy = \"write\" } operator = \"read\"" }' http://$SERVER/v1/acl/create?token=$MASTER_TOKEN
    echo -e "\n"

    
}

function vault_acl() {

    MASTER_TOKEN=$(grep "acl_master_token" $CONSUL_DIR | awk -F'"' '{print $4}')
    CLIENT_TOKEN=`awk -F'"' '{ print $4 }' acl_agent_token`
    VAULT_ACL="Vault_Server"

    echo "Creating Vault ACL ..."

    echo -e "${VAULT_ACL}: "
    curl -s -X PUT -d \
    '{"Name": "'${VAULT_ACL}'","Type": "client","Rules": "key \"\" { policy = \"read\" } key \"service/\" { policy = \"read\" } key \"service/batch_mailing/\" { policy = \"write\" } operator = \"read\"" }' http://$SERVER/v1/acl/create?token=$MASTER_TOKEN
    
    echo -e "\n"

    # java_mailing_acl

}


$@