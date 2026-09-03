-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/VIPDV.lua

VIPDV = class("VIPDV", DebugViewTemplate, _M)

function VIPDV:initialize()
	self._opType = 104
	self._viewConfig = {
		{
			default = 50,
			name = "vipLevel",
			title = "vipLevel",
			type = "Input"
		}
	}
end
