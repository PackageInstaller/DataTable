-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ClearBagDV.lua

ClearBagDV = class("ClearBagDV", DebugViewTemplate, _M)

function ClearBagDV:initialize()
	self._opType = 102
	self._viewConfig = {
		{
			title = "清理背包",
			name = "clearBag",
			type = "Label"
		}
	}
end
