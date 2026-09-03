-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/UICheckBox.lua

local CheckBox = ccui.CheckBox

function CheckBox:onEvent(callback)
	self:addEventListener(function(sender, eventType)
		local event = {}

		event.name = eventType == 0 and "selected" or "unselected"
		event.target = sender

		callback(event)
	end)

	return self
end
