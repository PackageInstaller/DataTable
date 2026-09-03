-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/UIScrollView.lua

local ScrollView = ccui.ScrollView

function ScrollView:onEvent(callback)
	self:addEventListener(function(sender, eventType)
		local event = {}

		if eventType == 0 then
			event.name = "SCROLL_TO_TOP"
		elseif eventType == 1 then
			event.name = "SCROLL_TO_BOTTOM"
		elseif eventType == 2 then
			event.name = "SCROLL_TO_LEFT"
		elseif eventType == 3 then
			event.name = "SCROLL_TO_RIGHT"
		elseif eventType == 4 then
			event.name = "SCROLLING"
		elseif eventType == 5 then
			event.name = "BOUNCE_TOP"
		elseif eventType == 6 then
			event.name = "BOUNCE_BOTTOM"
		elseif eventType == 7 then
			event.name = "BOUNCE_LEFT"
		elseif eventType == 8 then
			event.name = "BOUNCE_RIGHT"
		elseif eventType == 9 then
			event.name = "CONTAINER_MOVED"
		elseif eventType == 10 then
			event.name = "AUTOSCROLL_ENDED"
		end

		event.target = sender

		callback(event)
	end)

	return self
end

ScrollView.onScroll = ScrollView.onEvent
