-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtSummon.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtSummon", package.seeall)

local HurtEvtSummon = class("HurtEvtSummon", HurtEvtBase)

function HurtEvtSummon:getEvtType()
	return HurtEvtType.EvtSummon
end

function HurtEvtSummon:handleEvt(hurtData)
	hurtData.target:onSummonMonster()

	local battleScene = SceneMgr.instance:getCurScene()
	local unitFactory = battleScene.unitFactory
	local unit = unitFactory:getUnit(self.teamId, self.unitId)

	if unit then
		unit:onSummoned(true, true)
	end

	HurtEvtSummon.super.handleEvt(self, hurtData)
end

function HurtEvtSummon:getDesc(hurtData)
	return
end

return HurtEvtSummon
