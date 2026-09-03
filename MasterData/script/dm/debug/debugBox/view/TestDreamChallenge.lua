-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/TestDreamChallenge.lua

DreamStartBattle = class("DreamStartBattle", DebugViewTemplate, _M)

function DreamStartBattle:initialize()
	self._viewConfig = {
		{
			name = "point",
			title = "梦境塔开始战斗",
			type = "Input",
			default = "DreamChallenge_1," .. "DreamChallengePoint_1," .. "DreamChallengeBattle_1"
		}
	}
end

function DreamStartBattle:onClick(data)
	local dreamChallengeSystem = self:getInjector():getInstance(DreamChallengeSystem)

	dreamChallengeSystem:requestEnterBattle("DreamChallenge_1", "DreamChallengePoint_1", "DreamChallengeBattle_1", function(response)
		if response.resCode == GS_SUCCESS then
			dreamChallengeSystem:enterBattle(response.data, response.d)
		end
	end)
end
