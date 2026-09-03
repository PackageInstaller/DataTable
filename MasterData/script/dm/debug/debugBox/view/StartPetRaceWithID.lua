-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/StartPetRaceWithID.lua

StartPetRaceWithID = class("StartPetRaceWithID", DebugViewTemplate, _M)

function StartPetRaceWithID:initialize()
	self._opType = 134
	self._viewConfig = {
		{
			default = "",
			name = "list",
			title = "输入用户id（多个id以逗号分隔）",
			type = "Input"
		}
	}
end
