-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/UIWidget.lua

local Widget = ccui.Widget

function Widget:onTouch(callback)
	self:addTouchEventListener(function(sender, state)
		local event = {
			x = 0,
			y = 0
		}

		event.name = state == 0 and "began" or state == 1 and "moved" or state == 2 and "ended" or "cancelled"
		event.target = sender

		callback(event)
	end)

	return self
end
