do
function run(msg, matches) 
send_document(get_receiver(msg), "/root/robot/sticker.webp", ok_cb, false) 
end 

 
 return { 
 patterns = { 
"^[Ss][Ss][Ti][Ii][Cc][Kk][Er][Rr]$", 
 "^[!/]ssticker$",
 "^(نمایش) (استیکر)$"
}, 
 run = run 
 end 
