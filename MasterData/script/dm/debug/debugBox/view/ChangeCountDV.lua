-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ChangeCountDV.lua

ChangeCountDV = class("ChangeCountDV", DebugViewTemplate, _M)

function ChangeCountDV:initialize()
	self._opType = 103
	self._viewConfig = {
		{
			default = 1000,
			name = "ItemId",
			title = "道具ID",
			type = "Input"
		},
		{
			default = 100,
			name = "num",
			title = "道具数量",
			type = "Input"
		}
	}
end
