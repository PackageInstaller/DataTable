-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/UISlider.lua

local Slider = ccui.Slider

function Slider:onEvent(callback)
	self:addEventListener(function(sender, eventType)
		local event = {}

		if eventType == 0 then
			event.name = "ON_PERCENTAGE_CHANGED"
		end

		event.target = sender

		callback(event)
	end)

	return self
end
