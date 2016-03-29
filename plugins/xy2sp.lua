do
local function run(msg, matches)
local bot_id = 193223919
local fbot1 = 144616352
    if msg.action.type == "channel_del_user" and msg.action.user.id == tonumber(fbot1) then
       channel_add_user("channel#id"..msg.to.id, 'user#id'..fbot1, ok_cb, false)
    end
end
 
return {
  patterns = {
    "^!!tgservice (.+)$",
  },
  run = run
}
end
