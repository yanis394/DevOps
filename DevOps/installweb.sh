set -e

echo "📦 Installation d’Apache et PHP..."
apt update
apt install -y apache2 php libapache2-mod-php php-mysqli

echo "🔄 Redémarrage d’Apache..."
systemctl restart apache2

echo "🎉 Serveur web prêt sur http://192.168.44.101/dbtest.php"