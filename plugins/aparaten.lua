local function run(msg, matches)
	if matches[1]:lower() == 'aparat' then
		local url = http.request('http://www.aparat.com/etc/api/videoBySearch/text/'..URL.escape(matches[2]))
		local jdat = json:decode(url)

		local items = jdat.videobysearch
		text = 'searched in aparat:\n'
		for i = 1, #items do
		text = text..'\n'..i..'- '..items[i].title..'  -  visits: '..items[i].visit_cnt..'\n    link: aparat.com/v/'..items[i].uid
		end
		text = text..'\n\n@kingpowerobot ch:@kingpowerch'
		return text
	end
end

return {
   patterns = {
"^[/!](aparat) (.*)$",
   },
   run = run
}
