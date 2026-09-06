-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtMaxHp.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtMaxHp", package.seeall)

local HurtEvtMaxHp = class("HurtEvtMaxHp", HurtEvtBase)

function HurtEvtMaxHp:getEvtType()
	return HurtEvtType.EvtMaxHp
end

function HurtEvtMaxHp:handleEvt(hurtData)
	hurtData.target:onMaxHpChange(self.oldCurValue, self.oldMaxValue, self.newCurValue, self.newMaxValue)
	HurtEvtMaxHp.super.handleEvt(self, hurtData)
end

function HurtEvtMaxHp:getDesc(hurtData)
	if hurtData.target then
		local targetColor = hurtData:getColorByTeamId(hurtData.target.teamId)
		local petCo = CharacterConfig.instance:getPetCo(hurtData.target.raceId)
		local targetName = petCo.name

		return string.format(lang("battlerecord_max_sp"), targetColor, targetName)
	end
end

return HurtEvtMaxHp
