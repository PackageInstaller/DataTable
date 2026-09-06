-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/model/ScratchModel.lua

module("logic.extensions.scratch.model.ScratchModel", package.seeall)

local ScratchModel = class("ScratchModel", BaseModel)

ScratchModel.ShiziBomb = -1
ScratchModel.JiugongBomb = -2
ScratchModel.FirstPrize = -3
ScratchModel.MaxCount = 49

function ScratchModel:ctor()
	return
end

function ScratchModel:onInit()
	self:onReset()
end

function ScratchModel:onReset()
	self._taskList = {}
	self._score = 0
	self._payScore = 0
	self._positionInfoList = {}
	self._isPlaying = false
	self._activityId = 0
	self._curRound = 1
	self._bigPrizeInfos = {}
	self._digRangePosList = {}
	self._isDigFirstPrize = false
	self._bigPrizeId = nil

	local cfg = ScratchConfig.instance:getScratchParamsCfg("SCORE_EXCHANGE_ITEM")

	self._unitScore = checknumber(cfg.value)
end

function ScratchModel:isInActivityTime()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.Nor2)

	for k, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Nor2, v.activityId) then
			self._activityId = v.activityId

			return true
		end
	end

	return false
end

function ScratchModel:onGetScratchUserInfoRes(msg)
	self._isDigFirstPrize = false

	table.clear(self._taskList)

	for i, v in ipairs(msg.taskInfo) do
		table.insert(self._taskList, v)
	end

	self._score = msg.score
	self._payScore = msg.payScore

	table.clear(self._positionInfoList)

	if msg.positionInfo then
		for i, v in ipairs(msg.positionInfo) do
			table.insert(self._positionInfoList, v)

			if v.prizeId == ScratchModel.FirstPrize then
				self._isDigFirstPrize = true
			end
		end
	end

	self._isPlaying = msg.hasSelectPrize
	self._activityId = msg.activityId
	self._curRound = msg.curRound
	self._bigPrizeId = msg:HasField("bigPrizeId") and msg.bigPrizeId or 0

	table.clear(self._bigPrizeInfos)

	if msg.bigPrizeInfo then
		for i, v in ipairs(msg.bigPrizeInfo) do
			table.insert(self._bigPrizeInfos, v)
		end
	end
end

function ScratchModel:onScratchDigRes(msg)
	table.clear(self._digRangePosList)

	for i, v in ipairs(msg.positionInfo) do
		table.insert(self._digRangePosList, v)

		if v.prizeId == ScratchModel.FirstPrize then
			self._isDigFirstPrize = true
		end

		local info = self:_getPositionInfo(v.xAxis, v.yAxis)

		if info then
			v.xAxis = info.xAxis
			v.yAxis = info.yAxis
			v.prizeId = info.prizeId
		else
			table.insert(self._positionInfoList, v)
		end
	end
end

function ScratchModel:getDigRangePosList()
	return self._digRangePosList
end

function ScratchModel:setScore()
	self._score = self._score - self._exchangeNum * self._unitScore

	if self._score > 0 then
		self._score = self._score or 0
	end
end

function ScratchModel:getScore()
	return self._score
end

function ScratchModel:isPlaying()
	return self._isPlaying
end

function ScratchModel:isDigAll()
	return #self._positionInfoList >= ScratchModel.MaxCount
end

function ScratchModel:getActivityId()
	return self._activityId
end

function ScratchModel:getCurRound()
	return self._curRound
end

function ScratchModel:isDigFirstPrize()
	return self._isDigFirstPrize
end

function ScratchModel:_changeBigPrizeUseTimes(id, count)
	if id and id > 0 then
		local cfg = ScratchConfig.instance:getScratchActivityCfgById(self._activityId)

		if cfg then
			local cfgPrize = ScratchConfig.instance:getScratchPrizeCfg(cfg.bigPlanId, id, true)

			if cfgPrize then
				local info = self:_getBigPrizeInfo(id)

				if info then
					info.times = info.times + count
					info.times = Mathf.Clamp(info.times, 0, cfgPrize.totalTimes)
				end
			end
		end
	end
end

function ScratchModel:setBigPrizeId(id)
	self:_changeBigPrizeUseTimes(self._bigPrizeId, -1)
	self:_changeBigPrizeUseTimes(id, 1)

	self._bigPrizeId = id
end

function ScratchModel:getBigPrizeId()
	return (self._bigPrizeId ~= nil or nil) and (self._bigPrizeId or 0)
end

function ScratchModel:_getPositionInfo(x, y)
	for i, v in ipairs(self._positionInfoList) do
		if v.xAxis == x and v.yAxis == y then
			return v
		end
	end

	return nil
end

function ScratchModel:getGridList()
	local cfg = ScratchConfig.instance:getScratchActivityCfgById(self._activityId)
	local result = {}

	for i = 1, 49 do
		local element = {}

		element.x = Mathf.Floor((i - 1) / 7)
		element.y = (i - 1) % 7

		local gridData = self:_getPositionInfo(element.x, element.y)

		element.prizeId = gridData and gridData.prizeId or 0

		if element.prizeId == ScratchModel.FirstPrize then
			element.planId = cfg.bigPlanId or cfg.normalPlanId
		end

		table.insert(result, element)
	end

	return result
end

function ScratchModel:getTaskList()
	local result = {}

	if not self._taskList or #self._taskList == 0 then
		return result
	end

	for i, v in ipairs(self._taskList) do
		local element = {}

		element.taskId = v.taskId
		element.hasFinished = v.hasFinished
		element.curProgress = v.curProgress
		element.isPayScore = false

		table.insert(result, element)
	end

	table.sort(result, function(a, b)
		if a.hasFinished == b.hasFinished then
			return a.taskId < b.taskId
		else
			return not a.hasFinished and b.hasFinished
		end
	end)

	local payElement = {}

	payElement.isPayScore = true
	payElement.payScore = self._payScore

	table.insert(result, 1, payElement)

	return result
end

function ScratchModel:setExchangeSelectScore(num)
	self._exchangeNum = num
end

function ScratchModel:isCanExchange()
	return self._score / self._unitScore >= 1
end

function ScratchModel:setChangeSetId(changeSetId)
	self._changeSetId = changeSetId
end

function ScratchModel:getChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

function ScratchModel:setRecentDigGrid(x, y)
	self._recentX = x
	self._recentY = y
end

function ScratchModel:getRecentDigGrid()
	return self._recentX, self._recentY
end

function ScratchModel:_getBigPrizeInfo(prizeId)
	for i, v in pairs(self._bigPrizeInfos) do
		if v.prizeId == prizeId then
			return v
		end
	end

	return nil
end

function ScratchModel:getBigPrizeList()
	local resultList = {}
	local cfg = ScratchConfig.instance:getScratchActivityCfgById(self._activityId)
	local planId = cfg.bigPlanId
	local prizeCfgList = ScratchConfig.instance:getBigPrizeSortCfgs(planId)

	printInfo("test getBigPrizeList", #prizeCfgList)

	local bigPrizeId = self:getBigPrizeId()

	for i, v in ipairs(prizeCfgList) do
		local serverInfo = self:_getBigPrizeInfo(v.id)

		if serverInfo then
			local item = {}

			item.times = serverInfo.times
			item.cfg = v
			item.isLimit = true
			item.curRound = self._curRound
			item.isBigPrize = v.id == bigPrizeId

			table.insert(resultList, item)
		elseif v.totalTimes == -1 then
			local item = {}

			item.times = 0
			item.cfg = v
			item.curRound = self._curRound
			item.isLimit = false
			item.isBigPrize = v.id == bigPrizeId

			table.insert(resultList, item)
		end
	end

	return resultList
end

function ScratchModel:initRewardSelect()
	self._selectPrizeId = 0
end

function ScratchModel:setPrizeId(prizeId)
	self._selectPrizeId = prizeId
end

function ScratchModel:getPrizeId()
	return self._selectPrizeId
end

function ScratchModel:isSelectFinish()
	return self._selectPrizeId and self._selectPrizeId > 0
end

function ScratchModel:getRedPointConst()
	return ViewName.ScratchView .. "redpoint"
end

ScratchModel.instance = ScratchModel.New()

return ScratchModel
