library(tidyverse)

read_batch = function(dir_pai, mascara, col_types) {
    arqs = fs::dir_ls(
        path = here::here(dir_pai),
        glob = mascara,
        recurse = 1
    )
    
    read_csv2(arqs, col_types = col_types, id = "path") %>%
        janitor::clean_names()
}

raw2ready_licitacoes = function(dir_pai = "data/raw-portal/") {
    mascara = "*/utf8*_Licit*csv"
    col_types = cols(
        .default = col_character(),
        `Data Resultado Compra` = col_date(format = "%d/%M/%Y"),
        `Data Abertura` = col_date(format = "%d/%M/%Y"),
        `Valor Licitação` = col_double()
    )
    
    lics_raw = read_batch(dir_pai, mascara, col_types = col_types)
    
    lics = lics_raw %>%
        mutate(arquivo = str_extract(path, "\\d{6}_Licitacoes")) %>%
        select(-path)
    
    lics %>%
        write_csv(here::here("data/ready/licitacoes-portal.csv"))
}

raw2ready_emps_relac = function(dir_pai = "data/raw-portal/") {
    mascara = "*/utf8*EmpenhosRelacionados*csv"
    col_types = cols(
        .default = col_character(),
        `Data Emissão Empenho` = col_date(format = "%d/%M/%Y"),
        `Valor Empenho (R$)` = col_double()
    )
    
    raw = read_batch(dir_pai, mascara, col_types = col_types)
    
    ready = raw %>%
        mutate(arquivo = str_extract(path, "\\d{6}_EmpenhosRelacionados")) %>%
        select(-path)
    
    ready %>%
        write_csv(here::here("data/ready/empenhosrelacionados-portal.csv"))
}

main <- function(argv = NULL) {
    raw2ready_licitacoes()
    message("Licitações ready")
    raw2ready_emps_relac()
    message("Empenhos Relacionados ready")
}

if (!interactive()) {
    argv <- commandArgs(TRUE) 
    main(argv)
}