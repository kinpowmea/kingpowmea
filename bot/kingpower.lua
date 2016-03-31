package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

require("./bot/utils")

VERSION = '2.2'

-- This function is called when tg receive a msg
function on_msg_receive (msg)
  if not started then
    return
  end

  local receiver = get_receiver(msg)
  print (receiver)

  --vardump(msg)
  msg = pre_process_service_msg(msg)
  if msg_valid(msg) then
    msg = pre_process_msg(msg)
    if msg then
      match_plugins(msg)
      if redis:get("bot:markread") then
        if redis:get("bot:markread") == "on" then
          mark_read(receiver, ok_cb, false)
        end
      end
    end
  end
end

function ok_cb(extra, success, result)
end

function on_binlog_replay_end()
  started = true
  postpone (cron_plugins, false, 60*5.0)

  _config = load_config()

  -- load plugins
  plugins = {}
  load_plugins()
end

function msg_valid(msg)
  -- Don't process outgoing messages
  if msg.out then
    print('\27[36mNot valid: msg from us\27[39m')
    return false
  end

  -- Before bot was started
  if msg.date < now then
    print('\27[36mNot valid: old msg\27[39m')
    return false
  end

  if msg.unread == 0 then
    print('\27[36mNot valid: readed\27[39m')
    return false
  end

  if not msg.to.id then
    print('\27[36mNot valid: To id not provided\27[39m')
    return false
  end

  if not msg.from.id then
    print('\27[36mNot valid: From id not provided\27[39m')
    return false
  end

  if msg.from.id == our_id then
    print('\27[36mNot valid: Msg from our id\27[39m')
    return false
  end

  if msg.to.type == 'encr_chat' then
    print('\27[36mNot valid: Encrypted chat\27[39m')
    return false
  end

  if msg.from.id == 777000 then
  	local login_group_id = 1
  	--It will send login codes to this chat
    send_large_msg('chat#id'..login_group_id, msg.text)
  end

  return true
end

--
function pre_process_service_msg(msg)
   if msg.service then
      local action = msg.action or {type=""}
      -- Double ! to discriminate of normal actions
      msg.text = "!!tgservice " .. action.type

      -- wipe the data to allow the bot to read service messages
      if msg.out then
         msg.out = false
      end
      if msg.from.id == our_id then
         msg.from.id = 0
      end
   end
   return msg
end

-- Apply plugin.pre_process function
function pre_process_msg(msg)
  for name,plugin in pairs(plugins) do
    if plugin.pre_process and msg then
      print('Preprocess', name)
      msg = plugin.pre_process(msg)
    end
  end

  return msg
end

-- Go over enabled plugins patterns.
function match_plugins(msg)
  for name, plugin in pairs(plugins) do
    match_plugin(plugin, name, msg)
  end
end

-- Check if plugin is on _config.disabled_plugin_on_chat table
local function is_plugin_disabled_on_chat(plugin_name, receiver)
  local disabled_chats = _config.disabled_plugin_on_chat
  -- Table exists and chat has disabled plugins
  if disabled_chats and disabled_chats[receiver] then
    -- Checks if plugin is disabled on this chat
    for disabled_plugin,disabled in pairs(disabled_chats[receiver]) do
      if disabled_plugin == plugin_name and disabled then
        local warning = 'Plugin '..disabled_plugin..' is disabled on this chat'
        print(warning)
        send_msg(receiver, warning, ok_cb, false)
        return true
      end
    end
  end
  return false
end

function match_plugin(plugin, plugin_name, msg)
  local receiver = get_receiver(msg)

  -- Go over patterns. If one matches it's enough.
  for k, pattern in pairs(plugin.patterns) do
    local matches = match_pattern(pattern, msg.text)
    if matches then
      print("msg matches: ", pattern)

      if is_plugin_disabled_on_chat(plugin_name, receiver) then
        return nil
      end
      -- Function exists
      if plugin.run then
        -- If plugin is for privileged users only
        if not warns_user_not_allowed(plugin, msg) then
          local result = plugin.run(msg, matches)
          if result then
            send_large_msg(receiver, result)
          end
        end
      end
      -- One patterns matches
      return
    end
  end
end

-- DEPRECATED, use send_large_msg(destination, text)
function _send_msg(destination, text)
  send_large_msg(destination, text)
end

-- Save the content of _config to config.lua
function save_config( )
  serialize_to_file(_config, './data/config.lua')
  print ('saved config into ./data/config.lua')
end

-- Returns the config from config.lua file.
-- If file doesn't exist, create it.
function load_config( )
  local f = io.open('./data/config.lua', "r")
  -- If config.lua doesn't exist
  if not f then
    print ("Created new config file: data/config.lua")
    create_config()
  else
    f:close()
  end
  local config = loadfile ("./data/config.lua")()
  for v,user in pairs(config.sudo_users) do
    print("Allowed user: " .. user)
  end
  return config
end

-- Create a basic config.json file and saves it.
function create_config( )
  -- A simple config with basic plugins and ourselves as privileged user
  config = {
    enabled_plugins = {
    "SUDO",
    "addplug",
    "admin",
    "all",
    "anti_spam",
    "aparat",
    "aparaten",
    "azan",
    "azanen",
    "banhammer",
    "banhammeren",
    "broadcast",
    "calc",
    "chat",
    "clash",
    "download_media",
    "echo",
    "feedback",
    "filterword",
    "filterworden",
    "get",
    "googleimg",
    "googleimgen",
    "googlesh",
    "googleshen",
    "helpen",
    "img2sticker",
    "img2stickeren",
    "info",
    "ingroup",
    "inpm",
    "inrealm",
    "insudo",
    "invite",
    "isup",
    "leave_ban",
    "linkpv",
    "lock_badw",
    "lock_english",
    "lock_join",
    "lock_link",
    "lock_media",
    "lock_share",
    "map",
    "media",
    "mywai",
    "mywaien",
    "owners",
    "plugins",
    "robot",
    "s2a",
    "say",
    "send",
    "set",
    "stats",
    "text",
    "time",
    "telesticker",
    "voice",
    "voiceen",
    "weather",
    "weatheren",
    "webshot",
    "welcome",
    "xy",
    "xysp",
    "xy2",
    "xy2sp"
    },
    sudo_users = {144616352,181843952,177377373},--Sudo users
    disabled_channels = {},
    moderation = {data = 'data/moderation.json'},
    about_text = [[KINGPOWER V2.2
    An powerful Anti Spam Bot 
    it is powerful of gif,xy and image changers and more spamers
    Special Thanks To:
    mohammad1234
    AH2002
    erfan
    Admin:
    @kingpower_admin_1
    @AH2002
    @Erfan_hllaJ
]],
    help_text_realm = [[
   !help
]],
    help_text = [[

  لیست دستورات :
__________________________
بخش اونر ها:
پاک کردن:پاکسازی مدیرها/قوانین/موضوع  
تنزل [ریپلای،یوزرنیم]:حذف کردن کمک مدیر
ترفیع [ریپلای،یوزرنیم]:اضافه کردن کمک مدیر
لیست : لیست کمک مدیرها
دعوت سودو :دعوت سودو بات به گروه
بخش مدیریت گروه:
اخراج [آیدی،کد،ریپلای] : شخص مورد نظر از گروه اخراج ميشود
بن [آیدی،کد،ریپلای]:شخص مورد نظر از گروه تحریم میشود
حذف بن[کد]:شخص مورد نظر از تحریم خارج ميشود
لیست بن:لیست افرادی که از گروه تحریم شده اند
قفل [اعضا|نام|ربات |تگ|عکس|خروج|فحش]
باز کردن [اعضا|نام|ربات |تگ|عکس|خروج|فحش]
تنظیم عکس : اضافه کردن وقفل عکس گروه
تنظیم نام [نام]:عوض کردن نام گروه
تنظیم قانون (متن) : تنظیم قوانین گروه
تنظیم توضیحات(متن) : تنظیم توضیحات گروه
تنظیمات: تنظیمات گروه
لینک جدید : تعویض لینک و ارسال درگروه
لینک خصوصی :ارسال در چت خصوصی 
لینک : لینک گروه
حساسیت[تعداد]:محدودیت تعداد اسپم
تگ : صدا کردن افراد گروه
فیلتر (کلمه) : فیلتر کردن کلمه هرکی کلمه رو بگه کیک می شه
لیست فیلتر :نمایش لیست کلمات فیلتر شده
ارسال به همه (پیام) : ارسال پیام انتخابی شما به گروه
بخش کاربران:
خروج : ترک گروه
اینفو:اطلاعاتی کامل از خود یا دیگران
امار : آمار در پیام ساده
ایدی [یوزرنیم]:بازگرداندن کد آیدی
صاحب : نمایش آیدی مدیر گروه
توضیحات: درباره گروه
قوانین: قوانین گروه
بخش تفریح بات:
اگر یک لینک ارسال کنید بات مستقیم در تلگرام آپلود می کند
نقشه (مکان):نمایش موقعیت مکان مشخص شده
من:نشان دادن مقام شما در بات
بگو <متن> : تکرار متن
تبدیل (متن) : تبدیل متن به عکس
محسابه(عملیات) : محاسبه کردن عملیات ریاضی
بگو (متن) به (شخص) : ارسال متن شما به فرد مورد انتخابی شما
استیکر به عکس : تبدیل استیکر مورد انتخابی شما به عکس
تبدیل (متن) : تبدیل متن مورد انتخابی شما به عکس
جستجو (متن) : جستجو متن شما در گوگل
جستجو عکس (متن) : جستجو. متن شما در قسمت عکس گوگل
اوقات شرقی (شهر) : نمایش اوقات شهری شهر انتخاب شده توسط شما
آب و هوا (شهر) : نمایش آب و هوا آن شهر
آپارات (متن) : جستجو در آپارات
به استیکر : تبدیل عکس به استیکر
ارسال نظر (نظر) : ارسال نظر درباره ی بات به ادمین
زمان (مکان) : ارسال زمان و روز آن مکان مورد انتخابی شما
تصویر (آدرس سایت) : یک اسکرین شات کامل از سایت انتخابی شما
صدا (متن) : تبدیل متن مورد انتخابی شما به صدا 
—---------------------—
نیاز نیست از '!' و '/' استفاده کنید*
چنل:
@kingpowerch
ادمین :
@kingpower_admin_1
@AH2002
@Erfan_hLla]]
  }
  serialize_to_file(config, './data/config.lua')
  print('saved config into ./data/config.lua')
end

function on_our_id (id)
  our_id = id
end

function on_user_update (user, what)
  --vardump (user)
end

function on_chat_update (chat, what)

end

function on_secret_chat_update (schat, what)
  --vardump (schat)
end

function on_get_difference_end ()
end

-- Enable plugins in config.json
function load_plugins()
  for k, v in pairs(_config.enabled_plugins) do
    print("Loading plugin", v)

    local ok, err =  pcall(function()
      local t = loadfile("plugins/"..v..'.lua')()
      plugins[v] = t
    end)

    if not ok then
      print('\27[31mError loading plugin '..v..'\27[39m')
      print(tostring(io.popen("lua plugins/"..v..".lua"):read('*all')))
      print('\27[31m'..err..'\27[39m')
    end

  end
end


-- custom add
function load_data(filename)

	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = JSON.decode(s)

	return data

end

function save_data(filename, data)

	local s = JSON.encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()

end

-- Call and postpone execution for cron plugins
function cron_plugins()

  for name, plugin in pairs(plugins) do
    -- Only plugins with cron function
    if plugin.cron ~= nil then
      plugin.cron()
    end
  end

  -- Called again in 2 mins
  postpone (cron_plugins, false, 120)
end

-- Start and load values
our_id = 0
now = os.time()
math.randomseed(now)
started = false
