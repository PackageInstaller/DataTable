-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/model/SevenDaysModel.lua

module("logic.extensions.sevendays.model.SevenDaysModel", package.seeall)

local SevenDaysModel = class("SevenDaysModel", BaseModel)

function SevenDaysModel:ctor()
	self.sevenDays = 7
	self.registTime = 1
	self.scoreInfoList = nil
	self.taskSeverList = nil
	self.taskCacheList = nil
	self.choiseNums = {
		daysNum = 0,
		titlesNum = 0
	}
	self.sevenSignInfo = nil
	self.sevenSignCfgs = nil
	self.classScoreList = {}
	self.classSeverList = {}
	self.classTabIndex = 0
	self.trboxActivityType = 7
	self.boxOpenList = nil
	self.boxInfo = nil
	self.boxNewsLastList = nil
	self.shopBuyList = nil
	self.exchangeBuyList = nil
	self.boxChengeId = nil
	self.trboxTimerInfo = nil
	self.openBonusName = nil
end

function SevenDaysModel:onInit()
	SevenDaysModel.super.onInit(self)
	removetimer(self.CalculationFunctionOpen, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.SetRegisteredTimeDay, self)
	settimer(1, self.CalculationFunctionOpen, self, true)
	self:onReset()
end

function SevenDaysModel:onReset()
	self.sevenDays = SevenDaysConfig.instance:GetMaxSevenDaysNum()
	self.choiseNums = {
		daysNum = 0,
		titlesNum = 0
	}
	self.scoreInfoList = nil
	self.taskSeverList = nil
	self.taskCacheList = nil
	self.sevenSignInfo = nil
	self.classScoreList = {}
	self.classSeverList = {}
	self.classTabIndex = 0
	self.boxOpenList = nil
	self.boxInfo = nil
	self.boxNewsLastList = nil
	self.shopBuyList = nil
	self.exchangeBuyList = nil
	self.boxChengeId = nil

	if self.trboxTimerInfo then
		self.trboxTimerInfo.openId = -1
		self.trboxTimerInfo.supTime = -1
	end

	self.openBonusName = nil
	self._msgInfos = {}
end

function SevenDaysModel:SetRegisteredTimeDay()
	if RoleModel == nil or RoleModel.instance == nil then
		return
	end

	local regTime = RoleModel.instance:getActiveTime() / 1000
	local sss = GameUtil.time2date(regTime)
	local now = ServerTime.nowDateServerLook()
	local refreshTime = ClockMgr.instance._refreshTime
	local oneDayH = refreshTime - sss.hour
	local oneDayM = 0

	if refreshTime <= sss.hour then
		oneDayH = oneDayH + 24
	end

	if sss.min > 0 then
		oneDayH = oneDayH - 1
		oneDayM = 60 - sss.min
	end

	local oneAllMin = oneDayH * 60 + oneDayM
	local haveMin = math.ceil((checknumber(ServerTime.now()) - regTime) / 60)
	local index = 1

	if oneAllMin < haveMin then
		local surpMin = haveMin - oneAllMin

		while surpMin > 1440 do
			surpMin = surpMin - 1440
			index = index + 1
		end

		if surpMin > 0 then
			index = index + 1
		end
	end

	self.registTime = index
end

function SevenDaysModel:GetRegisteredTimeDay(isForce)
	if isForce then
		self:SetRegisteredTimeDay()
	end

	return self.registTime
end

function SevenDaysModel:IsOpenSevenDaysView(isForce)
	if isForce then
		self:SetRegisteredTimeDay()
	end

	return self.registTime <= self.sevenDays
end

function SevenDaysModel:SevenDaysChoisNums(isSet, daysNum, titlesNum)
	if not isSet then
		if self.choiseNums.daysNum == nil or self.choiseNums.daysNum == 0 then
			self.choiseNums.daysNum = self:GetRegisteredTimeDay(true)

			if self.choiseNums.daysNum > 7 then
				self.choiseNums.daysNum = 7
			end
		end

		if self.choiseNums.titlesNum == nil or self.choiseNums.titlesNum == 0 then
			self.choiseNums.titlesNum = 1
		end

		return self.choiseNums
	end

	self.choiseNums.daysNum = daysNum or 1
	self.choiseNums.titlesNum = titlesNum or 1
end

function SevenDaysModel:SCPushSevenDaysTaskData(msg)
	self.scoreInfoList = nil
	self.taskSeverList = nil
	self.taskCacheList = nil

	if msg == nil then
		return
	end

	local scoreData = msg.gainStates
	local taskData = msg.taskInfos
	local haveScore = 0

	if taskData and #taskData > 0 then
		self.taskSeverList = {}

		for i = 1, #taskData do
			if taskData[i] and taskData[i].taskId then
				if taskData[i].gainPrize then
					local score = SevenDaysConfig.instance:GetSevenDaysScoreById(taskData[i].taskId)

					if score and score > 0 then
						haveScore = haveScore + score
					end
				end

				self.taskSeverList[taskData[i].taskId] = {
					isReceive = taskData[i].gainPrize,
					havePro = taskData[i].curProgress
				}
			end
		end
	end

	local dayScoreData = SevenDaysConfig.instance:GetSevenDaysPrize()

	if dayScoreData and #dayScoreData > 0 then
		self.scoreInfoList = {
			allScore = 0,
			haveScore = haveScore,
			scoreList = {}
		}

		for i = 1, #dayScoreData do
			if dayScoreData[i] then
				local var_8_0 = {
					score = dayScoreData[i].score,
					goods = dayScoreData[i].goods
				}

				if scoreData then
					var_8_0.isReceive = scoreData[i] or false
				end

				self.scoreInfoList.scoreList[i] = var_8_0

				if i == #dayScoreData then
					self.scoreInfoList.allScore = dayScoreData[i].score
				end
			end
		end
	end
end

function SevenDaysModel:GetRegistTaskRedPoint()
	if not self:IsOpenSevenDaysView() then
		return false
	end

	for i = 1, self.registTime do
		if self:GetDyasTaskRedPoint(i) then
			return true
		end
	end

	return false
end

function SevenDaysModel:GetDyasTaskRedPoint(dayId)
	if not self:IsOpenSevenDaysView() then
		return false
	end

	local dayTaskData = SevenDaysConfig.instance:GetSevenDaysTask(dayId)

	if dayTaskData == nil or #dayTaskData == 0 then
		return false
	end

	for i = 1, #dayTaskData do
		local info = dayTaskData[i]

		if info and self.taskSeverList and self.taskSeverList[info.id] and not self.taskSeverList[info.id].isReceive and self.taskSeverList[info.id].havePro >= info.maxProgress then
			return true
		end
	end

	return false
end

function SevenDaysModel:GetRegistScoreRedPoint()
	if not self:IsOpenSevenDaysView() then
		return false
	end

	if self.scoreInfoList == nil or #self.scoreInfoList == 0 then
		return false
	end

	for i = 1, #self.scoreInfoList do
		if self.scoreInfoList[i] and not self.scoreInfoList[i].isReceive and self.scoreInfoList[i].score <= self.scoreInfoList[i].allScore then
			return true
		end
	end

	return false
end

function SevenDaysModel:GetTitleTaskRedPoint(dayId, num)
	if not self:IsOpenSevenDaysView() then
		return false
	end

	local dayTaskData = SevenDaysConfig.instance:GetSevenDaysTask(dayId)

	if dayTaskData == nil or #dayTaskData == 0 then
		return false
	end

	for i = 1, #dayTaskData do
		local info = dayTaskData[i]

		if info and info.category == num and self.taskSeverList and self.taskSeverList[info.id] and not self.taskSeverList[info.id].isReceive and self.taskSeverList[info.id].havePro >= info.maxProgress then
			return true
		end
	end

	return false
end

function SevenDaysModel:GetTaskDataByDays(dayId)
	if self.taskCacheList == nil then
		self.taskCacheList = {}
	end

	if self.taskCacheList[dayId] then
		return self.taskCacheList[dayId].infoList, self.taskCacheList[dayId].clientTypeList
	end

	local dayTaskData = SevenDaysConfig.instance:GetSevenDaysTask(dayId)

	if dayTaskData == nil or #dayTaskData == 0 then
		error("sr_ SevenDaysModel:GetTaskDataByDays()       获取任务列表为空 = ", dayId)

		return
	end

	local infoList = {}

	for i = 1, #dayTaskData do
		local tempInfo = self:ComparedServerTaskData(dayTaskData[i])

		if tempInfo then
			infoList[tempInfo.clientType] = infoList[tempInfo.clientType] or {}

			table.insert(infoList[tempInfo.clientType], tempInfo)
		end
	end

	for _, list in pairs(infoList) do
		if list and #list > 1 then
			table.sort(list, function(a, b)
				if a.isReceive == b.isReceive then
					if a.isReach == b.isReach then
						if a.taskType == b.taskType then
							if a.havePro == b.havePro then
								return a.baseId < b.baseId
							end

							return a.havePro < b.havePro
						end

						return a.taskType < b.taskType
					end

					return a.isReach
				end

				return not a.isReceive
			end)
		end
	end

	local clientTypeList = {}

	for client, info in pairs(infoList) do
		if client and info and #info > 0 then
			table.insert(clientTypeList, {
				dayId = dayId,
				clientType = client,
				subCount = #info,
				nameStr = SevenDaysConfig.instance:GetSevenDaysTitle(client)
			})
		end
	end

	if #clientTypeList > 1 then
		table.sort(clientTypeList, function(a, b)
			return a.clientType < b.clientType
		end)
	end

	self.taskCacheList[dayId] = {
		infoList = infoList,
		clientTypeList = clientTypeList
	}

	return infoList, clientTypeList
end

function SevenDaysModel:ComparedServerTaskData(cfg)
	if cfg == nil then
		return
	end

	local baseId = cfg.id
	local tempInfo = {
		isReach = false,
		havePro = 0,
		isReceive = false,
		baseId = baseId,
		clientType = cfg.category,
		des = cfg.desc,
		taskType = cfg.type,
		maxPro = cfg.maxProgress,
		goods = cfg.prize,
		score = cfg.score,
		jumpTo = cfg.jumpTo,
		nameStr = cfg.title
	}

	if self.taskSeverList == nil or self.taskSeverList[baseId] == nil then
		return tempInfo
	end

	tempInfo.isReceive = self.taskSeverList[baseId].isReceive
	tempInfo.havePro = self.taskSeverList[baseId].havePro
	tempInfo.isReach = tempInfo.havePro >= tempInfo.maxPro

	return tempInfo
end

function SevenDaysModel:GetAccumulateScoreData()
	return self.scoreInfoList
end

function SevenDaysModel:ResetSevenSignInfo()
	self.sevenSignInfo = nil
end

function SevenDaysModel:SCPushSignInfo(msg)
	self.sevenSignInfo = {
		loginDays = 0,
		prizedDays = {}
	}

	if msg.loginDays then
		self.sevenSignInfo.loginDays = msg.loginDays
	end

	if msg.prizedDays then
		self.sevenSignInfo.prizedDays = msg.prizedDays
	end

	GlobalDispatcher:dispatch("UpdataSevenSignInfo")
end

function SevenDaysModel:SignInGainPrize(list, dayId)
	if self.sevenSignInfo == nil or list == nil then
		return
	end

	self.sevenSignInfo.prizedDays = list

	GlobalDispatcher:dispatch("UpdataSevenSignInfo", dayId)
end

function SevenDaysModel:GetSevenSignInfo()
	if self.sevenSignInfo == nil then
		self.sevenSignInfo = {
			loginDays = 0,
			prizedDays = {}
		}

		SevenDaysController.instance:CSRequestSignInfo()
	end

	return self.sevenSignInfo
end

function SevenDaysModel:GetActivitySignCfgs()
	if self.sevenSignCfgs == nil then
		local cfgs = ActivityParamsConfig.instance:GetActivitySignCfgs()

		self.sevenSignCfgs = {}

		for _, item in pairs(cfgs or {}) do
			if item and item.value then
				local data = {}

				data.days = checknumber(item.value.day)

				if string.nilorempty(item.value.material) then
					data.goodsInfo = nil
				else
					local goodsStr = string.gsub(item.value.material, "=", ":")

					if string.nilorempty(goodsStr) then
						-- block empty
					end

					data.goodsInfo = string.split(goodsStr, ":")
				end

				data.lotteryCount = checknumber(item.value.lottery)

				table.insert(self.sevenSignCfgs, data)
			end
		end

		if #self.sevenSignCfgs > 1 then
			table.sort(self.sevenSignCfgs, function(a, b)
				return a.days < b.days
			end)
		end
	end

	return self.sevenSignCfgs
end

function SevenDaysModel:GetAllSignReceive()
	if self.sevenSignInfo == nil or self.sevenSignInfo.loginDays == nil then
		return false
	end

	if self.sevenSignInfo.loginDays < 7 then
		return false
	end

	for i = 2, 8 do
		if not self.sevenSignInfo.prizedDays[i] then
			return false
		end
	end

	return true
end

function SevenDaysModel:SCPushExcellentClassInfo(msg)
	if self.classSeverList == nil then
		self.classSeverList = {}
	end

	local actId = checknumber(msg.activityId)

	if actId > 0 then
		self._msgInfos[actId] = msg
	end

	printInfo("sssssss activityId", actId)

	if msg then
		if not msg.taskInfos then
			local taskData = {}
			local haveScore = 0

			if taskData and #taskData > 0 then
				self.classSeverList[actId] = {}

				for i = 1, #taskData do
					if taskData[i] and taskData[i].taskId then
						if taskData[i].gainPrize then
							local cfg = ExcellentClassConfig.instance:GetClassTaskCfgById(actId, taskData[i].taskId)

							if cfg and cfg.score and cfg.score > 0 then
								haveScore = haveScore + cfg.score
							end
						end

						self.classSeverList[actId][taskData[i].taskId] = {
							taskId = taskData[i].taskId,
							isReceive = taskData[i].gainPrize,
							havePro = taskData[i].curProgress
						}
					end
				end
			end

			if self.classScoreList[actId] == nil then
				self:GetClassScoreList(actId)
			end

			self.classScoreList[actId].haveScore = haveScore

			if #self.classScoreList[actId].scoreList > 0 then
				for i = 1, #self.classScoreList[actId].scoreList do
					if self.classScoreList[actId].scoreList[i] and msg and msg.gainStates and msg.gainStates[i] then
						self.classScoreList[actId].scoreList[i].isReceive = true
					end
				end
			end

			GlobalDispatcher:dispatch("UpdataExcellentClassTask")
		end
	end
end

function SevenDaysModel:getNewHandTargetInfo(actId)
	if self.classSeverList[actId] then
		return self.classSeverList[actId]
	end

	return {}
end

function SevenDaysModel:GetClassTaskList(actId, tabId)
	if tabId == nil or tabId <= 0 then
		return
	end

	local tabList = ExcellentClassConfig.instance:GetClassAllTabTask(actId, tabId)

	if tabList == nil or next(tabList) == nil then
		error("sr_精品课程  SevenDaysModel:GetClassTaskList()    获取任务配置为空 = " .. tabId)

		return
	end

	local targetList = {}

	for k, list in pairs(tabList or {}) do
		local info = self:SelectSatisfyItem(actId, list)

		if info then
			table.insert(targetList, info)
		end
	end

	if targetList and #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.taskId < b.taskId
		end)
	end

	return targetList
end

function SevenDaysModel:SelectSatisfyItem(actId, subList)
	if subList == nil or #subList == 0 then
		return
	end

	local info

	for i = 1, #subList do
		local cfg = ExcellentClassConfig.instance:GetClassTaskCfgById(actId, subList[i])

		if cfg then
			local taskId = cfg.id
			local need = cfg.maxProgress

			if self.classSeverList[actId] == nil then
				return {
					havePro = 0,
					isReceive = false,
					taskId = taskId,
					needPro = need
				}
			end

			if self.classSeverList[actId][taskId] == nil then
				if info == nil or info.isReceive then
					info = {
						havePro = 0,
						isReceive = false,
						taskId = taskId,
						needPro = need
					}
				end

				if taskId < info.taskId then
					info.taskId = taskId
					info.needPro = need
				end
			else
				if info == nil then
					info = {
						taskId = taskId,
						havePro = self.classSeverList[actId][taskId].havePro,
						needPro = need,
						isReceive = self.classSeverList[actId][taskId].isReceive
					}
				end

				if self.classSeverList[actId][taskId].isReceive then
					if info.isReceive and taskId > info.taskId then
						info.taskId = taskId
						info.havePro = self.classSeverList[actId][taskId].havePro
						info.needPro = need
						info.isReceive = true
					end
				elseif info.isReceive or info.havePro < info.needPro and need <= self.classSeverList[actId][taskId].havePro then
					info.taskId = taskId
					info.havePro = self.classSeverList[actId][taskId].havePro
					info.needPro = need
					info.isReceive = false
				end
			end
		end
	end

	if info == nil then
		local endCfg = ExcellentClassConfig.instance:GetClassTaskCfgById(actId, subList[#subList])

		info = {
			taskId = endCfg.id,
			havePro = self.classSeverList[actId][endCfg.id].havePro,
			needPro = endCfg.maxProgress,
			isReceive = self.classSeverList[actId][endCfg.id].isReceive
		}

		error("sr_精品课程  SevenDaysModel:SelectSatisfyItem()    获取显示为空 #subList = " .. #subList)
	end

	return info
end

function SevenDaysModel:GetClassScoreList(actId)
	if self.classScoreList[actId] == nil then
		self.classScoreList[actId] = {
			haveScore = 0,
			allScore = 0,
			scoreList = {}
		}

		local scoreData = ExcellentClassConfig.instance:GetClsaaScoreCfgs(actId)

		if scoreData and #scoreData > 0 then
			for i = 1, #scoreData do
				self.classScoreList[actId].scoreList[i] = {
					isReceive = false,
					score = scoreData[i].score,
					goods = scoreData[i].goods
				}

				if i == #scoreData then
					self.classScoreList[actId].allScore = scoreData[i].score
				end
			end
		end
	end

	return self.classScoreList[actId]
end

function SevenDaysModel:GetClassTaskRedPoint(actId, tabId)
	local subList = self:GetClassTaskList(actId, tabId)

	if subList == nil or #subList == 0 then
		return false
	end

	for i = 1, #subList do
		if subList[i] and not subList[i].isReceive and subList[i].havePro >= subList[i].needPro then
			return true
		end
	end
end

function SevenDaysModel:GetClassScoreRedPoint()
	if self.classScoreList[actId] == nil then
		return false
	end

	local scoreList = self.classScoreList[actId].scoreList

	if scoreList == nil or #scoreList == 0 then
		return false
	end

	if not self.classScoreList[actId].haveScore then
		local haveScore = 0

		for i = 1, #scoreList do
			if scoreList[i] and not scoreList[i].isReceive and haveScore >= scoreList[i].score then
				return true
			end
		end
	end
end

function SevenDaysModel:IsOpenExcellentClassView(actId)
	if not self:IsReceiveAllScore(actId) then
		return true
	end

	if self.classSeverList[actId] == nil or next(self.classSeverList[actId]) == nil then
		return true
	end

	local tabList = ExcellentClassConfig.instance:GetClassAllTabTask()

	for _, list in pairs(tabList or {}) do
		if list and #list > 0 then
			for i = 1, #list do
				if not self:IsReceiveAllTask(actId, list[i]) then
					return true
				end
			end
		end
	end

	return false
end

function SevenDaysModel:IsReceiveAllScore(actId)
	if self.classScoreList[actId] == nil or self.classScoreList[actId].scoreList == nil then
		return false
	end

	for _, info in pairs(self.classScoreList[actId].scoreList) do
		if info and not info.isReceive then
			return false
		end
	end

	return true
end

function SevenDaysModel:IsReceiveAllTask(actId, subList)
	if subList == nil or #subList == 0 then
		return false
	end

	for i = 1, #subList do
		if not subList[i] then
			if self.classSeverList[actId][subList[i]] == nil or not self.classSeverList[actId][subList[i]].isReceive then
				return false
			end
		end
	end

	return true
end

function SevenDaysModel:PushWishingWellInfo(data, isCallback)
	if self.boxInfo == nil then
		self.boxInfo = {}
	end

	self.boxInfo.shopBuyList = self.boxInfo.shopBuyList or {}

	if isCallback then
		self.boxInfo.shopBuyList[checknumber(data.buyTimes.itemId)] = checknumber(data.buyTimes.times)
	else
		self.boxInfo.drawTimes = data.drawTimes
		self.boxInfo.isShowTen = data.flag
		self.boxInfo.shopBuyList = {}

		for _, info in pairs(data.buyTimes or {}) do
			if info and checknumber(info.itemId) > 0 and checknumber(info.times) > 0 then
				self.boxInfo.shopBuyList[checknumber(info.itemId)] = checknumber(info.times)
			end
		end
	end

	GlobalDispatcher:dispatch("UpdataTreBoxBuyInfo")
end

function SevenDaysModel:SetShopGoodsBuyCount(itemId)
	local nowPlanId = self:GetNowOpenPlanId()

	if self.boxInfo == nil then
		return
	end

	if self.boxInfo.shopBuyList == nil then
		self.boxInfo.shopBuyList = {}
	end

	self.boxInfo.shopBuyList[itemId] = checknumber(self.boxInfo.shopBuyList[itemId]) <= 0 and 1 or self.boxInfo.shopBuyList[itemId] + 1

	GlobalDispatcher:dispatch("UpdataTreBoxBuyInfo")
end

function SevenDaysModel:SetExchangeGoodsBuyCount(isAll, activityId, data)
	if self.boxInfo == nil then
		return
	end

	if self.boxInfo.exchangeBuyList == nil then
		self.boxInfo.exchangeBuyList = {}
	end

	if self.boxInfo.exchangeBuyList[activityId] == nil then
		self.boxInfo.exchangeBuyList[activityId] = {}
	end

	if isAll then
		self.boxInfo.exchangeBuyList[activityId] = data
	else
		local isHave = false

		for i = 1, #self.boxInfo.exchangeBuyList[activityId] do
			if self.boxInfo.exchangeBuyList[activityId][i] and self.boxInfo.exchangeBuyList[activityId][i].itemId == data.itemId then
				self.boxInfo.exchangeBuyList[activityId][i].buyTimes = data.buyTimes
				isHave = true

				break
			end
		end

		if not isHave then
			table.insert(self.boxInfo.exchangeBuyList[activityId], data)
		end
	end

	GlobalDispatcher:dispatch("UpdataExchangeBuyInfo")
end

function SevenDaysModel:GetWishingWellInfo()
	if self.boxInfo == nil then
		self.boxInfo = {
			nextNewsTime = 0,
			isShowTen = false,
			drawTimes = 0,
			shopBuyList = {},
			newsInfoList = {},
			exchangeBuyList = {}
		}
	end

	return self.boxInfo
end

function SevenDaysModel:PushWishingWellBroadcast(data)
	local lastList

	if self.boxInfo == nil then
		self.boxInfo = {}
	end

	if self.boxInfo.newsInfoList and #self.boxInfo.newsInfoList > 0 then
		lastList = self.boxInfo.newsInfoList
	end

	self.boxInfo.nextNewsTime = checknumber(data.nextFreshTime) > 0 and math.ceil(checknumber(data.nextFreshTime) / 1000) or ServerTime.now() + 5
	self.boxInfo.newsInfoList = data.items

	GlobalDispatcher:dispatch("UpdataNewsInfoList", lastList)
end

function SevenDaysModel:PushWishingWellDraw(isWish, count, changeId)
	if isWish then
		count = count or 1

		if self.boxInfo == nil then
			self.boxInfo = {
				drawTimes = 0
			}
		end

		self.boxInfo.drawTimes = self.boxInfo.drawTimes + count
		self.boxChengeId = changeId
	end

	GlobalDispatcher:dispatch("UpdataWishingWellInfo", isWish, count)
end

function SevenDaysModel:CalculationFunctionOpen()
	if ActivityDefineConfig.instance == nil then
		return
	end

	if self.trboxTimerInfo == nil then
		self.trboxTimerInfo = {}
		self.trboxTimerInfo.timeAllCfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(self.trboxActivityType)
		self.trboxTimerInfo.openId = -1
		self.trboxTimerInfo.supTime = -1
	end

	local nowCfg

	for _, cfg in pairs(self.trboxTimerInfo.timeAllCfgs or {}) do
		if cfg and cfg.activityType and not string.nilorempty(cfg.startTime) and GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
			nowCfg = cfg
		end
	end

	local tempId = checknumber(self.trboxTimerInfo.openId)

	if nowCfg == nil then
		self.trboxTimerInfo.openId = -1
		self.trboxTimerInfo.supTime = -1

		if tempId > 0 then
			self:CleanTreasureView()
			GlobalDispatcher:dispatch(GlobalNotify.GetQilinData)
		end

		return
	end

	local endTimer = GameUtil.string2time(nowCfg.endTime)
	local nowTimer = ServerTime.now()
	local supTimer = endTimer - nowTimer

	if supTimer <= 0 then
		self.trboxTimerInfo.openId = -1
		self.trboxTimerInfo.supTime = -1

		if tempId > 0 then
			self:CleanTreasureView()
			GlobalDispatcher:dispatch(GlobalNotify.GetQilinData)
		end

		return
	end

	self.trboxTimerInfo.openId = nowCfg.activityId
	self.trboxTimerInfo.supTime = supTimer

	if tempId ~= nowCfg.activityId then
		GlobalDispatcher:dispatch(GlobalNotify.GetQilinData)
	end
end

function SevenDaysModel:GetFunctionIsOpen()
	if self.trboxTimerInfo == nil then
		return false
	end

	return checknumber(self.trboxTimerInfo.openId) > 0
end

function SevenDaysModel:GetFunctionActivityId()
	if self.trboxTimerInfo == nil then
		return -1
	end

	return checknumber(self.trboxTimerInfo.openId)
end

function SevenDaysModel:GetFunctionSupTimer()
	if not self:GetFunctionIsOpen() then
		return 0
	end

	return checknumber(self.trboxTimerInfo.supTime)
end

function SevenDaysModel:CalculationWishingWellOpen(isSupTime)
	local nowCfg
	local allCfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(self.trboxActivityType)

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and cfg.activityType and not string.nilorempty(cfg.startTime) and GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
			nowCfg = cfg
		end
	end

	if nowCfg == nil then
		return -1
	end

	if not isSupTime then
		return nowCfg.activityId
	end

	local endTimer = GameUtil.string2time(nowCfg.endTime)
	local nowTimer = ServerTime.now()

	if endTimer <= nowTimer then
		print("sr----天外飞石 SevenDaysModel:CalculationWishingWellOpen()     error计算的结果有误 id = " .. cfg.activityId)

		return -1, 0
	end

	return nowCfg.activityId, endTimer - nowTimer
end

function SevenDaysModel:GetNowOpenPlanId()
	local activityId = self:CalculationWishingWellOpen()

	if activityId <= 0 then
		return -1
	end

	local consumeCfg = TreasureBoxConfig.instance:GetConsumeCfg(activityId)

	if consumeCfg == nil then
		print("sr----天外飞石      SevenDaysModel:GetNowOpenPlanId()   error策划未配置这个活动 activityId = " .. activityId)

		return -1
	end

	return consumeCfg.planId
end

function SevenDaysModel:GetAwardedNewsTimer()
	if self.boxInfo == nil or checknumber(self.boxInfo.nextNewsTime) <= 0 then
		return ServerTime.now()
	end

	return self.boxInfo.nextNewsTime
end

function SevenDaysModel:GetAwardedNewsList()
	local tempList

	if self.boxNewsLastList and #self.boxNewsLastList > 0 then
		tempList = {}

		for i = 1, #self.boxNewsLastList do
			table.insert(tempList, {
				type = self.boxNewsLastList[i].type,
				name = self.boxNewsLastList[i].name,
				param = self.boxNewsLastList[i].param
			})
		end
	end

	self.boxNewsLastList = nil

	if self.boxInfo == nil or self.boxInfo.newsInfoList == nil or next(self.boxInfo.newsInfoList) == nil then
		return tempList
	end

	if self.boxInfo.newsInfoList and #self.boxInfo.newsInfoList > 0 then
		tempList = tempList or {}

		for i = 1, #self.boxNewsLastList do
			table.insert(tempList, {
				type = self.boxInfo.newsInfoList[i].type,
				name = self.boxInfo.newsInfoList[i].name,
				param = self.boxInfo.newsInfoList[i].param
			})
		end
	end

	return tempList
end

function SevenDaysModel:GetBaodiGoodsInfo()
	local planId = self:GetNowOpenPlanId()
	local baodiCfgs = TreasureBoxConfig.instance:GetBaodiCfg(planId)

	if baodiCfgs == nil or #baodiCfgs == 0 then
		print("sr----天外飞石      SevenDaysModel:GetBaodiGoodsInfo()    error方案配置获取 planId = " .. planId)

		return
	end

	if self.boxInfo then
		if not self.boxInfo.drawTimes then
			local useCount = 0
			local cfg

			for i = 1, #baodiCfgs do
				if useCount < baodiCfgs[i].times then
					cfg = baodiCfgs[i]

					break
				elseif baodiCfgs[i].times == useCount and baodiCfgs[i + 1] and useCount < baodiCfgs[i + 1].times then
					cfg = baodiCfgs[i + 1]

					break
				end
			end

			if cfg == nil then
				return
			end

			local supCount = cfg.times - useCount

			return string.split(cfg.prizeShow, ":"), supCount
		end
	end
end

function SevenDaysModel:GetAllGiftGoodsList()
	local planId = self:GetNowOpenPlanId()

	if planId <= 0 then
		print("sr----天外飞石      SevenDaysModel:GetAllGiftGoodsList()    error获取版本 planId = " .. planId)

		return
	end

	if self.giftAllList == nil then
		self.giftAllList = {}
	end

	if self.giftAllList[planId] == nil then
		self.giftAllList[planId] = {}

		local baodiCfgs = TreasureBoxConfig.instance:GetZhouqiJiangliList(planId, true)

		for _, str in pairs(baodiCfgs or {}) do
			if not string.nilorempty(str) then
				local list = string.split(str, ":")

				if list and #list >= 2 then
					table.insert(self.giftAllList[planId], {
						goodsType = checknumber(list[1]),
						goodsId = checknumber(list[2])
					})
				end
			end
		end
	end

	local tempList = {}

	if self.giftAllList[planId] and #self.giftAllList[planId] > 0 then
		for i = 1, #self.giftAllList[planId] do
			if self.giftAllList[planId][i] then
				local goodsType = self.giftAllList[planId][i].goodsType
				local goodsId = self.giftAllList[planId][i].goodsId
				local count = MaterialModel.instance:getMaterialsNumber(goodsType, goodsId)

				if count > 0 then
					local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)
					local var_51_0 = {
						goodsType = goodsType,
						goodsId = goodsId,
						goodsCount = count
					}

					if cfg then
						var_51_0.goodsName = cfg.name or ""
					end

					table.insert(tempList, var_51_0)
				end
			end
		end
	end

	return tempList
end

function SevenDaysModel:GetAllShopGoodsList()
	local planId = self:GetNowOpenPlanId()

	self.shopBuyList = self.shopBuyList or {}

	if self.shopBuyList[planId] == nil or #self.shopBuyList[planId] == 0 then
		local shopCfgs = TreasureBoxConfig.instance:GetShopBuyCfg(planId)

		if shopCfgs == nil or next(shopCfgs) == nil then
			print("sr----天外飞石      SevenDaysModel:GetAllShopGoodsList()    error获取礼包商城  planId = " .. planId)

			return
		end

		self.shopBuyList[planId] = {}

		for _, cfg in pairs(shopCfgs or {}) do
			if cfg and checknumber(cfg.itemId) > 0 then
				table.insert(self.shopBuyList[planId], {
					buyCount = 0,
					itemId = cfg.itemId,
					itemIcon = cfg.itemIcon,
					itemName = cfg.itemName,
					sellPrice = cfg.sellPrice,
					rmbId = cfg.goodsId,
					sellContent = (not string.nilorempty(cfg.sellContent) or nil) and string.split(cfg.sellContent, "#"),
					limitCount = checknumber(cfg.dailyLimitTimes)
				})
			end
		end

		if #self.shopBuyList[planId] > 1 then
			table.sort(self.shopBuyList[planId], function(a, b)
				return a.itemId < b.itemId
			end)
		end
	end

	if self.boxInfo == nil or self.boxInfo.shopBuyList == nil then
		return self.shopBuyList[planId]
	end

	if self.shopBuyList[planId] == nil or #self.shopBuyList[planId] == 0 then
		return
	end

	for i = 1, #self.shopBuyList[planId] do
		if self.shopBuyList[planId][i] then
			self.shopBuyList[planId][i].buyCount = self:GetShopBuyCount(self.shopBuyList[planId][i].itemId)
		end
	end

	return self.shopBuyList[planId]
end

function SevenDaysModel:GetShopBuyCount(itemId)
	if self.boxInfo == nil or self.boxInfo.shopBuyList == nil then
		return 0
	end

	return checknumber(self.boxInfo.shopBuyList[itemId])
end

function SevenDaysModel:GetAllExchangeGoodsList()
	local activityId = self:CalculationWishingWellOpen()

	if activityId <= 0 then
		print("sr----天外飞石   SevenDaysModel:GetAllExchangeGoodsList()   error兑换商城 activityId = " .. activityId)

		return
	end

	self.exchangeBuyList = self.exchangeBuyList or {}

	if self.exchangeBuyList[activityId] == nil or #self.exchangeBuyList[activityId] == 0 then
		local exchangeCfgs = ActivityshopConfig.instance:getActivityShopCfg(self.trboxActivityType, activityId)

		if exchangeCfgs == nil or next(exchangeCfgs) == nil then
			print("sr----天外飞石      SevenDaysModel:GetAllExchangeGoodsList()   error获取兑换商城配置  activityId = " .. activityId)

			return
		end

		self.exchangeBuyList[activityId] = {}

		for _, cfg in pairs(exchangeCfgs or {}) do
			if cfg and checknumber(cfg.shopItemId) > 0 then
				table.insert(self.exchangeBuyList[activityId], {
					shopItemId = cfg.shopItemId,
					name = cfg.name,
					sellContent = string.split(cfg.sellContent, ":"),
					sellPrice = string.split(cfg.sellPrice, ":"),
					sellPeriodLimit = cfg.sellPeriodLimit,
					sellLimitCount = cfg.sellLimitCount,
					activityId = cfg.activityId
				})
			end
		end

		if #self.exchangeBuyList[activityId] > 1 then
			table.sort(self.exchangeBuyList[activityId], function(a, b)
				return a.shopItemId < b.shopItemId
			end)
		end
	end

	if self.boxInfo == nil or self.boxInfo.exchangeBuyList == nil then
		return self.exchangeBuyList[activityId]
	end

	if self.exchangeBuyList[activityId] == nil or #self.exchangeBuyList[activityId] == 0 then
		return
	end

	for i = 1, #self.exchangeBuyList[activityId] do
		if self.exchangeBuyList[activityId][i] and self.exchangeBuyList[activityId][i].sellPeriodLimit ~= "none" then
			self.exchangeBuyList[activityId][i].buyCount = self:GetExchangeBuyCount(self.exchangeBuyList[activityId][i].activityId, self.exchangeBuyList[activityId][i].shopItemId)
		end
	end

	return self.exchangeBuyList[activityId]
end

function SevenDaysModel:GetExchangeBuyCount(activityId, shopItemId)
	if self.boxInfo == nil or self.boxInfo.exchangeBuyList == nil or self.boxInfo.exchangeBuyList[activityId] == nil then
		return 0
	end

	for _, info in pairs(self.boxInfo.exchangeBuyList[activityId]) do
		if info and info.itemId == shopItemId then
			return info.buyTimes
		end
	end

	return 0
end

function SevenDaysModel:GetShopViewRedpoint()
	local shopList = self:GetAllShopGoodsList()

	if shopList == nil or #shopList == 0 then
		return false
	end

	for i = 1, #shopList do
		if shopList[i] and string.nilorempty(shopList[i].rmbId) and string.nilorempty(shopList[i].sellPrice) and checknumber(shopList[i].buyCount) < checknumber(shopList[i].limitCount) then
			return true
		end
	end

	return false
end

function SevenDaysModel:GetWishCountRedpoint()
	local activityId = self:CalculationWishingWellOpen()

	if activityId <= -1 then
		return false
	end

	local consumeCfg = TreasureBoxConfig.instance:GetConsumeCfg(activityId)

	if consumeCfg == nil or string.nilorempty(consumeCfg.consume) then
		print("sr----天外飞石    SevenDaysModel:GetWishCountRedpoint()   error活动配置 activityId = " .. activityId)

		return false
	end

	local goodsList = string.split(consumeCfg.consume, ":")
	local goodsType = checknumber(goodsList[1])
	local goodsId = checknumber(goodsList[2])
	local goodsCount = checknumber(goodsList[3])
	local haveCount = MaterialModel.instance:getMaterialsNumber(goodsType, goodsId)

	return goodsCount <= haveCount
end

function SevenDaysModel:CleanTreasureView()
	if ViewMgr.instance:isOpen(ViewName.TreasureBox) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.TreasureExchange) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.TreasureShop) then
		return
	end

	local list = UIStateManager.instance:getCurStacks()

	if list and #list >= 1 then
		for i = #list, 1, -1 do
			if list[i] and not string.nilorempty(list[i].state) and (list[i].state == ViewName.TreasureBox or list[i].state == ViewName.TreasureShop or list[i].state == ViewName.TreasureExchange) then
				UIStateManager.instance:_clearExistState(list[i].state)
			end
		end
	end
end

function SevenDaysModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

SevenDaysModel.instance = SevenDaysModel.New()

return SevenDaysModel
