-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/model/FunCampModel.lua

module("logic.extensions.funcamp.model.FunCampModel", package.seeall)

local FunCampModel = class("FunCampModel", BaseModel)

FunCampModel.KeyAnim1 = "funcamp_animpath1"
FunCampModel.KeyStory1 = "funcamp_story1"
FunCampModel.BuyType1 = 1
FunCampModel.BuyType2 = 2
FunCampModel.CoinDonate = 1
FunCampModel.PlunderDonate = 2

function FunCampModel:ctor()
	return
end

function FunCampModel:onInit()
	self:onReset()
end

function FunCampModel:onReset()
	self._activityId = 0
	self._isRecInfo = false
	self._campId = -1
	self._isAutoSelect = false
	self._lastSelectGroupId = -1
	self._lastSelectCampId = -1
	self._personInspireValue = 0
	self._personScore = 0
	self._needToFind = false
	self.sceneId = 0
	self._id = 0
	self._hasGainCampPrize = false
	self._infoList = {}
	self._todayItemCount = 0
	self._isRecPlayInfo = false
	self._todayDonateTimes = 0
	self._donateBuyTimes = 0
	self._todayGameTimes = 0
	self._todayGameBuyTimes = 0
	self._todayIntrusionTimes = 0
	self._todayIntrusionBuyTimes = 0
	self._rankInfo = {}
	self._taskInfo = {}
	self._removeLastPet = false
end

function FunCampModel:onGetInfoRes(msg)
	self._isRecInfo = true
	self._campId = msg.campId
	self._isAutoSelect = msg.isAutoSelect
	self._lastSelectGroupId = msg.lastSelectGroupId
	self._lastSelectCampId = msg.lastSelectCampId
	self._personInspireValue = msg.personInspireValue
	self._personScore = msg.personScore
	self._needToFind = msg.needToFind
	self._sceneId = msg.sceneId
	self._id = msg.id
	self._hasGainCampPrize = msg.hasGainCampPrize
	self._infoList = GameUtil.pbToTable(msg.infoList) or {}
	self._todayItemCount = msg.todayItemCount
end

function FunCampModel:onSelectCampRes(msg)
	self:_setCampId(msg.campId)
end

function FunCampModel:onDonateCoinsRes(msg)
	self._todayDonateTimes = msg.todayDonateTimes

	if msg.type == 1 then
		self._personInspireValue = msg.personScore
	elseif msg.type == 2 then
		self._personScore = msg.personScore
	end

	for i, v in ipairs(self._infoList) do
		if v.campId == msg.campId then
			if msg.type == 1 then
				v.inspireCoins = msg.campCoins
				v.inspireValue = msg.score
			elseif msg.type == 2 then
				v.battleCoins = msg.campCoins
				v.campScore = msg.score
			end
		end
	end
end

function FunCampModel:onGetPlayInfoRes(msg)
	self._isRecPlayInfo = true
	self._todayDonateTimes = msg.todayDonateTimes
	self._donateBuyTimes = msg.donateBuyTimes
	self._todayGameTimes = msg.todayGameTimes
	self._todayGameBuyTimes = msg.todayGameBuyTimes
	self._todayIntrusionTimes = msg.todayIntrusionTimes
	self._todayIntrusionBuyTimes = msg.todayIntrusionBuyTimes
end

function FunCampModel:onBuyTimeRes(msg)
	if msg.type == 1 then
		self._todayGameBuyTimes = msg.buyTimes
	elseif msg.type == 2 then
		self._todayIntrusionBuyTimes = msg.buyTimes
	end
end

function FunCampModel:onBuyDonateTimesRes(msg)
	self._donateBuyTimes = msg.donateBuyTimes
end

function FunCampModel:onEndGameRes(msg)
	self._todayGameTimes = msg.todayGameTimes
	self._personInspireValue = msg.personInspireValue
	self._gameChangeSetId = msg.changeSetId

	for i, v in ipairs(self._infoList) do
		if v.campId == msg.campId then
			v.inspireValue = msg.inspireValue
		end
	end
end

function FunCampModel:isLastSelectedCamp()
	return self._lastSelectGroupId > 0 and self._lastSelectCampId > 0
end

function FunCampModel:getLastSelectId()
	return self._lastSelectGroupId, self._lastSelectCampId
end

function FunCampModel:getGameChangeSetId()
	printInfo("test getGameChangeSetId", self._gameChangeSetId)

	return self._gameChangeSetId
end

function FunCampModel:setActivityId(activityId)
	self._activityId = activityId
end

function FunCampModel:getActivityId()
	return self._activityId
end

function FunCampModel:_setCampId(campId)
	printInfo("test 设置阵营 id = ", campId)

	self._campId = campId
end

function FunCampModel:isRecGetInfoRes()
	return self._isRecInfo
end

function FunCampModel:isReceiveGetPlayInfo()
	return self._isRecPlayInfo
end

function FunCampModel:getCurFlipGameTimes()
	return self._todayGameTimes
end

function FunCampModel:getGameBuyTimes()
	return self._todayGameBuyTimes
end

function FunCampModel:getTotalMaxGameTimes(maxConfigGameTimes)
	return self._todayGameBuyTimes + maxConfigGameTimes
end

function FunCampModel:setRankInfo(msg)
	self._rankInfo = msg
end

function FunCampModel:getRankInfo()
	return self._rankInfo
end

function FunCampModel:getRankData()
	return self._rankInfo.infoList, self._rankInfo.myRank
end

function FunCampModel:isSelectCamp()
	return self._campId > 0
end

function FunCampModel:getCampId()
	return self._campId
end

function FunCampModel:getCampInspireValue(campId)
	for i, v in ipairs(self._infoList) do
		if v.campId == campId then
			return v.inspireValue
		end
	end

	return 0
end

function FunCampModel:getCampRank(campId)
	for i, v in ipairs(self._infoList) do
		if v.campId == campId then
			return v.rank
		end
	end

	return 1
end

function FunCampModel:getPersonInspireValue()
	return self._personInspireValue
end

function FunCampModel:getPersonScore()
	return self._personScore
end

function FunCampModel:setTaskInfo(msg)
	self._taskInfo = msg
end

function FunCampModel:getTaskInfo()
	return self._taskInfo
end

function FunCampModel:setCurNpcAndSceneId(msg)
	self._id = msg.id
	self._sceneId = msg.sceneId
end

function FunCampModel:getMaxIntrusionBuyTimes(maxTimes)
	return self._todayIntrusionBuyTimes + checknumber(maxTimes)
end

function FunCampModel:getIntrusionBuyTimes()
	return self._todayIntrusionBuyTimes
end

function FunCampModel:getIntrusionTimes()
	return self._todayIntrusionTimes
end

function FunCampModel:getCurSceneId()
	return self._sceneId
end

function FunCampModel:getCurNpcId()
	if self._sceneId > 0 and self._id > 0 then
		return (FunCampNpcConfig.instance:getNpcId(self._sceneId, self._id))
	end

	return nil
end

function FunCampModel:getCurId()
	return self._id
end

function FunCampModel:getTaskCfgList()
	local tpyeList = FunCampConfig.instance:getTaskInfo(self._activityId)
	local info
	local targetList = {}

	for _, idsList in pairs(tpyeList or {}) do
		info = self:_getTaskToDo(idsList)

		if info then
			table.insert(targetList, info)
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			if a.stage == b.stage then
				return a.cfg.taskId < b.cfg.taskId
			end

			return a.stage < b.stage
		end)
	end

	return targetList
end

function FunCampModel:_getTaskToDo(taskInfos)
	local task = self._taskInfo[taskInfos.taskId]

	if not taskInfos then
		return
	end

	local info = {}

	info.cfg = taskInfos
	info.taskId = info.cfg.taskId

	if task then
		info.progress = task.curProgress or 0
	end

	if task then
		info.hasGain = task.hasGainPrize or false
	end

	info.stage = info.hasGain and 3 or info.progress >= info.cfg.maxProgress and 1 or 2

	return info
end

function FunCampModel:getTaskHaveReward()
	local tpyeList = FunCampConfig.instance:getTaskInfo(self._activityId)
	local info

	for _, idsList in pairs(tpyeList or {}) do
		info = self:_getTaskToDo(idsList)

		if info and info.stage == 1 then
			return true
		end
	end

	return false
end

function FunCampModel:setHasGainCampPrize()
	self._hasGainCampPrize = true
end

function FunCampModel:isHasGainCampPrize()
	return self._hasGainCampPrize
end

function FunCampModel:isAutoSelectCamp()
	return self._isAutoSelect
end

function FunCampModel:getDonateTimes()
	return self._todayDonateTimes
end

function FunCampModel:getDonateBuyTimes()
	return self._donateBuyTimes
end

function FunCampModel:getTotalMaxDonateTimes(maxConfigDonateTimes)
	return self._donateBuyTimes + maxConfigDonateTimes
end

function FunCampModel:getCampCoins(donateType, campId)
	for i, v in ipairs(self._infoList) do
		if v.campId == campId then
			if donateType == FunCampModel.CoinDonate then
				return checknumber(v.inspireCoins)
			else
				return checknumber(v.battleCoins)
			end
		end
	end

	return 0
end

function FunCampModel:getCampScore(donateType, campId)
	for i, v in ipairs(self._infoList) do
		if v.campId == campId then
			if donateType == FunCampModel.CoinDonate then
				return checknumber(v.inspireValue)
			else
				return checknumber(v.campScore)
			end
		end
	end

	return 0
end

function FunCampModel:setLastPetState(isRemove)
	self._removeLastPet = isRemove
end

function FunCampModel:getLastPetState()
	return self._removeLastPet
end

function FunCampModel:getTodayItemCount()
	return self._todayItemCount
end

FunCampModel.instance = FunCampModel.New()

return FunCampModel
