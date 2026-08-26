-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerHeroPlayAnim.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerHeroPlayAnim", package.seeall)

local ExploreTriggerHeroPlayAnim = class("ExploreTriggerHeroPlayAnim", ExploreTriggerBase)

function ExploreTriggerHeroPlayAnim:handle(param, unit)
	local arr = string.splitToNumber(param, "#")

	self._state = arr[1]
	self._dis = arr[2]
	self._time = arr[3]

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.PlayTriggerAnim)

	local hero = ExploreController.instance:getMap():getHero()

	if self._dis then
		hero:setMoveSpeed(self._time)

		self._moveDir = ExploreHelper.xyToDir(unit.mo.nodePos.x - hero.nodePos.x, unit.mo.nodePos.y - hero.nodePos.y)

		local finalPos = (unit:getPos() - hero:getPos()):SetNormalize():Mul(self._dis):Add(hero:getPos())

		hero:setTrOffset(self._moveDir, finalPos, self._time, self.onRoleMoveEnd, self)
	else
		self:onRoleMoveEnd()
	end
end

function ExploreTriggerHeroPlayAnim:onRoleMoveEnd()
	local hero = ExploreController.instance:getMap():getHero()

	hero:setMoveSpeed(0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroStatuEnd, self.onHeroStateAnimEnd, self)
	hero:setHeroStatus(self._state, true, true)
end

function ExploreTriggerHeroPlayAnim:onHeroStateAnimEnd()
	local hero = ExploreController.instance:getMap():getHero()

	if self._dis then
		hero:setMoveSpeed(self._time)
		hero:setTrOffset(self._moveDir, hero:getPos(), self._time, self.onRoleMoveBackEnd, self)
	else
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.PlayTriggerAnim)
	end

	self:onDone(true)
end

function ExploreTriggerHeroPlayAnim:onRoleMoveBackEnd()
	local hero = ExploreController.instance:getMap():getHero()

	hero:setMoveSpeed(0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.PlayTriggerAnim)
end

function ExploreTriggerHeroPlayAnim:clearWork()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroStatuEnd, self.onHeroStateAnimEnd, self)
end

return ExploreTriggerHeroPlayAnim
