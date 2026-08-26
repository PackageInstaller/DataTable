-- chunkname: @modules/logic/explore/map/unit/ExploreElevatorUnit.lua

module("modules.logic.explore.map.unit.ExploreElevatorUnit", package.seeall)

local ExploreElevatorUnit = class("ExploreElevatorUnit", ExploreBaseDisplayUnit)

function ExploreElevatorUnit:onInit()
	self._stayUnitDic = {}
end

function ExploreElevatorUnit:setupMO()
	self._useHeight1 = self.mo:getInteractInfoMO().statusInfo.height == self.mo.height2

	self:_elevatorKeep()
end

function ExploreElevatorUnit:onRoleEnter(nowNode, preNode, role)
	if not preNode then
		return
	end

	if ExploreHeroCatchUnitFlow.instance:isInFlow() then
		ExploreController.instance:registerCallback(ExploreEvent.HeroCarryEnd, self._carryEnd, self)

		return
	end

	if self._stayUnitDic[role] == nil then
		self._useHeight1 = self.position.y == self.mo.height1

		self:_elevatorMoving()
	end

	self._stayUnitDic[role] = role.position.y - self.position.y

	role:clearTarget()
end

function ExploreElevatorUnit:_carryEnd()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroCarryEnd, self._carryEnd, self)
	self:onRoleEnter(nil, true, ExploreController.instance:getMap():getHero())
end

function ExploreElevatorUnit:onRoleLeave(nowNode, preNode, role)
	self._stayUnitDic[role] = nil
end

function ExploreElevatorUnit:movingElevator(height, time)
	if self.position.y ~= height then
		self.mo:updateNodeHeight(9999999)

		local tarY = height
		local startY = self.position.y

		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)
		end

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(startY, tarY, time, self._setY, nil, self, nil, EaseType.Linear)
		self._tarY = tarY

		self:setStatusActive(true)
		TaskDispatcher.runDelay(self.setNodeHeightByTarY, self, time)
	end
end

function ExploreElevatorUnit:_elevatorKeep()
	self:setStatusActive(false)
	self:setSpikeActive(self._useHeight1 == false)

	if string.nilorempty(self.mo.keepTime) == false then
		TaskDispatcher.runDelay(self._elevatorMoving, self, self.mo.keepTime)
	end
end

function ExploreElevatorUnit:_elevatorMoving()
	self.mo:updateNodeHeight(9999999)

	if string.nilorempty(self.mo.intervalTime) == false then
		if self._useHeight1 then
			if not self.mo.height2 then
				local tarY = self.mo.height1

				if self._useHeight1 then
					if not self.mo.height1 then
						local startY = self.mo.height2

						if self._tweenId then
							ZProj.TweenHelper.KillById(self._tweenId)
						end

						self._tweenId = ZProj.TweenHelper.DOTweenFloat(startY, tarY, self.mo.intervalTime, self._setY, nil, self, nil, EaseType.Linear)

						TaskDispatcher.runDelay(self._elevatorKeep, self, self.mo.intervalTime)
						self:setStatusActive(true)
					end
				end
			end
		end
	else
		self:_elevatorKeep()
	end
end

function ExploreElevatorUnit:setStatusActive(isActive)
	local interactInfoMO = self.mo:getInteractInfoMO()

	interactInfoMO:setBitByIndex(ExploreEnum.InteractIndex.ActiveState, isActive and 1 or 0)
end

function ExploreElevatorUnit:setNodeHeightByTarY()
	ZProj.TweenHelper.KillByObj(self.trans)
	self.mo:updateNodeHeight(self._tarY)
	self:_setY(self._tarY)
	self:setStatusActive(false)
end

function ExploreElevatorUnit:setSpikeActive(v)
	ZProj.TweenHelper.KillByObj(self.trans)

	self._useHeight1 = v

	local nodeKey = ExploreHelper.getKey(self.nodePos)
	local nodeHeight = v and self.mo.height1 or self.mo.height2

	self.mo:updateNodeHeight(nodeHeight)
	self:_setY(nodeHeight)
end

function ExploreElevatorUnit:_setY(y)
	self.position.y = y

	transformhelper.setPos(self.trans, self.position.x, self.position.y, self.position.z)
	self:_updateUnitRoleY()
end

function ExploreElevatorUnit:_updateUnitRoleY()
	for unit, offY in pairs(self._stayUnitDic) do
		unit:updateSceneY(self.position.y + offY)
	end
end

function ExploreElevatorUnit:onDestroy()
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroCarryEnd, self._carryEnd, self)
	ZProj.TweenHelper.KillByObj(self.trans)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	TaskDispatcher.cancelTask(self._elevatorMoving, self)
	TaskDispatcher.cancelTask(self._elevatorKeep, self)
	TaskDispatcher.cancelTask(self.setNodeHeightByTarY, self)
	ExploreElevatorUnit.super.onDestroy(self)
end

return ExploreElevatorUnit
