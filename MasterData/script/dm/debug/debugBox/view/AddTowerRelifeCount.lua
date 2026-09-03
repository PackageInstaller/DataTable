-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddTowerRelifeCount.lua

AddTowerRelifeCount = class("AddTowerRelifeCount", DebugViewTemplate, _M)

function AddTowerRelifeCount:initialize()
	self._opType = 282
	self._viewConfig = {
		{
			title = "增加爬塔复活次数100次",
			name = "AddTowerRelifeCount",
			type = "Label"
		}
	}
end
