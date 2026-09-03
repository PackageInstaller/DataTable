-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddTowerMissionsCount.lua

AddTowerMissionsCount = class("AddTowerMissionsCount", DebugViewTemplate, _M)

function AddTowerMissionsCount:initialize()
	self._opType = 281
	self._viewConfig = {
		{
			title = "增加爬塔次数100次",
			name = "AddTowerMissionsCount",
			type = "Label"
		}
	}
end
