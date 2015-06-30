# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

cd /tmp
wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

install 'Elixir' elixir
echo 'installing phoenix'
mix local.hex
mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v0.14.0/phoenix_new-0.14.0.ez
install 'Inotify' inotify-tools

install 'Git' git
install 'memcached' memcached
install 'Redis' redis-server
install 'RabbitMQ' rabbitmq-server

install 'PostgreSQL' postgresql postgresql-contrib libpq-dev

# sudo -u postgres createuser --superuser vagrant

sudo -u postgres createuser -d -U postgres dev_user
sudo -u postgres psql -c "ALTER USER dev_user WITH PASSWORD 'secret' CREATEDB;"
sudo -u postgres createuser -d -U postgres test_user
sudo -u postgres psql -c "ALTER USER test_user WITH PASSWORD 'secret' CREATEDB;"

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
install 'MySQL' mysql-server libmysqlclient-dev
mysql -uroot -proot <<SQL
CREATE USER 'dev_user'@'localhost';
GRANT ALL PRIVILEGES ON *.* to 'dev_user'@'localhost';
CREATE USER 'test_user'@'localhost';
GRANT ALL PRIVILEGES ON *.* to 'test_user'@'localhost';
SQL

install 'ExecJS runtime' nodejs npm
update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo 'all set, rock on!'
