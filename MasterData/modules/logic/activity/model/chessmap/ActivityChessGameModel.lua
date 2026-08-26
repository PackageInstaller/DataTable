-- chunkname: @modules/logic/activity/model/chessmap/ActivityChessGameModel.lua

module("modules.logic.activity.model.chessmap.ActivityChessGameModel", package.seeall)

local ActivityChessGameModel = class("ActivityChessGameModel", BaseModel)

function ActivityChessGameModel:onInit()
	return
end

function ActivityChessGameModel:reInit()
	return
end

function ActivityChessGameModel:release()
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
end

function ActivityChessGameModel:initData(actId, mapId)
	local mapCo = Activity109Config.instance:getMapCo(actId, mapId)

	self._actId = actId
	self._mapId = mapId
	self.width = mapCo.width
	self.height = mapCo.height
	self._mapTileBaseList = string.splitToNumber(mapCo.tilebase, ",")
	self._optList = {}
end

function ActivityChessGameModel:addInteractData(data)
	table.insert(self._mapInteractObjs, data)

	self._mapInteractObjDict[data.id] = data
end

function ActivityChessGameModel:removeInteractData(data)
	tabletool.removeValue(self._mapInteractObjs, data)

	self._mapInteractObjDict[data.id] = nil
end

function ActivityChessGameModel:initObjects(actId, serverObjList)
	self._mapInteractObjs = {}
	self._mapInteractObjDict = {}

	local len = #serverObjList

	for i = 1, len do
		local serverObj = serverObjList[i]

		if Activity109Config.instance:getInteractObjectCo(actId, serverObj.id) then
			local mo = ActivityChessGameInteractMO.New()

			mo:init(actId, serverObj)
			table.insert(self._mapInteractObjs, mo)

			self._mapInteractObjDict[mo.id] = mo
		end
	end
end

function ActivityChessGameModel:addObject(actId, serverData)
	local mo = ActivityChessGameInteractMO.New()

	mo:init(actId, serverData)
	table.insert(self._mapInteractObjs, mo)

	self._mapInteractObjDict[mo.id] = mo

	return mo
end

function ActivityChessGameModel:removeObjectById(id)
	for i = #self._mapInteractObjs, 1, -1 do
		if self._mapInteractObjs[i].id == id then
			local oldObj = self._mapInteractObjs[i]

			table.remove(self._mapInteractObjs, i)

			self._mapInteractObjDict[id] = nil

			return oldObj
		end
	end
end

function ActivityChessGameModel:syncObjectData(id, newData)
	local deltaDatas
	local mo = self._mapInteractObjDict[id]

	if mo then
		local oldData = mo.data

		deltaDatas = self:compareObjectData(oldData, newData)
		mo.data = newData
	end

	return deltaDatas
end

function ActivityChessGameModel:compareObjectData(oldData, newData)
	local deltaDatas = {}

	self:compareAlertArea(deltaDatas, oldData, newData)
	self:compareValueTypeField(deltaDatas, oldData, newData, "goToObject")
	self:compareValueTypeField(deltaDatas, oldData, newData, "lostTarget")

	return deltaDatas
end

function ActivityChessGameModel:compareAlertArea(deltaDatas, oldData, newData)
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

function ActivityChessGameModel:compareValueTypeField(deltaDatas, oldData, newData, fieldName)
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

function ActivityChessGameModel:compareValueOverride(deltaDatas, oldData, newData, fieldName)
	if oldData and oldData[fieldName] ~= nil and (newData == null or newData[fieldName] == nil) then
		deltaDatas.__deleteFields = deltaDatas.__deleteFields or {}
		deltaDatas.__deleteFields[fieldName] = true
	elseif newData then
		deltaDatas[fieldName] = newData[fieldName]
	end
end

function ActivityChessGameModel:getObjectDataById(id)
	return self._mapInteractObjDict[id]
end

function ActivityChessGameModel:appendOpt(opt)
	table.insert(self._optList, opt)
end

function ActivityChessGameModel:getOptList()
	return self._optList
end

function ActivityChessGameModel:cleanOptList()
	for k, v in pairs(self._optList) do
		self._optList[k] = nil
	end
end

function ActivityChessGameModel:updateFinishInteracts(ids)
	self._finishInteract = {}

	if ids then
		for i = 1, #ids do
			self._finishInteract[ids[i]] = true
		end
	end
end

function ActivityChessGameModel:addFinishInteract(id)
	self._finishInteract[id] = true
end

function ActivityChessGameModel:isInteractFinish(id)
	if self._finishInteract then
		return self._finishInteract[id]
	end
end

function ActivityChessGameModel:getBaseTile(x, y)
	local index = self:getIndex(x, y)

	return self._mapTileBaseList[index]
end

function ActivityChessGameModel:setBaseTile(x, y, tileType)
	local index = self:getIndex(x, y)

	self._mapTileBaseList[index] = tileType
end

function ActivityChessGameModel:setRound(round)
	self._round = round
end

function ActivityChessGameModel:setResult(isWin)
	self._isWin = isWin
end

function ActivityChessGameModel:getResult()
	return self._isWin
end

function ActivityChessGameModel:getInteractDatas()
	return self._mapInteractObjs
end

function ActivityChessGameModel:getIndex(x, y)
	return y * self.width + x + 1
end

function ActivityChessGameModel:getGameSize()
	return self.width, self.height
end

function ActivityChessGameModel:getMapId()
	return self._mapId
end

function ActivityChessGameModel:getActId()
	return self._actId
end

function ActivityChessGameModel:getRound()
	return math.max(self._round or 1, 1)
end

function ActivityChessGameModel:isPosInChessBoard(x, y)
	return x >= 0 and x < self.width and y >= 0 and y < self.height
end

function ActivityChessGameModel:getFinishGoalNum()
	if not self._actId then
		return 0
	end

	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	if not episodeId then
		return 0
	end

	local episodeCfg = Activity109Config.instance:getEpisodeCo(self._actId, episodeId)
	local conditionsStr = episodeCfg.extStarCondition
	local conditions = string.split(conditionsStr, "|")
	local conditionDesc = string.split(episodeCfg.conditionStr, "|")
	local count = 0

	if self:isGoalFinished() then
		count = count + 1
	end

	for i, condition in ipairs(conditions) do
		if self:isGoalFinished(condition) then
			count = count + 1
		end
	end

	return count
end

function ActivityChessGameModel:isGoalFinished(condition)
	if not self._actId then
		return false
	end

	if not string.nilorempty(condition) then
		local params = string.splitToNumber(condition, "#")

		return ActivityChessMapUtils.isClearConditionFinish(params, self._actId)
	else
		return self:getResult() == true
	end
end

ActivityChessGameModel.instance = ActivityChessGameModel.New()

return ActivityChessGameModel
