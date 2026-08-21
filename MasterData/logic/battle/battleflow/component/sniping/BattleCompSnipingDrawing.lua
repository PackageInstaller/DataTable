-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/sniping/BattleCompSnipingDrawing.lua

module("logic.battle.battleflow.component.sniping.BattleCompSnipingDrawing", package.seeall)

local BattleCompSnipingDrawing = class("BattleCompSnipingDrawing", IBattleFlowComp)

function BattleCompSnipingDrawing:onInit()
	self._lineList = {}
end

function BattleCompSnipingDrawing:onStart()
	self._unitMgr = self.flow.unitMgr or false

	self:_setEvent(true)
end

function BattleCompSnipingDrawing:onClear()
	self:_setEvent(false)
	self:clearAllSnipingLine()

	self._unitMgr = false
end

function BattleCompSnipingDrawing:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnEntityMove, self._onUnitMove, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnEntityMove, self._onUnitMove, self)
	end
end

function BattleCompSnipingDrawing:onUpdateTimeScale()
	for _, line in pairs(self._lineList) do
		line:setPlaySpeed(BattleTime.timeScale)
	end
end

function BattleCompSnipingDrawing:drawSniping(fromUnit, toUnit)
	local fx, fy, fz = BattleUnitUtil.getUnitCenterPos(fromUnit)
	local tx, ty, tz = BattleUnitUtil.getUnitCenterPos(toUnit)
	local line = SnipingCurveLine:createInstance()

	line:setOwnerEntityId(fromUnit.property:getEntityId())
	line:setTargetEntityId(toUnit.property:getEntityId())
	line:setStartPositionXYZ(fx, fy, fz)
	line:setEndPositionXYZ(tx, ty, tz)
	line:setPlaySpeed(BattleTime.timeScale)
	line:rebuild()
	table.insert(self._lineList, line)
	toUnit.uiProxy:setSnipingStatus(true)
end

function BattleCompSnipingDrawing:clearSnipingForUnit(unit)
	local targetEntityId = false

	for index, line in pairs(self._lineList) do
		if line:isEqualOwnerEntityId(unit.property:getEntityId()) then
			targetEntityId = line:getTargetEntityId()

			line:returnSelf()
			table.remove(self._lineList, index)

			break
		end
	end

	for index, line in pairs(self._lineList) do
		if line:getTargetEntityId() == targetEntityId then
			return
		end
	end

	local targetUnit = self._unitMgr:getUnit(targetEntityId)

	if targetUnit then
		targetUnit.uiProxy:setSnipingStatus(false)
	end
end

function BattleCompSnipingDrawing:clearAllSnipingLine()
	for _, line in pairs(self._lineList) do
		line:returnSelf()
	end

	BattleTableUtil.clearTable(self._lineList)
end

function BattleCompSnipingDrawing:_onUnitMove(evt, entityId)
	local unit = self._unitMgr:getUnit(entityId)

	if not unit then
		return
	end

	for index, line in pairs(self._lineList) do
		if line:isEqualOwnerEntityId(entityId) then
			local fx, fy, fz = BattleUnitUtil.getUnitCenterPos(unit)

			line:setStartPositionXYZ(fx, fy, fz)
			line:rebuild()
		elseif line:getTargetEntityId() == entityId then
			local fx, fy, fz = BattleUnitUtil.getUnitCenterPos(unit)

			line:setEndPositionXYZ(fx, fy, fz)
			line:rebuild()
		end
	end
end

return BattleCompSnipingDrawing
