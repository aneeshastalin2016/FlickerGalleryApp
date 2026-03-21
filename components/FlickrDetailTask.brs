sub init()
    m.top.functionName = "loadDetail"
end sub

sub loadDetail()
    photo = m.top.photo
    if photo = invalid or not photo.DoesExist("id")
        m.top.errorMessage = "Invalid photo"
        return
    end if

    url = BuildGetInfoUrl(photo.id)
    json = doGetJson(url)

    if json = invalid or not json.DoesExist("photo")
        m.top.errorMessage = "Failed to fetch detail"
        return
    end if

    info = json.photo

    title = "Untitled"
    if info.DoesExist("title")
        if type(info.title) = "roAssociativeArray" and info.title.DoesExist("_content")
            if info.title._content <> "" then title = info.title._content
        end if
    end if

    description = "No description available."
    if info.DoesExist("description")
        if type(info.description) = "roAssociativeArray" and info.description.DoesExist("_content")
            if info.description._content <> "" then description = info.description._content
        end if
    end if

    width = ""
    height = ""

    if info.DoesExist("o_width") then width = info.o_width.ToStr()
    if info.DoesExist("o_height") then height = info.o_height.ToStr()

    if width = "" and photo.DoesExist("o_width")
        width = photo.o_width.ToStr()
    end if
    if height = "" and photo.DoesExist("o_height")
        height = photo.o_height.ToStr()
    end if

    metaText = "Dimensions unavailable"
    if width <> "" and height <> ""
        metaText = "Dimensions: " + width + " x " + height
    end if

    imageUrl = ""
    if photo.DoesExist("largeUrl") and photo.largeUrl <> ""
        imageUrl = photo.largeUrl
    else if info.DoesExist("farm") and info.DoesExist("server") and info.DoesExist("id") and info.DoesExist("secret")
        imageUrl = "https://farm" + info.farm.ToStr() + ".staticflickr.com/" + info.server + "/" + info.id + "_" + info.secret + "_b.jpg"
    end if

    m.top.content = {
        title: title
        description: description
        imageUrl: imageUrl
        metaText: metaText
    }
end sub

function doGetJson(url as String) as Dynamic
    xfer = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    xfer.SetPort(port)
    xfer.SetUrl(url)
    xfer.EnableEncodings(true)
    xfer.InitClientCertificates()

    response = xfer.GetToString()

    if response = invalid or response = ""
        print "HTTP request failed or empty response"
        return invalid
    end if

    print response
    return ParseJson(response)
end function