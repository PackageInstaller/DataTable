-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ModifyMazeMaserLv.lua

ModifyMazeMaserLv = class("ModifyMazeMaserLv", DebugViewTemplate, _M)

function ModifyMazeMaserLv:initialize()
	self._opType = 251
	self._viewConfig = {
		{
			default = "BSNCT_01",
			name = "point",
			title = "事件ID",
			type = "Input"
		},
		{
			default = 1000000,
			name = "exp",
			title = "经验",
			type = "Input"
		}
	}
end
