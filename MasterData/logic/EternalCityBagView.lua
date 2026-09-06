-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBagView.lua

module("logic.extensions.eternalcity.view.EternalCityBagView", package.seeall)

local EternalCityBagView = class("EternalCityBagView", ViewComponent)

function EternalCityBagView:ctor()
	EternalCityBagView.super.ctor(self)

	self._eventSystemGo = GlobalModel.instance.eventSystem

	local eventSystem_type = SystemReflexHelp.getType("UnityEngine.EventSystems.EventSystem,UnityEngine.UI")

	self._eventSystemComp = self._eventSystemGo:GetComponent(eventSystem_type)
	self._eventSystem = SystemReflexHelp.getPropertyValue("UnityEngine.EventSystems.EventSystem,UnityEngine.UI", "current", self._eventSystemComp)

	self:_creatGridCellPool()
	self:_creatBuildCellPool()
end

function EternalCityBagView:buildUI()
	EternalCityBagView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._mapView = self:getGo("mapView/Viewport/Content")
	self._gridView = self:getGo("mapView/Viewport/Content/gridView")
	self._buildView = self:getGo("mapView/Viewport/Content/buildView")
	self._gridCell = self:getGo("gridCell")
	self._buildCell = self:getGo("buildCell")
	self._bgGoInBuildCell = self:getGo("buildCell/bgGo")
	self._treeCell = self:getGo("treeCell")
	self._dragView = self:getGo("dragView")
	self._buildScrView = self:getGo("bagCol/buildScrView")
	self._buildScrCell = self:getGo("bagCol/buildScrCell")
	self._buildScrollerList = ScrollerList.create(self._buildScrView, self._buildScrCell, GameUtil.handler(self._updateBuildScrCell, self), GameUtil.handler(self._clearBuildScrCell, self))

	self._buildScrollerList:setDragCallBack("drayPlane", function(eventData, data, go)
		self:_onDragBeginBuildScrCell(eventData, data, go)
	end, function(eventData, data, go)
		self:_onDragBuildScrCell(eventData, data, go)
	end, function(eventData, data, go)
		self:_onDragEndBuildScrCell(eventData, data, go)
	end)

	self._txtBuildCount = self:getTxt("bagCol/txtBuildCount")
	self._btnShop = self:getGo("bagCol/btnShop")
	self._btnActiveBuild = self:getGo("bagCol/btnActiveBuild")

	GameUtil.SetActive(self._gridCell, false)
	GameUtil.SetActive(self._buildCell, false)

	self._gridCellSize = {
		width = GameUtil.getWidth(self._gridCell),
		height = GameUtil.getHeight(self._gridCell)
	}
	self._bgGoInBuildCellSize = {
		width = GameUtil.getWidth(self._bgGoInBuildCell),
		height = GameUtil.getHeight(self._bgGoInBuildCell)
	}
end

function EternalCityBagView:bindEvents()
	EternalCityBagView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnActiveBuild, self._onClickBtnActiveBuild, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function EternalCityBagView:unbindEvents()
	EternalCityBagView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnActiveBuild)
	GameUtil.rmClickHandler(self._btnTip)
end

function EternalCityBagView:onEnter()
	EternalCityBagView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = EternalCityController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePMEternalCityInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityPlaceBuildingRes, self._onPlaceBuildingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityUnequipBuildingRes, self._onUnequipBuildingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityMoveBuildingRes, self._onMoveBuildingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityBuyBuildingRes, self._handlePM_EternalCityBuyBuildingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCitySaleBuildingRes, self._handlePM_EternalCitySaleBuildingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityCraftBuildingRes, self._handlePM_EternalCityCraftBuildingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityOperaPetRes, self._hndlePM_EternalCityOperaPetRes, self)
	self:_onInit()
	self:_onUpdate()
	self:_onUpdateBuildScrColUI()
end

function EternalCityBagView:onExit()
	EternalCityBagView.super.onExit(self)
	self:_onClear()
end

function EternalCityBagView:destroyUI()
	EternalCityBagView.super.destroyUI(self)

	self._eventSystemGo = nil
	self._eventSystemComp = nil
	self._eventSystem = nil

	self:_disposeGridCellPool()
	self:_disposeBuildCellPool()
end

function EternalCityBagView:_onPlaceBuildingRes(status, msg, onlyId)
	local result = 1

	if onlyId == nil then
		result = 2
	end

	if status ~= 0 then
		result = 2
	end

	if result == 1 then
		local x, y = msg.position.left, msg.position.right
		local posIndex = MmUtil.getPosIndex(x, y, self._mapCol, self._mapRow)

		self:_placeBuildingToMap(onlyId, posIndex)
	elseif result == 2 then
		local buildInfo = self._bagBuildInfos:get(onlyId)
		local isHasPlace = buildInfo._posIndex ~= 0

		if isHasPlace then
			self:_placeBuildingToMap(onlyId, buildInfo._posIndex)
		else
			self:_recycleBuildingFromMap(onlyId)
		end
	end
end

function EternalCityBagView:_onUnequipBuildingRes(status, msg, onlyId)
	local result = 1

	if onlyId == nil then
		result = 2
	end

	if status ~= 0 then
		result = 2
	end

	if result == 1 then
		self:_recycleBuildingFromMap(onlyId)
	elseif result == 2 then
		local buildInfo = self._bagBuildInfos:get(onlyId)
		local isHasPlace = buildInfo._posIndex ~= 0

		if isHasPlace then
			self:_placeBuildingToMap(onlyId, buildInfo._posIndex)
		else
			local x, y = msg.position.left, msg.position.right

			printError(string.format("建筑未放置，回归原位失败：( onlyId:%s, x:%s, y:%s )", onlyId, x, y))
		end
	end
end

function EternalCityBagView:_onMoveBuildingRes(status, msg, onlyId)
	local result = 1

	if onlyId == nil then
		result = 2
	end

	if status ~= 0 then
		result = 2
	end

	if result == 1 then
		local x, y = msg.newPosition.left, msg.newPosition.right
		local posIndex = MmUtil.getPosIndex(x, y, self._mapCol, self._mapRow)

		self:_placeBuildingToMap(onlyId, posIndex)
	elseif result == 2 then
		local buildInfo = self._bagBuildInfos:get(onlyId)
		local isHasPlace = buildInfo._posIndex ~= 0

		if isHasPlace then
			self:_placeBuildingToMap(onlyId, buildInfo._posIndex)
		else
			self:_recycleBuildingFromMap(onlyId)
		end
	end
end

function EternalCityBagView:_handlePM_EternalCityCraftBuildingRes(status, msg, onlyId)
	local result = 1

	if onlyId == nil then
		result = 2
	end

	if status ~= 0 then
		result = 2
	end

	if result == 1 then
		FloatWordMgr.instance:show("合成成功！")
		self:_recycleBuildingFromMap(onlyId)
		self:_onUpdate()
	elseif result == 2 then
		FloatWordMgr.instance:show("合成失败！")

		local buildInfo = self._bagBuildInfos:get(onlyId)
		local isHasPlace = buildInfo._posIndex ~= 0

		if isHasPlace then
			self:_placeBuildingToMap(onlyId, buildInfo._posIndex)
		else
			self:_recycleBuildingFromMap(onlyId)
		end
	end
end

function EternalCityBagView:_handlePM_EternalCityBuyBuildingRes(msg)
	self:_onUpdate()
end

function EternalCityBagView:_handlePM_EternalCitySaleBuildingRes(msg)
	self:_onUpdate()
end

function EternalCityBagView:_hndlePM_EternalCityOperaPetRes(msg)
	local x, y = msg.position.left, msg.position.right
	local posIndex = MmUtil.getPosIndex(x, y, self._mapCol, self._mapRow)
	local onlyIdList = self._buildOnlyIdsInMap:keyList()

	for _, onlyId in ipairs(onlyIdList) do
		local info = self._bagBuildInfos:get(onlyId)

		if posIndex == info._posIndex then
			local cell = self._buildCells[onlyId]

			if cell then
				self:_updateBuildCell(onlyId, cell)
			end
		end
	end
end

function EternalCityBagView:_onInit()
	self:_onClear()

	self._mapCol = EternalCityConfig.instance:getCommonValue("MAP_LENGTH", true)
	self._mapRow = EternalCityConfig.instance:getCommonValue("MAP_WIDTH", true)
	self._mapWidth = self._mapCol * self._gridCellSize.width
	self._mapHeight = self._mapRow * self._gridCellSize.height
	self._gridInfos = {}

	local tempVec3 = Vector3.New()
	local gridWidth, gridHeight = self._gridCellSize.width, self._gridCellSize.height

	for x = 0, self._mapCol - 1 do
		for y = 0, self._mapRow - 1 do
			local posIndex = MmUtil.getPosIndex(x, y, self._mapCol, self._mapRow)
			local info = {}

			info._posX = x
			info._posY = y
			info._posIndex = posIndex
			info._onlyId = 0

			local localPosX = gridWidth * (x + 1) - gridWidth / 2 - self._mapWidth / 2
			local localPosY = gridHeight * (y + 1) - gridHeight / 2 - self._mapHeight / 2

			tempVec3:Set(localPosX, localPosY, 0)

			info._worldPos = self._gridView.transform:TransformPoint(tempVec3)
			self._gridInfos[posIndex] = info
		end
	end

	self._bagBuildInfos = OrderedMap.New()
	self._buildOnlyIdsInMap = OrderedMap.New()
	self._buildCells = {}
	self._buildScrGos = {}
	self._shapes = {}

	local datass = EternalCityConfig.instance:getBuildingDatass(self._activityId) or {}

	for buildingId, v in ipairs(datass) do
		local data = v[1]
		local col, row = data.length, data.width
		local shape = {}

		for x = 0, col - 1 do
			for y = 0, row - 1 do
				local partIndex = MmUtil.getPosIndex(x, y, col, row)

				shape[partIndex] = {
					x = x,
					y = y
				}
			end
		end

		self._shapes[buildingId] = shape
	end

	self._treeInfo = {}
	self._treeInfo._posX = EternalCityConfig.instance:getCommonValue("GOD_TREE_X_POSITION", true)
	self._treeInfo._posY = EternalCityConfig.instance:getCommonValue("GOD_TREE_Y_POSITION", true)
	self._treeInfo._posIndex = MmUtil.getPosIndex(self._treeInfo._posX, self._treeInfo._posY, self._mapCol, self._mapRow)
	self._gridInfos[self._treeInfo._posIndex]._onlyId = EternalCityEnum.TreeOnlyId

	local boardSpacing = 50

	GameUtil.setWidth(self._mapView, self._mapWidth + boardSpacing)
	GameUtil.setHeight(self._mapView, self._mapHeight + boardSpacing)
	GameUtil.setWidth(self._gridView, self._mapWidth)
	GameUtil.setHeight(self._gridView, self._mapHeight)

	for posIndex, info in pairs(self._gridInfos) do
		local x, y = info._posX, info._posY
		local cell = self:_fetchGridCell(posIndex)

		GameUtil.setPos(cell._mainGo, info._worldPos.x, info._worldPos.y, info._worldPos.z)
		GameUtil.SetActive(cell._mainGo, true)
		self:_setGridUIState(posIndex, EternalCityEnum.GridUIState_Empty)
	end

	if self._treeCell then
		local gridInfo = self._gridInfos[self._treeInfo._posIndex]
		local worldPos = gridInfo._worldPos

		goutil.addChildToParent(self._treeCell, self._buildView)
		GameUtil.setPos(self._treeCell, worldPos.x, worldPos.y, worldPos.z)
		GameUtil.SetActive(self._treeCell, true)
	end

	self:_updateBuildCountUI()
end

function EternalCityBagView:_onUpdate()
	self:_returnAllBuildCells()
	self._bagBuildInfos:clear()
	self._buildOnlyIdsInMap:clear()

	local index = 0
	local datass = EternalCityConfig.instance:getBuildingDatass(self._activityId) or {}

	for buildingId, v in ipairs(datass) do
		for level, data in ipairs(v) do
			local buildNum = self._subMo:getBuildingNumByLevel(buildingId, level)

			for i = 1, buildNum do
				index = index + 1

				local info = {}

				info._onlyId = index
				info._buildingId = buildingId
				info._level = level
				info._posIndex = 0
				info._petIds = {}

				self._bagBuildInfos:put(info._onlyId, info)
			end
		end
	end

	local onlyIdList = self._bagBuildInfos:keyList()
	local placePositionInfos = self._subMo:getPlacePositionInfos()

	for _, v in ipairs(placePositionInfos) do
		for _, onlyId in ipairs(onlyIdList) do
			local info = self._bagBuildInfos:get(onlyId)

			if v.buildingId == info._buildingId and v.level == info._level and info._posIndex == 0 then
				info._posIndex = MmUtil.getPosIndex(v.position.left, v.position.right, self._mapCol, self._mapRow)

				MmUtil.coverList(info._petIds, v.petIds)
				self._buildOnlyIdsInMap:put(onlyId, onlyId)

				break
			end
		end
	end

	self:_onUpdateMap()
	self:_updateBuildCountUI()
	self:_onUpdateBuildScrColUI()
end

function EternalCityBagView:_onClear()
	if self._buildCells then
		for k, cell in pairs(self._buildCells) do
			self._buildCells[k] = nil

			self:_clearBuildCell(cell)
		end
	end

	if self._bagBuildInfos then
		self._bagBuildInfos:clear()
	end

	if self._buildOnlyIdsInMap then
		self._buildOnlyIdsInMap:clear()
	end

	self:_onClearBuildScrCol()
	self:_returnAllGridCells()
	self:_returnAllBuildCells()

	self._gridInfos = nil
	self._treeInfo = nil
	self._isDraging = false
	self._buildInfoInDrag = nil
end

function EternalCityBagView:_onUpdateMap()
	local onlyIdList = self._buildOnlyIdsInMap:keyList()

	for _, onlyId in ipairs(onlyIdList) do
		local mo = self._bagBuildInfos:get(onlyId)
		local posIndex = mo._posIndex

		self:_placeBuildingToMap(onlyId, posIndex)
	end
end

function EternalCityBagView:_updateBuildCountUI()
	local buildCount = self._bagBuildInfos:count()
	local max = self._subMo:getMaxBuildCount()

	self._txtBuildCount.text = string.format("(%s/%s)", buildCount, max)
end

function EternalCityBagView:_onUpdateBuildScrColUI()
	local onlyIdList = {}
	local list = self._bagBuildInfos:keyList()

	for _, onlyId in ipairs(list) do
		local buildInfo = self._bagBuildInfos:get(onlyId)

		if buildInfo._posIndex == EternalCityEnum.EmptyOnlyId then
			table.insert(onlyIdList, onlyId)
		end
	end

	self._buildScrollerList:reloadData(onlyIdList)
end

function EternalCityBagView:_onClearBuildScrCol()
	self._buildScrollerList:dispose()
	table.clear(self._buildScrGos)
end

function EternalCityBagView:_updateBuildScrCell(view, cell, onlyId, tag)
	local buildMo = self._bagBuildInfos:get(onlyId)
	local buildingId = buildMo._buildingId
	local level = buildMo._level
	local data = EternalCityConfig.instance:getBuildingData(self._activityId, buildingId, level)
	local col, row = data.length, data.width
	local mainGo = cell.gameObject

	self._buildScrGos[mainGo] = onlyId

	local icon = goutil.findChild(mainGo, "icon")
	local txtLevel = goutil.findChildTextComponent(mainGo, "level/txt")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
	local tagCraft = goutil.findChild(mainGo, "tagCraft")
	local partView = goutil.findChild(mainGo, "partView")
	local partCell = goutil.findChild(mainGo, "partCell")

	GameUtil.SetActive(partCell, false)

	txtLevel.text = string.format("%s级", level)
	txtName.text = data.name

	local spriteName = GameUrl.getBigbgPngUrl(data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName, function()
		return
	end)

	local col, row = data.length, data.width
	local partCount = col * row
	local childCount = partView.transform.childCount
	local length = Mathf.Max(partCount, childCount)

	for idx = 1, length do
		if childCount < idx then
			goutil.cloneAndSetParent(partCell, partView.transform)
		end

		local go = partView.transform:GetChild(idx - 1).gameObject

		GameUtil.SetActive(go, idx <= partCount)
	end

	local partWidth, partHeight = GameUtil.getWidth(partCell), GameUtil.getHeight(partCell)

	GameUtil.setWidth(partView, partWidth * col)
	GameUtil.setHeight(partView, partHeight * row)
	GameUtil.SetActive(tagCraft, false)

	if self._dragInfo then
		local dragOnlyId = self._dragInfo._onlyId
		local dragBuildInfo = self._bagBuildInfos:get(dragOnlyId)
		local dragBuildingId = dragBuildInfo._buildingId
		local dragLevel = dragBuildInfo._level

		if dragOnlyId ~= onlyId and dragBuildingId == buildingId and dragLevel == level then
			GameUtil.SetActive(tagCraft, true)
		end
	end
end

function EternalCityBagView:_clearBuildScrCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)

	self._buildScrGos[mainGo] = nil
end

function EternalCityBagView:_onDragBeginBuildScrCell(eventData, data, go)
	if self._isDraging then
		return
	end

	local onlyId = checknumber(data)
	local cell = self:_getBuildCell(onlyId)

	self:_onDragBeginBuildCell(cell, eventData)
end

function EternalCityBagView:_onDragBuildScrCell(eventData, data, go)
	local onlyId = checknumber(data)
	local cell = self._buildCells[onlyId]

	if cell then
		self:_onDragBuildCell(cell, eventData)
	end
end

function EternalCityBagView:_onDragEndBuildScrCell(eventData, data, go)
	local onlyId = checknumber(data)
	local cell = self._buildCells[onlyId]

	if cell then
		self:_onDragEndBuildCell(cell, eventData)
	end

	self._isDraging = false
end

function EternalCityBagView:_onDragBeginBuildCell(cell, eventData)
	if self._isDraging then
		return
	end

	self._isDraging = true

	local onlyId = cell._onlyId
	local buildInfo = self._bagBuildInfos:get(onlyId)
	local level = buildInfo._level
	local buildingId = buildInfo._buildingId
	local maxLevel = self._subMo:getBuildingMaxLevel(buildingId)
	local isFitCraftCondition = level < maxLevel

	self._dragInfo = {}
	self._dragInfo._onlyId = onlyId
	self._dragInfo._buildingId = buildingId

	if MmUtil.isInRangeByIndex(buildInfo._posIndex, self._mapCol, self._mapRow) then
		self._dragInfo._anchorX, self._dragInfo._anchorY = MmUtil.getPos(buildInfo._posIndex, self._mapCol, self._mapRow)
	else
		self._dragInfo._anchorX, self._dragInfo._anchorY = -1, -1
	end

	goutil.addChildToParent(cell._mainGo, self._dragView)

	local worldPos = uGuiUtil.GetTouchWorldPosition()

	self:_moveBuildCellToTouchPosition(cell, worldPos)

	if isFitCraftCondition then
		self._buildScrollerList:refresh()
	end

	local onlyIdList = self._buildOnlyIdsInMap:keyList()

	for _, _onlyId in ipairs(onlyIdList) do
		if _onlyId ~= onlyId then
			local buildInfo = self._bagBuildInfos:get(_onlyId)

			if buildInfo._buildingId == buildingId and buildInfo._level == level then
				local buildCell = self._buildCells[_onlyId]

				if buildCell then
					GameUtil.SetActive(buildCell._tagUpgrade, true)
				end
			end
		end
	end
end

function EternalCityBagView:_onDragBuildCell(cell, eventData)
	if not self._isDraging then
		return
	end

	local oldOnlyId = self._dragInfo._onlyId
	local oldBuildInfo = self._bagBuildInfos:get(oldOnlyId)
	local oldBuildingId = oldBuildInfo._buildingId
	local oldLevel = oldBuildInfo._level
	local oldPosIndex = MmUtil.getPosIndex(self._dragInfo._anchorX, self._dragInfo._anchorY, self._mapCol, self._mapRow)
	local oldOccupiedGrids = self:_getOccupiedGrids(oldBuildingId, oldPosIndex, true)
	local worldPos = uGuiUtil.GetTouchWorldPosition()
	local anchorLocalPos = self._gridView.transform:InverseTransformPoint(worldPos)
	local newPosX = Mathf.Round((anchorLocalPos.x - cell._centerOffeset.x + self._mapWidth / 2 + self._gridCellSize.width / 2) / self._gridCellSize.width) - 1
	local newPosY = Mathf.Round((anchorLocalPos.y - cell._centerOffeset.y + self._mapHeight / 2 + self._gridCellSize.height / 2) / self._gridCellSize.height) - 1
	local posIndex = MmUtil.getPosIndex(newPosX, newPosY, self._mapCol, self._mapRow)

	self._dragInfo._anchorX = newPosX
	self._dragInfo._anchorY = newPosY

	self:_moveBuildCellToTouchPosition(cell, worldPos)

	local gridUIStates = {}

	for _, gridIndex in pairs(oldOccupiedGrids) do
		gridUIStates[gridIndex] = EternalCityEnum.GridUIState_Empty
	end

	local onlyIds = self._buildOnlyIdsInMap:keyList()

	for _, _onlyId in ipairs(onlyIds) do
		if _onlyId ~= oldOnlyId then
			local buildInfo = self._bagBuildInfos:get(_onlyId)
			local result = self:_getBuildingPlacementResult(_onlyId, buildInfo._posIndex)
			local occupiedGrids = self:_getOccupiedGrids(buildInfo._buildingId, buildInfo._posIndex, true)
			local uiState = result

			if result == EternalCityEnum.GridUIState_SelectCorrect then
				uiState = EternalCityEnum.GridUIState_Empty
			end

			local isFitCraftCondition = buildInfo._level == oldLevel and buildInfo._buildingId == oldBuildingId

			for _, gridIndex in pairs(occupiedGrids) do
				gridUIStates[gridIndex] = (isFitCraftCondition or nil) and EternalCityEnum.GridUIState_Empty
			end
		end
	end

	local newPlaceResult = self:_getBuildingPlacementResult(oldOnlyId, posIndex)
	local newOccupiedGrids = self:_getOccupiedGrids(oldBuildingId, posIndex, true)
	local isFitCraftCondition = false

	for _, gridIndex in pairs(newOccupiedGrids) do
		local gridInfo = self._gridInfos[gridIndex]
		local _onlyId = gridInfo and gridInfo._onlyId

		if _onlyId and _onlyId ~= oldOnlyId then
			local buildInfo = self._bagBuildInfos:get(_onlyId)

			isFitCraftCondition = buildInfo and buildInfo._level == oldLevel and buildInfo._buildingId == oldBuildingId or false

			if isFitCraftCondition then
				break
			end
		end
	end

	for _, gridIndex in pairs(newOccupiedGrids) do
		gridUIStates[gridIndex] = (isFitCraftCondition or nil) and EternalCityEnum.GridUIState_Empty
	end

	for posIndex, uiState in pairs(gridUIStates) do
		self:_setGridUIState(posIndex, uiState)
	end
end

function EternalCityBagView:_onDragEndBuildCell(cell, eventData)
	if not self._isDraging then
		return
	end

	self._isDraging = false

	local dragResult = EternalCityEnum.OperationType_Restore
	local oldPosIndex = MmUtil.getPosIndex(self._dragInfo._anchorX, self._dragInfo._anchorY, self._mapCol, self._mapRow)

	self._dragInfo = nil

	local oldOnlyId = cell._onlyId
	local oldBuildInfo = self._bagBuildInfos:get(oldOnlyId)
	local oldBuildingId = oldBuildInfo._buildingId
	local oldLevel = oldBuildInfo._level
	local maxLevel = self._subMo:getBuildingMaxLevel(oldBuildingId)
	local isFitCraftCondition = oldLevel <= maxLevel
	local worldPos = uGuiUtil.GetTouchWorldPosition()
	local anchorLocalPos = self._gridView.transform:InverseTransformPoint(worldPos)
	local newPosX = Mathf.Round((anchorLocalPos.x - cell._centerOffeset.x + self._mapWidth / 2 + self._gridCellSize.width / 2) / self._gridCellSize.width) - 1
	local newPosY = Mathf.Round((anchorLocalPos.y - cell._centerOffeset.y + self._mapHeight / 2 + self._gridCellSize.height / 2) / self._gridCellSize.height) - 1
	local newPosIndex = MmUtil.getPosIndex(newPosX, newPosY, self._mapCol, self._mapRow)
	local newBuildInfo
	local oldOccupiedGrids = self:_getOccupiedGrids(oldBuildingId, oldPosIndex, true)

	for _, gridIndex in pairs(oldOccupiedGrids) do
		self:_setGridUIState(gridIndex, EternalCityEnum.GridUIState_Empty)
	end

	local isDragToInventoryArea = self:_isDragToInventoryArea(eventData)

	if isDragToInventoryArea then
		if isFitCraftCondition then
			local toOnlyId
			local raycastresult_list_type = SystemReflexHelp.getType("System.Collections.Generic.List`1[[UnityEngine.EventSystems.RaycastResult,UnityEngine.UI]]")
			local raycastresultList = tolua.createinstance(raycastresult_list_type)

			SystemReflexHelp.callRaycastAllOfEventSystem(self._eventSystem, eventData, raycastresultList)

			for i = 0, raycastresultList.Count - 1 do
				local raycastResult = raycastresultList[i]
				local resultGo = SystemReflexHelp.getPropertyValue("UnityEngine.EventSystems.RaycastResult,UnityEngine.UI", "gameObject", raycastResult)
				local currentTransform = resultGo.transform

				while currentTransform ~= nil do
					if self._buildScrGos[currentTransform.gameObject] then
						toOnlyId = self._buildScrGos[currentTransform.gameObject]

						break
					end

					if currentTransform.gameObject == self._buildScrView then
						break
					end

					if currentTransform.gameObject == self.mainGO then
						break
					end

					currentTransform = currentTransform.parent
				end

				if toOnlyId then
					break
				end
			end

			if toOnlyId then
				local toBuildInfo = self._bagBuildInfos:get(toOnlyId)
				local toBuildingId = toBuildInfo._buildingId
				local toLevel = toBuildInfo._level

				if oldOnlyId ~= toOnlyId and oldLevel < maxLevel and oldBuildingId == toBuildingId and oldLevel == toLevel then
					newBuildInfo = toBuildInfo
					dragResult = EternalCityEnum.OperationType_Craft
				end
			end

			if dragResult ~= EternalCityEnum.OperationType_Craft then
				dragResult = EternalCityEnum.OperationType_Recycle
			end
		end
	else
		local isInRange = MmUtil.isInRange(newPosX, newPosY, self._mapCol, self._mapRow)

		if isInRange then
			dragResult = EternalCityEnum.OperationType_Place

			if isFitCraftCondition then
				local newGridInfo = self._gridInfos[newPosIndex]
				local newOnlyId = newGridInfo._onlyId

				if newGridInfo and newOnlyId ~= EternalCityEnum.EmptyOnlyId and newOnlyId ~= EternalCityEnum.TreeOnlyId and newOnlyId ~= oldOnlyId then
					local info = self._bagBuildInfos:get(newOnlyId)

					if info._buildingId == oldBuildingId and info._level == oldLevel then
						newBuildInfo = info
						dragResult = EternalCityEnum.OperationType_Craft
					end
				end
			end
		end
	end

	if dragResult == EternalCityEnum.OperationType_Place then
		self:_doOperation(dragResult, oldOnlyId, newPosIndex)
	elseif dragResult == EternalCityEnum.OperationType_Recycle then
		self:_doOperation(EternalCityEnum.OperationType_Recycle, oldOnlyId)
	elseif dragResult == EternalCityEnum.OperationType_Craft then
		if newBuildInfo then
			self:_doOperation(EternalCityEnum.OperationType_Craft, oldOnlyId, newBuildInfo._onlyId)
		else
			printError("合成建筑失败，缺失关键参数 newBuildInfo")
		end
	elseif dragResult == EternalCityEnum.OperationType_Restore then
		self:_doOperation(EternalCityEnum.OperationType_Restore, oldOnlyId)
	end
end

function EternalCityBagView:_doOperation(operationType, ...)
	local params = {
		...
	}

	if operationType == EternalCityEnum.OperationType_Place then
		local onlyId = params[1]
		local newPosIndex = params[2]

		self:_doOperationOfPlace(onlyId, newPosIndex)
	elseif operationType == EternalCityEnum.OperationType_Recycle then
		local onlyId = params[1]

		self:_doOperationOfRecycle(onlyId)
	elseif operationType == EternalCityEnum.OperationType_Craft then
		local fromOnlyId = params[1]
		local toOnlyId = params[2]

		self:_doOperationOfCraft(fromOnlyId, toOnlyId)
	elseif operationType == EternalCityEnum.OperationType_Restore then
		local onlyId = params[1]

		self:_doOperationOfRestore(onlyId)
	end
end

function EternalCityBagView:_doOperationOfPlace(onlyId, newPosIndex)
	local oldBuildInfo = self._bagBuildInfos:get(onlyId)
	local oldPosIndex = oldBuildInfo._posIndex
	local isHasPlace = oldPosIndex ~= 0
	local isInRange = MmUtil.isInRangeByIndex(newPosIndex, self._mapCol, self._mapRow)

	if oldPosIndex == newPosIndex or not isInRange then
		self:_doOperationOfRestore(onlyId)
	else
		local placeResult = self:_getBuildingPlacementResultAndOther(onlyId, newPosIndex)

		if placeResult ~= EternalCityEnum.GridUIState_SelectCorrect then
			FloatWordMgr.instance:show("建筑放置不合法，无法放置")
			self:_doOperationOfRestore(onlyId)
		else
			local buildingId = oldBuildInfo._buildingId
			local level = oldBuildInfo._level
			local newX, newY = MmUtil.getPos(newPosIndex, self._mapCol, self._mapRow)
			local oldX, oldY = MmUtil.getPos(oldPosIndex, self._mapCol, self._mapRow)

			if isHasPlace then
				EternalCityController.instance:sendPM_EternalCityMoveBuildingReq(self._activityId, buildingId, level, oldX, oldY, newX, newY, onlyId)
			else
				EternalCityController.instance:sendPM_EternalCityPlaceBuildingReq(self._activityId, buildingId, level, newX, newY, onlyId)
			end
		end
	end
end

function EternalCityBagView:_doOperationOfRecycle(onlyId)
	local oldBuildInfo = self._bagBuildInfos:get(onlyId)
	local oldPosIndex = oldBuildInfo._posIndex
	local placeResult = self:_getBuildingPlacementResultAndOther(onlyId, oldPosIndex)

	if placeResult ~= EternalCityEnum.GridUIState_SelectCorrect then
		FloatWordMgr.instance:show("建筑放置不合法，无法回收")
		self:_doOperationOfRestore(onlyId)
	else
		local hasPlace = oldPosIndex ~= 0

		if hasPlace then
			local buildingId = oldBuildInfo._buildingId
			local level = oldBuildInfo._level
			local oldX, oldY = MmUtil.getPos(oldPosIndex, self._mapCol, self._mapRow)

			EternalCityController.instance:sendPM_EternalCityUnequipBuildingReq(self._activityId, buildingId, level, oldX, oldY, onlyId)
		else
			self:_doOperationOfRestore(onlyId)
		end
	end
end

function EternalCityBagView:_doOperationOfCraft(fromOnlyId, toOnlyId)
	local fromBuildInfo = self._bagBuildInfos:get(fromOnlyId)
	local fromBuildingId = fromBuildInfo._buildingId
	local fromLevel = fromBuildInfo._level
	local toBuildInfo = self._bagBuildInfos:get(toOnlyId)
	local toPosIndex = toBuildInfo._posIndex
	local toHasPlace = toPosIndex ~= 0
	local maxLevel = self._subMo:getBuildingMaxLevel(fromBuildingId)

	if maxLevel <= fromLevel then
		FloatWordMgr.instance:show("建筑等级已满，无法合成")
		self:_doOperationOfRestore(fromOnlyId)

		return
	end

	local placeResult = EternalCityEnum.GridUIState_SelectCorrect

	if toHasPlace then
		local onlyIds = self._buildOnlyIdsInMap:keyList()

		for _, _onlyId in ipairs(onlyIds) do
			if _onlyId ~= fromOnlyId and _onlyId ~= toOnlyId then
				local bInfo = self._bagBuildInfos:get(_onlyId)
				local result = self:_getBuildingPlacementResult(_onlyId, bInfo._posIndex)

				if result ~= EternalCityEnum.GridUIState_SelectCorrect then
					placeResult = result

					break
				end
			end
		end
	end

	if placeResult ~= EternalCityEnum.GridUIState_SelectCorrect then
		FloatWordMgr.instance:show("建筑放置不合法，无法合成")
		self:_doOperationOfRestore(fromOnlyId)
	else
		local buildingId = fromBuildInfo._buildingId
		local craftLevel = fromBuildInfo._level + 1
		local oldPos, newPos

		if fromBuildInfo._posIndex ~= 0 then
			local oldX, oldY = MmUtil.getPos(fromBuildInfo._posIndex, self._mapCol, self._mapRow)

			oldPos = {
				x = oldX,
				y = oldY
			}
		end

		if toBuildInfo._posIndex ~= 0 then
			local newX, newY = MmUtil.getPos(toBuildInfo._posIndex, self._mapCol, self._mapRow)

			newPos = {
				x = newX,
				y = newY
			}
		end

		EternalCityController.instance:sendPM_EternalCityCraftBuildingReq(self._activityId, buildingId, craftLevel, oldPos, newPos, fromOnlyId)
	end
end

function EternalCityBagView:_doOperationOfRestore(onlyId)
	local buildInfo = self._bagBuildInfos:get(onlyId)
	local posIndex = buildInfo._posIndex
	local isHasPlace = buildInfo._posIndex ~= 0

	if isHasPlace then
		self:_placeBuildingToMap(onlyId, posIndex)
	else
		self:_recycleBuildingFromMap(onlyId)
	end

	local onlyIdList = self._buildOnlyIdsInMap:keyList()

	for _, _onlyId in ipairs(onlyIdList) do
		local buildCell = self._buildCells[_onlyId]

		if buildCell then
			GameUtil.SetActive(buildCell._tagUpgrade, false)
		end
	end
end

function EternalCityBagView:_isDragToInventoryArea(eventData)
	if not eventData then
		return false
	end

	return (UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._buildScrView.transform, eventData.position, GlobalModel.instance.uiCamera))
end

function EternalCityBagView:_placeBuildingToMap(onlyId, posIndex)
	self._buildOnlyIdsInMap:put(onlyId, onlyId)

	local buildInfo = self._bagBuildInfos:get(onlyId)
	local buildingId = buildInfo._buildingId

	if buildInfo._posIndex ~= 0 and buildInfo._posIndex ~= posIndex then
		local anchorX, anchorY = MmUtil.getPos(buildInfo._posIndex, self._mapCol, self._mapRow)
		local shape = self._shapes[buildingId]

		for partIndex, partPos in pairs(shape) do
			local gridX = anchorX + partPos.x
			local gridY = anchorY + partPos.y
			local index = MmUtil.getPosIndex(gridX, gridY, self._mapCol, self._mapRow)
			local gridInfo = self._gridInfos[index]

			if gridInfo then
				gridInfo._onlyId = 0
			end
		end
	end

	buildInfo._posIndex = posIndex

	local anchorX, anchorY = MmUtil.getPos(posIndex, self._mapCol, self._mapRow)
	local shape = self._shapes[buildingId]

	for partIndex, partPos in pairs(shape) do
		local gridX = anchorX + partPos.x
		local gridY = anchorY + partPos.y
		local index = MmUtil.getPosIndex(gridX, gridY, self._mapCol, self._mapRow)
		local gridInfo = self._gridInfos[index]

		if gridInfo then
			gridInfo._onlyId = onlyId
		end
	end

	self:_snapBuildCellToGrid(onlyId)

	local gridUIStates = {}
	local newPlaceResult = self:_getBuildingPlacementResult(onlyId, posIndex)
	local newOccupiedGrids = self:_getOccupiedGrids(buildingId, posIndex, true)

	for _, gridIndex in pairs(newOccupiedGrids) do
		gridUIStates[gridIndex] = newPlaceResult
	end

	local onlyIds = self._buildOnlyIdsInMap:keyList()

	for _, _onlyId in ipairs(onlyIds) do
		if _onlyId ~= onlyId then
			local info = self._bagBuildInfos:get(_onlyId)
			local result = self:_getBuildingPlacementResult(_onlyId, info._posIndex)
			local occupiedGrids = self:_getOccupiedGrids(info._buildingId, info._posIndex, true)

			for _, gridIndex in pairs(occupiedGrids) do
				gridUIStates[gridIndex] = result
			end
		end

		local buildCell = self._buildCells[_onlyId]

		if buildCell then
			GameUtil.SetActive(buildCell._tagUpgrade, false)
		end
	end

	for posIndex, uiState in pairs(gridUIStates) do
		if uiState ~= EternalCityEnum.GridUIState_SelectCorrect then
			self:_setGridUIState(posIndex, uiState)
		else
			self:_setGridUIState(posIndex, EternalCityEnum.GridUIState_Empty)
		end
	end

	self:_onUpdateBuildScrColUI()
end

function EternalCityBagView:_recycleBuildingFromMap(onlyId)
	self._buildOnlyIdsInMap:remove(onlyId)

	local buildInfo = self._bagBuildInfos:get(onlyId)
	local posIndex = buildInfo._posIndex

	buildInfo._posIndex = 0

	local gridUIStates = {}
	local anchorX, anchorY = MmUtil.getPos(posIndex, self._mapCol, self._mapRow)
	local shape = self._shapes[buildInfo._buildingId]

	for partIndex, partPos in pairs(shape) do
		local gridX = anchorX + partPos.x
		local gridY = anchorY + partPos.y
		local index = MmUtil.getPosIndex(gridX, gridY, self._mapCol, self._mapRow)
		local gridInfo = self._gridInfos[index]

		if gridInfo then
			gridInfo._onlyId = 0
			gridUIStates[index] = EternalCityEnum.GridUIState_Empty
		end
	end

	if self._buildCells[onlyId] then
		local cell = self:_getBuildCell(onlyId)

		self:_clearBuildCell(cell)

		self._buildCells[onlyId] = nil
	end

	local onlyIds = self._buildOnlyIdsInMap:keyList()

	for _, _onlyId in ipairs(onlyIds) do
		if _onlyId ~= onlyId then
			local info = self._bagBuildInfos:get(_onlyId)
			local result = self:_getBuildingPlacementResult(_onlyId, info._posIndex)
			local occupiedGrids = self:_getOccupiedGrids(info._buildingId, info._posIndex, true)

			for _, gridIndex in pairs(occupiedGrids) do
				gridUIStates[gridIndex] = result
			end
		end
	end

	for posIndex, uiState in pairs(gridUIStates) do
		if uiState ~= EternalCityEnum.GridUIState_SelectCorrect then
			self:_setGridUIState(posIndex, uiState)
		else
			self:_setGridUIState(posIndex, EternalCityEnum.GridUIState_Empty)
		end
	end

	self:_onUpdateBuildScrColUI()
end

function EternalCityBagView:_getBuildingPlacementResultAndOther(onlyId, posIndex)
	local placeResult = self:_getBuildingPlacementResult(onlyId, posIndex)

	if placeResult == EternalCityEnum.GridUIState_SelectCorrect then
		local onlyIds = self._buildOnlyIdsInMap:keyList()

		for _, _onlyId in ipairs(onlyIds) do
			if _onlyId ~= onlyId then
				local bInfo = self._bagBuildInfos:get(_onlyId)
				local result = self:_getBuildingPlacementResult(_onlyId, bInfo._posIndex)

				if result ~= EternalCityEnum.GridUIState_SelectCorrect then
					placeResult = result

					break
				end
			end
		end
	end

	return placeResult
end

function EternalCityBagView:_getBuildingPlacementResult(onlyId, posIndex)
	local buildingId = self._bagBuildInfos:get(onlyId)._buildingId
	local occupiedGrids = self:_getOccupiedGrids(buildingId, posIndex, false)

	for _, gridIndex in pairs(occupiedGrids) do
		if not MmUtil.isInRangeByIndex(gridIndex, self._mapCol, self._mapRow) then
			return EternalCityEnum.GridUIState_SelectDisconnected
		end
	end

	for _, gridIndex in pairs(occupiedGrids) do
		local gridInfo = self._gridInfos[gridIndex]

		if gridInfo and gridInfo._onlyId ~= EternalCityEnum.EmptyOnlyId and gridInfo._onlyId ~= onlyId then
			return EternalCityEnum.GridUIState_SelectNotEmpty
		end
	end

	return EternalCityEnum.GridUIState_SelectCorrect
end

function EternalCityBagView:_getOccupiedGrids(buildingId, posIndex, isInRange)
	local result = {}

	if not isInRange or isInRange and MmUtil.isInRangeByIndex(posIndex, self._mapCol, self._mapRow) then
		local anchorX, anchorY = MmUtil.getPos(posIndex, self._mapCol, self._mapRow)
		local shape = self._shapes[buildingId]

		for partIndex, partPos in pairs(shape) do
			local gridX = anchorX + partPos.x
			local gridY = anchorY + partPos.y

			if not isInRange or isInRange and MmUtil.isInRange(gridX, gridY, self._mapCol, self._mapRow) then
				local gridIndex = MmUtil.getPosIndex(gridX, gridY, self._mapCol, self._mapRow)

				table.insert(result, gridIndex)
			end
		end
	end

	return result
end

function EternalCityBagView:_snapBuildCellToGrid(onlyId)
	local buildInfo = self._bagBuildInfos:get(onlyId)
	local posIndex = buildInfo._posIndex
	local gridCell = self._gridCells[posIndex]
	local buildCell = self:_getBuildCell(onlyId)

	goutil.addChildToParent(buildCell._mainGo, self._buildView)

	local localPos = self._buildView.transform:InverseTransformPoint(gridCell._mainGo.transform.position)

	GameUtil.setLocalPos(buildCell._mainGo, localPos.x + buildCell._centerOffeset.x, localPos.y + buildCell._centerOffeset.y, localPos.z)
end

function EternalCityBagView:_moveBuildCellToTouchPosition(cell, worldPos)
	GameUtil.setPos(cell._mainGo, worldPos.x, worldPos.y, worldPos.z)
end

function EternalCityBagView:_setGridUIState(posIndex, state)
	local cell = self._gridCells[posIndex]

	if cell == nil then
		return
	end

	GameUtil.SetActive(cell._imgBg, false)
	GameUtil.SetActive(cell._imgSelect, false)

	if state == EternalCityEnum.GridUIState_Empty then
		GameUtil.SetActive(cell._imgBg, true)
	elseif state == EternalCityEnum.GridUIState_SelectNotEmpty then
		GameUtil.SetActive(cell._imgSelect, true)
		cell._imgSelectChange:SetState(0)
	elseif state == EternalCityEnum.GridUIState_SelectDisconnected then
		GameUtil.SetActive(cell._imgSelect, true)
		cell._imgSelectChange:SetState(1)
	elseif state == EternalCityEnum.GridUIState_SelectCorrect then
		GameUtil.SetActive(cell._imgSelect, true)
		cell._imgSelectChange:SetState(2)
	end
end

function EternalCityBagView:_fetchGridCell(posIndex)
	if self._gridCells[posIndex] then
		printError(string.format("错误：格子已存在，尝试重复创建格子。( posIndex:%s )", posIndex))

		return nil
	end

	local cell = self._gridCellPoll:fetchObject()

	cell._posIndex = posIndex
	cell._mainGo.name = string.format("%s_%s", self._gridCell.name, posIndex)
	self._gridCells[posIndex] = cell

	return cell
end

function EternalCityBagView:_creatGridCellPool()
	if self._gridCellPoll ~= nil then
		return
	end

	local function createFunc()
		local mainGo = goutil.clone(self._gridCell)
		local cell = {}

		cell._posIndex = 0
		cell._mainGo = mainGo
		cell._imgBg = goutil.findChild(mainGo, "imgBg")
		cell._imgSelect = goutil.findChild(mainGo, "imgSelect")
		cell._imgSelectChange = GameUtil.getUIImageSpriteChange(cell._imgSelect)

		goutil.addChildToParent(mainGo, self._gridView)

		return cell
	end

	local function disposeFunc(cell)
		local mainGo = cell._mainGo

		table.clear(cell)

		cell = nil

		goutil.destroy(mainGo)
	end

	local function resetFunc(cell)
		GameUtil.SetActive(cell._mainGo, false)

		cell._mainGo.name = self._gridCell.name
	end

	self._gridCellPoll = ObjectPool.New(400, createFunc, disposeFunc, resetFunc)
	self._gridCells = {}
end

function EternalCityBagView:_returnAllGridCells()
	for posIndex, cell in pairs(self._gridCells) do
		self._gridCellPoll:returnObject(cell)
	end

	table.clear(self._gridCells)
end

function EternalCityBagView:_disposeGridCellPool()
	self:_returnAllGridCells()

	if self._gridCellPoll ~= nil then
		self._gridCellPoll:clear()

		self._gridCellPoll = nil
	end
end

function EternalCityBagView:_getBuildCell(onlyId)
	local cell = self._buildCells[onlyId]

	if cell == nil then
		cell = self._buildCellPoll:fetchObject()
		self._buildCells[onlyId] = cell
	end

	self:_updateBuildCell(onlyId, cell)

	return self._buildCells[onlyId]
end

function EternalCityBagView:_updateBuildCell(onlyId, cell)
	GameUtil.SetActive(cell._mainGo, true)

	local info = self._bagBuildInfos:get(onlyId)
	local buildingId = info._buildingId
	local level = info._level
	local data = EternalCityConfig.instance:getBuildingData(self._activityId, buildingId, level)
	local col, row = data.length, data.width
	local posIndex = info._posIndex
	local x, y = MmUtil.getPos(posIndex, self._mapCol, self._mapRow)
	local positionInfo = self._subMo:getPlacePositionInfoByPos(x, y)

	if positionInfo then
		if not positionInfo.petIds then
			local petIds = {}
			local spriteName = GameUrl.getBigbgPngUrl(data.iconUrl)

			uGuiUtil.setSpriteToImage(cell._icon, uGuiUtil.SpriteType.BigBg, spriteName, function()
				cell._icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end)

			cell._txtLevel.text = string.format("%s级", level)

			cell._petScrollerList:setCenterMode(true)
			cell._petScrollerList:reloadData(petIds)

			cell._onlyId = onlyId

			local bgGoWidth, bgGoHeight = self._bgGoInBuildCellSize.width, self._bgGoInBuildCellSize.height
			local buildWidth, buildHeight = col * bgGoWidth, row * bgGoHeight

			cell._centerOffeset.x = bgGoWidth * col / 2 - bgGoWidth / 2
			cell._centerOffeset.y = bgGoHeight * row / 2 - bgGoHeight / 2

			GameUtil.setWidth(cell._mainGo, buildWidth)
			GameUtil.setHeight(cell._mainGo, buildHeight)

			local anchorLocalPos = cell._mainGo.transform:InverseTransformPoint(cell._bgView.transform.position)
			local offsetX, offsetY = anchorLocalPos.x, anchorLocalPos.y
			local bgChildGoCount = cell._bgView.transform.childCount
			local index = 1

			for x = 0, col - 1 do
				for y = 0, row - 1 do
					local partIndex = MmUtil.getPosIndex(x, y, col, row)
					local bgGo = index <= bgChildGoCount and cell._bgView.transform:GetChild(index - 1).gameObject or goutil.cloneAndSetParent(cell._bgGo, cell._bgView.transform, string.format("%s_%s", cell._bgGo.name, partIndex))

					index = index + 1

					local localPosX = bgGoWidth * x + bgGoWidth / 2
					local localPosY = bgGoHeight * y + bgGoHeight / 2

					GameUtil.setLocalPos(bgGo, localPosX, localPosY, 0)
					GameUtil.SetActive(bgGo, true)
				end
			end

			for i = index, bgChildGoCount do
				local bgGo = cell._bgView.transform:GetChild(i - 1).gameObject

				GameUtil.SetActive(bgGo, false)
			end
		end
	end
end

function EternalCityBagView:_clearBuildCell(cell)
	local mainGo = cell._mainGo

	uGuiUtil.clearImage(cell._icon)

	local triggerGo = cell._bgView

	BeginDragHandler.Get(triggerGo):RemoveLuaHandler(cell._beginDragHandler)
	EndDragHandler.Get(triggerGo):RemoveLuaHandler(cell._endDragHandler)
	DragHandler.Get(triggerGo):RemoveLuaHandler(cell._dragHandler)
	table.clear(cell)

	cell = nil

	goutil.destroy(mainGo)
end

function EternalCityBagView:_creatBuildCellPool()
	if self._buildCellPoll ~= nil then
		return
	end

	local function createFunc()
		local mainGo = goutil.clone(self._buildCell, self._buildCell.name)

		goutil.addChildToParent(mainGo, self._buildView)
		GameUtil.SetActive(mainGo, true)

		local cell = {}

		cell._onlyId = 0
		cell._centerOffeset = {
			x = 0,
			y = 0
		}
		cell._mainGo = mainGo
		cell._bgView = goutil.findChild(mainGo, "bgView")
		cell._bgGo = goutil.findChild(mainGo, "bgGo")
		cell._icon = goutil.findChild(mainGo, "icon")
		cell._tagUpgrade = goutil.findChild(mainGo, "tagUpgrade")
		cell._txtLevel = goutil.findChildTextComponent(mainGo, "level/txt")
		cell._petScrCell = goutil.findChild(mainGo, "petScrCell")
		cell._petScrView = goutil.findChild(mainGo, "petScrView")
		cell._petScrollerList = ScrollerList.create(cell._petScrView, cell._petScrCell, GameUtil.handler(self._updatePetCellInBuild, self), GameUtil.handler(self._clearPetCellInBuild, self))

		cell._petScrollerList:setCenterMode(true)
		GameUtil.SetActive(cell._bgGo, false)
		GameUtil.SetActive(cell._tagUpgrade, false)

		local triggerGo = cell._mainGo

		cell._clickHandler = PointerClickHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			if self._isDraging then
				return
			end

			local info = self._bagBuildInfos:get(cell._onlyId)
			local buildingId = info._buildingId
			local level = info._level
			local px, py = MmUtil.getPos(info._posIndex, self._mapCol, self._mapRow)

			UIStateManager.instance:push(ViewName.EternalCityBuildInfoView, self._activityId, buildingId, level, {
				x = px,
				y = py
			})
		end)
		cell._beginDragHandler = BeginDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onDragBeginBuildCell(cell, eventData)
		end)
		cell._dragHandler = DragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onDragBuildCell(cell, eventData)
		end)
		cell._endDragHandler = EndDragHandler.Get(triggerGo):AddLuaHandler(function(_go, eventData)
			self:_onDragEndBuildCell(cell, eventData)
		end)

		return cell
	end

	local function disposeFunc(cell)
		local mainGo = cell._mainGo

		uGuiUtil.clearImage(cell._icon)
		cell._petScrollerList:dispose()

		local triggerGo = cell._bgView

		PointerClickHandler.Get(triggerGo):RemoveLuaHandler(cell._clickHandler)
		BeginDragHandler.Get(triggerGo):RemoveLuaHandler(cell._beginDragHandler)
		EndDragHandler.Get(triggerGo):RemoveLuaHandler(cell._endDragHandler)
		DragHandler.Get(triggerGo):RemoveLuaHandler(cell._dragHandler)
		GameUtil.rmClickHandler(cell._bgView)
		table.clear(cell)

		cell = nil

		goutil.destroy(mainGo)
	end

	local function resetFunc(cell)
		goutil.addChildToParent(cell._mainGo, self._buildView)
		GameUtil.SetActive(cell._mainGo, false)

		cell._mainGo.name = self._buildCell.name
	end

	self._buildCellPoll = ObjectPool.New(30, createFunc, disposeFunc, resetFunc)
	self._buildCells = {}
end

function EternalCityBagView:_disposeBuildCellPool()
	self:_returnAllBuildCells()

	if self._buildCellPoll ~= nil then
		self._buildCellPoll:clear()

		self._buildCellPoll = nil
	end
end

function EternalCityBagView:_returnAllBuildCells()
	for onlyId, cell in pairs(self._buildCells) do
		self._buildCellPoll:returnObject(cell)
	end

	table.clear(self._buildCells)
end

function EternalCityBagView:_updatePetCellInBuild(view, cell, creepsId, tag)
	local creepsData = EternalCityConfig.instance:getSupportPetData(self._activityId, creepsId)
	local skinId = checknumber(creepsData and creepsData.faceId)

	if skinId <= 0 then
		skinId = checknumber(creepsData and creepsData.raceId)
	end

	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)
end

function EternalCityBagView:_clearPetCellInBuild(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
end

function EternalCityBagView:_onClickBtnClose()
	self:close()
end

function EternalCityBagView:_onClickBtnShop()
	UIStateManager.instance:push(ViewName.EternalCityBuildShopTabView, self._activityId)
end

function EternalCityBagView:_onClickBtnActiveBuild()
	UIStateManager.instance:push(ViewName.EternalCityActiveBuildView, self._activityId)
end

function EternalCityBagView:_onClickBtnTip()
	local actData = EternalCityConfig.instance:getActivityData(self._activityId)
	local key = actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return EternalCityBagView
