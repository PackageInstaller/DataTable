-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/explore/ExploreAddTimes.lua

ExploreAddTimes = class("ExploreAddTimes", DebugViewTemplate, _M)

function ExploreAddTimes:initialize()
	self._opType = 226
	self._viewConfig = {
		{
			title = "增加次数",
			name = "ExploreAddTimes",
			type = "Input"
		}
	}
end
