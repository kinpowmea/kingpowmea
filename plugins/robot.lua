local function is_channel_disabled( receiver )
	if not _config.disabled_channels then
		return false
	end

	if _config.disabled_channels[receiver] == nil then
		return false
	end

  return _config.disabled_channels[receiver]
end

local function enable_channel(receiver, to_id)
	if not _config.disabled_channels then
		_config.disabled_channels = {}
	end

	if _config.disabled_channels[receiver] == nil then
		return  'ربات روشن است'
	end
	
	_config.disabled_channels[receiver] = false

	save_config()
	return 'ربات روشن است'
end

local function disable_channel(receiver, to_id)
	if not _config.disabled_channels then
		_config.disabled_channels = {}
	end
	
	_config.disabled_channels[receiver] = true

	save_config()
	return  'ربات خاموشه'
end

local function pre_process(msg)
	local receiver = get_receiver(msg)
	
	-- If sender is sudo then re-enable the channel
	if is_sudo(msg) then
	  if msg.text == "ربات روشن" then
	    enable_channel(receiver, msg.to.id)
	  end
	end

  if is_channel_disabled(receiver) then
  	msg.text = ""
  end
	return msg
end

local function run(msg, matches)
	if permissions(msg.from.id, msg.to.id, "ربات") then
		local receiver = get_receiver(msg)
		-- Enable a channel
		if matches[1] == 'روشن' then
			return enable_channel(receiver, msg.to.id)
		end
		-- Disable a channel
		if matches[1] == 'خاموش' then
			return disable_channel(receiver, msg.to.id)
		end
	else
		return 'فقط سودو'
	end
end

return {
	patterns = {
		"^ربات? (روشن)",
		"^ربات? (خاموش)" }, 
	run = run,
	pre_process = pre_process
}
