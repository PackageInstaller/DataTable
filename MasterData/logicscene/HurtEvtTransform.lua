-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtTransform.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtTransform", package.seeall)

local HurtEvtTransform = class("HurtEvtTransform", HurtEvtBase)

function HurtEvtTransform:getEvtType()
	return HurtEvtType.EvtTransform
end

function HurtEvtTransform:handleEvt(hurtData)
	hurtData.target:onTransform(self.curFaceId, self.curRaceId, self.curNormalSkillId, self.curUltimateSkillId, self.curAttributes, self.isPsychicTransform)
	HurtEvtTransform.super.handleEvt(self, hurtData)
end

function HurtEvtTransform:getDesc(hurtData)
	if hurtData.target then
		local targetColor = hurtData:getColorByTeamId(hurtData.target.teamId)
		local petCoFrom = CharacterConfig.instance:getPetCo(self.fromRaceId)
		local petCo = CharacterConfig.instance:getPetCo(self.curRaceId)
		local preName = petCoFrom.name
		local currName = petCo.name

		return string.format(lang("battlerecord_transform"), targetColor, preName, targetColor, currName)
	end
end

return HurtEvtTransform
