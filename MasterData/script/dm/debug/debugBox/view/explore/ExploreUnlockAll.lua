-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/explore/ExploreUnlockAll.lua

ExploreUnlockAll = class("ExploreUnlockAll", DebugViewTemplate, _M)

function ExploreUnlockAll:initialize()
	self._opType = 222
	self._viewConfig = {
		{
			title = "恢复大地图每日推荐次数",
			name = "ExploreUnlockAll",
			type = "Label"
		}
	}
end
