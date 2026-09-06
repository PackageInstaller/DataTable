-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtGenesisSkill.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtGenesisSkill", package.seeall)

local HurtEvtGenesisSkill = class("HurtEvtGenesisSkill", HurtEvtBase)

function HurtEvtGenesisSkill:getEvtType()
	return HurtEvtType.EvtGenesisSkill
end

function HurtEvtGenesisSkill:handleEvt(hurtData)
	BattleGenesisModel.instance:setGenesisInfo(self.teamId, self.newView)
	HurtEvtGenesisSkill.super.handleEvt(self, hurtData)
end

return HurtEvtGenesisSkill
