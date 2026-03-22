function GetAppConfig() as Object
    return {
        apiKey: "452b3b7a5d806dcd110842e6649c604d"
        baseUrl: "https://api.flickr.com/services/rest/"
        perPage: 15

        categories: [
            { 
                title: "Featured", 
                method: "flickr.interestingness.getList", 
                params: {} 
            }

            { 
                title: "Nature", 
                method: "flickr.photos.search", 
                params: { 
                    tags: "nature,forest,mountain,river", 
                    tag_mode: "any", 
                    sort: "relevance" 
                } 
            }

            { 
                title: "Architecture", 
                method: "flickr.photos.search", 
                params: { 
                    tags: "architecture,building,city,urban", 
                    tag_mode: "any", 
                    sort: "relevance" 
                } 
            }

            { 
                title: "Animals", 
                method: "flickr.photos.search", 
                params: { 
                    tags: "animal,wildlife,pet,bird", 
                    tag_mode: "any", 
                    sort: "relevance" 
                } 
            }

            { 
                title: "Historical", 
                method: "flickr.photos.search", 
                params: { 
                    tags: "history,monument,heritage,ancient", 
                    tag_mode: "any", 
                    sort: "relevance" 
                } 
            }

            { 
                title: "Travel", 
                method: "flickr.photos.search", 
                params: { 
                    tags: "travel,landscape,beach,cityscape", 
                    tag_mode: "any", 
                    sort: "relevance" 
                } 
            }

            { 
                title: "Food", 
                method: "flickr.photos.search", 
                params: { 
                    tags: "food,meal,cuisine,restaurant", 
                    tag_mode: "any", 
                    sort: "relevance" 
                } 
            }

            { 
                title: "Space", 
                method: "flickr.photos.search", 
                params: { 
                    tags: "space,galaxy,stars,universe", 
                    tag_mode: "any", 
                    sort: "relevance" 
                } 
            }

            { 
                title: "Popular", 
                method: "flickr.photos.search", 
                params: { 
                    tags: "popular,trending,photography,featured", 
                    tag_mode: "any", 
                    sort: "interestingness-desc" 
                } 
            }

            { 
                title: "Recent Uploads", 
                method: "flickr.photos.getRecent", 
                params: {} 
            }
        ]
    }
end function