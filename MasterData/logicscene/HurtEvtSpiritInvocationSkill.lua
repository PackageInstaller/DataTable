-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtSpiritInvocationSkill.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtSpiritInvocationSkill", package.seeall)

local HurtEvtSpiritInvocationSkill = class("HurtEvtSpiritInvocationSkill", HurtEvtBase)

function HurtEvtSpiritInvocationSkill:getEvtType()
	return HurtEvtType.EvtSpiritInvocationSkill
end

function HurtEvtSpiritInvocationSkill:handleEvt(hurtData)
	BattleSpiritInvocationModel.instance:setSpiritInvocationInfo(self.teamId, self.newView)
	HurtEvtSpiritInvocationSkill.super.handleEvt(self, hurtData)
end

return HurtEvtSpiritInvocationSkill
