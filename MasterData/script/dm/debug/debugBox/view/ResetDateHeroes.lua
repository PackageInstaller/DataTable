-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ResetDateHeroes.lua

ResetDateHeroes = class("ResetDateHeroes", DebugViewTemplate, _M)

function ResetDateHeroes:initialize()
	self._opType = 262
	self._viewConfig = {
		{
			title = "清除已约会过的英魂数据",
			name = "ResetDateHeroes",
			type = "Label"
		}
	}
end
