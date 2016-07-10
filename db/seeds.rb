# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

executive = Team.create({ name: 'Executive' })
hr = Team.create({ name: 'HR' })
product = Team.create({ name: 'Product' })

john = product.users.create({ email: 'john@teamrise.io', name: 'John Thillaye du Boullay' })
anne_sophie = hr.users.create({ email: 'anne-sophie@teamrise.io', name: 'Anne-Sophie Vasseur' })
gautier = executive.users.create({ email: 'gmachelon@multiposting.fr', name: 'Gautier Machelon' })
guillaume = executive.users.create({ email: 'guillaume@teamrise.io', name: 'Guillaume Berthault' })

obj1 = Objective.create({
  title: 'Livrer le plan de recrutement Q2',
  progress_start: 0,
  progress_target: 100,
  progress_value: 0,
  progress_unit: '%',
  owner: anne_sophie
})
obj1.children.create({
  title: 'Recruter un stagiaire bras droit',
  progress_start: 0,
  progress_target: 100,
  progress_value: 100,
  progress_unit: '%',
  owner: anne_sophie
})
obj1_1 = obj1.children.create({
  title: 'Recruter un développeur',
  progress_start: 0,
  progress_target: 100,
  progress_value: 30 ,
  progress_unit: '%',
  owner: john
})
obj1_1.children.create([
  {
    title: 'Rencontrer 4 prospects par semaine',
    progress_start: 0,
    progress_target: 4,
    progress_value: 0,
    owner: john
  },
  {
    title: 'Ecrire un test developpeur',
    progress_start: 0,
    progress_target: 100,
    progress_value: 0,
    progress_unit: '%',
    owner: john
  },
  {
    title: 'Formaliser le process jour par jour',
    progress_start: 0,
    progress_target: 100,
    progress_value: 0,
    progress_unit: '%',
    owner: john
  }
])

obj2 = Objective.create({
  title: 'Avoir la meilleure application du marché',
  progress_start: 0,
  progress_target: 100,
  progress_value: 0,
  progress_unit: '%',
  owner: john
})
obj2.children.create([
  {
    title: 'Identifier les 5 nouvelles fonctionnalités les plus demandées',
    progress_start: 0,
    progress_target: 5,
    progress_value: 0,
    owner: john
  },
  {
    title: 'Identifier les 3 pain points les plus fréquents',
    progress_start: 0,
    progress_target: 3,
    progress_value: 0,
    owner: john
  },
  {
    title: 'Identifier les 3 fonctionnalités qui marchent le mieux',
    progress_start: 0,
    progress_target: 3,
    progress_value: 0,
    owner: john
  }
])

obj3 = Objective.create({
  title: 'Se développer toujours plus rapidement',
  progress_start: 0,
  progress_target: 100,
  progress_value: 0,
  progress_unit: '%',
  owner: gautier
})
obj3.children.create([
  {
    title: 'Rejoindre le meilleur incubateur de Paris',
    progress_start: 0,
    progress_target: 100,
    progress_value: 0,
    progress_unit: '%',
    owner: gautier
  },
  {
    title: 'Élaborer la stratégie à deux ans',
    progress_start: 0,
    progress_target: 100,
    progress_value: 0,
    progress_unit: '%',
    owner: gautier
  }
])

obj4 = Objective.create({
  title: 'Release V0',
  progress_start: 0,
  progress_target: 100,
  progress_value: 0,
  progress_unit: '%',
  owner: john
})
obj4.children.create([
  {
    title: "Mettre en place les systèmes de suivi et d'analytics",
    progress_start: 0,
    progress_target: 100,
    progress_value: 50 ,
    progress_unit: '%',
    owner: john
  },
  {
    title: 'Imaginer 3 scénarios bêtatesteur et tester en amont différentes configurations',
    progress_start: 0,
    progress_target: 3,
    progress_value: 0,
    owner: john
  }
])
