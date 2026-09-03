-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddMazeDp.lua

AddMazeDp = class("AddMazeDp", DebugViewTemplate, _M)

function AddMazeDp:initialize()
	self._opType = 254
	self._viewConfig = {
		{
			default = "BSNCT_01",
			name = "eventId",
			title = "事件ID",
			type = "Input"
		},
		{
			default = 9999,
			name = "dp",
			title = "dp数量",
			type = "Input"
		}
	}
end
