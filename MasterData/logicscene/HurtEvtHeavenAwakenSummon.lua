-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtHeavenAwakenSummon.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtHeavenAwakenSummon", package.seeall)

local HurtEvtHeavenAwakenSummon = class("HurtEvtHeavenAwakenSummon", HurtEvtBase)

function HurtEvtHeavenAwakenSummon:getEvtType()
	return HurtEvtType.EvtHeavenAwakenSummon
end

function HurtEvtHeavenAwakenSummon:handleEvt(hurtData)
	hurtData.target:onTJSummonMonster()

	local battleScene = SceneMgr.instance:getCurScene()
	local unitFactory = battleScene.unitFactory
	local unit = unitFactory:getUnit(self.teamId, self.unitId)

	if unit then
		unit:onTJSummoned(true)
	end

	HurtEvtHeavenAwakenSummon.super.handleEvt(self, hurtData)
end

function HurtEvtHeavenAwakenSummon:getDesc(hurtData)
	return
end

return HurtEvtHeavenAwakenSummon
