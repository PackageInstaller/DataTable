-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtVigour.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtVigour", package.seeall)

local HurtEvtVigour = class("HurtEvtVigour", HurtEvtBase)

function HurtEvtVigour:getEvtType()
	return HurtEvtType.EvtVigour
end

function HurtEvtVigour:handleEvt(hurtData)
	if self.vigour ~= 0 then
		hurtData.target:onVigour(self.vigour)
	end

	HurtEvtVigour.super.handleEvt(self, hurtData)
end

function HurtEvtVigour:getDesc(hurtData)
	if hurtData.target and self.vigour ~= 0 then
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

return HurtEvtVigour
