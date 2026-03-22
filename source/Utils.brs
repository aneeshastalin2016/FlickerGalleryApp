'creates Flickr API request URL
function BuildFlickrUrl(method as String, extraParams = invalid as Dynamic) as String
    cfg = GetAppConfig()
'for storing query parameters
    params = {
        method: method
        api_key: cfg.apiKey
        format: "json"
        nojsoncallback: "1"
        per_page: cfg.perPage.ToStr()
        safe_search: "1"
        content_type: "1"
        media: "photos"
        extras: "description,url_q,url_z,url_b,o_dims"
    }

    if extraParams <> invalid
        for each key in extraParams
            params[key] = extraParams[key]  'adding extra parameters like tag,pg no.
        end for
    end if

    query = []
    for each key in params
        query.Push(key + "=" + UrlEncode(params[key].ToStr())) ' converting param to key value format,comas encoded 
    end for

    return cfg.baseUrl + "?" + Join(query, "&") ' everything joined
end function

' works when user clicks photo
function BuildGetInfoUrl(photoId as String) as String
    cfg = GetAppConfig()

    url = cfg.baseUrl + "?method=flickr.photos.getInfo"
    url = url + "&api_key=" + cfg.apiKey
    url = url + "&photo_id=" + UrlEncode(photoId)
    url = url + "&format=json"
    url = url + "&nojsoncallback=1"

    return url
end function

function UrlEncode(value as String) as String   'string 
    x = CreateObject("roUrlTransfer")
    return x.Escape(value)
end function

function Join(arr as Object, delim as String) as String 'join arr*string
    result = ""
    for i = 0 to arr.Count() - 1
        result = result + arr[i]
        if i < arr.Count() - 1
            result = result + delim
        end if
    end for
    return result
end function

' save from invalid crash as obj=invalid
function SafeGet(obj as Object, key as String, defaultValue = "" as Dynamic) as Dynamic
    if obj <> invalid and obj.DoesExist(key)
        return obj[key]
    end if
    return defaultValue
end function

' big image and building new if unavailable
function BuildLargeImageUrl(photo as Object) as String
    if photo = invalid then return ""

    if photo.DoesExist("url_b") and photo.url_b <> ""
        return photo.url_b
    end if

    if photo.DoesExist("farm") and photo.DoesExist("server") and photo.DoesExist("id") and photo.DoesExist("secret")
        return "https://farm" + photo.farm.ToStr() + ".staticflickr.com/" + photo.server + "/" + photo.id + "_" + photo.secret + "_b.jpg"
    end if

    return ""
end function

'small image and build new if unavailble
function BuildThumbUrl(photo as Object) as String
    if photo = invalid then return ""

    if photo.DoesExist("url_q") and photo.url_q <> ""
        return photo.url_q
    end if

    if photo.DoesExist("farm") and photo.DoesExist("server") and photo.DoesExist("id") and photo.DoesExist("secret")
        return "https://farm" + photo.farm.ToStr() + ".staticflickr.com/" + photo.server + "/" + photo.id + "_" + photo.secret + "_q.jpg"
    end if

    return ""
end function



'function BuildFlickrUrl("flickr.photos.search"),{tags: "popular,trending,photography,featured", 
                   