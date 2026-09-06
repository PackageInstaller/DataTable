-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/model/PlayerReturnModel.lua

module("logic.extensions.playerreturn.model.PlayerReturnModel", package.seeall)

local PlayerReturnModel = class("PlayerReturnModel", BaseModel)

PlayerReturnModel.PlgeTypeTimeGate = 6

function PlayerReturnModel:ctor()
	self._isActiEnd = false
	self._mainTabIndex = 1
	self._openActiInfo = nil
	self._signInfo = nil
	self._haveScoreCount = 0
	self._scoreInfoList = nil
	self._taskSeverList = nil
	self._taskCacheList = nil
	self._shopBuyList = nil
	self.backActType = 95
	self.backActId = nil
	self._backInfo = nil

	self:_setBackTaskInfo()
end

function PlayerReturnModel:onInit()
	PlayerReturnModel.super.onInit(self)
	self:onReset()
end

function PlayerReturnModel:onReset()
	PlayerReturnModel.super.onReset(self)

	self._isActiEnd = false
	self._mainTabIndex = 1
	self._openActiInfo = nil
	self._signInfo = nil
	self._haveScoreCount = 0
	self._scoreInfoList = nil
	self._taskSeverList = nil
	self._taskCacheList = nil
	self._shopBuyList = nil
	self._backInfo = nil

	self:_setBackTaskInfo()
end

function PlayerReturnModel:isOpenActivityEndWithActId(actId)
	if self._openActiInfo == nil then
		return true
	end

	if checknumber(self._openActiInfo.actId) <= 0 or checknumber(self._openActiInfo.actId) ~= checknumber(actId) then
		return true
	end

	return ServerTime.nowServerLook() > self._openActiInfo.endTime
end

function PlayerReturnModel:isOpenActivityEnd()
	if self._openActiInfo == nil then
		return true
	end

	if checknumber(self._openActiInfo.actId) <= 0 then
		return true
	end

	return ServerTime.nowServerLook() > self._openActiInfo.endTime
end

function PlayerReturnModel:getOpenActivityInfo()
	return self._openActiInfo
end

function PlayerReturnModel:setOpenActivityPopup()
	if self._openActiInfo == nil or self._openActiInfo.isPopup then
		return
	end

	self._openActiInfo.isPopup = true

	PlayerReturnController.instance:csRegressSetOpenReq()
end

function PlayerReturnModel:getAllSignInfo()
	return self._signInfo or {}
end

function PlayerReturnModel:getSinglePlgeCfg(typeId)
	if self:isOpenActivityEnd() then
		return
	end

	if checknumber(typeId) <= 0 then
		return
	end

	local info = self:getOpenActivityInfo()

	if info == nil or checknumber(info.actId) <= 0 then
		return
	end

	local mainCfg = PlayerReturnConfig.instance:getReturnMainViewCfgs(info.actId, 2)

	if mainCfg == nil or checknumber(mainCfg.planId) <= 0 then
		return
	end

	return PlayerReturnConfig.instance:getReturnPlgeCfgs(mainCfg.planId, typeId)
end

function PlayerReturnModel:getSinglePlgeCount(typeId)
	local plgeCfg = self:getSinglePlgeCfg(typeId)

	if plgeCfg == nil or checknumber(plgeCfg.param) <= 0 then
		return
	end

	return plgeCfg.param
end

function PlayerReturnModel:hasSinglePlge(typeId)
	return self:getSinglePlgeCfg(typeId) ~= nil
end

function PlayerReturnModel:getPlgePlotCopyIsDouble()
	if self:isOpenActivityEnd() then
		return
	end

	local count = self:getSinglePlgeCount(2)

	return checknumber(count) > 0
end

function PlayerReturnModel:getTaskInfoList(planId, dayNum)
	dayNum = dayNum or 1

	if self._taskCacheList == nil then
		self._taskCacheList = {}
	end

	if self._taskCacheList[dayNum] then
		return self._taskCacheList[dayNum]
	end

	local allCfgs = PlayerReturnConfig.instance:getReturnAllTaskCfgs(planId)
	local tempList = {}

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and cfg.day == dayNum then
			local info = self:_comparedTaskInfo(tempList[cfg.type], cfg)

			if info then
				tempList[cfg.type] = info
			end
		end
	end

	local taskList = {}

	for _, info in pairs(tempList) do
		if info and checknumber(info.id) > 0 then
			table.insert(taskList, info)
		end
	end

	if #taskList > 1 then
		table.sort(taskList, function(a, b)
			if a.stage == b.stage then
				return a.id < b.id
			end

			return a.stage < b.stage
		end)
	end

	self._taskCacheList[dayNum] = taskList

	return taskList
end

function PlayerReturnModel:_comparedTaskInfo(oldInfo, newCfg)
	if newCfg == nil then
		return nil
	end

	local newInfo = {
		isReach = false,
		isReceive = false,
		haveCount = 0,
		stage = 2,
		id = newCfg.id,
		title = newCfg.title,
		desc = newCfg.desc,
		needCount = newCfg.maxProgress,
		prizeList = string.split(newCfg.prize, "#"),
		score = newCfg.score,
		jumpTo = newCfg.jumpTo
	}

	if self._taskSeverList and self._taskSeverList[newCfg.id] then
		newInfo.isReceive = self._taskSeverList[newCfg.id].prizeGained
		newInfo.haveCount = self._taskSeverList[newCfg.id].curProgress
		newInfo.isReach = newInfo.haveCount >= newInfo.needCount
	end

	if newInfo.isReceive then
		newInfo.stage = 3
	elseif newInfo.isReach then
		newInfo.stage = 1
	end

	if oldInfo == nil or checknumber(oldInfo.id) <= 0 then
		return newInfo
	end

	if newInfo.isReceive then
		if oldInfo.isReceive and newInfo.id > oldInfo.id then
			return newInfo
		end
	elseif oldInfo.haveCount / oldInfo.needCount == newInfo.haveCount / newInfo.needCount and newInfo.id < oldInfo.id or oldInfo.isReceive or oldInfo.haveCount / oldInfo.needCount < newInfo.haveCount / newInfo.needCount then
		return newInfo
	end

	return nil
end

function PlayerReturnModel:getScoreInfoList(planId)
	local allCfgs = PlayerReturnConfig.instance:getReturnScoreCfgs(planId)

	self._scoreInfoList = self._scoreInfoList or {}

	local scoreList = {}

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and checknumber(cfg.scoreId) > 0 then
			local info = {}

			info.id = cfg.scoreId
			info.needCount = cfg.needScore
			info.goods = string.split(cfg.prize, ":")
			info.isReach = cfg.needScore <= self._haveScoreCount
			info.isReceive = self._scoreInfoList[cfg.scoreId]

			table.insert(scoreList, info)
		end
	end

	if #scoreList > 1 then
		table.sort(scoreList, function(a, b)
			return a.id < b.id
		end)
	end

	return scoreList, self._haveScoreCount
end

function PlayerReturnModel:getShopInfoList(planId)
	self._shopBuyList = self._shopBuyList or {}

	local allCfgs = PlayerReturnConfig.instance:getReturnShopCfgs(planId)
	local tempList = {}

	for _, cfg in pairs(allCfgs) do
		if cfg and checknumber(cfg.id) > 0 then
			local data = {}

			data.id = cfg.id
			data.price = cfg.price
			data.rmbId = cfg.payGoodsId
			data.contents = string.split(cfg.content, "#")
			data.limitCount = checknumber(cfg.countLimit)
			data.discount = checknumber(cfg.discount)
			data.itemIcon = cfg.itemIcon
			data.itemName = cfg.itemName
			data.buyCount = checknumber(self._shopBuyList[cfg.id])

			table.insert(tempList, data)
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			return a.id < b.id
		end)
	end

	return tempList
end

function PlayerReturnModel:getSingleShopBuyCount(shopId)
	if self._shopBuyList == nil or self._shopBuyList[shopId] == nil then
		return 0
	end

	return self._shopBuyList[shopId]
end

function PlayerReturnModel:getPlayerReturnRedpoint()
	if self:isOpenActivityEnd() then
		return false
	end

	return self:_getSignViewRedPoint() or self:_getPlgeViewRedPoint() or self:_getTaskViewRedPoint() or self:_getShopViewRedPoint()
end

function PlayerReturnModel:getTabViewRedpoint(tabId)
	if self:isOpenActivityEnd() then
		return false
	end

	if checknumber(tabId) <= 0 then
		return false
	end

	if tabId == 1 then
		return self:_getSignViewRedPoint()
	end

	if tabId == 2 then
		return self:_getPlgeViewRedPoint()
	end

	if tabId == 3 then
		return self:_getTaskViewRedPoint()
	end

	if tabId == 4 then
		return self:_getShopViewRedPoint()
	end

	if tabId == 5 then
		return RecallTaskModel.instance:getReturnViewRedpoint()
	end

	if tabId == 6 then
		return false
	end

	if tabId == 7 then
		local value = GameUtil.getUserData("PR_PlayerReturnLotteryRed")

		return checknumber(value) ~= 1
	end

	return false
end

function PlayerReturnModel:_getSignViewRedPoint()
	return RedPointModel.instance:isActiveByServer(RedPointModel.ID_PLAYERRETURN_SIGN)
end

function PlayerReturnModel:_getPlgeViewRedPoint()
	local value = GameUtil.getUserDayData("PR_PlayerReturnPlgeRed")

	return checknumber(value) ~= 1 or RedPointModel.instance:isActiveByServer(RedPointModel.ID_PLAYERRETURN_CARD)
end

function PlayerReturnModel:_getTaskViewRedPoint()
	return RedPointModel.instance:isActiveByServer(RedPointModel.ID_PLAYERRETURN_TASK)
end

function PlayerReturnModel:_getShopViewRedPoint()
	return false
end

function PlayerReturnModel:getTaskDaysRedpoint(planId, dayNum)
	local actInfo = self:getOpenActivityInfo()

	if actInfo == nil or actInfo.endTime < ServerTime.now() then
		return false
	end

	local openDays = GameUtil.getDaysByTimestamp(actInfo.startTime, ServerTime.now())

	if openDays < dayNum then
		return false
	end

	local taskList = self:getTaskInfoList(planId, dayNum)

	if taskList == nil or #taskList == 0 then
		return false
	end

	for i = 1, #taskList do
		if taskList[i] and not taskList[i].isReceive and taskList[i].isReach then
			return true
		end
	end

	return false
end

function PlayerReturnModel:setOpenActivityInfo(data)
	self._openActiInfo = nil

	if data == nil or checknumber(data.actId) == 0 then
		return
	end

	local actCfg = PlayerReturnConfig.instance:getReturnActivityCfg(data.actId)

	if actCfg == nil then
		return
	end

	local touchTime = math.floor(data.touchTimeMillis / 1000)
	local startTimestamp, endTimestamp = GameUtil.getTimestampOnStartAndEnd(touchTime, 1, actCfg.totalDays)

	self._openActiInfo = {}
	self._openActiInfo.actId = data.actId
	self._openActiInfo.startTime = startTimestamp
	self._openActiInfo.endTime = endTimestamp
	self._openActiInfo.isPopup = data.hadOpen

	if checknumber(self._openActiInfo.actId) > 0 and ServerTime.now() < self._openActiInfo.endTime then
		GlobalDispatcher:dispatch(GlobalNotify.UpdateMainUIFuncs)
	end
end

function PlayerReturnModel:setAllSignInfo(data)
	self._signInfo = nil

	if data == nil then
		return
	end

	self._signInfo = data

	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataSignInfo)
end

function PlayerReturnModel:setSingleSignInfo(dayNum)
	self._signInfo = self._signInfo or {}
	self._signInfo[dayNum] = true

	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataSignInfo)
	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 1)
end

function PlayerReturnModel:setTaskAndScoreInfo(data)
	self._haveScoreCount = checknumber(data.totalScore)
	self._scoreInfoList = {}

	if data.prizeGainBits then
		self._scoreInfoList = data.prizeGainBits
	end

	self._taskSeverList = {}

	for _, info in pairs(data.userTaskInfos or {}) do
		if info and checknumber(info.taskId) > 0 then
			self._taskSeverList[info.taskId] = info
		end
	end

	self._taskCacheList = nil

	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataTaskInfo)
end

function PlayerReturnModel:setScoreReceiveById(scoreId)
	self._scoreInfoList = self._scoreInfoList or {}
	self._scoreInfoList[scoreId] = true

	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataScoreInfo)
	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 3)
end

function PlayerReturnModel:setTaskReceiveById(taskId, planId)
	self._taskSeverList = self._taskSeverList or {}

	if self._taskSeverList[taskId] == nil then
		return
	end

	self._taskSeverList[taskId].prizeGained = true

	local taskCfg = PlayerReturnConfig.instance:getReturnSingleTaskCfg(planId, taskId)

	if taskCfg and checknumber(taskCfg.score) > 0 then
		self._haveScoreCount = checknumber(self._haveScoreCount) + taskCfg.score
	end

	self._taskCacheList = nil

	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataTaskInfo)
	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 3)
end

function PlayerReturnModel:handlePM_CIGainTypePrizeRes(msg)
	local prizeId = msg.prizeId

	if prizeId > 0 then
		table.insert(self._backInfo.gainTypePrizeIds, prizeId)
	end
end

function PlayerReturnModel:setAllShopBuyInfo(data)
	self._shopBuyList = {}

	if data == nil then
		return
	end

	for _, info in pairs(data) do
		if info and checknumber(info.buyCount) > 0 then
			self._shopBuyList[info.shopItemId] = info.buyCount
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataShopInfo)
end

function PlayerReturnModel:setSingleShopBuyInfo(shopId, count)
	self._shopBuyList = self._shopBuyList or {}

	if self._shopBuyList[shopId] == nil then
		self._shopBuyList[shopId] = 0
	end

	self._shopBuyList[shopId] = checknumber(count) <= 0 and self._shopBuyList[shopId] + 1 or count

	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataShopInfo)
end

function PlayerReturnModel:getBackTaskInfo()
	if self._backInfo == nil then
		self:_setBackTaskInfo()
	end

	return self._backInfo
end

function PlayerReturnModel:_setBackTaskInfo()
	if self._backInfo == nil then
		self._backInfo = {}
		self._backInfo.activityId = self.backActId
		self._backInfo.myCode = ""
		self._backInfo.score = 0
		self._backInfo.prizeIds = {}
		self._backInfo.inviteTimesInfos = {}
		self._backInfo.todayUsedCodes = {}
		self._backInfo.accUseCodeTimes = 0
		self._backInfo.gainTypePrizeIds = {}
		self._backInfo.activityTimesInfo = {}
	end
end

function PlayerReturnModel:getBackPrizeInfo(planId, prizeId)
	local allCfgs = PlayerReturnConfig.instance:getBackPrizeCfg(planId)

	if allCfgs then
		if not #allCfgs then
			local count = 0

			if count <= 0 then
				return nil, nil
			end

			if allCfgs and allCfgs[prizeId] then
				return allCfgs[prizeId], count
			end

			local tempInfo = {
				prizeId = 0,
				stage = 3
			}

			for i = 1, count do
				if allCfgs[i] and not string.nilorempty(allCfgs[i].prize) then
					local stage = 2

					if self._backInfo then
						if self._backInfo.prizeIds and table.indexof(self._backInfo.prizeIds, allCfgs[i].prizeId) then
							stage = 3
						elseif self._backInfo.score >= allCfgs[i].scoreReq then
							stage = 1
						end
					end

					if tempInfo.stage == 2 then
						break
					elseif tempInfo.stage == 1 and stage == 2 then
						break
					end

					tempInfo.prizeId = allCfgs[i].prizeId
					tempInfo.stage = stage
				end
			end

			if tempInfo == nil or tempInfo.prizeId <= 0 then
				return allCfgs[count], count
			end

			return allCfgs[tempInfo.prizeId], count
		end
	end
end

function PlayerReturnModel:_getTaskGradeName(index)
	if index == 1 then
		return "回归"
	end

	if index == 2 then
		return "新"
	end

	if index == 3 then
		return "普通"
	end

	if index == 4 then
		return "好友"
	end
end

function PlayerReturnModel:getBackTaskRedpoint()
	local value = GameUtil.getUserDayData("RP_BackTaskView")

	if checknumber(value) ~= 1 then
		return true
	end

	return RedPointModel.instance:isActiveByServer(180)
end

function PlayerReturnModel:csSendCIGetActInfo(msg)
	self:_setBackTaskInfo()

	if msg == nil or checknumber(msg.activityId) <= 0 then
		return
	end

	self._backInfo = {}
	self._backInfo.activityId = msg.activityId
	self._backInfo.myCode = msg.myCode
	self._backInfo.score = msg.score
	self._backInfo.prizeIds = msg.prizeIds or {}
	self._backInfo.inviteTimesInfos = msg.inviteTimesInfos or {}
	self._backInfo.todayUsedCodes = msg.todayUsedCodes or {}
	self._backInfo.accUseCodeTimes = msg.accUseCodeTimes
	self._backInfo.gainTypePrizeIds = {}

	table.insertto(self._backInfo.gainTypePrizeIds, msg.gainTypePrizeIds)

	self._backInfo.activityTimesInfo = msg.activityTimesInfo
end

function PlayerReturnModel:csSendCIUseCode(msg)
	if msg == nil or checknumber(msg.activityId) <= 0 then
		return
	end

	if self._backInfo == nil then
		self:_setBackTaskInfo()
	end

	self._backInfo.score = msg.score
	self._backInfo.todayUsedCodes = msg.todayUsedCodes
end

function PlayerReturnModel:csSendCIGainPrize(msg)
	if msg == nil or msg.prizeIds == nil then
		return
	end

	if self._backInfo == nil then
		self:_setBackTaskInfo()
	end

	self._backInfo.prizeIds = self._backInfo.prizeIds or {}

	for _, id in pairs(msg.prizeIds) do
		if id and checknumber(id) > 0 then
			table.insert(self._backInfo.prizeIds, id)
		end
	end
end

function PlayerReturnModel:csSendCINotifyNewInvite(msg)
	if msg == nil or msg.inviteInfo == nil then
		return
	end

	if self._backInfo == nil then
		self:_setBackTaskInfo()
	end

	self._backInfo.score = msg.score
	self._backInfo.activityTimesInfo = msg.activityTimesInfo

	for _, info in pairs(self._backInfo.inviteTimesInfos or {}) do
		if info and info.type == msg.inviteInfo.type then
			info.times = info.times + 1

			return
		end
	end
end

function PlayerReturnModel:getGainTypePrizeIds()
	return self._backInfo.gainTypePrizeIds
end

function PlayerReturnModel:getActTimes(_type)
	local info = self:_getActivityTimesInfo(_type)

	return (info or nil) and info.times
end

function PlayerReturnModel:_getActivityTimesInfo(_type)
	local result
	local baseInfo = self:getBackTaskInfo()

	for i, v in ipairs(baseInfo.activityTimesInfo) do
		if _type == v.type then
			result = v

			break
		end
	end

	return result
end

PlayerReturnModel.instance = PlayerReturnModel.New()

return PlayerReturnModel
