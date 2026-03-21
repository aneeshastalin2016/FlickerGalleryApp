sub init()
    m.statusLabel = m.top.findNode("statusLabel")
    m.spinner = m.top.findNode("spinner")
    m.rowsGroup = m.top.findNode("rowsGroup")
    m.currentRowIndex = 0
' m.rowSpacing = 120
m.rowSpacing = 140
m.baseRowsY = 150
m.spinner.visible=true
m.spinner.control="start"
m.visibleTopRowOffset = 1

    m.detailGroup = m.top.findNode("detailGroup")
    m.detailPoster = m.top.findNode("detailPoster")
    m.detailTitle = m.top.findNode("detailTitle")
    m.detailMeta = m.top.findNode("detailMeta")
    m.detailDescription = m.top.findNode("detailDescription")

    m.feedTask = m.top.findNode("feedTask")
    m.detailTask = m.top.findNode("detailTask")

    m.feedTask.observeField("content", "onFeedLoaded")
    m.feedTask.observeField("errorMessage", "onFeedError")
    m.detailTask.observeField("content", "onDetailLoaded")
    m.detailTask.observeField("errorMessage", "onDetailError")

    m.rows = []
    buildEmptyRows()

    m.feedTask.control = "RUN"
end sub

sub buildEmptyRows()
    cfg = GetAppConfig()
    y = 0
    ' m.currentRowIndex = 0

    for each cat in cfg.categories
        row = CreateObject("roSGNode", "CategoryRow")
        row.translation = [0, y]
        row.title = cat.title
        row.observeField("selectedItem", "onRowItemSelected")
        m.rowsGroup.appendChild(row)
        m.rows.Push(row)
        ' y = y + 150
        y=y+m.rowSpacing
    end for
m.rowsGroup.translation = [40, m.baseRowsY]

    if m.rows.Count() > 0
        m.currentRowIndex=0
        focusRowByIndex(0)
    end if
end sub

sub onFeedLoaded()
    data = m.feedTask.content
    if data = invalid
        m.statusLabel.text = "No data returned"
        m.spinner.control="stop"
        m.spinner.visible = false
        return
    end if
 m.spinner.control="stop"
    m.spinner.visible = false
    m.statusLabel.text = "Use remote arrows to browse. OK to open details."

    for i = 0 to m.rows.Count() - 1
        if i < data.Count()
            rowData = data[i]
            if rowData <> invalid and rowData.DoesExist("items")
                m.rows[i].title = rowData.title
                m.rows[i].items = rowData.items
            end if
        end if
    end for

    if m.rows.Count() > 0
        m.rows[0].setFocus(true)
        m.rows[0].callFunc("setFocusToGrid")
    end if
end sub

sub onFeedError()
     m.spinner.control="stop"
    m.spinner.visible = false
    if m.feedTask.errorMessage <> invalid and m.feedTask.errorMessage <> ""
        m.statusLabel.text = m.feedTask.errorMessage
    else
        m.statusLabel.text = "Unable to load Flickr data."
    end if
end sub

sub onRowItemSelected(event as Object)
    selected = event.getData()
    if selected = invalid then return

    m.statusLabel.text = "Loading details..."
    
    m.spinner.visible = true
 m.spinner.control="start"
    m.detailTask.photo = selected
    m.detailTask.control = "RUN"
end sub

sub onDetailLoaded()
     m.spinner.control="stop"
    m.spinner.visible = false

    info = m.detailTask.content
    if info = invalid then return

    m.detailTitle.text = SafeGet(info, "title", "Untitled")
    m.detailDescription.text = SafeGet(info, "description", "No description available.")
    m.detailPoster.uri = SafeGet(info, "imageUrl", "")
    m.detailMeta.text = SafeGet(info, "metaText", "Metadata unavailable")

    m.detailGroup.visible = true
    m.statusLabel.text = "Detail view open"
end sub

sub onDetailError()
     m.spinner.control="stop"
    m.spinner.visible = false
    m.statusLabel.text = "Failed to load image details."
end sub

' function onKeyEvent(key as String, press as Boolean) as Boolean
'     if not press then return false

'     if m.detailGroup.visible
'         if key = "back"
'             m.detailGroup.visible = false
'             m.statusLabel.text = "Use remote arrows to browse. OK to open details."
'             focusRowByIndex(m.currentRowIndex)
'             return true
'         end if
'         return false
'     end if

'     if key = "down"
'         if m.currentRowIndex < m.rows.Count() - 1
'             m.currentRowIndex = m.currentRowIndex + 1
'             focusRowByIndex(m.currentRowIndex)
'             return true
'         end if
'     else if key = "up"
'         if m.currentRowIndex > 0
'             m.currentRowIndex = m.currentRowIndex - 1
'             focusRowByIndex(m.currentRowIndex)
'             return true
'         end if
'     end if

'     return false
' end function
function onKeyEvent(key as String, press as Boolean) as Boolean
     if not press then return false
if m.detailGroup.visible
        if key = "back"
            m.detailGroup.visible = false
            m.statusLabel.text = "Use remote arrows to browse. OK to open details."
            focusRowByIndex(m.currentRowIndex)
            return true
        end if
        return false
    end if

    ' if key = "down"
    '     if m.currentRowIndex < m.rows.Count() - 1
    '         print "m.rows.Count()"m.rows.Count()
    '         print "m.currentRowIndex"m.currentRowIndex
    '         m.currentRowIndex = m.currentRowIndex + 1
    '         print "m.currentRowIndex1"m.currentRowIndex
    '         focusRowByIndex(m.currentRowIndex)
    '         updateRowsScroll()
    '         return true
    '     end if

    ' else if key = "up"
    '     if m.currentRowIndex > 0
    '         print "m.currentRowIndex2"m.currentRowIndex
    '         m.currentRowIndex = m.currentRowIndex - 1
    '         print "m.currentRowIndex3"m.currentRowIndex
    '         focusRowByIndex(m.currentRowIndex)
    '         updateRowsScroll()
    '         return true
    '     end if
    ' end if
if key = "down"
    if m.currentRowIndex < m.rows.Count() - 1
        m.currentRowIndex = m.currentRowIndex + 1
        
         updateRowsScroll()
         focusRowByIndex(m.currentRowIndex)
       
        return true
    end if
    return true
end if

if key = "up"
    if m.currentRowIndex > 0
        m.currentRowIndex = m.currentRowIndex - 1
         updateRowsScroll()
        focusRowByIndex(m.currentRowIndex)
        ' updateRowsScroll()
        return true
    end if
    return true
end if
    return false
end function
function getFocusedRowIndex() as Integer
    for i = 0 to m.rows.Count() - 1
        if m.rows[i].callFunc("rowInFocusChain") = true
            return i
        end if
    end for
    return 0
end function

sub focusCurrentRow()
    idx = getFocusedRowIndex()
    if idx >= 0 and idx < m.rows.Count()
        m.rows[idx].setFocus(true)
        m.rows[idx].callFunc("setFocusToGrid")
    end if
end sub
sub focusRowByIndex(index as Integer)
    if index >= 0 and index < m.rows.Count()
        m.rows[index].setFocus(true)
        m.rows[index].callFunc("setFocusToGrid")
    end if
end sub

sub updateRowsScroll()
  scrollIndex = m.currentRowIndex - m.visibleTopRowOffset
    if scrollIndex < 0
        scrollIndex = 0
    end if
    newY = m.baseRowsY - (scrollIndex * m.rowSpacing)
    print "new"newY
    m.rowsGroup.translation = [40, newY]
end sub