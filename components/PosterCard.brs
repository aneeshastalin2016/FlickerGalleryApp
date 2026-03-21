' sub init()
'     m.thumb = m.top.findNode("thumb")
'     m.focusRect = m.top.findNode("focusRect")
'     m.titleLabel = m.top.findNode("titleLabel")
' end sub

' sub showContent()
'     item = m.top.itemContent
'     if item = invalid then return

'     m.thumb.uri = SafeGetNodeField(item, "HDPosterUrl")
'     m.titleLabel.text = SafeGetNodeField(item, "title")
' end sub

' sub showFocus()
'     fp = m.top.focusPercent
'     m.focusRect.visible = (fp > 0)
'     if fp > 0
'         m.thumb.scale = [1.04, 1.04]
'     else
'         m.thumb.scale = [1.0, 1.0]
'     end if
' end sub

' function SafeGetNodeField(node as Object, fieldName as String) as String
'     if node <> invalid and node.hasField(fieldName)
'         value = node[fieldName]
'         if value <> invalid then return value
'     end if
'     return ""
' end function


sub init()
    m.thumb = m.top.findNode("thumb")
    'm.focusRect = m.top.findNode("focusRect")
    m.titleLabel = m.top.findNode("titleLabel")
   ' m.thumb=m.top.findNode("thumb")
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

    if fp > 0

        m.scaleGroup.scale = [1.06, 1.06]
        m.scaleGroup.translation = [-4, -3]
    else
       ' m.focusRect.visible = false
        m.scaleGroup.scale = [1.0, 1.0]
         m.scaleGroup.translation = [0, 0]
    end if
    ' scale = 1 + (m.top.focusPercent * 0.08)
    '   m.thumb.scale = [scale, scale]
end sub
' sub showrowfocus()
'       m.focusRect.opacity = 0.75 - (m.top.rowFocusPercent * 0.75)
'       m.titleLabel.opacity = m.top.rowFocusPercent
'       m.focusRect.visible=false
'     end sub