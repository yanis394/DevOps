set -e

echo "📦 Installation de MariaDB..."
apt update
apt install -y mariadb-server mariadb-client ufw

MYSQL_ROOT_PASSWORD="rootpass"
DB_NAME="mabase"
DB_USER="webuser"
DB_PASSWORD="superpassword"
WEB_IP="192.168.44.102"  

echo "🔒 Configuration du mot de passe root..."
mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}'); FLUSH PRIVILEGES;"

echo "⚙️ Configuration de bind-address pour autoriser les connexions distantes..."
sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

echo "🔄 Redémarrage de MariaDB..."
systemctl restart mariadb

echo "🛠️ Création de la base et de l'utilisateur..."
mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'${WEB_IP}' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'${WEB_IP}';
FLUSH PRIVILEGES;
EOF