-- chunkname: @/tmp/or_script/lua_compile/cocos/framework/extends/UIEditBox.lua

local EditBox = ccui.EditBox

function EditBox:onEditHandler(callback)
	self:registerScriptEditBoxHandler(function(name, sender)
		local event = {}

		event.name = name
		event.target = sender

		callback(event)
	end)

	return self
end

function EditBox:removeEditHandler()
	self:unregisterScriptEditBoxHandler()

	return self
end
