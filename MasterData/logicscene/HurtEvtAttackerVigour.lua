-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtAttackerVigour.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtAttackerVigour", package.seeall)

local HurtEvtAttackerVigour = class("HurtEvtAttackerVigour", HurtEvtBase)

function HurtEvtAttackerVigour:getEvtType()
	return HurtEvtType.AttackerVigour
end

function HurtEvtAttackerVigour:handleEvt(hurtData)
	if hurtData.attacker and self.vigour ~= 0 then
		hurtData.attacker:onVigour(self.vigour)
	end

	HurtEvtAttackerVigour.super.handleEvt(self, hurtData)
end

function HurtEvtAttackerVigour:getDesc(hurtData)
	if hurtData.attacker and self.vigour ~= 0 then
		local petCo = CharacterConfig.instance:getPetCo(hurtData.attacker.raceId)
		local targetName = petCo.name
		local targetColor = hurtData:getColorByTeamId(hurtData.attacker.teamId)

		if self.vigour < 0 then
			return string.format(lang("battlerecord_vigour_consume"), targetColor, targetName, targetColor, -self.vigour)
		else
			return string.format(lang("battlerecord_vigour_add"), targetColor, targetName, targetColor, self.vigour)
		end
	end
end

return HurtEvtAttackerVigour
