do
function run(msg, matches)
  return [[ 

  Commands list :

!kick [username|id]
You can also by reply
〰〰〰〰〰〰
!ban [ username|id]
You can also by reply
〰〰〰〰〰〰
!unban [id]
You can also by reply
〰〰〰〰〰〰
!insudo
you can invite sudo to the group
〰〰〰〰〰〰
!who
Members list
〰〰〰〰〰〰
!modlist
Moderators list
〰〰〰〰〰〰
!promote [username]
Promote someone
〰〰〰〰〰〰
!demote [username]
Demote someone
〰〰〰〰〰〰
!kickme
Will kick user
〰〰〰〰〰〰
!about
Group description
〰〰〰〰〰〰
!setphoto
locks group photo
〰〰〰〰〰〰
!setname [name]
Set group name
〰〰〰〰〰〰
!rules
Group rules
〰〰〰〰〰〰
!id
 group id & user id
〰〰〰〰〰〰
!help
This help persian text
〰〰〰〰〰〰
!lock [member|name|bots|leave|arabic|tag|ads] 
Locks [member|name|bots|leaveing|arabic|tag|ads] 
〰〰〰〰〰〰
!unlock [member|name|bots|leave|arabic|tag|ads]
Unlocks [member|name|bots|leaving|arabic|tag|ads]
〰〰〰〰〰〰
!set rules <text>
Set <text> as rules
〰〰〰〰〰〰
!set about <text>
Set <text> as about
〰〰〰〰〰〰
!settings
Returns group settings
〰〰〰〰〰〰
!newlink
create/revoke your group link
〰〰〰〰〰〰
!link
returns group link
〰〰〰〰〰〰
!owner
returns group owner id
〰〰〰〰〰〰
!setowner [id]
Will set id as owner
〰〰〰〰〰〰
!setflood [value]
Set [value] as flood sensitivity
〰〰〰〰〰〰
!stats
Simple message statistics
〰〰〰〰〰〰
!save [value] <text>
Save <text> as [value]
〰〰〰〰〰〰
!get [value]
Returns text of [value]
〰〰〰〰〰〰
!clean [modlist|rules|about]
Will clear [modlist|rules|about] 
〰〰〰〰〰〰
!info 
send you a user stats 
worked by reply
〰〰〰〰〰〰
!sticker [warn|kick|ok]
warn : warning send sticker
kick : send sticker=kick
ok : send sticker open
〰〰〰〰〰〰
!tagall [text]
tag users && send your message
〰〰〰〰〰〰
!all
see all about group
〰〰〰〰〰〰
!block (user-id)
!unblock (user-id)
block - unblock users (sudo only)
〰〰〰〰〰〰
!kickinactive
kick inactive users from Group
〰〰〰〰〰〰
!pv [user-id] [text]
send text to user-id (sudo only)
〰〰〰〰〰〰
!linkpv
send link to your pv ( bot reported)
〰〰〰〰〰〰
!banlist
group ban list
〰〰〰〰〰〰
!welcome [group|pm|disable]
set welcome to group
set welcome to pm (pv)
set welcome disable
〰〰〰〰〰〰
!calc (s.th)
calculation math
〰〰〰〰〰〰
!echo (s.th)
bot say s.th that you typed
〰〰〰〰〰〰
!feedback (s.th)
send a feedback to admin
〰〰〰〰〰〰
!fliter + word
if s.one say it bot kick him
!filter > word
if s.one say it bot warns him
!filter - word
remove a word from filterlist
!filterlist
you can see a filter list
〰〰〰〰〰〰
!info
information about you and members
〰〰〰〰〰〰
!tosticker
convert a photo to sticker
〰〰〰〰〰〰
!tophoto
conert a sticker to photo
〰〰〰〰〰〰
![Kk]ingpowersh
show the stickers and photos that converted
〰〰〰〰〰〰
!src [s.th]
search something of you entered in google
〰〰〰〰〰〰
!img [s.th]
search something of you entered in image google
〰〰〰〰〰〰
!quran
show the list of the qurans
!sura (number)
or
!write (number)
read the number of quran 
〰〰〰〰〰〰
!map [area]
you can see that areas location
〰〰〰〰〰〰
!me
you can see who are you in group?[sudo,admin,owner,moderatior,member]
〰〰〰〰〰〰
!t2i [text]
convert a text to image
〰〰〰〰〰〰
!voice [text]
convert a text to a voice
〰〰〰〰〰〰
!web [url]
take a webshot from a site(your site should to be start https or http
〰〰〰〰〰〰
**U can use "/" & "!"
〰〰〰〰〰〰
*Only owner & mods can add bots to group
〰〰〰〰〰〰
*Only moderators & owner can use kick,ban,unban,newlink,link,setphoto,setname,lock,unlock,set rules,set about,settings,filterword commands
〰〰〰〰〰〰
*Only owner can use res,setowner,promote,demote,log commands

  ]]
end

return {
  description = "kingpower",
  patterns = {"^[!/%$+=.-*&][Hh]elpen$"},
  run = run 
}
end
