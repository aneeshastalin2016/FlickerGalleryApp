'bg task that loads all category rows.

sub init()
    m.top.functionName = "loadFeeds"
end sub

sub loadFeeds()
    print "FlickrFeedTask-loadFeeds started"

    cfg = GetAppConfig() 'reading categories
    result = []

    for each category in cfg.categories  ' each category became one row
        row = {
            title: category.title
            items: []
        }

        url = BuildFlickrUrl(category.method, category.params)
        print "URL: "; url

        json = doGetJson(url)

        if json = invalid 'error handling
            m.top.errorMessage = "Network or parsing error while loading " + category.title
        else if json.DoesExist("stat") and json.stat <> "ok"
            m.top.errorMessage = "Flickr error in " + category.title
        else
            photos = invalid
            if json.DoesExist("photos") and json.photos.DoesExist("photo")
                photos = json.photos.photo
            end if 'extracting photos

            if photos <> invalid
                for each p in photos
                    item = {
                        id: SafeGet(p, "id", "") 
                        title: SafeGet(p, "title", "Untitled")
                        description: extractDescription(p)
                        thumb: BuildThumbUrl(p) 'grid image
                        largeUrl: BuildLargeImageUrl(p) 'full image
                        farm: SafeGet(p, "farm", "") 'fallabck url
                        server: SafeGet(p, "server", "")
                        secret: SafeGet(p, "secret", "")
                        o_width: SafeGet(p, "o_width", "") 'dimenisions
                        o_height: SafeGet(p, "o_height", "")
                    }
                    row.items.Push(item)
                end for
            end if
        end if

        result.Push(row) 'collecting all photots in category now
    end for
    m.top.content = result  'data is stored
end sub

' api call
function doGetJson(url as String) as Dynamic
    xfer = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    xfer.SetPort(port)
    xfer.SetUrl(url)
    xfer.EnableEncodings(true)
    xfer.InitClientCertificates()

    response = xfer.GetToString() 'send http request and return parsed json

    if response = invalid or response = ""
        print "HTTP request failed or empty response"
        return invalid
    end if

    print response
    return ParseJson(response)
end function

'maybe sometimes p as object and string so inorder to overcome crash doing roassoc
function extractDescription(photo as Object) as String
    if photo <> invalid and photo.DoesExist("description")
        d = photo.description
        if type(d) = "roAssociativeArray" and d.DoesExist("_content")
            return d._content
        else if type(d) = "String"
            return d
        end if
    end if
    return "No description available."
end function

'App starts ,Task runs (loadFeeds),Loop categories,Build API URL,Call Flickr API, Get photos,Build items (thumb + large),Create rows,Send to UI (m.top.content),Grid shows images