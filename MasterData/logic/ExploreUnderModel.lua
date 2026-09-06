-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/model/ExploreUnderModel.lua

module("logic.extensions.exploreunder.model.ExploreUnderModel", package.seeall)

local ExploreUnderModel = class("ExploreUnderModel", BaseModel)

function ExploreUnderModel:onInit()
	self:onReset()
end

function ExploreUnderModel:onReset()
	self._curActId = 0
	self._curLevel = 0
	self._curMapId = 0
	self._curDiceUseTimes = {}
	self._curGridInfos = {}
	self._curDiceNum = 0
	self._curGridId = 0
	self._curEventState = 0
	self._curEventData = nil
	self._userDataDailyAutoTipKey = "ExploreUnder_DaillyAutoTip"
	self._isNewLevel = false
	self.CiList = nil
	self._customFmtMo = nil
	self._dialogueFmtMo = nil
end

ExploreUnderModel.EventAction = {
	giveUpBuy = "giveUpBuy",
	finishGame = "finishGame",
	gainPrize = "gainPrize",
	buyItem = "buyItem",
	viewDialogue = "viewDialogue",
	selectAnswer = "selectAnswer",
	fight = "fight",
	startDialogue = "startDialogue",
	doMove = "doMove"
}
ExploreUnderModel.EventExtraParamKey = {
	itemId = "itemId",
	difficulty = "difficulty",
	win = "win"
}

function ExploreUnderModel:onGetInfo(msg)
	self._isNewLevel = false

	self:_changeLevelInfo(msg.levelInfo)
	self:_changeEventInfo(msg.gridInfo)

	if self:getIsAllPass() then
		self._curGridId = self._curMapEndId
		self._curEventState = ExploreUnderEnum.EventState_Finish
	end
end

function ExploreUnderModel:onDice(msg)
	self._curDiceNum = checkint(msg.diceNum)

	if self._isSpecialDice then
		self:useFixedDice(self._curDiceNum, 1)
	end

	local eventInfo = msg.eventInfo

	self:_changeLevelInfo(eventInfo.level)
	self:_changeEventInfo(eventInfo.gridInfo)

	if self:getIsAllPass() then
		self._curGridId = self._curMapEndId
		self._curEventState = ExploreUnderEnum.EventState_Finish
	end

	self.CiList = msg.eventInfo.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.eventInfo.changeSetId)
end

function ExploreUnderModel:onDealEvent(msg)
	return
end

function ExploreUnderModel:onNotifyEventInfoChanged(msg)
	if msg.eventInfo then
		local eventInfo = msg.eventInfo

		if eventInfo.level then
			self:_changeLevelInfo(eventInfo.level)
		end

		self:_changeEventInfo(eventInfo.gridInfo)

		if self:getIsAllPass() then
			self._curGridId = self._curMapEndId
			self._curEventState = ExploreUnderEnum.EventState_Finish
		end

		self.CiList = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end
end

function ExploreUnderModel:_changeEventInfo(info)
	if info then
		self._curGridId = checkint(info.curGrid)

		if self._curGridId == 0 or self._curGridId == self._curMapEndId then
			self._curEventState = ExploreUnderEnum.EventState_Finish
			self._curEventData = nil
		else
			self._curEventState = checkint(info.curState)
			self._curEventData = info.curEventInfo
		end
	end
end

function ExploreUnderModel:_changeLevelInfo(levelInfo)
	if levelInfo and checkint(levelInfo.level) > 0 then
		if self._curLevel ~= 0 then
			self._isNewLevel = self._curLevel ~= checkint(levelInfo.level)
		end

		self._curLevel = checkint(levelInfo.level)
		self._curMapId = checkint(levelInfo.mapId)

		local curActCfg = ExploreUnderConfig.instance:getActfg(self._curActId)
		local curLevel = self:getCurLevel()
		local curLevelCfg = ExploreUnderConfig.instance:getLevelCfg(curActCfg.levelPlanId, curLevel)
		local mapCfgs = ExploreUnderConfig.instance:getMapCfgs(self._curMapId)

		self._curGridInfos = {}

		for k, v in ipairs(levelInfo.grids) do
			local info = {}

			info.id = k

			local mapCfg = mapCfgs[info.id]

			info.eventType = checkint(v.gridType)
			info.eventParm = v.eventKey
			info.iconId = 0

			local cfg

			if info.eventType == 1 then
				cfg = ExploreUnderConfig.instance:getPrizeEventCfg(curLevelCfg.event_plan_1, checkint(info.eventParm))
			elseif info.eventType == 2 then
				cfg = ExploreUnderConfig.instance:getMoveEventCfg(curLevelCfg.event_plan_2, checkint(info.eventParm))
			elseif info.eventType == 3 then
				cfg = ExploreUnderConfig.instance:getGameEventCfg(curLevelCfg.event_plan_3, checkint(info.eventParm))
			elseif info.eventType == 4 then
				cfg = (ExploreUnderConfig.instance:getItemCfgs(checkint(info.eventParm)) or {})[1]
			elseif info.eventType == 5 then
				cfg = (ExploreUnderConfig.instance:getFightEventCfgs(curLevelCfg.event_plan_5) or {})[1]
			elseif info.eventType == 6 then
				cfg = {}
				cfg.iconId = 15
			end

			info.iconId = cfg and cfg.iconId and checkint(cfg.iconId) - 1 or info.eventType - 1

			if mapCfg then
				info.posX = mapCfg.posX or 0
			end

			if mapCfg then
				info.posY = mapCfg.posY or 0
			end

			self._curGridInfos[info.id] = info
		end

		local firstInfo = {}

		firstInfo.id = 0

		local mapCfg = mapCfgs[firstInfo.id]

		if mapCfg then
			firstInfo.posX = mapCfg.posX or 0
		end

		if mapCfg then
			firstInfo.posY = mapCfg.posY or 0
		end

		firstInfo.isFirst = true
		self._curGridInfos[firstInfo.id] = firstInfo

		local endInfo = {}

		endInfo.id = #levelInfo.grids + 1

		local mapCfg = mapCfgs[endInfo.id]

		if mapCfg then
			endInfo.posX = mapCfg.posX or 0
		end

		if mapCfg then
			endInfo.posY = mapCfg.posY or 0
		end

		endInfo.isEnd = true
		self._curGridInfos[endInfo.id] = endInfo
		self._curMapEndId = endInfo.id
		self._curDiceLeftTimes = {}

		local curActCfg = ExploreUnderConfig.instance:getActfg(self._curActId)

		if curActCfg then
			if not curActCfg.fixedDiceLimit then
				local fixedDiceLimit = ""
				local params = string.split(fixedDiceLimit, ",")

				for k, v in ipairs(params) do
					local temParams = string.split(v, "#")

					self._curDiceLeftTimes[checkint(temParams[1])] = checkint(temParams[2])
				end

				for k, v in ipairs(levelInfo.fixedDiceTimes) do
					self:useFixedDice(v.num, v.curUseCount)
				end
			end
		end
	end
end

function ExploreUnderModel:setActId(actId)
	self:onReset()

	self._curActId = actId
end

function ExploreUnderModel:getCurActTimeCfg()
	return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.ExploreUnder)
end

function ExploreUnderModel:getActId()
	return self._curActId
end

function ExploreUnderModel:getCurDiceNum()
	return self._curDiceNum
end

function ExploreUnderModel:getCurLevel()
	if self:getIsAllPass() then
		return self._curLevel - 1
	end

	return self._curLevel
end

function ExploreUnderModel:getCurGridInfos()
	return self._curGridInfos
end

function ExploreUnderModel:getCurMapEndIdId()
	return self._curMapEndId
end

function ExploreUnderModel:checkIsSpecialDice(diceNum)
	self._isSpecialDice = diceNum ~= -1
end

function ExploreUnderModel:getIsSpecialDice()
	return self._isSpecialDice
end

function ExploreUnderModel:getCurDiceLeftTime(diceNum)
	return self._curDiceLeftTimes[diceNum]
end

function ExploreUnderModel:useFixedDice(diceNum, usetime)
	local curTime = self._curDiceLeftTimes[diceNum]

	usetime = usetime or 1
	curTime = curTime - checkint(usetime)
	self._curDiceLeftTimes[diceNum] = math.max(0, curTime)
end

function ExploreUnderModel:getTotalLeftTimes()
	local totalTimes = 0

	for k, v in pairs(self._curDiceLeftTimes) do
		totalTimes = totalTimes + v
	end

	return totalTimes
end

function ExploreUnderModel:getCurGridId()
	return self._curGridId
end

function ExploreUnderModel:getCurGridInfo()
	return self._curGridInfos[self._curGridId]
end

function ExploreUnderModel:getCurEventState()
	return self._curEventState
end

function ExploreUnderModel:getCurEventData()
	return self._curEventData
end

function ExploreUnderModel:getIsNewLevel()
	return self._isNewLevel
end

function ExploreUnderModel:resetIsNewLevel()
	self._isNewLevel = false
end

function ExploreUnderModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = ExploreUnderCustomFmtMo.New()
	end

	return self._customFmtMo
end

function ExploreUnderModel:getDialogueFmtMo()
	if self._dialogueFmtMo == nil then
		self._dialogueFmtMo = ExploreUnderDialogueFmtMo.New()
	end

	return self._dialogueFmtMo
end

function ExploreUnderModel:getIsAllPass()
	if self._curLevel == 0 then
		return false
	end

	local curActCfg = ExploreUnderConfig.instance:getActfg(self._curActId)

	if curActCfg then
		::label_29_0::

		local curLevelCfg = ExploreUnderConfig.instance:getLevelCfg(curActCfg.levelPlanId, self._curLevel)

		if curLevelCfg then
			return false
		end

		return true
	end
end

function ExploreUnderModel:getIsAutoTipToday()
	local userData = GameUtil.getUserDayData(self._userDataDailyAutoTipKey)

	return checkint(userData) < 1
end

function ExploreUnderModel:setAutoTipToday(isShow)
	local userData = isShow and 1 or 0

	GameUtil.saveUserDayData(self._userDataDailyAutoTipKey, userData)
end

function ExploreUnderModel:resetDiceNum()
	self._curDiceNum = 0
	self._isSpecialDice = false
end

function ExploreUnderModel:ShowCI()
	MaterialController.instance:showChangeSetInTemp(checknumber(self.CiList))

	self.CiList = nil
end

ExploreUnderModel.instance = ExploreUnderModel.New()

return ExploreUnderModel
