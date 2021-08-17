#!/bin/bash

# 1. Baixar
for m in `seq 1 9`; do 
    curl -OJL http://www.portaltransparencia.gov.br/download-de-dados/licitacoes/20200$m; 
    curl -OJL http://www.portaltransparencia.gov.br/download-de-dados/licitacoes/20210$m; 
done

for m in `seq 10 12`; do 
    curl -OJL http://www.portaltransparencia.gov.br/download-de-dados/licitacoes/2020$m; 
    curl -OJL http://www.portaltransparencia.gov.br/download-de-dados/licitacoes/2021$m; 
done

# 2. Descompactar. N
# o Mac OS precisei usar "open". Unzip e gunzip não funcionaram devido ao encoding

# 3. Iso 8859-1 para UTF8
for d in 202?0[1-9]*es; do 
    cd $d; 
    for f in `ls`; do 
        iconv -f iso-8859-1 -t utf-8 < $f > utf8-$f; 
    done; 
    cd -; 
done

for d in 202?1[012]*es; do 
    cd $d; 
    for f in `ls`; do 
        iconv -f iso-8859-1 -t utf-8 < $f > utf8-$f; 
    done; 
    cd -; 
done