library(tidyverse)
library(readxl)
library(KoNLP)
library(reshape2)
library(wordcloud2)
library(igraph)
library(tidygraph)
library(ggraph)


useNIADic()

# 고유명사 사전 추가가
mergeUserDic(data.frame(c("일기","청울림"), 
                        "ncn")) 

cafeWritten = readxl::read_excel("./data//naverCafeWrite_A.xlsx")
text_data = cafeWritten$title






m_df <- text_data %>%
  SimplePos09 %>%
  melt %>%
  as_tibble %>%
  select(3, 1)


# word cloud

m_df %>%
  mutate(noun=str_match(value, '([가-힣]+)/N')[,2]) %>%
  na.omit %>%
  filter(str_length(noun)>=2) %>%
  count(noun, sort=TRUE) %>%
  wordcloud2()



# sna

m_count <- m_df %>%
  mutate(noun=str_match(value, '([가-힣]+)/N')[,2]) %>%
  na.omit %>%
  filter(str_length(noun)>=2) %>%
  count(noun, sort=TRUE) %>%
  head(15)

m_df2 <- m_df %>%
  mutate(noun=str_match(value, '([가-힣]+)/N')[,2]) %>%
  na.omit %>%
  filter(str_length(noun)>=2) %>%
  select(3, 1)

m_df3 <- m_df2 %>%
  filter(noun %in% m_count$noun)

mg <- graph_from_data_frame(m_df3)


V(mg)$type <- bipartite_mapping(mg)$type
mm <- as_incidence_matrix(mg) %*% t(as_incidence_matrix(mg))
diag(mm) <- 0
mg <- graph_from_adjacency_matrix(mm)


# sna 초안
mg %>% as_tbl_graph() %>%
  ggraph() +
  geom_edge_link(aes(start_cap = label_rect(node1.name), end_cap = label_rect(node2.name))) +
  geom_node_text(aes(label=name))




bigram_df <- m_df2 %>%
  na.omit() %>%
  select(noun) %>%
  mutate(lead=lead(noun)) %>%
  unite(bigram, c(noun, lead), sep=" ") %>%
  count(bigram, sort=TRUE) %>%
  head(19) %>%
  separate(bigram, c('word1', 'word2'), sep=' ')


# bigram
bigram_df %>%
  as_tbl_graph %>%
  ggraph() +
  geom_edge_link(aes(start_cap = label_rect(node1.name), end_cap = label_rect(node2.name))) +
  geom_node_text(aes(label=name))









