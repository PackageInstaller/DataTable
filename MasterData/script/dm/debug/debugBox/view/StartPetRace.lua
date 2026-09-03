-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/StartPetRace.lua

StartPetRace = class("StartPetRace", DebugViewTemplate, _M)

function StartPetRace:initialize()
	self._opType = 117
	self._viewConfig = {
		{
			default = 1,
			name = "count",
			title = "count",
			type = "Input"
		}
	}
end
