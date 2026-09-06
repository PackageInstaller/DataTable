-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/battle/skills/buffs/BuffAnimation.lua

module("logicscene.scene.battle.skills.buffs.BuffAnimation", package.seeall)

local BuffAnimation = class("BuffAnimation", BuffBase)

function BuffAnimation:onBuffBegin()
	self._unit:stopSkill()
	self._unit.attrs:setAnimation(true)
	self._unit.skillPlayer:play(self.animation, self._onPlayEvent, self)
	BuffAnimation.super.onBuffBegin(self)
end

function BuffAnimation:onBuffEnd()
	self._unit.skillPlayer:stopAnimation()
	self._unit.attrs:setAnimation(false)
	BuffAnimation.super.onBuffEnd(self)
end

function BuffAnimation:pause()
	if self._isPause then
		return
	end

	self._isPause = true

	self._unit.skillPlayer:pauseAnimation()
end

function BuffAnimation:resume()
	if not self._isPause then
		return
	end

	self._isPause = false

	self._unit.skillPlayer:resumeAnimation()
end

function BuffAnimation:isDone()
	return self._isDone
end

function BuffAnimation:_onPlayEvent(evt)
	if evt == "stop" or evt == "break" then
		self._isDone = true
	end
end

function BuffAnimation:getBuffId()
	return UnitCompBuffList.AnimationId
end

function BuffAnimation:isCustomBuff()
	return true
end

return BuffAnimation
