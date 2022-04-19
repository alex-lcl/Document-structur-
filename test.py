from lxml import etree

def get_mapscene(idScene:str()):
    parser = etree.HTMLParser()
    tree = etree.parse("templates/map.html", parser)
    visible = False
    for element in tree.findall('//svg'):
        for child in element:
            attrList = child.items()
            for attr in attrList:
                if attr[0] == 'id' and attr[1] == idScene:
                    print(attr, child)
                    child.set('visibility', 'hidden')
                    break
    tree.write("templates/map.html", method="html")


get_mapscene("scene01")