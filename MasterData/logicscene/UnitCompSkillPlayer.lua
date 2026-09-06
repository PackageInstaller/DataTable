-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompSkillPlayer.lua

module("logicscene.scene.unit.component.battle.UnitCompSkillPlayer", package.seeall)

local UnitCompSkillPlayer = class("UnitCompSkillPlayer", UnitComponentBase)

function UnitCompSkillPlayer:ctor(unit)
	UnitCompSkillPlayer.super.ctor(self, unit)

	self._skill = nil
	self._evtHandler = nil
	self._evtHandlerTarget = nil
	self._skillPlayer = BattleSkillPlayer.New(unit)
end

function UnitCompSkillPlayer:playAnimation(skill)
	self._skill = skill

	self._skillPlayer:playAnimation(skill)
end

function UnitCompSkillPlayer:play(animation, evtHandler, evtHandlerTarget)
	self._skillPlayer:play(animation, evtHandler, evtHandlerTarget)
end

function UnitCompSkillPlayer:getAnimLen()
	return self._skillPlayer:getAnimLen()
end

function UnitCompSkillPlayer:setEventHandler(evtHandler, evtHandlerTarget)
	self._skillPlayer:setEventHandler(evtHandler, evtHandlerTarget)
end

function UnitCompSkillPlayer:setAnimationEventHandler(evtHandler, evtHandlerTarget)
	self._skillPlayer:setAnimationEventHandler(evtHandler, evtHandlerTarget)
end

function UnitCompSkillPlayer:stopAnimation()
	self._skillPlayer:stopAnimation()
end

function UnitCompSkillPlayer:pauseAnimation()
	self._skillPlayer:pauseAnimation()
end

function UnitCompSkillPlayer:resumeAnimation()
	self._skillPlayer:resumeAnimation()
end

function UnitCompSkillPlayer:notifyBulletHitFinished(idx)
	self._skillPlayer:notifyBulletHitFinished(idx)
end

return UnitCompSkillPlayer
