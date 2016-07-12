namespace 'objectives' do
  task detect_types: :environment do
    titles = ["[SALES]  Deliver Revenue Target",
              "Increase leads/month by 5%",
              "Find 5 new leads source",
              "Deliver Q1 Bookings Target",
              "Deliver Renewal Business Plan on X accounts",
              "[PRODUCT]  Deliver Roadmaps",
              "Deliver Standalone Roadmap",
              "Deliver Onboarding Features",
              "Deliver new backoffice",
              "Deliver 100 new integrations",
              "Improve Scalability : Test 4x user base",
              "Maintain error rates to 0.2%",
              "Maintain number of GitHub issues to under 100",
              "[HR] Manage all costs",
              "Manage all costs and cash from 2016 budget",
              "Perform monthly closing",
              "Monthly PNL below budgeted costs",
              "Reduce amount overdue to < X k€",
              "Deliver 2016 recruitment plan : X hirings",
              "Limit staff turnover : 0 resignation in key staff",
              "8/10 employee satisfaction average",
              "1 chat with each manager per quarter",
              "[MARKETING]  Increase Customer Loyalty",
              "Feature Customers in our content",
              "Call X random customers to get feedback",
              "Create Referral Program",
              "Find 5 crazy reward ideas",
              "Have 10% of customers use the program once",
              "[SUPPORT] Satisfaction Client",
              "Volume de Contacts",
              "Taux de résolution",
              "Taux de service",
              "Stock de contacts",
              "Productivité équipe",
              "[PRODUCT] Build a Web Scraper to get plenty of leads",
              "Write patterns for 10 different sources",
              "Have 90% match success",
              "Scrape >10 pages per second",
              "[PRODUCT] 50 betatesteurs ont utilisé notre produit (JT)",
              "Avoir 20 betatesteurs qui ont été actifs",
              "Minimum 4 top objectifs créés par entreprise par trimestre",
              "1 MAJ Progrès minimum par utilisateur par semaine",
              "Identifier 5 power users, pour les suivre"]

    results = TypeDetector.results(titles)
    TypeDetector.csv_results(results)

    puts "results.csv file generated."
  end
end