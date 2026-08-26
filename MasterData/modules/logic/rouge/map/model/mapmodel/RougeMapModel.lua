-- chunkname: @modules/logic/rouge/map/model/mapmodel/RougeMapModel.lua

module("modules.logic.rouge.map.model.mapmodel.RougeMapModel", package.seeall)

local RougeMapModel = class("RougeMapModel")

function RougeMapModel:init(type)
	self.mapType = type
end

function RougeMapModel:getMapType()
	return self.mapType
end

function RougeMapModel:setMapSize(size)
	self.mapSize = size

	self:calculateMapEpisodeIntervalX()
end

function RougeMapModel:getMapSize()
	return self.mapSize
end

function RougeMapModel:calculateMapEpisodeIntervalX()
	if not self:isNormalLayer() then
		self.mapEpisodeIntervalX = 0

		return
	end

	self.mapStartOffsetX = RougeMapEnum.MapStartOffsetX

	local x = self.mapSize.x - RougeMapEnum.MapStartOffsetX - RougeMapEnum.MapEndOffsetX
	local episodeList = self:getEpisodeList()
	local len = #episodeList - 1
	local intervalX = x / len

	if intervalX > RougeMapEnum.MaxMapEpisodeIntervalX then
		intervalX = RougeMapEnum.MaxMapEpisodeIntervalX

		local resultMapWidth = RougeMapEnum.MaxMapEpisodeIntervalX * len + RougeMapEnum.MapStartOffsetX + RougeMapEnum.MapEndOffsetX

		self.mapStartOffsetX = (self.mapSize.x - resultMapWidth) / 2 + RougeMapEnum.MapStartOffsetX
		self.mapSize.x = resultMapWidth
	end

	self.mapEpisodeIntervalX = RougeMapHelper.retain2decimals(intervalX)
end

function RougeMapModel:getMapStartOffsetX()
	return self.mapStartOffsetX or RougeMapEnum.MapStartOffsetX
end

function RougeMapModel:getMapEpisodeIntervalX()
	return self.mapEpisodeIntervalX
end

function RougeMapModel:setCameraSize(cameraSize)
	self.cameraSize = cameraSize
end

function RougeMapModel:setMapXRange(min, max)
	self.minX = min
	self.maxX = max
end

function RougeMapModel:getCameraSize()
	return self.cameraSize
end

function RougeMapModel:setMapPosX(posX)
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

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMapPosChange, self.mapPosX)
end

function RougeMapModel:getMapPosX()
	return self.mapPosX
end

function RougeMapModel:setFocusScreenPosX(screenPosX)
	self.focusScreenPosX = screenPosX
end

function RougeMapModel:getFocusScreenPosX()
	return self.focusScreenPosX
end

function RougeMapModel:getLayerId()
	return self.mapModel and self.mapModel.layerId
end

function RougeMapModel:getLayerCo()
	return self.mapModel and self.mapModel.layerCo
end

function RougeMapModel:isNormalLayer()
	return self.mapType == RougeMapEnum.MapType.Normal
end

function RougeMapModel:isMiddle()
	return self.mapType == RougeMapEnum.MapType.Middle
end

function RougeMapModel:isPathSelect()
	return self.mapType == RougeMapEnum.MapType.PathSelect
end

function RougeMapModel:getMiddleLayerId()
	return self.mapModel and self.mapModel.middleLayerId
end

function RougeMapModel:getMiddleLayerCo()
	return self.mapModel and self.mapModel.middleCo
end

function RougeMapModel:getPathSelectCo()
	return self.mapModel and self.mapModel.pathSelectCo
end

function RougeMapModel:setWaitLeaveMiddleLayerReply(waiting)
	self.waitMiddleLayerReply = waiting
end

function RougeMapModel:updateSimpleMapInfo(info)
	if self.waitMiddleLayerReply then
		return
	end

	if not self:_isSameMap(info) then
		return
	end

	if self.mapType == RougeMapEnum.MapType.Middle or self.mapType == RougeMapEnum.MapType.PathSelect then
		self.mapModel:updateSimpleMapInfo(info.middleLayerInfo)
	else
		self.mapModel:updateSimpleMapInfo(info.layerInfo)
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onUpdateMapInfo)
end

function RougeMapModel:updateMapInfo(info)
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

function RougeMapModel:_isSameMap(info)
	if not self.inited then
		return false
	end

	if self.mapType ~= self:_getTypeByInfo(info) then
		return false
	end

	if self.mapType == RougeMapEnum.MapType.Normal then
		return self.mapModel.layerId == info.layerInfo.layerId
	end

	local layerInfo = info.middleLayerInfo

	return self.mapModel.layerId == layerInfo.layerId and self.mapModel.middleLayerId == layerInfo.middleLayerId
end

function RougeMapModel:_getTypeByInfo(info)
	if info.mapType ~= RougeMapEnum.MapType.Middle then
		return info.mapType
	end

	local middleLayerInfo = info.middleLayerInfo

	if middleLayerInfo.positionIndex == RougeMapEnum.PathSelectIndex then
		return RougeMapEnum.MapType.PathSelect
	end

	return RougeMapEnum.MapType.Middle
end

function RougeMapModel:_initMapInfo(info)
	self.inited = true
	self.mapType = self:_getTypeByInfo(info)

	local cls = RougeMapEnum.MapType2ModelCls[self.mapType]

	self.mapModel = cls.New()

	if self.mapType == RougeMapEnum.MapType.Middle or self.mapType == RougeMapEnum.MapType.PathSelect then
		self.mapModel:initMap(info.middleLayerInfo)
	else
		self.mapModel:initMap(info.layerInfo)
	end

	self:setMapEntrustInfo(info)
	self:initMapInteractive(info)
	self:setMapSkillInfo(info)
	self:setDLCInfo_103(info)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onInitMapInfoDone)
end

function RougeMapModel:_updateMapInfo(info)
	if self.mapType == RougeMapEnum.MapType.Middle or self.mapType == RougeMapEnum.MapType.PathSelect then
		self.mapModel:updateMapInfo(info.middleLayerInfo)
	else
		self.mapModel:updateMapInfo(info.layerInfo)
	end

	self:setMapEntrustInfo(info)
	self:setMapCurInteractive(info)
	self:setMapSkillInfo(info)
	self:setDLCInfo_103(info)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onUpdateMapInfo)
end

function RougeMapModel:_changeMapInfo(info)
	local nextType = self:_getTypeByInfo(info)
	local changeMapEnum = RougeMapHelper.getChangeMapEnum(self.mapType, nextType)

	if changeMapEnum == RougeMapEnum.ChangeMapEnum.NormalToMiddle then
		self._newInfo = info

		self:clearInteractive()

		if self:getMapState() == RougeMapEnum.MapState.Normal then
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeActorMoveToEnd)
		end

		return
	end

	self:_initMapInfo(info)
	self:dispatchChangeMapEvent()
end

function RougeMapModel:updateToNewMapInfo()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeNormalToMiddle)
	self:setMapState(RougeMapEnum.MapState.SwitchMapAnim)

	if self.mapModel then
		self.mapModel:clear()
	end

	local info = self._newInfo

	self._newInfo = nil

	self:_initMapInfo(info)
	self:dispatchChangeMapEvent()
end

function RougeMapModel:dispatchChangeMapEvent()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeChangeMapInfo)
	TaskDispatcher.runDelay(self._dispatchChangeMapEvent, self, RougeMapEnum.WaitSwitchMapAnim)
end

function RougeMapModel:_dispatchChangeMapEvent()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChangeMapInfo)
end

function RougeMapModel:needPlayMoveToEndAnim()
	return self._newInfo ~= nil
end

function RougeMapModel:initMapInteractive(info)
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

function RougeMapModel:setMapCurInteractive(info)
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

	if self.curInteractiveIndex == info.curInteractiveIndex then
		return
	end

	self.curInteractive = info.curInteractive
	self.curInteractType = string.splitToNumber(self.curInteractive, "#")[1]
	self.curInteractiveIndex = info.curInteractiveIndex

	RougeMapController.instance:dispatchEvent(RougeMapEvent.triggerInteract)
end

function RougeMapModel:clearInteractive()
	logNormal("清理交互数据")

	self.curInteractiveIndex = nil
	self.curInteractive = nil
	self.interactiveJson = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClearInteract)
end

function RougeMapModel:checkDropIsEmpty(curInteractive)
	local interactArr = string.splitToNumber(curInteractive, "#")
	local interactType = interactArr[1]

	if interactType == RougeMapEnum.InteractType.Drop or interactType == RougeMapEnum.InteractType.DropGroup or interactType == RougeMapEnum.InteractType.AdvanceDrop then
		local dropCollectList = self.interactiveJson.dropCollectList

		return not dropCollectList or #dropCollectList < 1
	end

	return false
end

function RougeMapModel:setMapEntrustInfo(info)
	if not info:HasField("rougeEntrust") then
		self:clearEntrustInfo()
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)

		return
	end

	local entrust = info.rougeEntrust
	local curEntrustId = entrust.id
	local curEntrustProgress = entrust.count

	if self.entrustId == curEntrustId and self.entrustProgress == curEntrustProgress then
		return
	end

	if self.entrustId ~= curEntrustId then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onAcceptEntrust)
	end

	self.entrustId = curEntrustId
	self.entrustProgress = curEntrustProgress

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)
end

function RougeMapModel:updateEntrustInfo(entrustInfo)
	if entrustInfo.id == 0 then
		self:clearEntrustInfo()
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)

		return
	end

	self.entrustId = entrustInfo.id
	self.entrustProgress = entrustInfo.count

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEntrustChange)
end

function RougeMapModel:clearEntrustInfo()
	self.entrustId = nil
	self.entrustProgress = nil
end

function RougeMapModel:getEntrustId()
	return self.entrustId
end

function RougeMapModel:getEntrustProgress()
	return self.entrustProgress
end

function RougeMapModel:setMapSkillInfo(info)
	self._mapSkills = {}
	self._mapSkillMap = {}

	for _, skillInfo in ipairs(info.mapSkill) do
		local mapSkillMo = RougeMapSkillMO.New()

		mapSkillMo:init(skillInfo)

		self._mapSkillMap[mapSkillMo.id] = mapSkillMo

		table.insert(self._mapSkills, mapSkillMo)
	end
end

function RougeMapModel:setDLCInfo_103(info)
	self.monsterRuleFreshNum = info.monsterRuleFreshNum or 0
	self.monsterRuleCanFreshNum = info.monsterRuleCanFreshNum or 0
	self.choiceCollection = info.choiceCollection or 0
	self.monsterRuleRemainCanFreshNum = self.monsterRuleCanFreshNum - self.monsterRuleFreshNum
end

function RougeMapModel:getMonsterRuleRemainCanFreshNum()
	return self.monsterRuleRemainCanFreshNum or 0
end

function RougeMapModel:getChoiceCollection()
	return self.choiceCollection
end

function RougeMapModel:clearMapSkillInfo()
	self._mapSkills = nil
end

function RougeMapModel:getMapSkillList()
	return self._mapSkills
end

function RougeMapModel:onUpdateMapSkillInfo(skillInfo)
	if self._mapSkillMap then
		if self._mapSkillMap then
			self._mapSkillMap:init(skillInfo)
		end
	end
end

function RougeMapModel:getEpisodeList()
	return self.mapModel and self.mapModel:getEpisodeList()
end

function RougeMapModel:getNode(nodeId)
	return self.mapModel and self.mapModel:getNode(nodeId)
end

function RougeMapModel:getEndNodeId()
	return self.mapModel and self.mapModel:getEndNodeId()
end

function RougeMapModel:getCurEpisodeId()
	return self.mapModel and self.mapModel:getCurEpisodeId()
end

function RougeMapModel:getCurNode()
	return self.mapModel and self.mapModel.getCurNode and self.mapModel:getCurNode()
end

function RougeMapModel:getCurEvent()
	if not self.mapModel then
		return
	end

	local curNode = self:getCurNode()

	return curNode and curNode:getEventCo()
end

function RougeMapModel:getCurPieceMo()
	return self.mapModel.getCurPieceMo and self.mapModel:getCurPieceMo()
end

function RougeMapModel:getNodeDict()
	return self.mapModel and self.mapModel:getNodeDict()
end

function RougeMapModel:getCurInteractType()
	return self.curInteractType
end

function RougeMapModel:getCurInteractive()
	return self.curInteractive
end

function RougeMapModel:getCurInteractiveJson()
	return self.interactiveJson
end

function RougeMapModel:isInteractiving()
	return self.curInteractive ~= nil
end

function RougeMapModel:getPieceList()
	return self.mapModel and self.mapModel:getPieceList()
end

function RougeMapModel:getPieceMo(pieceIndex)
	return self.mapModel and self.mapModel:getPieceMo(pieceIndex)
end

function RougeMapModel:getMiddleLayerPosByIndex(index)
	return self.mapModel and self.mapModel:getMiddleLayerPosByIndex(index)
end

function RougeMapModel:getPathIndex(pointIndex)
	if not self.mapModel then
		return
	end

	local pos = self:getMiddleLayerPosByIndex(pointIndex)

	return pos.z
end

function RougeMapModel:getMiddleLayerPathPos(index)
	return self.mapModel and self.mapModel:getMiddleLayerPathPos(index)
end

function RougeMapModel:getMiddleLayerPathPosByPathIndex(pathIndex)
	return self.mapModel and self.mapModel:getMiddleLayerPathPosByPathIndex(pathIndex)
end

function RougeMapModel:getMiddleLayerLeavePos()
	if not self.mapModel then
		return
	end

	return self.mapModel:getMiddleLayerLeavePos()
end

function RougeMapModel:hadLeavePos()
	if not self.mapModel then
		return
	end

	return self.mapModel:hadLeavePos()
end

function RougeMapModel:getMiddleLayerLeavePathIndex()
	return self.mapModel and self.mapModel:getMiddleLayerLeavePathIndex()
end

function RougeMapModel:getCurPosIndex()
	return self.mapModel and self.mapModel:getCurPosIndex()
end

function RougeMapModel:getMapName()
	if not self.mapModel then
		return
	end

	if self.mapType == RougeMapEnum.MapType.Normal then
		return self.mapModel.layerCo.name
	elseif self.mapType == RougeMapEnum.MapType.Middle then
		return self.mapModel.middleCo.name
	elseif self.mapType == RougeMapEnum.MapType.PathSelect then
		return self.mapModel.pathSelectCo.name
	end
end

function RougeMapModel:getNextLayerList()
	return self.mapModel and self.mapModel:getNextLayerList()
end

function RougeMapModel:setEndId(endId)
	self.endId = endId
end

function RougeMapModel:getEndId()
	if self.endId then
		return self.endId
	end

	return RougeMapHelper.getEndId()
end

function RougeMapModel:updateSelectLayerId(layerId)
	if not self.mapModel then
		return
	end

	self.mapModel:updateSelectLayerId(layerId)
end

function RougeMapModel:getSelectLayerId()
	return self.mapModel and self.mapModel:getSelectLayerId()
end

function RougeMapModel:getFogNodeList()
	if self.mapModel and self.mapModel.getFogNodeList then
		return self.mapModel:getFogNodeList()
	end
end

function RougeMapModel:getHoleNodeList()
	if self.mapModel and self.mapModel.getFogNodeList then
		return self.mapModel:getHoleNodeList()
	end
end

function RougeMapModel:isHoleNode(nodeId)
	if self.mapModel and self.mapModel.isHoleNode then
		return self.mapModel:isHoleNode(nodeId)
	end
end

function RougeMapModel:clear()
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
	self.entrustId = nil
	self.entrustProgress = nil
	self.endId = nil
	self.loading = nil
	self.curChoiceId = nil
	self.playingDialogue = nil
	self.state = nil
	self.mapState = nil
	self.finalMap = nil
	self.firstEnterMapFlag = nil

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

function RougeMapModel:setLoadingMap(loading)
	self.loading = loading
end

function RougeMapModel:checkIsLoading()
	return self.loading
end

function RougeMapModel:recordCurChoiceEventSelectId(choiceId)
	self.curChoiceId = choiceId
end

function RougeMapModel:getCurChoiceId()
	return self.curChoiceId
end

function RougeMapModel:setPlayingDialogue(playing)
	self.playingDialogue = playing
end

function RougeMapModel:isPlayingDialogue()
	return self.playingDialogue
end

function RougeMapModel:setChoiceViewState(state)
	self.state = state
end

function RougeMapModel:getChoiceViewState()
	return self.state
end

function RougeMapModel:setMapState(state)
	self.mapState = state
end

function RougeMapModel:getMapState()
	return self.mapState or RougeMapEnum.MapState.Empty
end

function RougeMapModel:setFinalMapInfo(info)
	self.finalMap = info
end

function RougeMapModel:getFinalMapInfo()
	return self.finalMap
end

function RougeMapModel:getExchangeMaxDisplaceNum()
	local maxExchangeCount = RougeMapConfig.instance:getRestExchangeCount()
	local curEffectDict = RougeModel.instance:getEffectDict()

	if curEffectDict then
		for _, effectCo in pairs(curEffectDict) do
			if effectCo.type == RougeMapEnum.EffectType.UpdateExchangeDisplaceNum then
				maxExchangeCount = maxExchangeCount + tonumber(effectCo.typeParam)
			end
		end
	end

	return maxExchangeCount
end

function RougeMapModel:setFirstEnterMap(flag)
	self.firstEnterMapFlag = flag
end

function RougeMapModel:getFirstEnterMapFlag()
	return self.firstEnterMapFlag
end

function RougeMapModel:getLayerChoiceInfo(layerId)
	if self.mapModel and self.mapModel.getLayerChoiceInfo then
		return self.mapModel:getLayerChoiceInfo(layerId)
	end
end

RougeMapModel.instance = RougeMapModel.New()

return RougeMapModel
