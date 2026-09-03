-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddTreasure.lua

AddTreasure = class("AddTreasure", DebugViewTemplate, _M)

function AddTreasure:initialize()
	self._opType = 250
	self._viewConfig = {
		{
			default = "TestItem_1",
			name = "configId",
			title = "宝物ID",
			type = "Input"
		},
		{
			default = 1,
			name = "level",
			title = "宝物等级",
			type = "Input"
		},
		{
			default = "BSNCT_01",
			name = "point",
			title = "事件id",
			type = "Input"
		}
	}
end
