import csv
from lxml import etree

with open("ponctualite-mensuelle-transilien.csv", encoding="ISO-8859-1") as file:
    reader = csv.reader(file, delimiter=';')
    headers = next(reader)
    content = [{headers[nb] : x[nb] for nb in range(len(headers))} for x in reader]

root = etree.Element("Services")
for line in content:
    service = [x for x in root if line["Service"] in [y.text for y in x]]
    if len(service) == 0:
        service = etree.SubElement(root, "Service")
        service_nom = etree.SubElement(service, "Nom")
        service_nom.text = line["Service"]
    else:
        service = service[0]

    ligne = [x for x in service if line["Ligne"] in [y.text for y in x]]
    if len(ligne) == 0:
        ligne = etree.SubElement(service, "Ligne")
        ligne_id = etree.SubElement(ligne, "ID")
        ligne_id.text = line["Ligne"]
        ligne_nom = etree.SubElement(ligne, "Nom")
        ligne_nom.text = line["Nom de la ligne"]
        ligne_train = etree.SubElement(ligne, "Train")
        train_id = etree.SubElement(ligne_train, "ID")
        train_id.text = line["ID"]
        train_punctuality = etree.SubElement(ligne_train, "Ponctualite")
        punctuality_date = etree.SubElement(train_punctuality, "Date")
        punctuality_date.text = line["Date"]
        punctuality_taux = etree.SubElement(train_punctuality, "Taux")
        punctuality_taux.text = line["Taux de ponctualité"]
        punctuality_atTime = etree.SubElement(train_punctuality, "PonctuelParRetard")
        punctuality_atTime.text = line["Nombre de voyageurs à l'heure pour un voyageur en retard"]
    else:
        ligne = ligne[0]
        ligne_train = [x for x in ligne if line["ID"] in [y.text for y in x]][0]
        train_punctuality = etree.SubElement(ligne_train, "Ponctualite")
        punctuality_date = etree.SubElement(train_punctuality, "Date")
        punctuality_date.text = line["Date"]
        punctuality_taux = etree.SubElement(train_punctuality, "Taux")
        punctuality_taux.text = line["Taux de ponctualité"]
        punctuality_atTime = etree.SubElement(train_punctuality, "PonctuelParRetard")
        punctuality_atTime.text = line["Nombre de voyageurs à l'heure pour un voyageur en retard"]

print(etree.tostring(root, pretty_print=True, encoding="unicode"))
