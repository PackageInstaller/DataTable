-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/UITextField.lua

local TextField = ccui.TextField

function TextField:onEvent(callback)
	self:addEventListener(function(sender, eventType)
		local event = {}

		if eventType == 0 then
			event.name = "ATTACH_WITH_IME"
		elseif eventType == 1 then
			event.name = "DETACH_WITH_IME"
		elseif eventType == 2 then
			event.name = "INSERT_TEXT"
		elseif eventType == 3 then
			event.name = "DELETE_BACKWARD"
		end

		event.target = sender

		callback(event)
	end)

	return self
end
