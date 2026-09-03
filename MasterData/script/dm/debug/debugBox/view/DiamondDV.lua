-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/DiamondDV.lua

DiamondDV = class("DiamondDV", DebugViewTemplate, _M)

function DiamondDV:initialize()
	self._opType = 101
	self._viewConfig = {
		{
			default = 100,
			name = "count",
			title = "钻石数量",
			type = "Input"
		}
	}
end
