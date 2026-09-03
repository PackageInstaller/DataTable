-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/PetRaceJumpTo.lua

PetRaceJumpTo = class("PetRaceJumpTo", DebugViewTemplate, _M)

function PetRaceJumpTo:initialize()
	self._opType = 135
	self._viewConfig = {
		{
			default = "",
			name = "",
			title = "跳至下一个状态",
			type = "Label"
		}
	}
end
