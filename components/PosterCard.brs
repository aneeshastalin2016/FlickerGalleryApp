sub init()
    m.thumb = m.top.findNode("thumb")
    m.titleLabel = m.top.findNode("titleLabel")
   m.scaleGroup=m.top.findNode("scaleGroup")
end sub

sub showContent()
    item = m.top.itemContent
    if item = invalid then return

    if item.hasField("HDPosterUrl")
        m.thumb.uri = item.HDPosterUrl
    else
        m.thumb.uri = ""
    end if

    if item.hasField("title")
        m.titleLabel.text = item.title
    else
        m.titleLabel.text = ""
    end if
end sub

sub showFocus()
    fp = m.top.focusPercent
    print"fp",fp 
    if fp > 0. 'focused'

        m.scaleGroup.scale = [1.06, 1.06] 'zoom in
        m.scaleGroup.translation = [1, 1]
    else
        m.scaleGroup.scale = [1.0, 1.0] 'normal pose
        m.scaleGroup.translation = [0, 0]
    end if
end sub

