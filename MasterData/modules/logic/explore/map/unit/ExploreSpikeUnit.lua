-- chunkname: @modules/logic/explore/map/unit/ExploreSpikeUnit.lua

module("modules.logic.explore.map.unit.ExploreSpikeUnit", package.seeall)

local ExploreSpikeUnit = class("ExploreSpikeUnit", ExploreBaseDisplayUnit)

function ExploreSpikeUnit:onResLoaded()
	self:beginTriggerSpike()
	gohelper.addAkGameObject(self.go)
end

function ExploreSpikeUnit:beginTriggerSpike()
	self:setInteractActive(false)
	self.animComp:playAnim(ExploreAnimEnum.AnimName.normal)
	self:setSpikeActive(false)
	TaskDispatcher.runDelay(self.activeSpike, self, self.mo.intervalTime)
end

function ExploreSpikeUnit:activeSpike()
	self:beginAudio()
	self:setSpikeActive(true)
	self:setInteractActive(true)
end

function ExploreSpikeUnit:inactiveSpike()
	self:beginAudio()
	self:setSpikeActive(true)
	self:setInteractActive(false)
end

function ExploreSpikeUnit:isInFOV()
	return true
end

function ExploreSpikeUnit:setInFOV()
	return
end

function ExploreSpikeUnit:onAnimEnd(preAnim, nowAnim)
	self:stopAudio()

	if nowAnim == ExploreAnimEnum.AnimName.normal then
		self:setSpikeActive(false)
		TaskDispatcher.runDelay(self.activeSpike, self, self.mo.intervalTime)
	elseif nowAnim == ExploreAnimEnum.AnimName.active then
		self:setSpikeActive(true)
		TaskDispatcher.runDelay(self.inactiveSpike, self, self.mo.keepTime)
	end
end

function ExploreSpikeUnit:setSpikeActive(v)
	self._spikeAcitve = v

	if v and self.roleStay then
		TaskDispatcher.runDelay(self.delayCheckCanTrigger, self, 0.3)
	end
end

function ExploreSpikeUnit:onRoleEnter(nowNode, preNode, unit)
	if unit:isRole() then
		self.roleStay = true

		if self._spikeAcitve then
			TaskDispatcher.runDelay(self.delayCheckCanTrigger, self, 0.3)
		end
	end
end

function ExploreSpikeUnit:onRoleLeave(nowNode, preNode, unit)
	if unit:isRole() then
		self.roleStay = false

		TaskDispatcher.cancelTask(self.delayCheckCanTrigger, self)
	end
end

function ExploreSpikeUnit:delayCheckCanTrigger()
	if self._spikeAcitve and self.roleStay then
		self:tryTrigger()
	end
end

function ExploreSpikeUnit:tryTrigger(...)
	if not self._spikeAcitve then
		return
	end

	local map = ExploreController.instance:getMap()
	local hero = map:getHero()

	hero:stopMoving(true)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Spike)
	ExploreSpikeUnit.super.tryTrigger(self, ...)
end

function ExploreSpikeUnit:beginAudio()
	if not self.mo.playAudio then
		return
	end

	local map = ExploreController.instance:getMap()
	local hero = map:getHero()

	if ExploreHelper.getDistance(hero.nodePos, self.nodePos) > ExploreConstValue.TrapAudioMaxDis then
		return
	end

	if not self._playingAudio then
		AudioMgr.instance:trigger(AudioEnum.Explore.TrapStart, self.go)

		self._playingAudio = true
	end
end

function ExploreSpikeUnit:stopAudio()
	if self._playingAudio then
		AudioMgr.instance:trigger(AudioEnum.Explore.TrapEnd, self.go)

		self._playingAudio = false
	end
end

function ExploreSpikeUnit:pauseTriggerSpike()
	self.roleStay = false
	self._spikeAcitve = false

	self.animComp:playAnim(ExploreAnimEnum.AnimName.active)
	TaskDispatcher.cancelTask(self.activeSpike, self)
	TaskDispatcher.cancelTask(self.inactiveSpike, self)
	TaskDispatcher.cancelTask(self.delayCheckCanTrigger, self)
end

function ExploreSpikeUnit:onDestroy()
	self:stopAudio()
	TaskDispatcher.cancelTask(self.activeSpike, self)
	TaskDispatcher.cancelTask(self.inactiveSpike, self)
	TaskDispatcher.cancelTask(self.delayCheckCanTrigger, self)
	ExploreSpikeUnit.super.onDestroy(self)
end

return ExploreSpikeUnit
