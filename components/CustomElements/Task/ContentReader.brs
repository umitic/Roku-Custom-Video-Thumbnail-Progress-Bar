sub init()
    print "ContentReader " ; "init()"
         
    m.top.functionName = "readContent"
end sub

sub readContent()
    print "ContentReader " ; "readContent()"
    content = createObject("roSGNode", "ContentNode")
    
    contentXml = createObject("roXMLElement")
    
    xmlString = ReadAsciiFile(m.top.contenturi)
    
    contentXml.parse(xmlString)

    if contentXml.getName() = "Content"
        for each item in contentXml.GetNamedElements("item")
            markupGridItem = content.createChild("ContentNode")
            markupGridItem.setFields(item.getAttributes())
        end for
    end if


    m.top.content = content
end sub