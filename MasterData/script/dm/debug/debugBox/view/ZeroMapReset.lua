-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ZeroMapReset.lua

ZeroMapReset = class("ZeroMapReset", DebugViewTemplate, _M)

function ZeroMapReset:initialize()
	self._opType = 410
	self._viewConfig = {
		{
			default = "Re0_Map1",
			name = "mapId",
			title = "副本id",
			type = "Input"
		}
	}
end
