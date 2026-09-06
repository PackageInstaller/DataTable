-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtCarriedChange.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtCarriedChange", package.seeall)

local HurtEvtCarriedChange = class("HurtEvtCarriedChange", HurtEvtBase)

function HurtEvtCarriedChange:getEvtType()
	return HurtEvtType.EvtCarriedChange
end

function HurtEvtCarriedChange:handleEvt(hurtData)
	hurtData.target:onCarriedChange(self.curFaceId, self.curRaceId, self.target, self.carriedPet)
	HurtEvtCarriedChange.super.handleEvt(self, hurtData)
end

function HurtEvtCarriedChange:getDesc(hurtData)
	if hurtData.target then
		local targetColor = hurtData:getColorByTeamId(hurtData.target.teamId)
		local petCoFrom = CharacterConfig.instance:getPetCo(self.fromRaceId)
		local petCo = CharacterConfig.instance:getPetCo(self.curRaceId)
		local preName = petCoFrom.name
		local currName = petCo.name

		return string.format(lang("battlerecord_transform"), targetColor, preName, targetColor, currName)
	end
end

return HurtEvtCarriedChange
