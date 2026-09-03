-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/TestBox.lua

TestBox = class("TestBox", DebugViewTemplate, _M)

function TestBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function TestBox:onClick(data)
	local view = self:getInjector():getInstance("TestView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view)

	self:dispatch(event)
end
