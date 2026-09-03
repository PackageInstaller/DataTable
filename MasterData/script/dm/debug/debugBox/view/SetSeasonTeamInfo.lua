-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/SetSeasonTeamInfo.lua

SetSeasonTeamInfo = class("SetSeasonTeamInfo", DebugViewTemplate, _M)

function SetSeasonTeamInfo:initialize()
	self._opType = 140
	self._viewConfig = {
		{
			default = 0,
			name = "hindex",
			title = "敌人索引",
			type = "Input"
		},
		{
			default = 0,
			name = "index",
			title = "阵型里要替换掉的hero索引",
			type = "Input"
		},
		{
			default = "YFZZhu",
			name = "hero",
			title = "替上去的heroid",
			type = "Input"
		}
	}
end
