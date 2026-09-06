-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtPsychicSkill.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtPsychicSkill", package.seeall)

local HurtEvtPsychicSkill = class("HurtEvtPsychicSkill", HurtEvtBase)

function HurtEvtPsychicSkill:getEvtType()
	return HurtEvtType.EvtPsychicSkill
end

function HurtEvtPsychicSkill:handleEvt(hurtData)
	BattlePsychicModel.instance:setPsychicInfo(self.teamId, self.newView)
	HurtEvtPsychicSkill.super.handleEvt(self, hurtData)
end

return HurtEvtPsychicSkill
