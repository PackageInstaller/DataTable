-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/view/OriginKingMoYanClgLevelView.lua

module("logic.extensions.originkingmoyanclg.view.OriginKingMoYanClgLevelView", package.seeall)

local OriginKingMoYanClgLevelView = class("OriginKingMoYanClgLevelView", ViewComponent)
local DRAG_TYPE_FLOWER = 1
local DRAG_TYPE_FIRE = 2
local MODE_EDIT = 1
local MODE_EDIT_COMPLETE = 2
local MODE_GAME = 3

function OriginKingMoYanClgLevelView:ctor()
	OriginKingMoYanClgLevelView.super.ctor(self)
end

function OriginKingMoYanClgLevelView:unbindEvents()
	OriginKingMoYanClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	self._flowerDrag:RemoveDragListener()
	self._flowerDrag:RemoveBeginDragListener()
	self._flowerDrag:RemoveEndDragListener()
	self._fireDrag:RemoveDragListener()
	self._fireDrag:RemoveBeginDragListener()
	self._fireDrag:RemoveEndDragListener()
end

function OriginKingMoYanClgLevelView:bindEvents()
	OriginKingMoYanClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	self._flowerDrag:AddDragListener(self._onDrag, self)
	self._flowerDrag:AddBeginDragListener(function(eventData)
		self:_onDragBegin(DRAG_TYPE_FLOWER, self._flower, self._flowerDragGo, eventData)
	end, self)
	self._flowerDrag:AddEndDragListener(self._onDragEnd, self)
	self._fireDrag:AddDragListener(self._onDrag, self)
	self._fireDrag:AddBeginDragListener(function(eventData)
		self:_onDragBegin(DRAG_TYPE_FIRE, self._fire, self._fireDragGo, eventData)
	end, self)
	self._fireDrag:AddEndDragListener(self._onDragEnd, self)

	for i, v in ipairs(self._floorCells) do
		GameUtil.addClickHandler(v.btn, function()
			self:_onClickFloor(i)
		end, self)
	end
end

function OriginKingMoYanClgLevelView:buildUI()
	OriginKingMoYanClgLevelView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnReset = self:getGo("btnReset")
	self._map = self:getGo("map")
	self._gridCell = self:getGo("cell")
	self._flower = self:getGo("flower")
	self._flowerDragGo = self:getGo("flowerDrag")
	self._flowerDrag = Framework.UIDragTrigger.Get(self._flower)
	self._fire = self:getGo("fire")
	self._fireDragGo = self:getGo("fireDrag")
	self._fireDrag = Framework.UIDragTrigger.Get(self._fire)
	self._txtFlowerCount = self:getTxt("txtFlowerCount")
	self._txtFireCount = self:getTxt("txtFireCount")
	self._floorInfo = self:getGo("floorInfo")
	self._floorCells = {}

	for i = 1, self._floorInfo.transform.childCount do
		local floorCell = goutil.findChild(self._floorInfo, "floorCell_" .. i)
		local btn = goutil.findChild(floorCell, "node/btn")

		self._floorCells[i] = {
			go = floorCell,
			btn = btn
		}
	end

	self._prizeCon = self:getGo("prize/prizeCon")
	self._prizeGain = self:getGo("prize/prizeGain")
end

function OriginKingMoYanClgLevelView:onExit()
	OriginKingMoYanClgLevelView.super.onExit(self)
	self:_disposeMap()
	MaterialMgr.resetAll(self._prizeCon)
end

function OriginKingMoYanClgLevelView:onEnter()
	OriginKingMoYanClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginKingMoYanClgGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_OriginKingMoYanClgSetItemRes, self._refreshMapInfo, self)
	self.addGEvent(self, GlobalNotify.PM_OriginKingMoYanClgResetRes, self._refreshMapInfo, self)
	self.addGEvent(self, GlobalNotify.PM_OriginKingMoYanClgFightNotifyRes, self._PM_OriginKingMoYanClgFightNotifyRes, self)

	self._activityId = checknumber(self:getFirstParam())

	GameUtil.SetActive(self._gridCell, false)

	local floorCfgs = OriginKingMoYanClgConfig.instance:getFloorCfgs(self._activityId)

	self._curFloor = 1
	self._passMaxFloorId = 0

	for i, v in ipairs(floorCfgs) do
		if OriginKingMoYanClgModel.instance:isFloorPass(self._activityId, v.phaseId) and v.phaseId + 1 > self._curFloor then
			self._curFloor = v.phaseId + 1
			self._passMaxFloorId = v.phaseId
		end
	end

	if self._curFloor > #floorCfgs then
		self._curFloor = #floorCfgs
	end

	self:_refreshView()
end

function OriginKingMoYanClgLevelView:_refreshView()
	for i = 1, #self._floorCells do
		self:_updateFloorCell(self._floorCells[i], i)
	end

	self:_initMapInfo()
	self:_refreshMapInfo()

	self._isPassAll = true

	local floorCfgs = OriginKingMoYanClgConfig.instance:getFloorCfgs(self._activityId)

	for i, v in ipairs(floorCfgs) do
		if not OriginKingMoYanClgModel.instance:isFloorPass(self._activityId, v.phaseId) then
			self._isPassAll = false
		end
	end

	local floorCfg = OriginKingMoYanClgConfig.instance:getFloorCfg(self._activityId, self._curFloor)

	MaterialMgr.resetAll(self._prizeCon)
	MaterialMgr.setCellByCfg(floorCfg.prize, self._prizeCon)
	GameUtil.SetActive(self._prizeGain, OriginKingMoYanClgModel.instance:isFloorPass(self._activityId, self._curFloor))
end

function OriginKingMoYanClgLevelView:_initMapInfo()
	local floorCfg = OriginKingMoYanClgConfig.instance:getFloorCfg(self._activityId, self._curFloor)
	local mapPos = GameUtil.getLocalPos(self._map)

	self._mapOffset = {
		x = mapPos.x,
		y = mapPos.y
	}

	local mapWidth, mapHeight = GameUtil.getWidth(self._map), GameUtil.getHeight(self._map)

	self._mapZeroX, self._mapZeroY = -mapWidth / 2, -mapHeight / 2
	self._cellWidth, self._cellHeight = 110, 94
	self._colCount, self._rowCount = floorCfg.xLength, floorCfg.yLength
	self._emptyCellIndexMap = {}

	for i, v in ipairs(floorCfg.itemPointIds) do
		self._emptyCellIndexMap[v] = true
	end

	local stageCfgs = OriginKingMoYanClgConfig.instance:getStageCfgs(self._activityId, self._curFloor)

	self._stageCellInfoMap = {}

	for i, v in ipairs(stageCfgs) do
		self._stageCellInfoMap[v.pointId] = v.stageId
	end
end

function OriginKingMoYanClgLevelView:_generateMap()
	self:_clearMap()

	self._mapObject = {}

	local index = 1

	for i = 1, self._rowCount do
		self._mapObject[i] = self._mapObject[i] or {}

		for j = 1, self._colCount do
			local cellInfo = {
				x = j,
				y = i,
				index = index
			}

			index = index + 1
			self._mapObject[i][j] = self:_genarateGridCell(cellInfo)
		end
	end
end

function OriginKingMoYanClgLevelView:_refreshMapInfo()
	self:_generateMap()

	local floorCfg = OriginKingMoYanClgConfig.instance:getFloorCfg(self._activityId, self._curFloor)
	local flowerIds = OriginKingMoYanClgModel.instance:getSetFlowerIds(self._activityId, self._curFloor)
	local flowerCount = floorCfg.flowerCount - #flowerIds
	local fireIds = OriginKingMoYanClgModel.instance:getSetFireIds(self._activityId, self._curFloor)
	local fireCount = floorCfg.fireCount - #fireIds
	local stageCfgs = OriginKingMoYanClgConfig.instance:getStageCfgs(self._activityId, self._curFloor)
	local isStageFight = false

	for i, v in ipairs(stageCfgs) do
		if OriginKingMoYanClgModel.instance:isStagePass(self._activityId, self._curFloor, v.stageId) == true then
			isStageFight = true
		end
	end

	self._txtFlowerCount.text = string.format("x%d", flowerCount)
	self._txtFireCount.text = string.format("x%d", fireCount)
	self._gameType = MODE_EDIT
	self._gameType = (flowerCount > 0 or fireCount > 0) and MODE_EDIT or isStageFight == true and MODE_GAME or MODE_EDIT_COMPLETE
end

function OriginKingMoYanClgLevelView:_genarateGridCell(cellInfo)
	if not self._cellPools then
		local function resetFunc(obj)
			self:_resetFunc(obj)
		end

		local function disposeFunc(obj)
			self:_disposeFunc(obj)
		end

		local function createFunc()
			return (goutil.cloneAndSetParent(self._gridCell, self._map.gameObject.transform))
		end

		self._cellPools = ObjectPool.New(5, createFunc, disposeFunc, resetFunc)
	end

	local cellObj = self._cellPools:fetchObject()

	goutil.addChildToParent(cellObj.gameObject, self._map.gameObject.transform)
	GameUtil.SetActive(cellObj.gameObject, true)
	self:_updateGridCell(cellObj, cellInfo)

	return cellObj
end

function OriginKingMoYanClgLevelView:_disposeFunc(obj)
	goutil.destroy(obj)
end

function OriginKingMoYanClgLevelView:_resetFunc(obj)
	self:_clearGridCell(obj)
	GameUtil.SetActive(obj.gameObject, false)
end

function OriginKingMoYanClgLevelView:_updateGridCell(cell, data)
	local go = cell.gameObject
	local content = goutil.findChild(go, "content")
	local txtIndex = goutil.findChildTextComponent(content, "txtIndex")
	local btn = goutil.findChild(content, "btn")
	local fireGo = goutil.findChild(content, "fire")
	local flowerGo = goutil.findChild(content, "flower")
	local unitGo = goutil.findChild(content, "unit")
	local passGo = goutil.findChild(content, "pass")
	local col, row = data.x, data.y
	local x, y = self:getCellPos(col, row)
	local isFire = OriginKingMoYanClgModel.instance:isSetFire(self._activityId, self._curFloor, data.index)
	local isFlower = OriginKingMoYanClgModel.instance:isSetFlower(self._activityId, self._curFloor, data.index)
	local isUnit = isFire and isFlower

	GameUtil.SetActive(fireGo, isFire and not isUnit)
	GameUtil.SetActive(flowerGo, isFlower and not isUnit)
	GameUtil.SetActive(unitGo, isUnit)
	GameUtil.SetActive(passGo, false)
	GameUtil.SetActive(content, true)

	if self._emptyCellIndexMap[data.index] == true then
		txtIndex.text = ""
	elseif self._stageCellInfoMap[data.index] then
		local stageId = self._stageCellInfoMap[data.index]

		GameUtil.SetActive(passGo, OriginKingMoYanClgModel.instance:isStagePass(self._activityId, self._curFloor, stageId))

		txtIndex.text = langPara("挑战")
	else
		txtIndex.text = ""

		GameUtil.SetActive(content, false)
	end

	GameUtil.setAnchoredPos(go, x, y)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickGrid(data.index)
	end)
end

function OriginKingMoYanClgLevelView:_clearGridCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function OriginKingMoYanClgLevelView:_clearMap()
	for row, v in ipairs(self._mapObject or {}) do
		for col, obj in ipairs(v) do
			self._cellPools:returnObject(obj)
		end
	end

	self._mapObject = nil
end

function OriginKingMoYanClgLevelView:_disposeMap()
	self:_clearMap()
	self._cellPools:clear()
end

function OriginKingMoYanClgLevelView:_updateFloorCell(cell, index)
	local go = cell.go
	local txt = goutil.findChildTextComponent(go, "node/txt")
	local selectGo = goutil.findChild(go, "node/select")
	local lockGo = goutil.findChild(go, "node/lock")

	GameUtil.SetActive(selectGo, index == self._curFloor)

	txt.text = langPara("第%s层", GameUtil.getChineseNumber(index))

	GameUtil.SetActive(lockGo, index > self._passMaxFloorId + 1)
end

function OriginKingMoYanClgLevelView:getCellPos(col, row)
	local targetX = 0.75 * self._cellWidth * (col - 1) + self._mapZeroX
	local targetY

	return targetX, col % 2 == 0 and self._cellHeight * (row - 1) + 0.5 * self._cellHeight + self._mapZeroY or self._cellHeight * (row - 1) + self._mapZeroY
end

function OriginKingMoYanClgLevelView:getCellId(x, y)
	return (y - 1) * self._colCount + x
end

function OriginKingMoYanClgLevelView:getCellColRow(index)
	local x = index % self._colCount

	if x == 0 then
		x = self._colCount
	end

	local y = math.ceil(index / self._colCount)

	return x, y
end

function OriginKingMoYanClgLevelView:_axialToEvenq(q, r)
	local parity = TableUtil.dand(q, 1)
	local col = q
	local row = r + (q + parity) / 2

	return col, row
end

function OriginKingMoYanClgLevelView:_evenqToAxial(col, row)
	local parity = TableUtil.dand(col, 1)
	local q = col
	local r = row - (col + parity) / 2

	return q, r
end

function OriginKingMoYanClgLevelView:getGridNeighborWithIndex(index)
	local result = {}
	local x, y = self:getCellColRow(index)
	local q, r = self:_evenqToAxial(x, y)
	local s = -q - r
	local neighbor = self:getGridNeighbor(q, r, s)

	for i, v in ipairs(neighbor) do
		local targetX, targetY = self:_axialToEvenq(v[1], v[2])

		if self._mapObject[targetY] and self._mapObject[targetY][targetX] then
			local targetIndex = self:getCellId(targetX, targetY)

			table.insert(result, targetIndex)
		end
	end

	return result
end

function OriginKingMoYanClgLevelView:getGridNeighbor(q, r, s)
	local result = {}
	local hex = {
		q,
		r,
		s
	}

	for i = 1, 6 do
		local dir = LuaPathfinder_Const.Directions_Hex_Cube_6[i]
		local target = {
			hex[1] + dir[1],
			hex[2] + dir[2],
			hex[3] + dir[3]
		}

		table.insert(result, target)
	end

	return result
end

function OriginKingMoYanClgLevelView:checkDragSelectGrid(x, y)
	local targetX = (x - self._mapZeroX) / (0.75 * self._cellWidth)

	targetX = math.round(targetX)
	targetX = targetX + 1

	local targetY

	if targetX % 2 == 0 then
		targetY = (y - self._mapZeroY - 0.5 * self._cellHeight) / self._cellHeight
		targetY = math.round((y - self._mapZeroY - 0.5 * self._cellHeight) / self._cellHeight)
		targetY = (y - self._mapZeroY - 0.5 * self._cellHeight) / self._cellHeight + 1
	else
		targetY = (y - self._mapZeroY) / self._cellHeight
		targetY = math.round((y - self._mapZeroY) / self._cellHeight)
		targetY = (y - self._mapZeroY) / self._cellHeight + 1
	end

	return targetX, targetY
end

function OriginKingMoYanClgLevelView:_onDrag(eventData)
	if not self._isDraging then
		return
	end

	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)

	GameUtil.setLocalPos(self._dragGo, posEvent.x, posEvent.y, posEvent.z)

	local gridX, gridY = self:checkDragSelectGrid(posEvent.x - self._mapOffset.x, posEvent.y - self._mapOffset.y)

	if gridX ~= self._selectGridX or gridY ~= self._selectGridY then
		self._selectGridX = gridX
		self._selectGridY = gridY
	end
end

function OriginKingMoYanClgLevelView:_onDragBegin(type, obj, dragGo, eventData)
	if self._isDraging == true then
		return
	end

	if self._gameType == MODE_GAME then
		FloatWordMgr.instance:show(lang("已开始挑战，消除请重置本层"))

		return
	end

	local floorCfg = OriginKingMoYanClgConfig.instance:getFloorCfg(self._activityId, self._curFloor)

	if type == DRAG_TYPE_FIRE then
		local fireIds = OriginKingMoYanClgModel.instance:getSetFireIds(self._activityId, self._curFloor)

		if floorCfg.fireCount <= #fireIds then
			FloatWordMgr.instance:show(lang("已无使用次数"))

			return
		end
	elseif type == DRAG_TYPE_FLOWER then
		local flowerIds = OriginKingMoYanClgModel.instance:getSetFlowerIds(self._activityId, self._curFloor)

		if floorCfg.flowerCount <= #flowerIds then
			FloatWordMgr.instance:show(lang("已无使用次数"))

			return
		end
	end

	self._selectGridX = nil
	self._selectGridY = nil
	self._dragGo = dragGo

	local pos = GameUtil.getAnchoredPos(obj)

	GameUtil.setAnchoredPos(dragGo, pos.x, pos.y)
	GameUtil.SetActive(self._dragGo, true)

	self._isDraging = true
	self._dragType = type
end

function OriginKingMoYanClgLevelView:_onDragEnd(eventData)
	if not self._isDraging then
		return
	end

	self._isDraging = false

	GameUtil.SetActive(self._dragGo, false)

	if self._mapObject[self._selectGridY] and self._mapObject[self._selectGridY][self._selectGridX] then
		local id = self:getCellId(self._selectGridX, self._selectGridY)

		if self._emptyCellIndexMap[id] then
			if self._dragType == DRAG_TYPE_FIRE then
				if not OriginKingMoYanClgModel.instance:isSetFire(self._activityId, self._curFloor, id) then
					OriginKingMoYanClgAgent.instance:sendPM_OriginKingMoYanClgSetItemReq(self._activityId, self._curFloor, self._dragType, id)
				end
			elseif self._dragType == DRAG_TYPE_FLOWER and not OriginKingMoYanClgModel.instance:isSetFlower(self._activityId, self._curFloor, id) then
				OriginKingMoYanClgAgent.instance:sendPM_OriginKingMoYanClgSetItemReq(self._activityId, self._curFloor, self._dragType, id)
			end
		end
	end
end

function OriginKingMoYanClgLevelView:_onClickGrid(index)
	if self._emptyCellIndexMap[index] then
		if self._gameType == MODE_GAME then
			FloatWordMgr.instance:show(lang("已开始挑战，消除请重置本层"))

			return
		end

		if OriginKingMoYanClgModel.instance:isSetFlower(self._activityId, self._curFloor, index) or OriginKingMoYanClgModel.instance:isSetFire(self._activityId, self._curFloor, index) then
			OriginKingMoYanClgAgent.instance:sendPM_OriginKingMoYanClgResetPointReq(self._activityId, self._curFloor, index)
		end
	end

	if self._stageCellInfoMap[index] then
		if self._gameType == MODE_EDIT then
			FloatWordMgr.instance:show(lang("需放置完本层的【炽火】【心莲】道具才能开启挑战哦~"))

			return
		end

		local isPass = false

		if isPass then
			FloatWordMgr.instance:show(lang("已通过该关卡"))

			return
		end

		local stageId = self._stageCellInfoMap[index]
		local neighbors = self:getGridNeighborWithIndex(index)

		OriginKingMoYanClgController.instance:openMissionView(self._activityId, self._curFloor, stageId, neighbors)
	end
end

function OriginKingMoYanClgLevelView:_onClickReset()
	local floorCfg = OriginKingMoYanClgConfig.instance:getFloorCfg(self._activityId, self._curFloor)
	local flowerIds = OriginKingMoYanClgModel.instance:getSetFlowerIds(self._activityId, self._curFloor)
	local fireIds = OriginKingMoYanClgModel.instance:getSetFireIds(self._activityId, self._curFloor)

	if self._isPassAll == true then
		FloatWordMgr.instance:show(lang("已通关"))
	elseif #flowerIds == 0 and #fireIds == 0 and self._gameType ~= MODE_GAME then
		FloatWordMgr.instance:show(lang("未放置任意花火"))
	else
		local content = lang("确定将当前放置的道具与已通关的挑战重置?  【确认】则清除当前层六宫格中所有挑战位的状态，以及宫格放置的所有道具，复原位。")

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			OriginKingMoYanClgAgent.instance:sendPM_OriginKingMoYanClgResetReq(self._activityId, self._curFloor)
		end)
	end
end

function OriginKingMoYanClgLevelView:_onClickFloor(floorId)
	if self._passMaxFloorId < 3 then
		FloatWordMgr.instance:show(lang("未通关全部层数"))

		return
	end

	self._curFloor = floorId

	self:_refreshView()
end

function OriginKingMoYanClgLevelView:_PM_OriginKingMoYanClgFightNotifyRes()
	local floorCfgs = OriginKingMoYanClgConfig.instance:getFloorCfgs(self._activityId)

	self._curFloor = 1

	for i, v in ipairs(floorCfgs) do
		if OriginKingMoYanClgModel.instance:isFloorPass(self._activityId, v.phaseId) and v.phaseId + 1 > self._curFloor then
			self._curFloor = v.phaseId + 1
		end
	end

	if self._curFloor > #floorCfgs then
		self._curFloor = #floorCfgs
	end

	self:_refreshView()
end

return OriginKingMoYanClgLevelView
