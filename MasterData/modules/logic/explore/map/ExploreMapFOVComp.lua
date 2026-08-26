-- chunkname: @modules/logic/explore/map/ExploreMapFOVComp.lua

module("modules.logic.explore.map.ExploreMapFOVComp", package.seeall)

local ExploreMapFOVComp = class("ExploreMapFOVComp", LuaCompBase)

function ExploreMapFOVComp:init(go)
	self._showRange = 8
	self._hideRange = 12
end

function ExploreMapFOVComp:addEventListeners()
	self.addEventCb(self, ExploreController.instance, ExploreEvent.OnCharacterNodeChange, self._onCharacterNodeChange, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.OnUnitNodeChange, self._onUnitNodeChange, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.SetFovTargetPos, self._setFovTargetPos, self)
end

function ExploreMapFOVComp:removeEventListeners()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.OnCharacterNodeChange, self._onCharacterNodeChange, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.OnUnitNodeChange, self._onUnitNodeChange, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.SetFovTargetPos, self._setFovTargetPos, self)
end

function ExploreMapFOVComp:setMap(map)
	self._map = map

	self:_onCharacterNodeChange()
end

function ExploreMapFOVComp:_onCharacterNodeChange(nowPos, prePos, nextPos)
	self:_checkFov()
end

function ExploreMapFOVComp:_setFovTargetPos(pos)
	self._targetPos = pos

	self:_checkFov()
end

function ExploreMapFOVComp:_checkFov()
	local dic = self._map:getAllUnit()

	if not dic then
		return
	end

	local heroNodePos = self._map:getHeroPos()

	for id, unit in pairs(dic) do
		self:_checkUnitInFov(unit, (self._targetPos or nil) and ExploreHelper.posToTile(self._targetPos))
	end
end

function ExploreMapFOVComp:_onUnitNodeChange(changeUnit, nowPos, prePos)
	if not self._targetPos then
		local heroNodePos = self._map:getHeroPos()

		self:_checkUnitInFov(changeUnit, self._targetPos)
	end
end

function ExploreMapFOVComp:_checkUnitInFov(unit, pos)
	local isInFov = unit:isInFOV()
	local isUseItem = ExploreModel.instance:isUseItemOrUnit(unit.id)

	if isUseItem then
		if not isInFov then
			unit:setInFOV(true)
		end

		return
	end

	local dis = ExploreHelper.getDistanceRound(pos, unit.nodePos)

	if isInFov then
		if dis >= self._hideRange then
			unit:setInFOV(false)
		end
	elseif dis <= self._showRange then
		unit:setInFOV(true)
	end
end

function ExploreMapFOVComp:onDestroy()
	self._map = nil
	self._targetPos = nil
end

return ExploreMapFOVComp
