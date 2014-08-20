$.getJSON 'https://api.vineapp.com/timelines/popular', (json)->
    console.log [json]
    if json?
        $r = json.data.records
        console.log ["json-data...", json.data.records]

        vue = new Vue {
            el: 'body'
            data:
                items: $r
        }
 
