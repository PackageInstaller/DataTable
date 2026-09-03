-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/explore/ExploreAddBagItem.lua

ExploreAddBagItem = class("ExploreAddBagItem", DebugViewTemplate, _M)

function ExploreAddBagItem:initialize()
	self._opType = 223
	self._viewConfig = {
		{
			default = "IM_Egypt_1_Item1",
			name = "itemId",
			title = "道具ID",
			type = "Input"
		},
		{
			default = 5,
			name = "count",
			title = "道具数量",
			type = "Input"
		}
	}
end
