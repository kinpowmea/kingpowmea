do 
 local function run(msg, matches) 
 local user = 'user#id'
     if msg.from.last_name == "X" or msg.from.last_name == "Y" or  msg.from.last_name == "Z" or msg.from.first_name == "X" or msg.from.first_name == "Y" or msg.from.first_name == "Z" then 
        chat_del_user("chat#id"..msg.to.id, 'user#id'..user, ok_cb, false) 
     end 
 end 
   
 return { 
 patterns = { 
     "^!!tgservice (.+)$", 
   }, 
   run = run 
 } 
 end 
