-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/explore/ExploreChangeMoveRate.lua

ExploreChangeMoveRate = class("ExploreChangeMoveRate", DebugViewTemplate, _M)

function ExploreChangeMoveRate:initialize()
	self._opType = 225
	self._viewConfig = {
		{
			default = 2,
			name = "count",
			title = "可为小数，最小0.5倍",
			type = "Input"
		}
	}
end
