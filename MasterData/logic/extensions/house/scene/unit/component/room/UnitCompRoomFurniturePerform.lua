-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomFurniturePerform.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomFurniturePerform", package.seeall)

local M = class("UnitCompRoomFurniturePerform", UnitComponentBase)
local PlayerStatus = HouseEnum.PlayerStatus
local BehaviorStatus = HouseEnum.BehaviorStatus

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._arrayPerformCtrl = {}
	self._triggerTimer = SchedulerCtrl.New(self._tryPerformTrigger, self)
end

function M:onReuse()
	return
end

function M:onReset()
	self._triggerTimer:stop()
end

function M:onRoomResLoaded()
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_START, self._onFurnitureEditStart, self)
	HouseDispatcher:addEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)
end

function M:onRoomResUnload()
	HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_START, self._onFurnitureEditStart, self)
	HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_EDIT_END, self._onFurnitureEditEnd, self)
end

function M:onDestroy()
	self:onReset()
	self._triggerTimer:clear()

	self._triggerTimer = nil
end

function M:interruptAllCtrl()
	for _, ctrl in ipairs(self._arrayPerformCtrl) do
		ctrl:interruptPerform()
		ctrl:returnSelf()
	end

	table.clear(self._arrayPerformCtrl)
end

function M:clearEndingCtrls()
	local len = #self._arrayPerformCtrl

	if len > 0 then
		for i = len, 1, -1 do
			local ctrl = self._arrayPerformCtrl[i]

			if not ctrl:isWorking() then
				ctrl:returnSelf()
				table.remove(self._arrayPerformCtrl, i)
			end
		end
	end
end

function M:startPerformTriggerTimer()
	self:endPerformTriggerTimer()
	self:_loopPerformTrigger()
end

function M:endPerformTriggerTimer()
	self._triggerTimer:stop()
end

function M:_loopPerformTrigger()
	local sec = math.random(5, 10)

	self._triggerTimer:restart(sec, false)
end

function M:_tryPerformTrigger()
	self:showPerforms()
	self:_loopPerformTrigger()
end

function M:showPerforms()
	self:clearEndingCtrls()
	self:triggerWaitingCtrls()

	local count = math.random(0, 2)

	if count > 0 then
		for i = 1, count do
			self:showPerform()
		end
	end
end

function M:showPerform()
	local units = HouseSceneUtil.getPlayersByZoneId(self._unit.model:getRoomId())
	local freeUnits = {}

	for _, unit in ipairs(units) do
		if HousePerformUtil.canUnitTriggerPerform(unit) and unit.performCtrl:canTriggerFurniture() then
			table.insert(freeUnits, unit)
		end
	end

	local performCOs = {}
	local dictFurniture = self._unit.furnitureMgr:getDictFurnitureUnit()

	for _, furniture in pairs(dictFurniture) do
		local hasPath = furniture.perform:hasPathToTrigger()

		if hasPath then
			local furnitureId = furniture.model:getFurnitureId()
			local COs = HouseConfig.instance:getFurnPerformCOs(furnitureId)

			for _, CO in ipairs(COs) do
				if CO:canPerform(furniture, freeUnits) then
					table.insert(performCOs, CO)
				end
			end
		end
	end

	local targetCO
	local totalWeight = 0

	for _, CO in ipairs(performCOs) do
		totalWeight = totalWeight + CO:getWeight()
	end

	local weight = math.random(1, totalWeight)

	for _, CO in ipairs(performCOs) do
		if weight <= CO:getWeight() then
			targetCO = CO

			break
		end

		weight = weight - CO:getWeight()
	end

	if targetCO then
		self:createPerformCtrl(targetCO)
	end
end

function M:createPerformCtrl(CO)
	local ctrl = FurniturePerformCtrl:createInstance()

	ctrl:showPerformance(CO)
	table.insert(self._arrayPerformCtrl, ctrl)

	return ctrl
end

function M:getCtrlsByFurniture(id)
	local ctrls = {}

	for _, ctrl in ipairs(self._arrayPerformCtrl) do
		local furniture = ctrl:getFurniture()

		if furniture and furniture.id == id then
			table.insert(ctrls, ctrl)
		end
	end

	return ctrls
end

function M:triggerWaitingCtrls()
	for _, ctrl in ipairs(self._arrayPerformCtrl) do
		if ctrl:isWaitingPlayer() then
			self:_triggerWaitingCtrl(ctrl)
		end
	end
end

function M:_triggerWaitingCtrl(ctrl)
	local units = HouseSceneUtil.getPlayersByZoneId(self._unit.model:getRoomId())
	local freeUnits = {}

	for _, unit in ipairs(units) do
		if HousePerformUtil.canUnitTriggerPerform(unit) and unit.performCtrl:canTriggerFurniture() then
			table.insert(freeUnits, unit)
		end
	end

	ctrl:findRemainPerformUnits(freeUnits)
end

function M:_onFurnitureEditStart()
	return
end

function M:_onFurnitureEditEnd()
	return
end

return M
