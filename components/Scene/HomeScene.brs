sub init()
    print "HomeScreen " ; "init()"
    
    m.layoutTop = m.top.findNode("layoutTop")
    m.progressBar = m.top.findNode("progressBar")
    m.markupGrid = m.top.findNode("markupGrid")
    m.video = m.top.findNode("videos")
    
    m.readMarkupGridTask = createObject("roSGNode", "ContentReader")
    m.readMarkupGridTask.contenturi = "pkg:/components/customContent.xml"
    m.readMarkupGridTask.observeField("content", "showMarkupGrid")
    m.readMarkupGridTask.control = "RUN"
        
    m.markupGrid.setFocus(true)
    
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.streamformat = "mp4"
    videoContent.url = "http://roku.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/f8de8daf2ba34aeb90edc55b2d380c3f/b228eeaba0f248c48e01e158f99cd96e/rr_123_segment_1_072715.mp4"
    videoContent.title = "Roku Video"
    
    m.video.content = videoContent
    
    m.video.observeField("state", "onVideoState")   
end sub

sub showMarkupGrid()
    print "HomeScreen " ; "showMarkupGrid()"    

    m.markupGrid.content = m.readMarkupGridTask.content
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    print "HomeScreen " ; "onKeyEvent()"     
  
  handled = false
  if press 
    if (key = "OK")
        if  m.markupGrid.hasFocus()
            playVideo()
         end if
    
    else if (key = "back")
        if m.video.state = "playing"
           onVideoPosition()    
        end if   
        
        if m.video.visible
            m.video.control = "stop"
            returnToHS()
            handled = true  
        end if
    
    end if
  end if
  return handled
end function

function playVideo() as void
    print "HomeScreen " ; "playVideo()"    
    
    m.video.visible = true
    m.video.setFocus(true)  
    m.video.control = "play"
end function

sub onVideoState()
    print "HomeScreen " ; "onVideoState()"
    
    if m.video.state = "finished"
        returnToHS()
        onVideoPosition()
    end if
end sub

sub returnToHS()
    print "HomeScreen " ; "returnToHS()"
    
    m.video.visible = "false"
    m.markupGrid.setFocus(true)
end sub

sub onVideoPosition()
    print "HomeScreen " ; "onVideoPosition()"
    
    'setting progressBar to itemPoster width
    m.markupGrid.content.getChild(m.markupGrid.itemFocused).progressBarWidth = m.markupGrid.content.getChild(m.markupGrid.itemFocused).posterWidth
    'calculating percent of watched content 
    passedVideoProgress = (m.video.position / m.video.duration) * 100
    'calculating progress bar width based on percent of watched content
    passedProgreesBar = (m.markupGrid.content.getChild(m.markupGrid.itemFocused).progressBarWidth / 100) *  passedVideoProgress
        
    m.markupGrid.content.getChild(m.markupGrid.itemFocused).progressBarWidth = passedProgreesBar
end sub