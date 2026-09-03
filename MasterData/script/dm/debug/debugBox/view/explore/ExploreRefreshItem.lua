-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/explore/ExploreRefreshItem.lua

ExploreRefreshItem = class("ExploreRefreshItem", DebugViewTemplate, _M)

function ExploreRefreshItem:initialize()
	self._opType = 224
	self._viewConfig = {
		{
			title = "刷新一次性物件",
			name = "ExploreRefreshItem",
			type = "Label"
		}
	}
end
