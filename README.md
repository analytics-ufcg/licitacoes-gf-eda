# Licitações, contratos e itens do Gov Federal

EDA dos dados no Portal de Transparência do GF sobre Licitações, contratos e itens

Para obter os dados:

```
mkdir -p data/raw-portal
cd data/raw-portal
../../code/fetch_data.sh
cd -
./code/import_licitacoes.R
```

Com os dados, o report em `reports/match-licitacao-empenho.Rmd` explora o número de licitações e licitações com empenhos associados.