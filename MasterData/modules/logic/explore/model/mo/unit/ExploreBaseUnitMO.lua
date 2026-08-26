-- chunkname: @modules/logic/explore/model/mo/unit/ExploreBaseUnitMO.lua

module("modules.logic.explore.model.mo.unit.ExploreBaseUnitMO", package.seeall)

local ExploreBaseUnitMO = pureTable("ExploreBaseUnitMO")
local cachePos = {
	x = 0,
	y = 0
}

function ExploreBaseUnitMO:init(data)
	local prePos

	if self.nodePos and (self.nodePos.x ~= data[ExploreUnitMoFieldEnum.nodePos][1] or self.nodePos.y ~= data[ExploreUnitMoFieldEnum.nodePos][2]) then
		cachePos.x = self.nodePos.x
		cachePos.y = self.nodePos.y
		prePos = cachePos
	end

	self.hasInteract = false

	for property, index in pairs(ExploreUnitMoFieldEnum) do
		self[property] = data[index] or data[index] == nil and self[property]
	end

	self.nodePos.x = self.nodePos[1]
	self.nodePos.y = self.nodePos[2]
	self.enterTriggerType = false
	self.defaultWalkable = self.defaultWalkable ~= false
	self.triggerEffects = self.triggerEffects or {}
	self.doneEffects = self.doneEffects or {}
	self.unitDir = self.unitDir or 0
	self.specialDatas = self.specialDatas or {
		1,
		1
	}
	self.offsetSize = self.offsetSize or {
		0,
		0,
		0,
		0
	}
	self.resRotation = self.resRotation or {
		0,
		0,
		0
	}
	self.resPosition = self.resPosition or {
		0,
		0,
		0
	}
	self.customIconType = nil

	for _, v in pairs(self.triggerEffects) do
		if v[1] == ExploreEnum.TriggerEvent.ChangeIcon then
			self.customIconType = v[2]
		end
	end

	self:initTypeData()

	self.triggerEffectsCount = #self.triggerEffects + 1

	if ExploreModel.instance:hasInteractInfo(self.id) == false then
		self:setStatus(tonumber(self.interact) or 0)
	else
		local interactMO = self:getInteractInfoMO()

		self.unitDir = interactMO.dir
		self.nodePos.x = interactMO.posx
		self.nodePos.y = interactMO.posy
	end

	if self._hasInit ~= true then
		self:buildTriggerExData()
	end

	self._hasInit = true

	if prePos then
		self:_updateNodeOpenKey(prePos, self.nodePos)
	end
end

function ExploreBaseUnitMO:initTypeData()
	return
end

function ExploreBaseUnitMO:updateNO()
	return
end

function ExploreBaseUnitMO:activeStateChange(isActive)
	if not self._countSource then
		return
	end

	for _, targetId in pairs(self._countSource) do
		if isActive then
			ExploreCounterModel.instance:add(targetId, self.id)
		else
			ExploreCounterModel.instance:reduce(targetId, self.id)
		end
	end
end

function ExploreBaseUnitMO:buildTriggerExData()
	for i, v in ipairs(self.triggerEffects) do
		if v[1] == ExploreEnum.TriggerEvent.Counter then
			self._countSource = self._countSource or {}

			local targetParams = tostring(v[2])
			local arr = string.splitToNumber(targetParams, "#") or {}

			table.insert(self._countSource, arr[1])
			ExploreCounterModel.instance:addCountSource(arr[1], self.id)
		end
	end
end

function ExploreBaseUnitMO:onEnterScene()
	local pos = Vector2.New(self.nodePos.x, self.nodePos.y)

	self:updatePos(pos)
	ExploreMapModel.instance:addUnitMO(self)
end

function ExploreBaseUnitMO:onRemoveScene()
	if self:isWalkable() == false then
		local newKey = ExploreHelper.getKey(self.nodePos)

		ExploreMapModel.instance:updateNodeOpenKey(newKey, self.id, true)
	end

	ExploreMapModel.instance:removeUnit(self.id)
end

function ExploreBaseUnitMO:getTriggerPos()
	if self.triggerDir == ExploreEnum.TriggerDir.Left then
		return {
			x = self.nodePos.x - 1,
			y = self.nodePos.y
		}
	elseif self.triggerDir == ExploreEnum.TriggerDir.Right then
		return {
			x = self.nodePos.x + 1,
			y = self.nodePos.y
		}
	elseif self.triggerDir == ExploreEnum.TriggerDir.Up then
		return {
			x = self.nodePos.x,
			y = self.nodePos.y + 1
		}
	elseif self.triggerDir == ExploreEnum.TriggerDir.Down then
		return {
			x = self.nodePos.x,
			y = self.nodePos.y - 1
		}
	end

	return self.nodePos
end

function ExploreBaseUnitMO:canTrigger(pos)
	if self.triggerDir == ExploreEnum.TriggerDir.Left then
		return pos.x == self.nodePos.x - 1 and pos.y == self.nodePos.y
	elseif self.triggerDir == ExploreEnum.TriggerDir.Right then
		return pos.x == self.nodePos.x + 1 and pos.y == self.nodePos.y
	elseif self.triggerDir == ExploreEnum.TriggerDir.Up then
		return pos.x == self.nodePos.x and pos.y == self.nodePos.y + 1
	elseif self.triggerDir == ExploreEnum.TriggerDir.Down then
		return pos.x == self.nodePos.x and pos.y == self.nodePos.y - 1
	end

	return true
end

function ExploreBaseUnitMO:updatePos(pos)
	self.nodeKey = ExploreHelper.getKey(pos)

	self:_updateNodeOpenKey(self.nodePos, pos)
	self:onPosChange(self.nodePos, pos)

	self.nodePos.x = pos.x
	self.nodePos.y = pos.y
end

function ExploreBaseUnitMO:removeFromNode()
	self:_updateNodeOpenKey(self.nodePos)
	self:onPosChange(self.nodePos)
end

function ExploreBaseUnitMO:setNodeOpenKey(v)
	ExploreMapModel.instance:updateNodeOpenKey(self.nodeKey, self.id, v, true)
end

function ExploreBaseUnitMO:_updateNodeOpenKey(oldPos, newPos)
	if self:isWalkable() == false then
		if oldPos then
			for x = self.offsetSize[1], self.offsetSize[3] do
				for y = self.offsetSize[2], self.offsetSize[4] do
					local oldKey = ExploreHelper.getKeyXY(oldPos.x + x, oldPos.y + y)

					ExploreMapModel.instance:updateNodeOpenKey(oldKey, self.id, true)
				end
			end
		end

		if newPos then
			for x = self.offsetSize[1], self.offsetSize[3] do
				for y = self.offsetSize[2], self.offsetSize[4] do
					local newKey = ExploreHelper.getKeyXY(newPos.x + x, newPos.y + y)

					ExploreMapModel.instance:updateNodeOpenKey(newKey, self.id, false)
				end
			end
		end
	end
end

function ExploreBaseUnitMO:getConfigId()
	return self.config.configId
end

function ExploreBaseUnitMO:isWalkable()
	return self.defaultWalkable
end

function ExploreBaseUnitMO:setStatus(status)
	self:getInteractInfoMO():updateStatus(status)
end

function ExploreBaseUnitMO:getStatus()
	return self:getInteractInfoMO().status
end

function ExploreBaseUnitMO:isEnter()
	return self:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.IsEnter) == 1
end

function ExploreBaseUnitMO:setEnter(v)
	if v then
		self:onEnterScene()
	else
		self:onRemoveScene()
	end

	return self:getInteractInfoMO():setBitByIndex(ExploreEnum.InteractIndex.IsEnter, v and 1 or 0)
end

function ExploreBaseUnitMO:isInteractEnabled()
	return self:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.InteractEnabled) == 1
end

function ExploreBaseUnitMO:getInteractInfoMO()
	return ExploreModel.instance:getInteractInfo(self.id)
end

function ExploreBaseUnitMO:isInteractDone()
	return true
end

function ExploreBaseUnitMO:isInteractActiveState()
	local interactInfoMO = self:getInteractInfoMO()

	return interactInfoMO:getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
end

function ExploreBaseUnitMO:isInteractFinishState()
	local interactInfoMO = self:getInteractInfoMO()

	return interactInfoMO:getBitByIndex(ExploreEnum.InteractIndex.IsFinish) == 1
end

function ExploreBaseUnitMO:onPosChange(oldPos, newPos)
	return
end

local _nameToCls = {}

function ExploreBaseUnitMO:getUnitClass()
	local name = ExploreEnum.ItemTypeToName[self.type]

	_nameToCls[name] = _nameToCls[name] or _G[string.format("Explore%sUnit", name)] or _G[string.format("Explore%s", name)] or ExploreBaseMoveUnit

	return _nameToCls[name]
end

return ExploreBaseUnitMO
