

X11_Liga <- read_excel("11_Liga.xlsx")

#Resumes statistiques 
#proportion de joueurs par poste
jr_poste <- X11_Liga %>% 
  mutate(Poste = as.factor(Poste)) %>%  
  group_by(Poste) %>%                  
  summarise(
    Effectif = n(),                     # Effectif total par poste
    Proportion = n() / nrow(data)       # Proportion de joueurs par poste
  )
print(jr_poste)

# Résumé statistique des variables par club
resum_stat <- data %>% 
  group_by(Club) %>% 
  summary()  # Moyenne, médiane, etc. pour chaque club
print(resum_stat)

# Analyse des buts par club
but_club <- data %>%
  group_by(Club) %>% 
  summarise(nb_buts = sum(Buts)) %>% 
  arrange(desc(nb_buts))  # Tri des clubs par nombre total de buts
View(but_club)


# Filtrage des clubs ayant marqué plus de 25 buts
buts_club_filtrer <- but_club %>% 
  filter(nb_buts > 25)
buts_club_filtrer


# Calcul de la moyenne des buts des clubs filtrés
moyenne_buts <- mean(buts_club_filtrer$nb_buts)

# Calcul et visualisation de la proportion de passes par club
prop_passe_par_club <- data %>% 
  group_by(Club) %>% 
  summarise(prop_passes = sum(`%Passes`, na.rm = T) / n())
View(prop_passe_par_club)



#Pour réaliser les boîtes à moustaches :
# Analyse et visualisation des clubs spécifiques
clubs_specifiques <- c("Barcelona", "Real Madrid", "Atlético", "Athletic Bilbao")

buts_club_filtrer_selection <- data %>%
  filter(Club %in% clubs_specifiques) %>% 
  arrange(desc(Buts))

# Liste des clubs à comparer
clubs_specifiques <- c("Barcelona", "Real Madrid", "Atlético", "Athletic")

# Filtrer les données pour les clubs spécifiés
data_clubs_specifiques <- data %>%
  filter(Club %in% clubs_specifiques)

# Analyse et visualisation des clubs spécifiques
clubs_specifiques <- c("Barcelona", "Real Madrid", "Atlético", "Athletic Bilbao")
buts_club_filtrer_selection <- data %>%
  filter(Club %in% clubs_specifiques) %>% 
  arrange(desc(Buts))


#Pour réaliser le graphique de moyenne des pourcenatges de passes par club 
# Calcul de la moyenne des pourcentages de passes pour chaque club sélectionné
mean_passes_per_club <- data_clubs_specifiques %>%
  group_by(Club) %>%
  summarise(mean_passes = mean(`%Passes`, na.rm = TRUE))




# Interface utilisateur
ui <- fluidPage(
  titlePanel("Analyse des données de la Liga"),
  sidebarLayout(
    sidebarPanel(
      selectInput("club", "Sélectionnez un club :", choices = unique(data$Club)),
      numericInput("seuil", "Seuil de buts :", value = 0, min = 0),
      actionButton("update", "Mettre à jour")
    ),
    mainPanel(
      plotOutput("plot_buts")
    )
  )
)

# Serveur
server <- function(input, output) {
  filtered_data <- eventReactive(input$update, {
    data %>%
      filter(Club == input$club, Buts > input$seuil)
  })
  
  output$plot_buts <- renderPlot({
    ggplot(filtered_data()) +
      aes(x = Joueur, y = Buts, fill = Joueur) +
      geom_col() +
      labs(
        title = paste("Nombre de buts pour", input$club),
        x = "Joueur",
        y = "Buts"
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1, size = 10) # Inclinaison des noms
      )
  })
}


# Analyse des meilleurs buteurs du championnat
classement_buteurs <- data %>%
  group_by(Joueur) %>% 
  summarise(nb_buts = sum(Buts)) %>% 
  arrange(desc(nb_buts))  # Tri des joueurs par nombre total de buts
View(classement_buteurs)

