-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/SkipMazeOption.lua

SkipMazeOption = class("SkipMazeOption", DebugViewTemplate, _M)

function SkipMazeOption:initialize()
	self._opType = 252
	self._viewConfig = {
		{
			default = "BSNCT_01",
			name = "eventId",
			title = "事件ID",
			type = "Input"
		},
		{
			default = 1,
			name = "index",
			title = "页签项",
			type = "Input"
		}
	}
end
