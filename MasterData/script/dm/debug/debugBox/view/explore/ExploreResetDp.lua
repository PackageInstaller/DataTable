-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/explore/ExploreResetDp.lua

ExploreResetDp = class("ExploreResetDp", DebugViewTemplate, _M)

function ExploreResetDp:initialize()
	self._opType = 220
	self._viewConfig = {
		{
			default = "EGYPT",
			name = "groupId",
			title = "关卡组ID",
			type = "Input"
		},
		{
			default = 40,
			name = "count",
			title = "关卡组DP值",
			type = "Input"
		}
	}
end
