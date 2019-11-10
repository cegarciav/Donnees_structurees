from lxml import etree
from io import StringIO

#Constants
file_name = "ponctualite-mensuelle-transilien-2.xml"
dtd_included = True
dtd_file = "external_dtd.dtd"
encoding_dtd = "UTF-8"

#File opened and stored in memory
with open(file_name, 'rb') as file:
    data = file.read()

#Validate file
if dtd_included:
    parser = etree.XMLParser(dtd_validation=True)
    try:
        root = etree.fromstring(data, parser)
        print("File well formed and validated from internal dtd")
    except etree.XMLSyntaxError as err:
        print("We've found the following error on this file:")
        print(err)
else:
    with open(dtd_file, 'r', encoding=encoding_dtd) as file:
        dtd_data = file.read()
    try:
        root = etree.fromstring(data)

        #Getting content of doctype
        start_limit = dtd_data.find("[") + 1
        end_limit = dtd_data.find("]")
        dtd_data = dtd_data[start_limit : end_limit]
        dtd_data = StringIO(dtd_data)
        dtd = etree.DTD(dtd_data)

        if dtd.validate(root):
            print("File well formed and validated from external dtd")
        else:
            print("We've found the following error on this file:")
            print(dtd.error_log.filter_from_errors()[0])
    except etree.DTDParseError as err:
        print("DTD file not valid")
    except etree.XMLSyntaxError as err:
        print("We've found the following error on this file:")
        print(err)
