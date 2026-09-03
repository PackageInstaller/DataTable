-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ResetHeroStoryCount.lua

ResetHeroStoryCount = class("ResetHeroStoryCount", DebugViewTemplate, _M)

function ResetHeroStoryCount:initialize()
	self._opType = 273
	self._viewConfig = {
		{
			title = "重置英魂副本挑战次数",
			name = "ResetDateHeroes",
			type = "Label"
		}
	}
end
