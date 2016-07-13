# test-teamrise

## Requirements
ruby > 2.0
```
# Mac OSX
brew install postgresql

# Ubuntu
sudo apt-get install postgresql-9.3
sudo su postgres -c psql
CREATE ROLE <username> SUPERUSER LOGIN;
\q
```

## 1 Installation du projet
Récupérer le code :
```
git clone git@github.com:nemile/test-teamrise.git
```

Installer les dépendances :
```
bundle install
```

Enrichir la base de donée (voir [seeds.rb](https://github.com/nemile/test-teamrise/blob/master/db/seeds.rb#L1)):
```
rake db:create
rake db:migrate
rake db:seed
```

Naviguer vers l'index d'objectifs :
`rails s` et naviguer vers http://localhost:3000/objectives

Pour générer la détection de type d'objectifs à partir des exemples fournis
```
rake objectives:detect_types
```
Un fichier `results.csv` sera généré à la racine du projet.

## 2 Outil de visualisation d’organigramme

### 2.1 Modèle
#### Nested set
La difficulté du modèle réside dans l’association récursive sur les objectifs. Nous avons fait le choix d’une base de donnée relationnelle, car une base de données NoSQL avec dénormalisation du modèle entraînerait des documents très lourds et une répétition trop importante des données, dangereuse pour la consistance et longue à mettre à jour.

Puisque le but de l’exercice est d’afficher un organigramme, une simple clé étrangère parent_id qui pointe vers le parent d’un objectif entraînerait N+1 requêtes en base à l’affichage. Le dataset fourni ne contient que 3 niveaux de profondeur et ne nécessiterait que peu de requêtes; mais pour une grosse entreprise (avec beaucoup d’objectifs) l’affichage de l’organigramme serait lent.

C’est pourquoi nous stockons nos objectifs en base sous forme de nested set. Le nested set utilise deux colonnes “droite” et “gauche” qui permettent de déterminer pour un objectif un intervalle d’ids à requêter pour avoir ses descendants, et de les récupérer en une seule requête. Nous réduisons ainsi le nombre de requêtes au nombre d’objectifs de plus bas niveau.

#### Filtrage par équipe
Pour cette exercice, nous n’avons pas ajouté de clé étrangère team_id sur la table objectives. Pour filtrer par équipe, nous récupérons d’abord l’équipe et effectuons une jointure sur la table objectives.
Si nous voulions afficher tous les objectifs avec leur équipe, nous pourrions la rajouter, car la requête pour l’obtenir serait moins complexe que celle qui recherche le plus vieux parent avant et qui récupère son équipe. Dans cet exercice nous pouvons directement filtrer par équipe, donc nous l’avons omise.

#### Filtrage par niveau
Pour le filtrage par niveau, nous avons utilisé une colonne `level` qui est remplie à l’ajout d’un objectif. Nous avons également rajouté un index sur cette colonne pour booster le filtrage.

#### Filtrage d’objectifs terminés/en cours
Nous avons également réalisé un filtrage simple par état d’avancement. Pour ce faire nous comparons les colonnes progress_value et progress_target, et nous avons ajouté un index pour ces deux colonnes.

### 2.2 Cache de fragments
Afin de diminuer encore plus les requêtes en base, nous avons ajouté du cache sur le fichier `app/views/objectives/_objective.html.erb`. Si un objectif enfant est mis à jour, la clé de cache pour son parent expire, car le paramètre `touch: true` passé [ici](https://github.com/nemile/test-teamrise/blob/master/app/models/objective.rb#L3) met à jour la colonne `updated_at` de son parent, qui est utilisée dans la clé de cache.
l'appel à `render` effectué dans [index.html.erb](https://github.com/nemile/test-teamrise/blob/master/app/views/objectives/index.html.erb#L15) contient une option `cached: true` qui permet de fetcher depuis le cache avec un seul appel, ce qui réduit encore le chargement.

### 2.3 Injections SQL
L'utilisation de rails/arel nous permet de bénéficier du protection contre l'injection SQL.

### 2.4. Limites et améliorations
Le nested set est rapide en lecture, mais lent en écriture (il faut déterminer les valeurs à insérer dans les colonnes “droite” et “gauche’). Pour cette exercice ça n’est pas un problème, mais si l’application proposait l’ajout d’objectif n’importe où dans l’arbre suivi d’un ré-affichage, cela poserait une baisse de performance.
Pour contrer ce problème, on pourrait utiliser une API qui effectue l’insertion de manière asynchrone pendant que l’arbre est mis à jour de façon optimiste côté client, avec une librairie JS comme ReactJS qui effectuerait le rendu rapidement grâce à son DOM virtuel.

## 3 Détection de type d’objectif
Un petit module permettant d’automatiser la détection des types d’objectif à été ajouté au dossier lib/ du projet. Des résultats sont disponibles ici : https://docs.google.com/spreadsheets/d/1qozyFCqRES6bydRdB2rK9gZlLrIWCOjCaKUdw-WliPw/edit?usp=sharing

### 3.1 Fonctionnement
Son fonctionnement est basé sur des expressions régulières qui tentent de remplir les critères suivant :
- détecter des nombres correspondant à des quantités (ne pas matcher les potentielles dates)
- détecter des unités
- détecter des fréquences

A partir des chaines de caractères récupérées, nous pouvons déterminer le type d’un objectif.

### 3.2 Limites et améliorations
Certains types d’objectifs on mal été détectés, pour plusieurs raisons :
- aucun système de détection de langue n’a été mis en place.
- les fréquences à matcher ne sont pas exhaustives.

Il faudrait améliorer ces points :
- rajouter des unités (unités SI par exemple), des fréquences.
- détecter si l’objectif concerne l’augmentation ou la diminution de sa valeur pour savoir si progress_start est 0 ou n’est pas déductible, i.e. rajouter la détection de termes comme “increase”, “below”...

De manière générale, il faut enrichir les différents lexiques utilisés pour maximiser les résultats.

