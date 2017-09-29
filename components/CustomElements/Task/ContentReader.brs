sub init()
    print "ContentReader " ; "init()"
         
    m.top.functionName = "readContent"
end sub

sub readContent()
    print "ContentReader " ; "readContent()"
    
    customContent = createObject("roSGNode", "customContent")
    
    for i = 0 to 2
        customContent.createChild("customContent")
    end for

    m.top.content = customContent
end sub