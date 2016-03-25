do 
2 local function run(msg, matches) 
3   local url = "http://tts.baidu.com/text2audio?lan=en&ie=UTF-8&text="..matches[1] 
4   local receiver = get_receiver(msg) 
5   local file = download_to_file(url,'text.ogg') 
6       send_audio('chat#id'..msg.to.id, file, ok_cb , false) 
7 end 
8 
 
9 return { 
10   description = "text to voice", 
11   usage = { 
12     "/voice convert text to a voice"
13   }, 
14   patterns = { 
15     "^[!/#]voice (.+)$" 
16   }, 
17   run = run 
18 } 
19 
 
20 end 
