-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtBuffVigour.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtBuffVigour", package.seeall)

local HurtEvtBuffVigour = class("HurtEvtBuffVigour", HurtEvtBase)

function HurtEvtBuffVigour:getEvtType()
	return HurtEvtType.EvtBuffVigour
end

function HurtEvtBuffVigour:handleEvt(hurtData)
	hurtData.target:onBuffVigour(self.buffId, self.vigour)
	HurtEvtBuffVigour.super.handleEvt(self, hurtData)
end

function HurtEvtBuffVigour:getDesc(hurtData)
	if hurtData.target then
		local petCo = CharacterConfig.instance:getPetCo(hurtData.target.raceId)
		local targetName = petCo.name
		local targetColor = hurtData:getColorByTeamId(hurtData.target.teamId)

		if self.vigour < 0 then
			return string.format(lang("battlerecord_vigour_consume"), targetColor, targetName, targetColor, -self.vigour)
		else
			return string.format(lang("battlerecord_vigour_add"), targetColor, targetName, targetColor, self.vigour)
		end
	end
end

return HurtEvtBuffVigour
