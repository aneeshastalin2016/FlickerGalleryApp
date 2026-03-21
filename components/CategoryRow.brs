' sub init()
'     m.rowTitle = m.top.findNode("rowTitle")
'     m.grid = m.top.findNode("grid")

'     m.top.observeField("title", "onTitleChanged")
'     m.top.observeField("items", "onItemsChanged")
'     m.grid.observeField("itemSelected", "onItemSelected")
' end sub

' sub onTitleChanged()
'     m.rowTitle.text = m.top.title
' end sub

' sub onItemsChanged()
'     content = CreateObject("roSGNode", "ContentNode")

'     if m.top.items <> invalid
'         for each itemAA in m.top.items
'             itemNode = CreateObject("roSGNode", "ContentNode")
'             itemNode.title = SafeGet(itemAA, "title", "Untitled")
'             itemNode.HDPosterUrl = SafeGet(itemAA, "thumb", "")
'             itemNode.description = SafeGet(itemAA, "description", "")
'             content.appendChild(itemNode)
'         end for
'     end if

'     m.grid.content = content
'     m.grid.jumpToItem = 0
' end sub

' sub onItemSelected()
'     idx = m.grid.itemSelected
'     if idx < 0 or m.top.items = invalid or idx >= m.top.items.Count()
'         return
'     end if

'     m.top.selectedItem = m.top.items[idx]
' end sub

' sub setFocusToGrid()
'     m.grid.setFocus(true)
' end sub

' function rowInFocusChain() as Boolean
'     return m.grid.isInFocusChain() or m.top.isInFocusChain()
' end function

' function onKeyEvent(key as String, press as Boolean) as Boolean
'     if not press then return false

'     if key = "up" or key = "down"
'         return false
'     end if

'     if not m.grid.hasFocus()
'         m.grid.setFocus(true)
'         return true
'     end if

'     return false
' end function

' sub init()
'     m.rowTitle = m.top.findNode("rowTitle")
'     m.grid = m.top.findNode("grid")

'     m.top.observeField("title", "onTitleChanged")
'     m.top.observeField("items", "onItemsChanged")
'     m.grid.observeField("itemSelected", "onItemSelected")
' end sub

' sub onTitleChanged()
'     m.rowTitle.text = m.top.title
' end sub

' sub onItemsChanged()
'     content = CreateObject("roSGNode", "ContentNode")

'     if m.top.items <> invalid
'         for each itemAA in m.top.items
'             itemNode = CreateObject("roSGNode", "ContentNode")
'             itemNode.title = SafeGet(itemAA, "title", "Untitled")
'             itemNode.HDPosterUrl = SafeGet(itemAA, "thumb", "")
'             itemNode.description = SafeGet(itemAA, "description", "")
'             content.appendChild(itemNode)
'         end for
'     end if

'     m.grid.content = content
'     m.grid.jumpToItem = 0
' end sub

' sub onItemSelected()
'     idx = m.grid.itemSelected
'     if idx < 0 or m.top.items = invalid or idx >= m.top.items.Count()
'         return
'     end if

'     m.top.selectedItem = m.top.items[idx]
' end sub

' sub setFocusToGrid()
'     if m.grid <> invalid
'         m.grid.setFocus(true)
'     end if
' end sub

' function onKeyEvent(key as String, press as Boolean) as Boolean
'     if not press then return false

'     if key = "left" or key = "right" or key = "OK"
'         if m.grid <> invalid and not m.grid.hasFocus()
'             m.grid.setFocus(true)
'             return true
'         end if
'     end if

'     return false
' end function


sub init()
    m.rowTitle = m.top.findNode("rowTitle")
    m.grid = m.top.findNode("grid")

    m.top.observeField("title", "onTitleChanged")
    m.top.observeField("items", "onItemsChanged")
    m.grid.observeField("itemSelected", "onItemSelected")
end sub

sub onTitleChanged()
    m.rowTitle.text = m.top.title
end sub

sub onItemsChanged()
    content = CreateObject("roSGNode", "ContentNode")

    if m.top.items <> invalid
        for each itemAA in m.top.items
            itemNode = CreateObject("roSGNode", "ContentNode")
            itemNode.title = SafeGet(itemAA, "title", "Untitled")
            itemNode.HDPosterUrl = SafeGet(itemAA, "thumb", "")
            itemNode.description = SafeGet(itemAA, "description", "")
            content.appendChild(itemNode)
        end for
    end if

    m.grid.content = content
    m.grid.jumpToItem = 0
end sub

sub onItemSelected()
    idx = m.grid.itemSelected
    if idx < 0 or m.top.items = invalid or idx >= m.top.items.Count()
        return
    end if

    m.top.selectedItem = m.top.items[idx]
end sub

sub setFocusToGrid()
    if m.grid <> invalid
        m.grid.setFocus(true)
        m.grid.jumpToItem = 0
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then return false

    if key = "up" or key = "down"
        return false
    end if

    if m.grid <> invalid and not m.grid.hasFocus()
        m.grid.setFocus(true)
        return true
    end if

    return false
end function