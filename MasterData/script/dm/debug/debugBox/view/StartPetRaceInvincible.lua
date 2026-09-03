-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/StartPetRaceInvincible.lua

StartPetRaceInvincible = class("StartPetRaceInvincible", DebugViewTemplate, _M)

function StartPetRaceInvincible:initialize()
	self._opType = 125
	self._viewConfig = {
		{
			default = 0,
			name = "code",
			title = "code",
			type = "Input"
		}
	}
end
