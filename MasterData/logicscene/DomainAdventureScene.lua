-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/DomainAdventureScene.lua

module("logicscene.scene.impl.DomainAdventureScene", package.seeall)

local DomainAdventureScene = class("DomainAdventureScene", CityScene)
local _ShowType = DomAdvEnum.ShowType_Normal
local _ViewGridId = -1

function DomainAdventureScene:_initComponents()
	self:_addComponent("unitFactory", DomainAdventureSceneUnitFactory)
	self:_addComponent("camera", DomainAdventureSceneCamera)
	self:_addComponent("stage", DomainAdventureSceneStage)
	self:_addComponent("joystick", SceneCompDisableJoystickListener)
	self:_addComponent("picker", SceneCompDomAdvPicker)
	self:_addComponent("bgm", TilingSceneBgmMgr)
	self:_addComponent("resCache", SceneResObjectCache)
	self:_addComponent("mapInfoMgr", SceneCompMapInfoMgr)
end

function DomainAdventureScene:onEnter(sceneId, bornX, bornZ)
	self._activityId = DomainAdventureController.instance:getCurActivityId()
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)
	self._loadGridIdQueue = self._loadGridIdQueue or DeQueue.New()
	self._curClickGridId = nil
	self._oldShowType = _ShowType
	self._oldCenterAreaId = -1
	self._isNeedNotifyMapDataUpdate = false
	self._isNeedMapUIUpdate = false
	self._readyFocusToGridId = 0
	self._isNeedAnimInFocus = false
	self._refreshAreaIdDic = {}
	self._refreshAreaIdCount = 0
	self._maxRefreshAreaIdCount = DomAdvPathFindingDataModel.instance:getAreaCount()
	self._refreshCheckMaxDelta = 0.14
	self._refreshCheckCurDelta = 0
	self._finishReadyLoad = false

	DomainAdventureScene.super.onEnter(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.DomainAdventureSceneClickGrid, self._handleDomainAdventureSceneClickGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.DomainAdventureSceneFocusToGrid, self._handleDomainAdventureSceneFocusToGrid, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DomainAdventureOccupiedChangesRes, self._handlePM_DomainAdventureOccupiedChangesRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DomainAdventureGetInfoRes, self._onUpdateMapData, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DomainAdventureLoadMapRes, self._onUpdateMapData, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, self._onUpdateMapData, self)
	self:_onUpdateMapData()

	local initBlockId = DomainAdventureConfig.instance:getInitBlockId(self._activityId)

	self._domAdvMo:addGridIdToUpdateDic(initBlockId)

	if _ViewGridId < 0 then
		_ViewGridId = initBlockId
	end

	self:_refreshImportantAndEyeGrids(_ViewGridId)
	settimer(0, self._onTickingInLoadMap, self, true)
	self:_onTickingInLoadMap()
end

function DomainAdventureScene:onEnterFinished()
	DomainAdventureScene.super.onEnterFinished(self)
end

function DomainAdventureScene:lateEnterFinished()
	DomainAdventureScene.super.lateEnterFinished(self)

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer.syncPos:disable(true)
		mainPlayer:setVisible(false)
	end

	self.joystick:setEnable(false)
	self:changeFocusToGrid(_ViewGridId, false)

	self._finishReadyLoad = true
end

function DomainAdventureScene:onExit()
	removetimer(self._onTickingInLoadMap, self)
	GlobalDispatcher:removeListener(GlobalNotify.DomainAdventureSceneClickGrid, self._handleDomainAdventureSceneClickGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.DomainAdventureSceneFocusToGrid, self._handleDomainAdventureSceneFocusToGrid, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureOccupiedChangesRes, self._handlePM_DomainAdventureOccupiedChangesRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureGetInfoRes, self._onUpdateMapData, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureLoadMapRes, self._onUpdateMapData, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DomainAdventureNotifyActionRes, self._onUpdateMapData, self)
	self._loadGridIdQueue:clear()

	self._curClickGridId = nil

	DomainAdventureScene.super.onExit(self)
end

function DomainAdventureScene:getActivityIdInScene()
	return self._activityId
end

function DomainAdventureScene:_handleDomainAdventureSceneClickGrid(gridId)
	local unit = self:getUnitByGridId(gridId)

	if unit then
		local eventType = DomainAdventureConfig.instance:getEventType(self._activityId, gridId)

		if eventType ~= nil then
			self._curClickGridId = gridId

			unit:playSelectedAnimation(GameUtil.handler(self._doClickCallBack, self, gridId))
		end
	end
end

function DomainAdventureScene:_handleDomainAdventureSceneFocusToGrid(gridId, isNeedAnim)
	self:setReadyFocusToGrid(gridId, isNeedAnim)
end

function DomainAdventureScene:_handlePM_DomainAdventureOccupiedChangesRes()
	local pos = self.camera:getScreenCenterWorldPosition()
	local centerGridId = DomAdvPathFindingDataModel.instance:pos2Id(pos.x, pos.y)

	self:_refreshImportantAndEyeGrids(centerGridId)
end

function DomainAdventureScene:_refreshImportantAndEyeGrids(centerGridId)
	local yellowGridIdDic = {}

	for _, eventType in ipairs({
		DomAdvEnum.EventType_Boss
	}) do
		local ids = self.mapInfoMgr:getGridIdsByType(eventType)

		for _, v in ipairs(ids) do
			yellowGridIdDic[v] = true
		end
	end

	for _, eventType in ipairs({
		DomAdvEnum.EventType_EliteFight
	}) do
		local ids = self.mapInfoMgr:getGridIdsByType(eventType)

		for _, v in ipairs(ids) do
			yellowGridIdDic[v] = true

			local adjacentIds = DomAdvPathFindingDataModel.instance:getAdjacentGridIds(v, 1)

			for _, vv in ipairs(adjacentIds) do
				yellowGridIdDic[vv] = true
			end
		end
	end

	local buffGridIds = self.mapInfoMgr:getGridIdsInBuff()

	for _, gridId in ipairs(buffGridIds or {}) do
		yellowGridIdDic[gridId] = true
	end

	local centerAreaId = DomAdvPathFindingDataModel.instance:getAreaId(centerGridId)

	self._oldCenterAreaId = centerAreaId

	local adjacentAreaIds = DomAdvPathFindingDataModel.instance:getAdjacentAreaIds(centerAreaId)

	for _, areaId in ipairs(adjacentAreaIds) do
		if not self._refreshAreaIdDic[areaId] then
			self._refreshAreaIdDic[areaId] = true
			self._refreshAreaIdCount = self._refreshAreaIdCount + 1
		end

		local gridIds = DomAdvPathFindingDataModel.instance:getGridIds(areaId)

		for _, gridId in ipairs(gridIds) do
			yellowGridIdDic[gridId] = true
		end
	end

	local gridIds = DomAdvPathFindingDataModel.instance:getAdjacentGridIds(centerGridId, 8)

	for _, gridId in ipairs(gridIds) do
		yellowGridIdDic[gridId] = true
	end

	for gridId, _ in pairs(yellowGridIdDic) do
		self:addGridIdToReqList(gridId)
	end
end

function DomainAdventureScene:_onTickingInLoadMap()
	if self._loadGridIdQueue:count() > 0 then
		local req = DomainAdventureExtension_pb.PM_DomainAdventureLoadMapReq()

		req.activityId = self._activityId

		local count = self._loadGridIdQueue:count()

		for index = 1, Mathf.Min(count, DomAdvEnum.EachReqGridMaxCount) do
			req.blockIds:append(self._loadGridIdQueue:popFront())
		end

		DomainAdventureAgent.instance:sendPM_DomainAdventureLoadMapReqInHighPer(req)
	end
end

function DomainAdventureScene:addGridIdToReqList(gridId)
	if not self:_isNecessaryGrid(gridId) then
		return
	end

	self._loadGridIdQueue:pushBack(gridId)
end

function DomainAdventureScene:_isNecessaryGrid(gridId)
	if not DomAdvPathFindingDataModel.instance:isInRangeById(gridId) then
		return false
	end

	if not DomainAdventureConfig.instance:getMapData(self._activityId, gridId) then
		return false
	end

	return true
end

function DomainAdventureScene:getSceneType()
	return SceneType.DomainAdventure
end

function DomainAdventureScene:getDefaultView()
	return (DomainAdventureConfig.instance:getViewName(self._activityId))
end

function DomainAdventureScene:update(deltaTime)
	self.camera:update(deltaTime)
	self.mapInfoMgr:onTicking(deltaTime)

	if self._finishReadyLoad == false then
		return
	end

	if _ShowType ~= self._oldShowType then
		self._oldShowType = _ShowType

		self:setNeedNeedMapUIUpdate()
	end

	if self._isNeedNotifyMapDataUpdate then
		self._isNeedNotifyMapDataUpdate = false

		self:setNeedNeedMapUIUpdate()
		GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneMapDataUpdate)
	end

	if self._isNeedMapUIUpdate then
		self._isNeedMapUIUpdate = false

		self:_onUpdateMapUI()
	end

	if self._readyFocusToGridId > 0 then
		self:changeFocusToGrid(self._readyFocusToGridId, self._isNeedAnimInFocus)

		self._readyFocusToGridId = 0
		self._isNeedAnimInFocus = false
	end

	if self._IsAdvTestMode_Eye or self._refreshAreaIdCount < self._maxRefreshAreaIdCount then
		self._refreshCheckCurDelta = self._refreshCheckCurDelta + deltaTime

		if self._refreshCheckCurDelta >= self._refreshCheckMaxDelta then
			self._refreshCheckCurDelta = 0

			local pos = self.camera:getScreenCenterWorldPosition()
			local centerGridId = DomAdvPathFindingDataModel.instance:pos2Id(pos.x, pos.y)
			local centerAreaId = DomAdvPathFindingDataModel.instance:getAreaId(centerGridId)

			_ViewGridId = centerGridId

			if centerAreaId ~= self._oldCenterAreaId then
				local adjacentAreaIds = DomAdvPathFindingDataModel.instance:getAdjacentAreaIds(centerAreaId)

				for _, areaId in ipairs(adjacentAreaIds) do
					if not self._refreshAreaIdDic[areaId] then
						self._refreshAreaIdDic[areaId] = true
						self._refreshAreaIdCount = self._refreshAreaIdCount + 1

						local gridIds = DomAdvPathFindingDataModel.instance:getGridIds(areaId)

						for _, gridId in ipairs(gridIds) do
							self:addGridIdToReqList(gridId)
						end
					end
				end

				if self._IsAdvTestMode_Eye then
					local oldAdjacentAreaIds = DomAdvPathFindingDataModel.instance:getAdjacentAreaIds(self._oldCenterAreaId)

					for _, areaId in ipairs(oldAdjacentAreaIds) do
						local gridIds = DomAdvPathFindingDataModel.instance:getGridIds(areaId)

						for _, gridId in ipairs(gridIds) do
							local unit = self:getUnitByGridId(gridId)

							if unit then
								unit:showTag(false)
							end
						end
					end

					for _, areaId in ipairs(adjacentAreaIds) do
						local gridIds = DomAdvPathFindingDataModel.instance:getGridIds(areaId)

						for _, gridId in ipairs(gridIds) do
							local unit = self:getUnitByGridId(gridId)

							if unit then
								unit:showTag(true)
							end
						end
					end
				end

				self._oldCenterAreaId = centerAreaId
			end
		end
	end
end

function DomainAdventureScene:lateUpdate()
	return
end

function DomainAdventureScene:changeFocusToGrid(blockId, isNeedAnim)
	local unit = self:getUnitByGridId(blockId)

	if unit then
		_ViewGridId = blockId

		local x, y, z = unit.transform:getPos()
		local yOffset = self.camera:getPosFocusYOffset()

		self.camera:setPosFocus(x, y - yOffset)

		if isNeedAnim then
			unit:playFocusFlashAnimation()
		end
	end
end

function DomainAdventureScene:isBreakPathFindingWhileHitAirwall()
	return false
end

function DomainAdventureScene:isNeedMergePath()
	return false
end

function DomainAdventureScene:_onElementCreate(elementId, path, quality, pos)
	DomainAdventureScene.super._onElementCreate(self, elementId, path, quality, pos)

	local row, col = self:getCellRowAndColIndexByElementId(elementId)
	local layer = DomAdvPathFindingDataModel.instance:getLayerNumByElementId(elementId)
	local fatherLayer = DomAdvEnum.Layer_GroundDown

	if layer <= fatherLayer then
		local unit = self.unitFactory:getUnitByLayer(layer, elementId)

		if not unit then
			unit = self.unitFactory:createUnitByLayer(layer, elementId, row, col)

			unit:onUnitCreated({
				posX = pos.x,
				posY = pos.y,
				posZ = pos.z
			})
		end
	else
		local gridId = DomAdvPathFindingDataModel.instance:grid2Id(row, col)
		local fatherElementId = DomAdvPathFindingDataModel.instance:getElementIdByGridId(fatherLayer, gridId)
		local fatherUnit = self.unitFactory:getUnitByLayer(fatherLayer, fatherElementId)

		if not fatherUnit then
			fatherUnit = self.unitFactory:createUnitByLayer(fatherLayer, fatherElementId, row, col)

			fatherUnit:onUnitCreated({
				posX = pos.x,
				posY = pos.y,
				posZ = pos.z
			})
		end

		if fatherUnit then
			local childUnit = self.unitFactory:getUnitByLayer(layer, elementId)

			if not childUnit then
				local sortGroup = DomAdvEnum.SortGroupsInLayer[layer]

				childUnit = self.unitFactory:createUnitByLayer(layer, elementId, row, col)

				local sort = fatherUnit:getSortingOrderInGroup(sortGroup)

				childUnit:onUnitCreated({
					sortingOrder = sort
				})
				fatherUnit:addObjToSortGroupRoot(childUnit.go, sortGroup)
			end
		end
	end
end

function DomainAdventureScene:_onElementVisible(elementId, go, toSceneId, visible)
	local dic = {}

	for k, tag in pairs(DomAdvEnum.TagsInLayer) do
		if not dic[tag] and tag ~= UnitTag.SceneElement then
			dic[tag] = true

			local unit = self.unitFactory:getUnit(tag, elementId)

			if unit then
				if visible then
					if unit.onUnitVisible then
						unit:onUnitVisible(go)
					end
				elseif unit.onUnitInVisible then
					unit:onUnitInVisible()
				end
			end
		end
	end

	DomainAdventureScene.super._onElementVisible(self, elementId, go, toSceneId, visible)
end

function DomainAdventureScene:getUnitByGridId(gridId)
	return (self:_getUnitByLayerGridId(DomAdvEnum.Layer_GroundDown, gridId))
end

function DomainAdventureScene:_getUnitByLayerGridId(layer, gridId)
	local elementId = DomAdvPathFindingDataModel.instance:getElementIdByGridId(layer, gridId)

	return (self.unitFactory:getUnit(DomAdvEnum.TagsInLayer[layer], elementId))
end

function DomainAdventureScene:getElementIdByGridId(layer, gridId)
	return DomAdvPathFindingDataModel.instance:getElementIdByGridId(layer, gridId)
end

function DomainAdventureScene:getGridIdByElementId(elementId)
	return DomAdvPathFindingDataModel.instance:getGridIdByElementId(elementId)
end

function DomainAdventureScene:getCellRowAndColIndexByElementId(elementId)
	return DomAdvPathFindingDataModel.instance:getCellRowAndColIndexByElementId(elementId)
end

function DomainAdventureScene:getLayerNumByElementId(elementId)
	return DomAdvPathFindingDataModel.instance:getLayerNumByElementId(elementId)
end

function DomainAdventureScene:getGridUnitOffsetY(gridX, gridY)
	local gridId = DomAdvPathFindingDataModel.instance:grid2Id(gridX, gridY)
	local unit = self:getUnitByGridId(gridId)

	return (unit or nil) and unit:getPositionOffsetY()
end

function DomainAdventureScene:getPosWithOffsetY(gridX, gridY)
	local posX, posY = DomAdvPathFindingDataModel.instance:grid2Pos(gridX, gridY)
	local offsetY = self:getGridUnitOffsetY(gridX, gridY)

	return posX, posY + offsetY
end

function DomainAdventureScene:getCellRowAndColIndexByPosition(x, y)
	return DomAdvPathFindingDataModel.instance:pos2Grid(x, y)
end

function DomainAdventureScene:isPositionReachable(unit, x, y)
	return true
end

function DomainAdventureScene:getNearestTransmitGroupPos(startX, startY, endX, endY)
	return
end

function DomainAdventureScene:findRandomNotBerrierAround(sceneunit, x, y, checkAirWaill)
	return {}
end

function DomainAdventureScene:visibleMainPlayer(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end
end

function DomainAdventureScene:visibleObjects(visible)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer:setVisible(false)
	end

	if self.walkEff then
		self.walkEff:setVisible(false)
	end

	self._otherPlayerVisible = false

	self.unitFactory:showUnits(visible)
end

function DomainAdventureScene:createMainPlayerPet()
	return
end

function DomainAdventureScene:setNeedNotifyMapDataUpdate()
	self._isNeedNotifyMapDataUpdate = true
end

function DomainAdventureScene:setNeedNeedMapUIUpdate()
	self._isNeedMapUIUpdate = true
end

function DomainAdventureScene:setReadyFocusToGrid(gridId, isNeedAnim)
	self._readyFocusToGridId = checknumber(gridId)
	self._isNeedAnimInFocus = checkbool(isNeedAnim)
end

function DomainAdventureScene:_onUpdateMapData()
	print(string.format("===??? DomainAdventureScene:_onUpdateMapData()"))
	self.mapInfoMgr:onUpdate()
	self:setNeedNotifyMapDataUpdate()
end

function DomainAdventureScene:_onUpdateMapUI()
	print(string.format("===??? DomainAdventureScene:_onUpdateMapUI()"))

	local count = DomAdvPathFindingDataModel.instance:getGridCount()

	for gridId = 0, count do
		local unit = self:getUnitByGridId(gridId)

		if unit then
			unit:onUpdateGridUI()
		end
	end
end

function DomainAdventureScene:getGridState(gridId)
	return self.mapInfoMgr:getGridState(gridId)
end

function DomainAdventureScene:getDsipatchInfo(petId)
	return self.mapInfoMgr:getDsipatchInfo(petId)
end

function DomainAdventureScene:getAllDsipatchInfo()
	return self.mapInfoMgr:getAllDsipatchInfo()
end

function DomainAdventureScene:getGridIdsByType(eventType)
	return self.mapInfoMgr:getGridIdsByType(eventType)
end

function DomainAdventureScene:getShowType()
	return _ShowType
end

function DomainAdventureScene:setShowType(value)
	_ShowType = value
end

function DomainAdventureScene:getTryStartEventFightResultAndTips(activityId, blockId, mode)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and mode == DomAdvEnum.EventFightMode_Sweet and not self._domAdvMo:isCanSweetInFight(blockId) then
		result = GameEnum.ResultCode.Error
		tips = "请先通关后再尝试扫荡"
	end

	if result == GameEnum.ResultCode.Success then
		result, tips = self:getTryStartGridEventResultAndTips(activityId, blockId)
	end

	return result, tips
end

function DomainAdventureScene:getTryStartEventBossResultAndTips(gridId, mode)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not DomainAdventureController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开放时间范围内"
	end

	if result == GameEnum.ResultCode.Success and not self._domAdvMo:isBossUnlock(gridId) then
		result = GameEnum.ResultCode.Error
		tips = string.format("需要占领%s个地块之后解锁BOSS", self._domAdvMo:getMaxBossUnlockCount(gridId))
	end

	if result == GameEnum.ResultCode.Success and mode == DomAdvEnum.BossFightMode_Normal and not self._domAdvMo:isBossEnoughTimes(gridId) then
		result = GameEnum.ResultCode.Error
		tips = "剩余挑战次数不足"
	end

	return result, tips
end

function DomainAdventureScene:getTryStartGridEventResultAndTips(activityId, blockId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local eventType = DomainAdventureConfig.instance:getEventType(activityId, blockId)

	if result == GameEnum.ResultCode.Success and not DomainAdventureController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开放时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local gridState = self:getGridState(blockId)

		if gridState:isOccupied() and eventType ~= DomAdvEnum.EventType_Game then
			result = GameEnum.ResultCode.NotUnlockCond
			tips = "该地块已被占领"
		elseif gridState:isSealFatherOcc() == false then
			result = GameEnum.ResultCode.NotUnlockCond
			tips = "该片区域未解锁"
		elseif gridState:isRelFatherOcc() == false then
			result = GameEnum.ResultCode.NotUnlockCond
			tips = "对应神域强袭未打败"
		elseif gridState:isAdjacentUnlock() == false then
			result = GameEnum.ResultCode.NotUnlockCond
			tips = "请占领相邻地块后再试"
		end
	end

	if result == GameEnum.ResultCode.Success and eventType ~= DomAdvEnum.EventType_SolveForm then
		local cur = self._domAdvMo:getCurStrength()
		local cost = DomainAdventureConfig.instance:getCostStrength(activityId, blockId)

		if cur < cost then
			result = GameEnum.ResultCode.NoEnergy

			local costItem = DomainAdventureConfig.instance:getCostItem(activityId)
			local matName = MaterialMgr.getMaterialsNameByCfg(costItem)

			tips = string.format("%s不足", matName)
		end
	end

	return result, tips
end

function DomainAdventureScene:_doClickCallBack(gridId)
	if self._curClickGridId == gridId then
		local state = self:getGridState(gridId)

		DomainAdventureController.instance:triggerGridEvent(self._activityId, gridId, state)

		self._curClickGridId = nil
	end
end

return DomainAdventureScene
