-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseDragShelf.lua

local RearHouseDragObject = require("Logic/RearHouse/RearHouseDragObject")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local strClassName = "RearHouseDragShelf"
local RearHouseDragShelf = Class(strClassName, RearHouseDragObject)

function RearHouseDragShelf:ctor(parent, putData, initData)
	self.turned = initData.angle == 180
	self.onShelfObjs = {}
	self.onHalfShelfObjs = {}
	self.isOnShelfObjChange = true
	self.allOccupyInfo = {}
end

function RearHouseDragShelf:getOccupyInfo(isAll)
	local info = self.mParent:getOccupyInfo(self.modelId, self.turned)

	if isAll then
		if self.isOnShelfObjChange == false then
			return self.allOccupyInfo
		else
			local minIndex = 9999
			local minObj

			for _, obj in ipairs(self.onShelfObjs) do
				if obj.gridPos < self.gridPos and minIndex > obj.gridPos then
					minObj = obj
					minIndex = obj.gridPos
				end
			end

			if minObj == nil then
				self.allOccupyInfo = info

				return info
			else
				self.isOnShelfObjChange = false
				self.allOccupyInfo = {}

				for i, data in ipairs(info) do
					table.insert(self.allOccupyInfo, data)
				end

				local objR, objC = self.mParent:gridIdxToRowColumn(minObj.gridPos)
				local myR, myC = self.mParent:gridIdxToRowColumn(self.gridPos)
				local objInfo = minObj:getOccupyInfo()

				for i, data in ipairs(objInfo) do
					local d = {
						rowOffset = data.rowOffset + objR - myR,
						colOffset = data.colOffset + objC - myC
					}

					table.insert(self.allOccupyInfo, d)
				end

				return self.allOccupyInfo
			end
		end
	else
		return info
	end
end

function RearHouseDragShelf:setTopRootPos(...)
	local size = self.mParent.gridSize
	local _x = -self.boundsInfo.right * size * 0.5

	self.topRootRight.localPosition = Vector3(_x, -size * self.boundsInfo.down * 0.5, 0)
	self.topRootLeft.localPosition = Vector3(-_x, -size * self.boundsInfo.down * 0.5, 0)
	self.effectAnchor.localPosition = Vector3(0, 0.5, 0)
end

function RearHouseDragShelf:setModelPos(go, needOffset)
	local xOffset, yOffset = self:getConfigOffset()

	go.transform.localPosition = Vector3(xOffset, yOffset, 0)

	self:setRotation(self.angle)
end

function RearHouseDragShelf:getConfigOffset(...)
	local x = (self.boundsInfo.right * 0.5 - self.configPosOffset.x) * self.mParent.gridSize
	local y = -self.configPosOffset.y * self.mParent.gridSize

	return x, y
end

function RearHouseDragShelf:createBackPlane(gridBackOffset)
	if #self.rangeData > 0 and #self.posData > 0 then
		local offset = self.boundsInfo.right * 0.5

		self.range = Vector2(self.boundsInfo.right, 0)

		local size = self.mParent.gridSize
		local pos, leftUpPos

		for idx, vec in ipairs(self.rangeData) do
			leftUpPos = self.posData[idx]
			pos = leftUpPos + vec * 0.5

			self:setBackSize(vec, idx - 1)
			self.dragController:SetBackPlaneLocalPostion(Vector3((-pos.x + offset) * size, -pos.y * size, -self.initZ + gridBackOffset), idx - 1)
		end
	end
end

function RearHouseDragShelf:resetPos(initData)
	self._isInLimitArea = nil

	self:leaveObj()
	self:setGridIndex(initData.pos, true)
	self:setRotation(initData.angle)
end

function RearHouseDragShelf:_setShelfAvailablePos(...)
	local data = {}
	local rowIdx, colIdx = self.mParent:gridIdxToRowColumn(self.gridPos)
	local oriIndex = colIdx - 1

	self.shelfPartInfo = {}

	for idx, posInfo in ipairs(self.posData) do
		local range = self.rangeData[idx]

		if idx <= self.objAvalibleNum then
			local r = rowIdx + posInfo.y

			data[r] = data[r] or {}
			self.shelfPartInfo[r] = self.shelfPartInfo[r] or {}
			self.shelfPartInfo[r][idx] = range.x

			local index

			if self.turned then
				index = oriIndex + self.boundsInfo.right - self.posData[idx].x - range.x
			else
				index = oriIndex + self.posData[idx].x
			end

			for i = 1, range.x do
				index = index + 1
				data[r][index] = idx
			end
		end
	end

	self.shelfAvaliblePos = data
end

function RearHouseDragShelf:setGridIndex(index, isPosition)
	RearHouseDragShelf.super.setGridIndex(self, index, isPosition)
	self:_setShelfAvailablePos()

	for i, obj in ipairs(self.onShelfObjs) do
		if obj then
			obj:setGridIndex(index - obj.gridOffset)
		end
	end
end

function RearHouseDragShelf:getShelfPartInfo(...)
	return self.shelfPartInfo
end

function RearHouseDragShelf:canFallDown(colDic, partInfo)
	local data = self.shelfAvaliblePos
	local result = 0
	local dic = {}
	local partIndex = 1
	local validCol = false
	local objColCount = 0

	for r, col in pairs(data) do
		result = 1
		partIndex = 1
		validCol = false
		objColCount = 0

		for c, _ in pairs(colDic) do
			objColCount = objColCount + 1

			local _idx = col[c]

			if _idx and partInfo[_idx] then
				partIndex = _idx
				validCol = true
				dic[c] = 1
			else
				result = -2
			end
		end

		if validCol then
			if result == -2 or objColCount > partInfo[partIndex] then
				for c, s in pairs(dic) do
					colDic[c] = 1
				end

				return result, r
			end

			if result == 1 then
				return result, partIndex
			end
		end
	end

	return -1
end

function RearHouseDragShelf:setLimitIndex(...)
	local minRow, maxRow, minCol, maxCol

	if self.dragController then
		local highest = 0

		for i, obj in ipairs(self.onShelfObjs) do
			if obj then
				local offsetH = -self.posData[obj.shelfPartIndex].y + obj.range.y

				highest = math.max(offsetH, highest)
			end
		end

		minRow = highest + 1
		maxRow = self.mParent.limitRows - self.boundsInfo.down + 1
		minCol = 1
		maxCol = self.mParent.columns - self.boundsInfo.right + 1
		self.limitBounds = {
			minRow = minRow,
			maxRow = maxRow,
			minCol = minCol,
			maxCol = maxCol,
			upOffset = highest,
			rightOffset = self.boundsInfo.right - 1,
			downOffset = self.boundsInfo.down - 1
		}
	end
end

function RearHouseDragShelf:setRotation(angle)
	self.turned = angle == 180

	local scale = self.dragController.TopModel.transform.localScale
	local t = 1

	if self.turned then
		if scale.x > 0 then
			t = -1
		end
	elseif scale.x < 0 then
		t = -1
	end

	self.dragController.TopModel.transform.localScale = Vector3(t * scale.x, scale.y, scale.z)
	self.angle = angle

	self:setGridIndex(self.gridPos)
	self:setLimitIndex()
end

function RearHouseDragShelf:addOnShelf(obj, partIndex)
	table.insert(self.onShelfObjs, obj)

	obj.shelfPartIndex = partIndex
	obj.gridOffset = self.gridPos - obj.gridPos
	self.isOnShelfObjChange = true

	self:setLimitIndex()
end

function RearHouseDragShelf:addOnHalfShelf(obj)
	table.insert(self.onHalfShelfObjs, obj)
end

function RearHouseDragShelf:delOnShelf(obj)
	local index = 0

	for i, _obj in ipairs(self.onShelfObjs) do
		if _obj.did == obj.did then
			index = i

			break
		end
	end

	if index > 0 then
		table.remove(self.onShelfObjs, index)
	end

	self.isOnShelfObjChange = true

	self:setLimitIndex()
end

function RearHouseDragShelf:delOnHalfShelf(obj)
	local index = 0

	for i, _obj in ipairs(self.onHalfShelfObjs) do
		if _obj.did == obj.did then
			index = i

			break
		end
	end

	if index > 0 then
		table.remove(self.onHalfShelfObjs, index)
	end
end

function RearHouseDragShelf:onFlipClick(...)
	self:leaveObj(true)
	self:setRotation(180 - self.angle)
	self.mParent:checkFallDown(false, true)
end

function RearHouseDragShelf:OnDragBegin(hitPos)
	self._modelsTransform.parent = nil

	self:setGridOffset(hitPos)
	self.mParent:setDraging()

	self.isDraging = true

	self:leaveObj(false)
end

function RearHouseDragShelf:leaveObj(isLeaveAll)
	if #self.onHalfShelfObjs > 0 then
		local temp = {}

		for _, obj in ipairs(self.onHalfShelfObjs) do
			table.insert(temp, obj)
		end

		for i, obj in ipairs(temp) do
			obj:leaveHalfShelf()
		end

		self.onHalfShelfObjs = {}
	end

	if #self.onShelfObjs > 0 and isLeaveAll then
		local temp = {}

		for _, obj in ipairs(self.onShelfObjs) do
			table.insert(temp, obj)
		end

		for _, obj in pairs(temp) do
			obj:leaveShelf()
		end

		self.onShelfObjs = {}
	end

	self.isOnShelfObjChange = true
end

function RearHouseDragShelf:onDel(...)
	self:leaveObj(true)
	self:removeConflict()

	self.onShelfObjs = nil
	self.onHalfShelfObjs = nil

	self:destroy()
end

function RearHouseDragShelf:isInLimitArea(...)
	self._isInLimitArea = RearHouseDragShelf.super.isInLimitArea(self)

	for _, obj in ipairs(self.onShelfObjs) do
		if obj:isInLimitArea(true) then
			self._isInLimitArea = true
		end
	end

	return self._isInLimitArea
end

return RearHouseDragShelf
