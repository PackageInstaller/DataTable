-- chunkname: @modules/logic/explore/map/ExploreMapUnitCatchComp.lua

module("modules.logic.explore.map.ExploreMapUnitCatchComp", package.seeall)

local ExploreMapUnitCatchComp = class("ExploreMapUnitCatchComp", LuaCompBase)

function ExploreMapUnitCatchComp:init(go)
	self._mapGo = go
end

function ExploreMapUnitCatchComp:addEventListeners()
	self.addEventCb(self, ExploreController.instance, ExploreEvent.UseItemChanged, self._onUpdateCatchUnit, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.OnClickHero, self._onClickHero, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.HeroResInitDone, self._onHeroInitDone, self)
end

function ExploreMapUnitCatchComp:removeEventListeners()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.UseItemChanged, self._onUpdateCatchUnit, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.HeroResInitDone, self._onHeroInitDone, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.OnClickHero, self._onClickHero, self)
end

function ExploreMapUnitCatchComp:setMap(map)
	self._map = map
	self._hero = map:getHero()

	self:_onUpdateCatchUnit()

	if self._catchUnit then
		self._catchUnit:setActive(false)
	end
end

function ExploreMapUnitCatchComp:_onHeroInitDone()
	if self._catchUnit then
		self._catchUnit:setActive(true)
		self._catchUnit:setupRes()
		self._hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)

		local trans = self._hero:getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right)

		if trans then
			self._catchUnit:setParent(trans, ExploreEnum.ExplorePipePotHangType.Carry)
		end
	end
end

function ExploreMapUnitCatchComp:_onUpdateCatchUnit(useItemUid)
	local id = tonumber(ExploreModel.instance:getUseItemUid())
	local preUnit = self._catchUnit

	self._catchUnit = self._map:getUnit(id, true)

	local isChange = self._catchUnit ~= preUnit

	if self._catchUnit then
		self._catchUnit:removeFromNode()
	end

	if isChange and useItemUid then
		if self._catchUnit ~= nil then
			self._catchUnit.nodePos = self._catchUnit.nodePos or self._catchUnit.mo.nodePos

			ExploreHeroCatchUnitFlow.instance:catchUnit(self._catchUnit)
		else
			ExploreHeroCatchUnitFlow.instance:uncatchUnit(preUnit)
		end
	end
end

function ExploreMapUnitCatchComp:setCatchUnit(unit)
	self._catchUnit = unit
end

function ExploreMapUnitCatchComp:_onClickHero()
	if not ExploreModel.instance:isHeroInControl() then
		return
	end

	if self._hero:isMoving() then
		return
	end

	if self._catchUnit then
		ExploreController.instance:dispatchEvent(ExploreEvent.TryCancelTriggerUnit, self._catchUnit.id)
	end
end

function ExploreMapUnitCatchComp:onDestroy()
	self._mapGo = nil
	self._map = nil
	self._catchUnit = nil
end

return ExploreMapUnitCatchComp
