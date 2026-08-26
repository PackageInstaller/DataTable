-- chunkname: @modules/logic/explore/map/heroanimflow/ExploreHeroCatchUnitFlow.lua

module("modules.logic.explore.map.heroanimflow.ExploreHeroCatchUnitFlow", package.seeall)

local ExploreHeroCatchUnitFlow = class("ExploreHeroCatchUnitFlow")

function ExploreHeroCatchUnitFlow:catchUnit(unit)
	if ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	self._catchUnit = unit

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	local hero = self:getHero()
	local dir = ExploreHelper.xyToDir(unit.mo.nodePos.x - hero.nodePos.x, unit.mo.nodePos.y - hero.nodePos.y)
	local finalPos = (hero:getPos() - unit:getPos()):SetNormalize():Mul(0.3):Add(unit:getPos())

	hero:setTrOffset(dir, finalPos, 0.39, self.onRoleMoveToUnitEnd, self)
	hero:setMoveSpeed(0.3)
end

function ExploreHeroCatchUnitFlow:onRoleMoveToUnitEnd()
	local hero = self:getHero()

	hero:setMoveSpeed(0)

	if self._catchUnit then
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPick)
	else
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPut)
	end

	TaskDispatcher.runDelay(self._delayCatchUnit, self, 0.4)
end

function ExploreHeroCatchUnitFlow:_delayCatchUnit()
	if self._catchUnit then
		local hero = self:getHero()
		local trans = hero:getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right)

		if trans then
			self._catchUnit:setParent(trans, ExploreEnum.ExplorePipePotHangType.Carry)
		end

		AudioMgr.instance:trigger(AudioEnum.Explore.Pick_Pot)
	else
		self._uncatchUnit:setParent(ExploreController.instance:getMap():getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
		AudioMgr.instance:trigger(AudioEnum.Explore.Put_Pot)
	end

	TaskDispatcher.runDelay(self._onCatchEnd, self, 0.4)
end

function ExploreHeroCatchUnitFlow:_onCatchEnd()
	local hero = self:getHero()

	hero:setMoveSpeed(0)

	if self._catchUnit then
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)

		local pos = ExploreHelper.tileToPos(ExploreHelper.posToTile(hero:getPos() + hero._displayTr.localPosition))
		local heroPos = hero:getPos()

		pos.y = heroPos.y

		hero:setTrOffset(nil, pos, 0.21, self.onRoleMoveToCenterEnd, self)
		hero:setMoveSpeed(0.3)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	else
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.MoveBack)

		local heroPos = hero:getPos():Clone()
		local xy = ExploreHelper.dirToXY(hero.dir)
		local finalPos = heroPos:Clone()

		finalPos.x = finalPos.x - xy.x * 1
		finalPos.z = finalPos.z - xy.y * 1
		heroPos.x = heroPos.x - xy.x * 0.3
		heroPos.z = heroPos.z - xy.y * 0.3
		hero._displayTr.localPosition = heroPos - finalPos

		hero:setPos(finalPos, nil, true)
		hero:setTrOffset(hero.dir, finalPos, 0.6, self.onRoleMoveBackEnd, self)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	end
end

function ExploreHeroCatchUnitFlow:onRoleMoveToCenterEnd()
	local hero = self:getHero()
	local realPos = hero:getPos() + hero._displayTr.localPosition

	hero:setPos(realPos)

	hero._displayTr.localPosition = Vector3.zero

	hero:setMoveSpeed(0)

	self._catchUnit = nil

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.CatchUnit)
end

function ExploreHeroCatchUnitFlow:onRoleMoveBackEnd()
	local hero = self:getHero()

	if self._catchUnit and self._fromUnit then
		hero:setMoveSpeed(0)
	else
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	end

	if self._endCallBack and self._fromUnit then
		self._endCallBack(self._fromUnit)
	end

	self._catchUnit = nil
	self._uncatchUnit = nil
	self._fromUnit = nil
	self._endCallBack = nil

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.CatchUnit)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryEnd)
end

function ExploreHeroCatchUnitFlow:uncatchUnit(unit)
	local hero = self:getHero()

	if ExploreHeroResetFlow.instance:isReseting() then
		local map = ExploreController.instance:getMap()

		unit:setParent(map:getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)

		return
	end

	transformhelper.setLocalPos(unit.trans, 0, 0, 0)

	self._uncatchUnit = unit

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	local xy = ExploreHelper.dirToXY(hero.dir)
	local finalPos = hero:getPos():Clone()

	finalPos.x = finalPos.x - xy.x * 0.3
	finalPos.z = finalPos.z - xy.y * 0.3

	hero:setTrOffset(hero.dir, finalPos, 0.39, self.onRoleMoveToUnitEnd, self)
	hero:setMoveSpeed(0.3)
end

function ExploreHeroCatchUnitFlow:getHero()
	return ExploreController.instance:getMap():getHero()
end

function ExploreHeroCatchUnitFlow:isInFlow(unit)
	if not unit then
		return self._catchUnit or self._uncatchUnit
	end

	return unit == self._catchUnit or unit == self._uncatchUnit
end

function ExploreHeroCatchUnitFlow:catchUnitFrom(unit, fromUnit, endCallBack)
	if ExploreHeroResetFlow.instance:isReseting() then
		endCallBack(fromUnit)

		return
	end

	self._catchUnit = unit
	self._fromUnit = fromUnit
	self._endCallBack = endCallBack

	self:moveToFromUnit(fromUnit)
end

function ExploreHeroCatchUnitFlow:uncatchUnitFrom(unit, fromUnit, endCallBack)
	if ExploreHeroResetFlow.instance:isReseting() then
		endCallBack(fromUnit)

		return
	end

	self._uncatchUnit = unit
	self._fromUnit = fromUnit
	self._endCallBack = endCallBack

	transformhelper.setLocalPos(self._uncatchUnit.trans, 0, 0, 0)
	self:moveToFromUnit(fromUnit)
end

function ExploreHeroCatchUnitFlow:moveToFromUnit(fromUnit)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.CatchUnit)

	local hero = self:getHero()
	local dir = ExploreHelper.xyToDir(fromUnit.mo.nodePos.x - hero.nodePos.x, fromUnit.mo.nodePos.y - hero.nodePos.y)
	local finalPos = (hero:getPos() - fromUnit:getPos()):SetNormalize():Mul(0.3):Add(fromUnit:getPos())

	hero:setTrOffset(dir, finalPos, 0.39, self.onRoleMoveToFromUnitEnd, self)
	hero:setMoveSpeed(0.3)
end

function ExploreHeroCatchUnitFlow:onRoleMoveToFromUnitEnd()
	local hero = self:getHero()

	hero:setMoveSpeed(0)

	local delay = 0.4

	if self._catchUnit then
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPick)
	else
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CarryPut)

		delay = 0.2
	end

	TaskDispatcher.runDelay(self._delayCatchUnitFromUnit, self, delay)
end

function ExploreHeroCatchUnitFlow:_delayCatchUnitFromUnit()
	local delay = 0.4

	if self._catchUnit then
		local hero = self:getHero()
		local trans = hero:getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right)

		if trans then
			self._catchUnit:setParent(trans, ExploreEnum.ExplorePipePotHangType.Carry)
		end

		AudioMgr.instance:trigger(AudioEnum.Explore.Take_On_Pot)
	else
		self._uncatchUnit:setParent(self._fromUnit.trans, ExploreEnum.ExplorePipePotHangType.Put)

		delay = 0.6

		AudioMgr.instance:trigger(AudioEnum.Explore.Take_Off_Pot)
	end

	TaskDispatcher.runDelay(self._onCatchFromUnitEnd, self, delay)
end

function ExploreHeroCatchUnitFlow:_onCatchFromUnitEnd()
	local unit = self._fromUnit
	local hero = self:getHero()
	local dir = ExploreHelper.xyToDir(unit.nodePos.x - hero.nodePos.x, unit.mo.nodePos.y - hero.nodePos.y)
	local finalPos = ExploreHelper.tileToPos(hero.nodePos)

	hero:setTrOffset(dir, finalPos, 0.39, self.onRoleMoveBackEnd, self)

	if self._catchUnit then
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)
		hero:setMoveSpeed(0.3)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	else
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
		hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.MoveBack)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)
	end
end

function ExploreHeroCatchUnitFlow:clear()
	self._catchUnit = nil
	self._uncatchUnit = nil
	self._fromUnit = nil
	self._endCallBack = nil

	TaskDispatcher.cancelTask(self._delayCatchUnitFromUnit, self)
	TaskDispatcher.cancelTask(self._delayCatchUnit, self)
	TaskDispatcher.cancelTask(self._onCatchEnd, self)
	TaskDispatcher.cancelTask(self._onCatchFromUnitEnd, self)
end

ExploreHeroCatchUnitFlow.instance = ExploreHeroCatchUnitFlow.New()

return ExploreHeroCatchUnitFlow
