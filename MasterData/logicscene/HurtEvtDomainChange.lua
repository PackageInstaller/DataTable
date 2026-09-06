-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtDomainChange.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtDomainChange", package.seeall)

local HurtEvtDomainChange = class("HurtEvtDomainChange", HurtEvtBase)

function HurtEvtDomainChange:getEvtType()
	return HurtEvtType.DomainChange
end

function HurtEvtDomainChange:handleEvt(hurtData)
	local scene = SceneMgr.instance:getCurScene()
	local unit = scene.unitFactory:getUnit(self.domainChange.trigger.targetTeamId, self.domainChange.trigger.targetCharacterId)

	unit:onDomainChange(self.domainChange.skillId, self.domainChange.level)
	HurtEvtDomainChange.super.handleEvt(self, hurtData)
end

function HurtEvtDomainChange:getDesc(hurtData)
	return
end

return HurtEvtDomainChange
