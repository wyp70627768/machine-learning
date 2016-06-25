FROM ubuntu:14.04

## install git, and wget
RUN apt-get -y update
RUN apt-get -y install git=1:1.9.1-1ubuntu0.3
RUN apt-get -y install wget=1.15-1ubuntu1.14.04.2

## install puppet
RUN wget https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb
RUN dpkg -i puppetlabs-release-pc1-trusty.deb
RUN apt-get update -y
RUN apt-get install puppet-agent -y

## install r10k
RUN apt-get -y install rubygems-integration=1.5
RUN gem install r10k -v 2.2.0

## clone repository: allow puppet manifests to run (below)
RUN git clone https://jeff1evesque@github.com/jeff1evesque/machine-learning.git /var/machine-learning

## debug print
RUN /opt/puppetlabs/bin/puppet -V
RUN ls -l /var/machine-learning
RUN ls -l /var/machine-learning/hiera

## install puppet modules using puppetfile with r10k
RUN mkdir -p /var/machine-learning/puppet/environment/development/modules_contrib/
RUN PUPPETFILE=/var/machine-learning/test/Puppetfile PUPPETFILE_DIR=/var/machine-learning/puppet/environment/development/modules_contrib/ r10k puppetfile install

## provision with puppet
RUN for x in /var/machine-learning/puppet/environment/development/manifests/*.pp; do /opt/puppetlabs/bin/puppet apply "$x" --modulepath=/var/machine-learning/puppet/environment/development/modules_contrib:/var/machine-learning/puppet/environment/development/modules confdir=/var/machine-learning; done;
