-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/model/Va3ChessGameModel.lua

module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameModel", package.seeall)

local Va3ChessGameModel = class("Va3ChessGameModel", BaseModel)

function Va3ChessGameModel:onInit()
	self._mapTileMOList = {}
end

function Va3ChessGameModel:reInit()
	return
end

function Va3ChessGameModel:release()
	self.width = nil
	self.height = nil
	self._mapTileBaseList = nil
	self._mapInteractObjs = nil
	self._mapInteractObjDict = nil
	self._actId = nil
	self._mapId = nil
	self._optList = nil
	self._round = nil
	self._result = nil
	self._finishInteract = nil
	self._allFinishInteract = nil
	self.failReason = nil
	self.lastMapRound = nil
	self._playingStory = nil
end

function Va3ChessGameModel:initData(actId, mapId)
	local mapCo = Va3ChessConfig.instance:getMapCo(actId, mapId)

	self._actId = actId
	self._mapId = mapId
	self.width = mapCo.width
	self.height = mapCo.height
	self._optList = {}

	self:_initTileNum()

	self._mapTileBaseList = {}

	local tileArr = string.split(mapCo.tilebase, ",") or {}

	for i = 1, #self._mapTileMOList do
		local mo = self._mapTileMOList[i]

		mo:setParamStr(tileArr[i])
	end
end

function Va3ChessGameModel:_initTileNum()
	self._mapTileMOList = {}

	local num = self.width * self.height

	for i = 1, num do
		local mo = self._mapTileMOList[i]

		if not mo then
			mo = Va3ChessGameTileMO.New()
			self._mapTileMOList[i] = mo
		end

		mo:init(i)
	end
end

function Va3ChessGameModel:addInteractData(data)
	table.insert(self._mapInteractObjs, data)

	self._mapInteractObjDict[data.id] = data
end

function Va3ChessGameModel:removeInteractData(data)
	tabletool.removeValue(self._mapInteractObjs, data)

	self._mapInteractObjDict[data.id] = nil
end

function Va3ChessGameModel:initObjects(actId, serverObjList)
	self._mapInteractObjs = {}
	self._mapInteractObjDict = {}

	local len = #serverObjList

	for i = 1, len do
		local serverObj = serverObjList[i]

		if Va3ChessConfig.instance:getInteractObjectCo(actId, serverObj.id) then
			local mo = Va3ChessGameInteractMO.New()

			mo:init(actId, serverObj)
			table.insert(self._mapInteractObjs, mo)

			self._mapInteractObjDict[mo.id] = mo
		end
	end
end

function Va3ChessGameModel:addObject(actId, serverData)
	local mo = Va3ChessGameInteractMO.New()

	mo:init(actId, serverData)
	table.insert(self._mapInteractObjs, mo)

	self._mapInteractObjDict[mo.id] = mo

	return mo
end

function Va3ChessGameModel:removeObjectById(id)
	for i = 1, #self._mapInteractObjs do
		if self._mapInteractObjs[i].id == id then
			local oldObj = self._mapInteractObjs[i]

			table.remove(self._mapInteractObjs, i)

			self._mapInteractObjDict[id] = nil

			return oldObj
		end
	end
end

function Va3ChessGameModel:syncObjectData(id, newData)
	local deltaDatas
	local mo = self._mapInteractObjDict[id]

	if mo then
		local oldData = mo.data

		deltaDatas = self:compareObjectData(oldData, newData)
		mo.data = newData
	end

	return deltaDatas
end

function Va3ChessGameModel:compareObjectData(oldData, newData)
	local deltaDatas = {}

	self:compareAlertArea(deltaDatas, oldData, newData)
	self:compareValueTypeField(deltaDatas, oldData, newData, "goToObject")
	self:compareValueTypeField(deltaDatas, oldData, newData, "lostTarget")
	self:compareValueTypeField(deltaDatas, oldData, newData, "status")
	self:compareValueTypeField(deltaDatas, oldData, newData, "attributes")
	self:compareValueTypeField(deltaDatas, oldData, newData, "pedalStatus")

	return deltaDatas
end

function Va3ChessGameModel:compareAlertArea(deltaDatas, oldData, newData)
	if oldData and newData and oldData.alertArea and newData.alertArea and #oldData.alertArea == #newData.alertArea then
		for i = 1, #oldData.alertArea do
			if oldData.alertArea[i].x ~= newData.alertArea[i].x or oldData.alertArea[i].y ~= newData.alertArea[i].y then
				deltaDatas.alertArea = newData.alertArea

				break
			end
		end
	else
		self:compareValueOverride(deltaDatas, oldData, newData, "alertArea")
	end
end

function Va3ChessGameModel:compareValueTypeField(deltaDatas, oldData, newData, fieldName)
	if oldData and newData then
		if oldData[fieldName] ~= newData[fieldName] then
			if oldData[fieldName] ~= nil and newData[fieldName] == nil then
				deltaDatas.__deleteFields = deltaDatas.__deleteFields or {}
				deltaDatas.__deleteFields[fieldName] = true
			else
				deltaDatas[fieldName] = newData[fieldName]
			end
		end
	else
		self:compareValueOverride(deltaDatas, oldData, newData, fieldName)
	end
end

function Va3ChessGameModel:compareValueOverride(deltaDatas, oldData, newData, fieldName)
	if oldData and oldData[fieldName] ~= nil and (newData == null or newData[fieldName] == nil) then
		deltaDatas.__deleteFields = deltaDatas.__deleteFields or {}
		deltaDatas.__deleteFields[fieldName] = true
	elseif newData then
		deltaDatas[fieldName] = newData[fieldName]
	end
end

function Va3ChessGameModel:getObjectDataById(id)
	return self._mapInteractObjDict[id]
end

function Va3ChessGameModel:appendOpt(opt)
	table.insert(self._optList, opt)
end

function Va3ChessGameModel:getOptList()
	return self._optList
end

function Va3ChessGameModel:cleanOptList()
	for k, v in pairs(self._optList) do
		self._optList[k] = nil
	end
end

function Va3ChessGameModel:updateFinishInteracts(ids)
	self._finishInteract = {}

	if ids then
		for i = 1, #ids do
			self._finishInteract[ids[i]] = true
		end
	end
end

function Va3ChessGameModel:updateBrokenTilebases(actId, brokenTilebases)
	if not brokenTilebases then
		return
	end

	local tmpActId = Activity142Model.instance:getActivityId()

	if tmpActId == actId then
		for _, pos in ipairs(brokenTilebases) do
			local brokenTriggerType = Va3ChessEnum.TileTrigger.Broken
			local status = Va3ChessEnum.TriggerStatus[brokenTriggerType].Broken

			self:updateTileTriggerStatus(pos.x, pos.y, brokenTriggerType, status)
			self:addTileFinishTrigger(pos.x, pos.y, brokenTriggerType)
		end
	else
		for _, pos in ipairs(brokenTilebases) do
			self:addTileFinishTrigger(pos.x, pos.y, Va3ChessEnum.TileTrigger.PoSui)
		end
	end
end

function Va3ChessGameModel:updateLightUpBrazier(actId, lightUpBrazierList)
	if not lightUpBrazierList then
		return
	end

	for _, brazierId in ipairs(lightUpBrazierList) do
		local interactMO = self:getObjectDataById(brazierId)

		if interactMO then
			interactMO:setBrazierIsLight(true)
		end
	end
end

function Va3ChessGameModel:updateFragileTilebases(actId, fragileTilebases)
	if not fragileTilebases then
		return
	end

	for _, pos in ipairs(fragileTilebases) do
		local brokenTriggerType = Va3ChessEnum.TileTrigger.Broken
		local status = Va3ChessEnum.TriggerStatus[brokenTriggerType].Fragile

		self:updateTileTriggerStatus(pos.x, pos.y, brokenTriggerType, status)
	end
end

function Va3ChessGameModel:updateTileTriggerStatus(x, y, triggerId, status)
	local tileMO = self:getTileMO(x, y)

	if tileMO then
		tileMO:updateTrigger(triggerId, status)
	end
end

function Va3ChessGameModel:addTileFinishTrigger(x, y, triggerId)
	local tileMO = self:getTileMO(x, y)

	if tileMO then
		tileMO:addFinishTrigger(triggerId)
	end
end

function Va3ChessGameModel:addFinishInteract(id)
	self._finishInteract[id] = true
end

function Va3ChessGameModel:isInteractFinish(id, checkAllMap)
	if checkAllMap and self._allFinishInteract then
		return self._allFinishInteract[id]
	end

	if self._finishInteract then
		return self._finishInteract[id]
	end
end

function Va3ChessGameModel:findInteractFinishIds(checkAllMap)
	local finishDict = self._finishInteract

	if checkAllMap then
		finishDict = self._allFinishInteract
	end

	if not finishDict then
		return nil
	end

	local ids = {}

	for id, finish in pairs(finishDict) do
		if finish == true then
			table.insert(ids, id)
		end
	end

	return ids
end

function Va3ChessGameModel:addAllMapFinishInteract(id)
	self._allFinishInteract[id] = true
end

function Va3ChessGameModel:updateAllFinishInteracts(ids)
	self._allFinishInteract = {}

	if ids then
		for i = 1, #ids do
			self._allFinishInteract[ids[i]] = true
		end
	end
end

function Va3ChessGameModel:getTileMO(x, y)
	local index = self:getIndex(x, y)

	return self._mapTileMOList[index]
end

function Va3ChessGameModel:getBaseTile(x, y)
	local tileMO = self:getTileMO(x, y)

	return tileMO and tileMO.tileType
end

function Va3ChessGameModel:setBaseTile(x, y, tileType)
	local tileMO = self:getTileMO(x, y)

	if tileMO then
		tileMO.tileType = tileType
	end
end

function Va3ChessGameModel:setResult(isWin)
	self._isWin = isWin
end

function Va3ChessGameModel:getResult()
	return self._isWin
end

function Va3ChessGameModel:setFailReason(failReason)
	self.failReason = failReason
end

function Va3ChessGameModel:getFailReason()
	return self.failReason
end

function Va3ChessGameModel:getInteractDatas()
	return self._mapInteractObjs
end

function Va3ChessGameModel:getIndex(x, y)
	return y * self.width + x + 1
end

function Va3ChessGameModel:getGameSize()
	return self.width, self.height
end

function Va3ChessGameModel:getMapId()
	return self._mapId
end

function Va3ChessGameModel:getActId()
	return self._actId
end

function Va3ChessGameModel:getRound()
	return math.max(self._round or 1, 1)
end

function Va3ChessGameModel:setRound(round)
	if self.lastMapRound then
		self._round = round + self.lastMapRound

		return
	end

	self._round = round
end

function Va3ChessGameModel:recordLastMapRound()
	self.lastMapRound = self._round
end

function Va3ChessGameModel:clearLastMapRound()
	self.lastMapRound = nil
end

function Va3ChessGameModel:getHp()
	return math.max(self._hp or 1, 1)
end

function Va3ChessGameModel:setHp(value)
	self._hp = value
end

function Va3ChessGameModel:setPlayingStory(value)
	self._playingStory = value
end

function Va3ChessGameModel:isPlayingStory()
	return self._playingStory
end

function Va3ChessGameModel:isPosInChessBoard(x, y)
	return x >= 0 and x < self.width and y >= 0 and y < self.height
end

function Va3ChessGameModel:isPosValid(x, y)
	return
end

function Va3ChessGameModel:setFinishedTargetNum(value)
	self._finishedTargetNum = value
end

function Va3ChessGameModel:getFinishedTargetNum()
	return self._finishedTargetNum
end

function Va3ChessGameModel:getFinishGoalNum()
	if not self._actId then
		return 0
	end

	local episodeId = Va3ChessModel.instance:getEpisodeId()

	if not episodeId then
		return 0
	end

	local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(self._actId, episodeId)
	local mainCondition, extraCondition

	if self._actId == VersionActivity1_3Enum.ActivityId.Act304 then
		mainCondition = episodeCfg.starCondition
		extraCondition = episodeCfg.extStarCondition
	elseif self._actId == VersionActivity1_3Enum.ActivityId.Act306 then
		mainCondition = episodeCfg.mainConfition
		extraCondition = episodeCfg.extStarCondition
	end

	local conditionList = {}

	if not string.nilorempty(mainCondition) then
		for _, condition in ipairs(GameUtil.splitString2(mainCondition, true)) do
			table.insert(conditionList, condition)
		end
	end

	if not string.nilorempty(extraCondition) then
		for _, condition in ipairs(GameUtil.splitString2(extraCondition, true)) do
			table.insert(conditionList, condition)
		end
	end

	local count = 0

	if self:getResult() then
		count = count + 1
	end

	for i, condition in ipairs(conditionList) do
		if Va3ChessMapUtils.isClearConditionFinish(condition, self._actId) then
			count = count + 1
		end
	end

	return count
end

function Va3ChessGameModel:isGoalFinished(condition)
	if not self._actId then
		return false
	end

	if not string.nilorempty(condition) then
		local params = string.splitToNumber(condition, "#")

		return Va3ChessMapUtils.isClearConditionFinish(params, self._actId)
	else
		return self:getResult() == true
	end
end

function Va3ChessGameModel:getFireBallCount()
	return self._fireBallCount or 0
end

function Va3ChessGameModel:setFireBallCount(count, updateInteract)
	if not count or count < 0 then
		count = 0
	end

	self._fireBallCount = count

	if not updateInteract then
		return
	end

	local handler
	local interactMgr = Va3ChessGameController.instance.interacts

	if interactMgr then
		local mainPlayer = interactMgr:getMainPlayer(true)

		handler = mainPlayer and mainPlayer:getHandler() or nil
	end

	if handler and handler.updateFireBallCount then
		handler:updateFireBallCount()
	end
end

Va3ChessGameModel.instance = Va3ChessGameModel.New()

return Va3ChessGameModel
