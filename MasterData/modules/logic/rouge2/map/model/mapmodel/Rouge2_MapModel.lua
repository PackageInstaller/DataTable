-- chunkname: @modules/logic/rouge2/map/model/mapmodel/Rouge2_MapModel.lua

module("modules.logic.rouge2.map.model.mapmodel.Rouge2_MapModel", package.seeall)

local Rouge2_MapModel = class("Rouge2_MapModel")

function Rouge2_MapModel:init(type)
	self.mapType = type
end

function Rouge2_MapModel:getMapType()
	return self.mapType
end

function Rouge2_MapModel:setMapSize(size)
	self.mapSize = size
end

function Rouge2_MapModel:getMapSize()
	return self.mapSize
end

function Rouge2_MapModel:getMapEpisodeIntervalX()
	return self.mapEpisodeIntervalX
end

function Rouge2_MapModel:setCameraSize(cameraSize)
	self.cameraSize = cameraSize
end

function Rouge2_MapModel:setMapXRange(min, max)
	self.minX = min
	self.maxX = max
end

function Rouge2_MapModel:getCameraSize()
	return self.cameraSize
end

function Rouge2_MapModel:setMapPosX(posX)
	if posX < self.minX then
		posX = self.minX
	end

	if posX > self.maxX then
		posX = self.maxX
	end

	if self.mapPosX == posX then
		return
	end

	self.mapPosX = posX

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onMapPosChange, self.mapPosX)
end

function Rouge2_MapModel:getMapPosX()
	return self.mapPosX
end

function Rouge2_MapModel:setFocusScreenPosX(screenPosX)
	self.focusScreenPosX = screenPosX
end

function Rouge2_MapModel:getFocusScreenPosX()
	return self.focusScreenPosX
end

function Rouge2_MapModel:getLayerId()
	return self.mapModel and self.mapModel.layerId
end

function Rouge2_MapModel:getLayerCo()
	return self.mapModel and self.mapModel.layerCo
end

function Rouge2_MapModel:isNormalLayer()
	return self.mapType == Rouge2_MapEnum.MapType.Normal
end

function Rouge2_MapModel:isMiddle()
	return self.mapType == Rouge2_MapEnum.MapType.Middle
end

function Rouge2_MapModel:isPathSelect()
	return self.mapType == Rouge2_MapEnum.MapType.PathSelect
end

function Rouge2_MapModel:getMiddleLayerId()
	return self.mapModel and self.mapModel.middleLayerId
end

function Rouge2_MapModel:getMiddleLayerCo()
	return self.mapModel and self.mapModel.middleCo
end

function Rouge2_MapModel:getPathSelectCo()
	return self.mapModel and self.mapModel.pathSelectCo
end

function Rouge2_MapModel:setWaitLeaveMiddleLayerReply(waiting)
	self.waitMiddleLayerReply = waiting
end

function Rouge2_MapModel:updateSimpleMapInfo(info)
	if self.waitMiddleLayerReply then
		return
	end

	if not self:_isSameMap(info) then
		return
	end

	if self.mapType == Rouge2_MapEnum.MapType.Middle or self.mapType == Rouge2_MapEnum.MapType.PathSelect then
		self.mapModel:updateSimpleMapInfo(info.middleLayerInfo)
	else
		self.mapModel:updateSimpleMapInfo(info.layerInfo)
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onUpdateMapInfo)
end

function Rouge2_MapModel:updateMapInfo(info)
	if self.waitMiddleLayerReply then
		return
	end

	if self.inited then
		if self:_isSameMap(info) then
			self:_updateMapInfo(info)
		else
			self:_changeMapInfo(info)
		end
	else
		self:_initMapInfo(info)
	end
end

function Rouge2_MapModel:_isSameMap(info)
	if not self.inited then
		return false
	end

	if self.mapType ~= self:_getTypeByInfo(info) then
		return false
	end

	if self.mapType == Rouge2_MapEnum.MapType.Normal then
		return self.mapModel.layerId == info.layerInfo.layerId
	end

	local layerInfo = info.middleLayerInfo

	return self.mapModel.layerId == layerInfo.layerId and self.mapModel.middleLayerId == layerInfo.middleLayerId
end

function Rouge2_MapModel:_getTypeByInfo(info)
	if info.mapType ~= Rouge2_MapEnum.MapType.Middle then
		return info.mapType
	end

	local middleLayerInfo = info.middleLayerInfo

	if middleLayerInfo.positionIndex == Rouge2_MapEnum.PathSelectIndex then
		return Rouge2_MapEnum.MapType.PathSelect
	end

	return Rouge2_MapEnum.MapType.Middle
end

function Rouge2_MapModel:_initMapInfo(info)
	self.inited = true
	self.mapType = self:_getTypeByInfo(info)

	local cls = Rouge2_MapEnum.MapType2ModelCls[self.mapType]

	self.mapModel = cls.New()

	if self.mapType == Rouge2_MapEnum.MapType.Middle or self.mapType == Rouge2_MapEnum.MapType.PathSelect then
		self.mapModel:initMap(info.middleLayerInfo)
	else
		self.mapModel:initMap(info.layerInfo)
	end

	self:setMapEntrustInfo(info)
	self:initMapInteractive(info)
	self:setMapWeatherInfo(info)
	self:setGameRecordInfo(info)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onInitMapInfoDone)
end

function Rouge2_MapModel:_updateMapInfo(info)
	if self.mapType == Rouge2_MapEnum.MapType.Middle or self.mapType == Rouge2_MapEnum.MapType.PathSelect then
		self.mapModel:updateMapInfo(info.middleLayerInfo)
	else
		self.mapModel:updateMapInfo(info.layerInfo)
	end

	self:setMapEntrustInfo(info)
	self:setMapCurInteractive(info)
	self:setMapWeatherInfo(info)
	self:setGameRecordInfo(info)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onUpdateMapInfo)
end

function Rouge2_MapModel:_changeMapInfo(info)
	local nextType = self:_getTypeByInfo(info)
	local changeMapEnum = Rouge2_MapHelper.getChangeMapEnum(self.mapType, nextType)

	if changeMapEnum == Rouge2_MapEnum.ChangeMapEnum.NormalToMiddle then
		self._newInfo = info

		self:setMapCurInteractive(info)

		if self:getMapState() == Rouge2_MapEnum.MapState.Normal then
			Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onBeforeActorMoveToEnd)
		end

		return
	end

	self:_initMapInfo(info)
	self:dispatchChangeMapEvent()
end

function Rouge2_MapModel:updateToNewMapInfo()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onBeforeNormalToMiddle)
	self:setMapState(Rouge2_MapEnum.MapState.SwitchMapAnim)

	if self.mapModel then
		self.mapModel:clear()
	end

	local info = self._newInfo

	self._newInfo = nil

	self:_initMapInfo(info)
	self:dispatchChangeMapEvent()
end

function Rouge2_MapModel:dispatchChangeMapEvent()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onBeforeChangeMapInfo)
	TaskDispatcher.runDelay(self._dispatchChangeMapEvent, self, Rouge2_MapEnum.WaitSwitchMapAnim)
end

function Rouge2_MapModel:_dispatchChangeMapEvent()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onChangeMapInfo)
end

function Rouge2_MapModel:needPlayMoveToEndAnim()
	return self._newInfo ~= nil
end

function Rouge2_MapModel:initMapInteractive(info)
	if not info:HasField("curInteractiveIndex") then
		self:clearInteractive()

		return
	end

	self.interactiveJson = cjson.decode(info.interactiveJson)

	if self:checkDropIsEmpty(info.curInteractive) then
		logError(string.format("触发掉落，但是掉落列表是空! interactive : %s, json : %s", info.curInteractive, info.interactiveJson))
		self:clearInteractive()

		return
	end

	self.curInteractive = info.curInteractive
	self.curInteractType = string.splitToNumber(self.curInteractive, "#")[1]
	self.curInteractiveIndex = info.curInteractiveIndex
end

function Rouge2_MapModel:setMapCurInteractive(info)
	if not info:HasField("curInteractiveIndex") then
		self:clearInteractive()

		return
	end

	self.interactiveJson = cjson.decode(info.interactiveJson)

	if self:checkDropIsEmpty(info.curInteractive) then
		logError(string.format("触发掉落，但是掉落列表是空! interactive : %s, json : %s", info.curInteractive, info.interactiveJson))
		self:clearInteractive()

		return
	end

	if self.curInteractiveIndex == info.curInteractiveIndex and self.curInteractive == info.curInteractive then
		return
	end

	self.curInteractive = info.curInteractive
	self.curInteractType = string.splitToNumber(self.curInteractive, "#")[1]
	self.curInteractiveIndex = info.curInteractiveIndex

	if self.blockTrigger then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.triggerInteract)
end

function Rouge2_MapModel:blockTriggerInteractive(block)
	self.blockTrigger = block
end

function Rouge2_MapModel:isBlockTriggerInteractive()
	return self.blockTrigger
end

function Rouge2_MapModel:setMapWeatherInfo(info)
	if not info:HasField("weather") then
		self.layerWeatherMo = nil

		return
	end

	self.layerWeatherMo = self.layerWeatherMo or Rouge2_LayerWeatherInfoMO.New()

	self.layerWeatherMo:init(info.weather)
end

function Rouge2_MapModel:getCurMapWeatherInfo()
	return self.layerWeatherMo
end

function Rouge2_MapModel:getNextLayerWeatherInfoList(layerId)
	if self.mapModel and self:isPathSelect() then
		return self.mapModel:getNextLayerWeatherInfoList(layerId)
	end
end

function Rouge2_MapModel:getNextLayerWeatherInfoMap(layerId)
	if self.mapModel and self:isPathSelect() then
		return self.mapModel:getNextLayerWeatherInfoMap(layerId)
	end
end

function Rouge2_MapModel:setGameRecordInfo(info)
	if not info:HasField("gameRecordInfo") then
		self.gameRecordMo = nil

		return
	end

	self.gameRecordMo = self.gameRecordMo or Rouge2_GameMapRecordInfoMO.New()

	self.gameRecordMo:init(info.gameRecordInfo)
end

function Rouge2_MapModel:getGameRecordInfo()
	return self.gameRecordMo
end

function Rouge2_MapModel:clearInteractive()
	logNormal("清理交互数据")

	self.curInteractiveIndex = nil
	self.curInteractive = nil
	self.interactiveJson = nil

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onClearInteract)
end

function Rouge2_MapModel:checkDropIsEmpty(curInteractive)
	local interactArr = string.splitToNumber(curInteractive, "#")
	local interactType = interactArr[1]

	if interactType == Rouge2_MapEnum.InteractType.SelectDrop then
		local dropCollectList = self.interactiveJson.dropCollectList

		return not dropCollectList or #dropCollectList < 1
	end

	return false
end

function Rouge2_MapModel:setMapEntrustInfo(info)
	local curEntrustList, curEntrustMap = GameUtil.rpcInfosToListAndMap(info.rouge2Entrust, Rouge2_EntrustInfoMO, "_id")
	local newEntrustIdList, updateEntrustIdList = self:findDiffEntrustIds(self.entrustMoList, curEntrustList)

	if newEntrustIdList then
		if not #newEntrustIdList then
			local newEntrustIdNum = 0

			if updateEntrustIdList then
				if not #updateEntrustIdList then
					if newEntrustIdNum > 0 then
						Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onAcceptEntrust, newEntrustIdList)
					end

					self.entrustMoMap = curEntrustMap
					self.entrustMoList = curEntrustList

					Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onEntrustChange)
				end
			end
		end
	end
end

function Rouge2_MapModel:findDiffEntrustIds(oldEntrustMap, newEntrustMap)
	if not newEntrustMap then
		return
	end

	local newAcceptIdList = {}
	local updateAcceptIdList = {}

	for newEntrustId, newEntrustMo in pairs(newEntrustMap) do
		local oldEntrustMo = oldEntrustMap and oldEntrustMap[newEntrustId]

		if not oldEntrustMo then
			table.insert(newAcceptIdList, newEntrustId)
		elseif oldEntrustMo:getProgress() ~= newEntrustMo:getProgress() then
			table.insert(updateAcceptIdList, newEntrustId)
		end
	end

	return newAcceptIdList, updateAcceptIdList
end

function Rouge2_MapModel:updateEntrustInfo(entrustInfo)
	if not entrustInfo or not entrustInfo.id or entrustInfo.id == 0 then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onEntrustChange)

		return
	end

	local entrustId = entrustInfo.id

	if self.entrustMoMap then
		local entrustMo = self.entrustMoMap[entrustId]

		if not self.entrustMoMap then
			entrustMo = Rouge2_EntrustInfoMO.New()
			self.entrustMoMap = self.entrustMoMap or {}
			self.entrustMoList = self.entrustMoList or {}
			self.entrustMoMap[entrustId] = self.entrustMoMap

			table.insert(self.entrustMoList, self.entrustMoMap)
		end

		self.entrustMoMap:init(entrustInfo)
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onEntrustChange)
	end
end

function Rouge2_MapModel:clearEntrustInfo()
	self.entrustMoMap = nil
	self.entrustMoList = nil
end

function Rouge2_MapModel:getEntrustList()
	return self.entrustMoList
end

function Rouge2_MapModel:getDoingEntrustNum()
	local entrustList = self:getDoingEntrustList()

	return (entrustList or nil) and (#entrustList or 0)
end

function Rouge2_MapModel:getDoingEntrustList()
	local entrustList = {}

	if self.entrustMoList then
		for _, entrustMo in ipairs(self.entrustMoList) do
			if not entrustMo:isFinish() then
				table.insert(entrustList, entrustMo)
			end
		end
	end

	return entrustList
end

function Rouge2_MapModel:getEntrustProgress(entrustId)
	if self.entrustMoMap then
		return self.entrustMoMap and self.entrustMoMap:getProgress() or 0
	end
end

function Rouge2_MapModel:isEntrustFinish(entrustId)
	if self.entrustMoMap then
		return self.entrustMoMap and self.entrustMoMap:isFinish()
	end
end

function Rouge2_MapModel:getEntrust(entrustId)
	if self.entrustMoMap then
		return self.entrustMoMap
	end
end

function Rouge2_MapModel:getEpisodeList()
	return self.mapModel and self.mapModel:getEpisodeList()
end

function Rouge2_MapModel:getNode(nodeId)
	return self.mapModel and self.mapModel:getNode(nodeId)
end

function Rouge2_MapModel:getEndNodeId()
	return self.mapModel and self.mapModel:getEndNodeId()
end

function Rouge2_MapModel:getCurEpisodeId()
	return self.mapModel and self.mapModel:getCurEpisodeId()
end

function Rouge2_MapModel:getCurNode()
	return self.mapModel and self.mapModel.getCurNode and self.mapModel:getCurNode()
end

function Rouge2_MapModel:getCurEvent()
	if not self.mapModel then
		return
	end

	local curNode = self:getCurNode()

	return curNode and curNode:getEventCo()
end

function Rouge2_MapModel:getCurPieceMo()
	return self.mapModel.getCurPieceMo and self.mapModel:getCurPieceMo()
end

function Rouge2_MapModel:getNodeDict()
	return self.mapModel and self.mapModel:getNodeDict()
end

function Rouge2_MapModel:getCurInteractType()
	return self.curInteractType
end

function Rouge2_MapModel:getCurInteractive()
	return self.curInteractive
end

function Rouge2_MapModel:getCurInteractiveJson()
	return self.interactiveJson
end

function Rouge2_MapModel:isInteractiving()
	return self.curInteractive ~= nil
end

function Rouge2_MapModel:getPieceList()
	return self.mapModel and self.mapModel:getPieceList()
end

function Rouge2_MapModel:getPieceMo(pieceIndex)
	return self.mapModel and self.mapModel:getPieceMo(pieceIndex)
end

function Rouge2_MapModel:getMiddleLayerPosByIndex(index)
	return self.mapModel and self.mapModel:getMiddleLayerPosByIndex(index)
end

function Rouge2_MapModel:getPathIndex(pointIndex)
	if not self.mapModel then
		return
	end

	local pos = self:getMiddleLayerPosByIndex(pointIndex)

	return pos.z
end

function Rouge2_MapModel:getMiddleLayerPathPos(index)
	return self.mapModel and self.mapModel:getMiddleLayerPathPos(index)
end

function Rouge2_MapModel:getMiddleLayerPathPosByPathIndex(pathIndex)
	return self.mapModel and self.mapModel:getMiddleLayerPathPosByPathIndex(pathIndex)
end

function Rouge2_MapModel:getMiddleLayerLeavePos()
	if not self.mapModel then
		return
	end

	return self.mapModel:getMiddleLayerLeavePos()
end

function Rouge2_MapModel:hadLeavePos()
	if not self.mapModel then
		return
	end

	return self.mapModel:hadLeavePos()
end

function Rouge2_MapModel:getMiddleLayerLeavePathIndex()
	return self.mapModel and self.mapModel:getMiddleLayerLeavePathIndex()
end

function Rouge2_MapModel:getCurPosIndex()
	return self.mapModel and self.mapModel:getCurPosIndex()
end

function Rouge2_MapModel:getMapName()
	if not self.mapModel then
		return
	end

	if self.mapType == Rouge2_MapEnum.MapType.Normal then
		return self.mapModel.layerCo.name
	elseif self.mapType == Rouge2_MapEnum.MapType.Middle then
		return self.mapModel.middleCo.name
	elseif self.mapType == Rouge2_MapEnum.MapType.PathSelect then
		return self.mapModel.pathSelectCo.name
	end
end

function Rouge2_MapModel:getNextLayerList()
	return self.mapModel and self.mapModel:getNextLayerList()
end

function Rouge2_MapModel:setEndId(endId)
	self.endId = endId
end

function Rouge2_MapModel:getEndId()
	if self.endId then
		return self.endId
	end

	return Rouge2_MapHelper.getEndId()
end

function Rouge2_MapModel:updateSelectLayerId(layerId)
	if not self.mapModel then
		return
	end

	self.mapModel:updateSelectLayerId(layerId)
end

function Rouge2_MapModel:getSelectLayerId()
	return self.mapModel and self.mapModel:getSelectLayerId()
end

function Rouge2_MapModel:clear()
	self.inited = nil
	self.mapType = nil
	self.mapEpisodeIntervalX = nil
	self.mapSize = nil
	self.cameraSize = nil
	self.minX = nil
	self.maxX = nil
	self.mapPosX = nil
	self.focusScreenPosX = nil
	self._newInfo = nil
	self.interactiveJson = nil
	self.curInteractive = nil
	self.curInteractType = nil
	self.curInteractiveIndex = nil
	self.entrustMoMap = nil
	self.entrustMoList = nil
	self.endId = nil
	self.loading = nil
	self.curChoiceId = nil
	self.playingDialogue = nil
	self.state = nil
	self.mapState = nil
	self.finalMap = nil
	self.firstEnterMapFlag = nil
	self.layerWeatherMo = nil
	self.blockTrigger = false

	TaskDispatcher.cancelTask(self._dispatchChangeMapEvent, self)

	if self.mapModel then
		self.mapModel:clear()

		self.mapModel = nil

		return
	end

	if self.preMapModel then
		self.preMapModel:clear()

		self.preMapModel = nil
	end
end

function Rouge2_MapModel:setLoadingMap(loading)
	self.loading = loading
end

function Rouge2_MapModel:checkIsLoading()
	return self.loading
end

function Rouge2_MapModel:recordCurChoiceEventSelectId(choiceId, choiceIndex)
	self.curChoiceId = choiceId
	self.curChoiceIndex = choiceIndex
end

function Rouge2_MapModel:getCurChoiceId()
	return self.curChoiceId, self.curChoiceIndex
end

function Rouge2_MapModel:setPlayingDialogue(playing)
	self.playingDialogue = playing
end

function Rouge2_MapModel:isPlayingDialogue()
	return self.playingDialogue
end

function Rouge2_MapModel:setChoiceViewState(state)
	self.state = state
end

function Rouge2_MapModel:getChoiceViewState()
	return self.state
end

function Rouge2_MapModel:setMapState(state)
	self.mapState = state
end

function Rouge2_MapModel:getMapState()
	return self.mapState or Rouge2_MapEnum.MapState.Empty
end

function Rouge2_MapModel:setFinalMapInfo(info)
	self.finalMap = info
end

function Rouge2_MapModel:getFinalMapInfo()
	return self.finalMap
end

function Rouge2_MapModel:setFirstEnterMap(flag)
	self.firstEnterMapFlag = flag
end

function Rouge2_MapModel:getFirstEnterMapFlag()
	return self.firstEnterMapFlag
end

function Rouge2_MapModel:setManualCloseHeroGroupView(isManual)
	self.closeHeroGroupView = isManual
end

function Rouge2_MapModel:checkManualCloseHeroGroupView()
	return self.closeHeroGroupView
end

Rouge2_MapModel.instance = Rouge2_MapModel.New()

return Rouge2_MapModel
