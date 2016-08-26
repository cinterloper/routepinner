FROM cinterloper/lash
RUN apt install -y net-tools libboost-dev
RUN cd /opt; wget https://downloads.powerdns.com/releases/pdns-recursor-4.0.1.tar.bz2; tar -jxvf pdns-recursor-4.0.1.tar.bz2
RUN cd /opt/pdns-recursor-4.0.1; ./configure --with-luajit --with-lua --with-gnu-ld; make -j4; make install
RUN mkdir -p /usr/share/dns
ADD root.hints /usr/share/dns/
ADD . /opt/routepinner
RUN luarocks install httpclient
RUN cd /opt/routepinner; ln -sf /usr/local/share/lua/ ./
CMD bash -c 'source /etc/bash.bashrc; cd /opt/routepinner; source startup.sh; startup_func'

