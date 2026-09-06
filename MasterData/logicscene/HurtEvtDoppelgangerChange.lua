-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/hurts/evts/HurtEvtDoppelgangerChange.lua

module("logicscene.scene.battle.skills.hurts.evts.HurtEvtDoppelgangerChange", package.seeall)

local HurtEvtDoppelgangerChange = class("HurtEvtDoppelgangerChange", HurtEvtBase)

function HurtEvtDoppelgangerChange:getEvtType()
	return HurtEvtType.EvtDoppelgangerChange
end

function HurtEvtDoppelgangerChange:handleEvt(hurtData)
	hurtData.target:onDoppelganger()

	local battleScene = SceneMgr.instance:getCurScene()
	local unitFactory = battleScene.unitFactory
	local unit = unitFactory:getUnit(self.teamId, self.unitId)

	if unit then
		unit:onDoppelgangered(true, true)
	end

	HurtEvtDoppelgangerChange.super.handleEvt(self, hurtData)
end

function HurtEvtDoppelgangerChange:getDesc(hurtData)
	return
end

return HurtEvtDoppelgangerChange
