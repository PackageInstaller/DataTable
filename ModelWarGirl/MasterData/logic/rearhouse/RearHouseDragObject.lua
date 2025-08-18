-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseDragObject.lua

local UIUtils = require("Framework.UI.UIUtils")
local Model = require("Entity/Model")
local RearHouseModelManager = require("Logic/RearHouse/RearHouseModelManager")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local EntityFactory = Framework.Entity.EntityFactory
local COLOR_MODE = {
	choose_red = 2,
	choose_green = 1,
	green = 3,
	red = 4
}
local DEFAULT_PADDING = {
	0,
	0,
	0,
	0
}
local Z_OFFSET = 12
local START_ENTITY_ID = 990000
local RearHouseDragObject = Class("RearHouseDragObject")

RearHouseDragObject._curID = START_ENTITY_ID

function RearHouseDragObject:ctor(parent, putData, initData, camp)
	self.mParent = parent
	self.did = RearHouseDragObject._curID
	RearHouseDragObject._curID = self.did + 1
	self.initData = initData
	self.gridPos = 0
	self.loadedNum = 0
	self.putData = putData
	self.data = putData.data
	self.modelData = self.data.modelData
	self.modelId = self.data.modelId
	self.zoneName = self.modelData.baseInfo.zone_name
	self.layer = self.data.modelData.typeInfo.layer_id or 99
	self.type = self.data.modelData.typeInfo.type_id
	self.conflictLayers = {}
	self.conflictObjs = {}
	self.conflictCount = 0
	self.occupyData = {}
	self.angle = initData.angle or 0
	self.shelf = nil
	self.halfShelfs = nil
	self.gridOffset = 0
	self.shelfPartIndex = 1
	self.isDelete = false
end

function RearHouseDragObject:loadModel(...)
	self:put2Pos()
	self:postInit()
	self:setGridIndex(self.initData.pos, true)
	self:setChoosing()
	self:_initModel(self.modelData)
end

function RearHouseDragObject:destroy()
	self.isDelete = true

	if self.entityModel then
		self.entityModel:destroy()

		self.entityModel = nil
	end

	if self.entityModelHigh then
		self.entityModelHigh:destroy()

		self.entityModelHigh = nil
	end

	if self.timer then
		self.timer:Stop()
	end

	self.topNode = nil
	self.topRootRight = nil
	self.topRootLeft = nil
	self.effectAnchor = nil
	self.dragController = nil
	self.controller = nil
	self._transform = nil
	self._modelsTransform = nil
	self.mParent = nil
	self.conflictObjs = nil
	self.shelf = nil
	self.halfShelfs = nil

	EntityFactory.ReleaseEntity(self.did)
end

function RearHouseDragObject:getEffectTranAndOffset(...)
	return self:getParentTra(), self.range.y * 0.5 * self.mParent.gridSize
end

function RearHouseDragObject:getParentTra(...)
	if self.topNode then
		return self.topNode
	end
end

function RearHouseDragObject:_initModel(info)
	self:loadModelOnly()
end

function RearHouseDragObject:showModel(...)
	if self.entityModel then
		self.entityModel:showModel(true)
	end

	if self.entityModelHigh then
		self.entityModelHigh:showModel(true)
	end
end

function RearHouseDragObject:postInit(...)
	self:parsePosInfo()
	self:setLimitIndex()
	self:initInfoPanel()
end

function RearHouseDragObject:onModelLoadedEnd()
	local go = self.entityModel.modelGameObject

	self.entityModel:setModelLayer(Const.LAYER_NPC)
	self.dragController:SetLodGroup(go, -1)
	self:setModelPos(go, false)
	self:_checkLoadedEnd()
end

function RearHouseDragObject:setChoosing(...)
	if self.initData.isNewPut == true then
		self:setClick()

		self.initData.isNewPut = nil
	elseif self.initData.isNewDrag == true then
		self:setClick()
		self:setDragBegin()

		self.initData.isNewDrag = nil
	end
end

function RearHouseDragObject:_checkLoadedEnd(...)
	self.loadedNum = self.loadedNum + 1

	if self.loadedNum == 1 and self.initData then
		self.mParent:addLoadedNum(self)
	end
end

function RearHouseDragObject:isInitWallObjLoadEnd(...)
	return self.loadedNum >= 1
end

function RearHouseDragObject:recalculateLodBounds(...)
	self.dragController:RecalculateLodBounds()
end

function RearHouseDragObject:initInfoPanel(...)
	self.topRootRight = self.dragController:GetTopRootRight()
	self.topRootLeft = self.dragController:GetTopRootLeft()
	self.effectAnchor = self.dragController:GetEffectAnchor()

	if self.topRootRight ~= nil and self.topRootLeft == nil then
		-- block empty
	end

	self:setTopRootPos()
end

function RearHouseDragObject:setTopRootPos(...)
	local size = self.mParent.gridSize

	self.topRootRight.localPosition = Vector3(-self.range.x * size * 0.5, 0, 0)
	self.topRootLeft.localPosition = Vector3(self.range.x * size * 0.5, 0, 0)
	self.effectAnchor.localPosition = Vector3(0, self.range.y * 0.5 * size + 0.5, 0)
end

function RearHouseDragObject:setClick()
	if self.dragController then
		self.dragController:SetClick()
	end
end

function RearHouseDragObject:setDragBegin(...)
	if self.dragController then
		self.isClick = true

		self.dragController:SetDragBegin()
	end
end

function RearHouseDragObject:clearDragState(...)
	self:resetChoosingPos()

	self.isClick = false
end

function RearHouseDragObject:setModelPos(go, needOffset)
	local size = self.mParent.gridSize
	local xOffset, yOffset = self:getConfigOffset()

	self:setRotation(0)

	go.transform.localPosition = Vector3(xOffset, yOffset, 0)
end

function RearHouseDragObject:getConfigOffset(...)
	local x = (self.boundsInfo.right * 0.5 - self.configPosOffset.x) * self.mParent.gridSize
	local y = (self.boundsInfo.down * 0.5 - self.configPosOffset.y) * self.mParent.gridSize

	return x, y
end

function RearHouseDragObject:parsePosInfo()
	self.range = Vector2(2, 2)
	self.rangeData = self.modelData.rangeData
	self.posData = self.modelData.posData
	self.configPosOffset = self.modelData.configPosOffset
	self.objAvalibleNum = self.modelData.avalibleNum

	local blackLayers = self.modelData.typeInfo.conflict_layer

	if blackLayers then
		local data = utils.splitString(blackLayers, ",")

		if data then
			for i, d in ipairs(data) do
				self.conflictLayers[tonumber(d)] = true
			end
		end
	end

	self.dragController:InitBackPlanes(#self.posData)

	local gridBackOffset = -0.001

	if self.type == 2 then
		gridBackOffset = -0.009
	end

	local layer = self.modelData.typeInfo.offset

	if self.initData.wall_offset then
		layer = self.initData.wall_offset
	end

	self.boundsInfo = self.modelData.boundsInfo
	self.initZ = layer

	self:createBackPlane(gridBackOffset)
end

function RearHouseDragObject:createBackPlane(gridBackOffset)
	if #self.rangeData > 0 and #self.posData > 0 then
		local xOffset = self.boundsInfo.right * 0.5
		local yOffset = self.boundsInfo.down * 0.5
		local size = self.mParent.gridSize

		self.range = Vector2(self.boundsInfo.right, self.boundsInfo.down)

		local pos, leftUpPos

		for idx, vec in ipairs(self.rangeData) do
			leftUpPos = self.posData[idx]
			pos = leftUpPos + vec * 0.5

			self:setBackSize(vec, idx - 1)
			self.dragController:SetBackPlaneLocalPostion(Vector3((-pos.x + xOffset) * size, (-pos.y + yOffset) * size, -self.initZ + gridBackOffset), idx - 1)
		end
	end
end

function RearHouseDragObject:getSaveInfo(...)
	local data = {}

	data.putData = self.putData

	local initData = {}

	initData.pos = self.gridPos
	initData.angle = self.angle
	initData.layer = self.layer
	initData.zoneName = self.zoneName
	initData.checkInit = true
	data.initData = initData

	return data
end

function RearHouseDragObject:resetPos(initData)
	self._isInLimitArea = nil

	self:leaveShelf()
	self:setGridIndex(initData.pos, true)
	self:setRotation(initData.angle)
end

function RearHouseDragObject:getPosInfo(...)
	local columnDic = {}

	self.rowIdx = 1

	if self.gridPos >= 0 then
		local rowIdx, columnIdx = self.mParent:gridIdxToRowColumn(self.gridPos)

		if self.objAvalibleNum > 0 then
			local _range, _offset

			for i = 1, self.objAvalibleNum do
				_range = self.rangeData[i]
				_offset = self.posData[i]

				if _range and _offset then
					for j = columnIdx + _offset.x, columnIdx + _offset.x + _range.x - 1 do
						columnDic[j] = 0
					end
				end
			end
		else
			for i = columnIdx, columnIdx + self.range.x - 1 do
				columnDic[i] = 0
			end
		end

		self.rowIdx = rowIdx - 1 + self.range.y
		self.columnDic = columnDic
	end

	return self.rowIdx, columnDic
end

function RearHouseDragObject:setLimitIndex(...)
	local minRow, maxRow, minCol, maxCol

	if self.dragController then
		maxRow = self.mParent.limitRows - self.range.y + 1
		maxCol = self.mParent.columns - self.range.x + 1
		self.limitBounds = {
			minCol = 1,
			upOffset = 0,
			minRow = 1,
			maxRow = maxRow,
			maxCol = maxCol,
			rightOffset = self.range.x - 1,
			downOffset = self.range.y - 1
		}
	end
end

local commonLimitBounds = {}

function RearHouseDragObject:_getLimitBounds(...)
	if self.limitBounds == nil then
		self:setLimitIndex()
	end

	for k, v in pairs(self.limitBounds) do
		commonLimitBounds[k] = v
	end

	commonLimitBounds.minRow = self.mParent:getTopRowOffset() + self.limitBounds.minRow

	return commonLimitBounds
end

function RearHouseDragObject:setPos(pos)
	local _pos = -self.mParent.dragModelRoot.position + pos

	_pos.z = self.initZ
	self._transform.localPosition = _pos
end

function RearHouseDragObject:isInLimitBounds(rowIdx, colIdx)
	local preRowIdx, preColIdx = self.mParent:gridIdxToRowColumn(self.gridPos)

	if preRowIdx == rowIdx and colIdx == preColIdx then
		return -1
	end

	self._isInLimitArea = nil

	local row = rowIdx
	local col = colIdx
	local occupyInfo = self:getOccupyInfo()
	local _limitBounds = self:_getLimitBounds()

	row = math.min(math.max(_limitBounds.minRow, row), _limitBounds.maxRow)
	col = math.min(math.max(_limitBounds.minCol, col), _limitBounds.maxCol)

	return self.mParent:rowColToGridIdx(row, col)
end

function RearHouseDragObject:isInLimitArea(forceRefresh)
	if forceRefresh or self._isInLimitArea == nil then
		local occupyInfo = self:getOccupyInfo()
		local r, c = self.mParent:gridIdxToRowColumn(self.gridPos)

		self._isInLimitArea = self.mParent:isInLockArea(r, c, occupyInfo) or self.mParent:isInForbiddenArea(r, c, occupyInfo)
	end

	return self._isInLimitArea
end

function RearHouseDragObject:setBackSize(range, index)
	if self.dragController then
		local size = self.mParent.gridSize

		self.dragController:SetBackSize(size * range.x, size * range.y, index or 0)
		self.dragController:SetBackTexTureScale(range, index or 0)
	end
end

function RearHouseDragObject:rotate(delta)
	self:setRotation(self.angle + delta)
end

function RearHouseDragObject:setRotation(angle)
	if self._modelsTransform then
		local originAngle = self._modelsTransform.localEulerAngles

		self.angle = angle
		self._modelsTransform.localEulerAngles = Vector3(originAngle.x, angle, originAngle.z)
	end
end

function RearHouseDragObject:setGray(v)
	if self.dragController then
		self.dragController:SetGray(v)
	end
end

function RearHouseDragObject:put2Pos()
	self.dragController = UIUtils.SetRearHouseDragTarget(self, self.did)
	self.dragController.layer = self.layer
	self.topNode = self.dragController:GetTopNodeTransform()
	self.controller = self.dragController:GetController()
	self._transform = self.controller.transform
	self._modelsTransform = self.dragController.models.transform

	if self.initData.initWall == true then
		self.oriParentTra = self.mParent.staticModelRoot
		self._transform.parent = self.mParent.staticModelRoot
	else
		self.oriParentTra = self.mParent.dragModelRoot
		self._transform.parent = self.mParent.dragModelRoot
	end

	self.dragController.zoneName = self.mParent.zoneName
end

function RearHouseDragObject:showPlane(v, color)
	if self.isDelete == true or not self.dragController then
		return
	end

	if self.planeVisible ~= v then
		self.planeVisible = v

		self.dragController:ShowPlane(v)
	end

	if (self.isClick or self.isDraging) and v then
		self.mParent.dragCenter.changeEffectState(color == "red")
	end

	if not v then
		return
	end

	color = (self.isClick or self.isDraging) and "choose_" .. color or color

	if self.color == color then
		return
	end

	self.color = color

	self.dragController:SetBackColor(COLOR_MODE[color])
end

function RearHouseDragObject:telepotRow(rowIdx, partIndex, shelfs, isInit)
	if not rowIdx or self.isDraging then
		return
	end

	local gridOffset = rowIdx - self.rowIdx - 1
	local offsetY = gridOffset * self.mParent.gridSize

	self.gridPos = gridOffset * self.mParent.columns + self.gridPos
	self.dragController.gridIndex = self.gridPos

	if #shelfs == 1 then
		self.shelf = shelfs[1]
		self.parentTra = self.shelf:getParentTra()

		self.shelf:addOnShelf(self, partIndex)
		self:setParentTra(self.parentTra, true)
	elseif #shelfs > 0 then
		for i, shelf in ipairs(shelfs) do
			shelf:addOnHalfShelf(self)
		end

		self.halfShelfs = shelfs
	end

	if isInit then
		return
	end
end

function RearHouseDragObject:setParentTra(tra, isOnShelf)
	if tra then
		self._transform.parent = tra

		if isOnShelf == true then
			self._transform.localPosition = self._transform.localPosition + tra.localPosition
		elseif isOnShelf == false then
			local pos = self._transform.localPosition

			self._transform.localPosition = Vector3(pos.x, pos.y, self.modelData.typeInfo.offset)
		end
	end
end

function RearHouseDragObject:isPutStateWrong(...)
	return self.conflictCount > 0 or self:isInLimitArea()
end

function RearHouseDragObject:setModelMovePos(pos, isLocal)
	if self.dragController then
		pos = pos or self._transform.position

		if isLocal then
			self._modelsTransform.localPosition = pos
		else
			self._modelsTransform.position = pos
		end
	end
end

function RearHouseDragObject:isInArea(gridIdx)
	if self.occupyData[gridIdx] then
		return true
	end

	local row, col = self.mParent:gridIdxToRowColumn(gridIdx)
	local myRow, myCol = self.mParent:gridIdxToRowColumn(self.gridPos)
	local isMatchCol = false
	local padding = self.modelData.baseInfo.padding or DEFAULT_PADDING

	if row >= myRow - padding[1] and row <= myRow + self.boundsInfo.down + padding[2] - 1 and col >= myCol - padding[3] and col <= myCol + self.boundsInfo.right + padding[4] - 1 then
		return true
	end

	return false
end

function RearHouseDragObject:setGridIndex(index, isPosition)
	if index == nil then
		return
	end

	if isPosition then
		local pos = self.mParent:gridIdxToPos(index, self.range)

		self:setPos(pos)
	end

	self.gridPos = index

	self:setOccupyData()
end

function RearHouseDragObject:getOccupyInfo(...)
	return self.mParent:getOccupyInfo(self.modelId)
end

function RearHouseDragObject:setOccupyData(isDestroy)
	if self.initData.isPreView == true or self.initData.isStage == true then
		return
	end

	local posData = {}

	if not isDestroy then
		local data = self:getOccupyInfo()

		for _, offset in ipairs(data) do
			local pos = self.gridPos + offset.rowOffset * self.mParent.columns + offset.colOffset

			posData[pos] = true
		end
	end

	local addData = {}
	local removeData = {}

	for pos, t in pairs(self.occupyData) do
		if not posData[pos] then
			local r, c = self.mParent:gridIdxToRowColumn(pos)

			table.insert(removeData, {
				r = r,
				c = c
			})
		end
	end

	for pos, t in pairs(posData) do
		if not self.occupyData[pos] then
			local r, c = self.mParent:gridIdxToRowColumn(pos)

			table.insert(addData, {
				r = r,
				c = c
			})
		end
	end

	self.mParent:removeOccupyPoint(removeData, self)
	self.mParent:addOccupyPoint(addData, self)

	self.occupyData = posData
end

function RearHouseDragObject:setSelectState(...)
	if self.mParent:getCurDragObj() ~= self then
		self.mParent:setCurDragObj(self)
	end
end

function RearHouseDragObject:onDelClick(...)
	return self.mParent:delObj({
		self
	})
end

function RearHouseDragObject:onConfirmClick(...)
	self:showInfoPanel(false)
	self.mParent:clearState()
end

function RearHouseDragObject:showInfoPanel(v)
	if self.infoPanel then
		self.infoPanel:setVisible(v)
	end
end

function RearHouseDragObject:checkDragPos(pos)
	if self.initData.pos == nil then
		local r, c = self.mParent:posToRowCol(pos)

		r = r - math.floor(self.boundsInfo.down * 0.5)
		c = c - math.floor(self.boundsInfo.right * 0.5)

		local gridIndex

		if c <= 0 or r <= 0 then
			gridIndex = self:isInLimitBounds(r, c)
		else
			gridIndex = self.mParent:rowColToGridIdx(r, c)
		end

		self:setGridIndex(gridIndex, true)

		self.initData.pos = gridIndex
	end
end

function RearHouseDragObject:OnClick(pos)
	if self.isClick ~= true then
		self:checkDragPos(pos)

		self.isClick = true

		if self.mEventDragCatch then
			self:mEventDragCatch()
		end

		self:setSelectState()
		self.mParent:checkFallDown()

		local isEditMode = self.mParent:isEditMode()

		if self.initData.isNewPut == nil and self.initData.isNewDrag == nil and (isEditMode == true or self.type == 5) then
			self:tweenScale(0.2)
		end

		if isEditMode == true then
			self.topNode.localPosition = Vector3(0, 0, Z_OFFSET)
		end
	end

	local r, c = self.mParent:gridIdxToRowColumn(self.gridPos)
end

function RearHouseDragObject:onDragPut(isSure)
	if self.mEventDragPut then
		self:mEventDragPut(pos)
	end

	self._modelsTransform.parent = self.dragController.TopModel.transform
	self.isDraging = false

	self:setModelMovePos(Vector3.zero, true)
	self.mParent:checkFallDown(false, true)

	if isSure == true then
		self:resetChoosingPos()
	end
end

function RearHouseDragObject:resetChoosingPos(...)
	if self.isClick == true then
		self.topNode.localPosition = Vector3.zero
	end
end

function RearHouseDragObject:OnDragBegin(hitPos)
	self._modelsTransform.parent = nil

	self:setGridOffset(hitPos)
	self.mParent:setDraging()

	self.isDraging = true

	self:leaveShelf()
	self:leaveHalfShelf()
	self:leaveDeskAndStage()
end

function RearHouseDragObject:setGridOffset(hitPos)
	local row, col = self.mParent:gridIdxToRowColumn(self.gridPos)
	local hitRow, hitCol = self.mParent:gridIdxToRowColumn(self.mParent:posToGridIndex(hitPos))

	self.gridIndexOffset = {
		rowOffset = hitRow - row,
		colOffset = hitCol - col
	}
	self.posOffset = self._modelsTransform.position - hitPos
end

function RearHouseDragObject:leaveDeskAndStage(...)
	self.onDesk = nil
	self.onStage = nil
end

function RearHouseDragObject:leaveShelf(...)
	if self.shelf then
		self:setParentTra(self.oriParentTra, false)
		self.shelf:delOnShelf(self)

		self.shelf = nil
	end
end

function RearHouseDragObject:leaveHalfShelf(...)
	if self.halfShelfs then
		for i, shelf in ipairs(self.halfShelfs) do
			shelf:delOnHalfShelf(self)
		end

		self.halfShelfs = nil
	end
end

function RearHouseDragObject:addConflictObj(did)
	if not self.conflictObjs[did] then
		self.conflictObjs[did] = 1
		self.conflictCount = self.conflictCount + 1
	else
		self.conflictObjs[did] = self.conflictObjs[did] + 1
	end
end

function RearHouseDragObject:removeConflictObj(did)
	if self.conflictObjs[did] then
		self.conflictObjs[did] = self.conflictObjs[did] - 1

		if self.conflictObjs[did] <= 0 then
			self.conflictCount = self.conflictCount - 1
			self.conflictObjs[did] = nil
		end
	end
end

function RearHouseDragObject:onDel(...)
	self:leaveShelf()
	self:leaveHalfShelf()
	self:removeConflict()
	self:destroy()
end

function RearHouseDragObject:removeConflict()
	self:setOccupyData(true)
end

function RearHouseDragObject:unloadModelOnly(high)
	if high and self.entityModelHigh then
		self.entityModelHigh:destroy()

		self.entityModelHigh = nil
	elseif self.entityModel then
		self.entityModel:destroy()

		self.entityModel = nil
	end
end

function RearHouseDragObject:loadModelOnly(high, forceLoad)
	if self.type == 5 then
		if high then
			if forceLoad == true or RearHouseModelManager.isLimitModelQuality() == false then
				local highModelData = self:getHeroModelData(self.modelData, true)

				self.entityModelHigh = Model(Slot(self.onModelLoadedEndHigh, self))

				self.entityModelHigh:setModelData(highModelData)
				self.entityModelHigh:loadGameObject(false, true)
			end
		else
			local modelData = self:getHeroModelData(self.modelData, false)

			self.entityModel = Model(Slot(self.onModelLoadedEnd, self))

			self.entityModel:setModelData(modelData)
			self.entityModel:loadGameObject(false, self.initData.show)
		end
	else
		self.entityModel = Model(Slot(self.onModelLoadedEnd, self))

		self.entityModel:setModelDataSimple(self.modelData.baseInfo.path)
		self.entityModel:loadGameObject(false, self.initData.show)
	end
end

function RearHouseDragObject:tweenScale(punch)
	if self.dragController then
		self.dragController:TweenScale(punch, 0.5)
	end
end

return RearHouseDragObject
