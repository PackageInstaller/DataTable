-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/model/YearCardModel.lua

module("logic.extensions.yearcard.model.YearCardModel", package.seeall)

local YearCardModel = class("YearCardModel", BaseModel)

function YearCardModel:ctor()
	return
end

function YearCardModel:onInit()
	return
end

function YearCardModel:onReset()
	self.curAnnuityId = 0

	self:resetAnnuityInfo()

	self._ifGetAnnuityInfo = false
	self.allYearActList = {}
	self._isInitInfo = false
end

function YearCardModel:resetAnnuityInfo()
	self.annuityInfoDic = {}
	self.annuityRankInfoDic = {}
end

function YearCardModel:setAnnuityInfo(annuityInfoList)
	self._isInitInfo = true
	self.allYearActList = {}

	if annuityInfoList then
		for i, v in ipairs(annuityInfoList) do
			table.insert(self.allYearActList, v.activityId)
			self:setSingleAnnuityInfo(v)
		end
	end

	self:updateRedPoint()
end

function YearCardModel:isInitInfo()
	return self._isInitInfo
end

function YearCardModel:updateRedPoint()
	local nowTime = ServerTime.now()

	for i, actId in ipairs(self.allYearActList) do
		local endTime = self:getEndTime(actId)
		local isExpire = endTime <= nowTime
		local isActive = not isExpire and self:isActiveAnnuity(actId)
		local redKey = RedPointModel.ID_YEARCAR_PROG_PRE .. actId
		local proList = YearCardConfig.instance:getProgressCfgList(actId)

		RedPointController.instance:setRedPointInfo(redKey, false)

		for j, cfg in ipairs(proList) do
			local has = self:getIsAbleToGetProgressPrizeId(actId, cfg.prizeId)

			if has then
				RedPointController.instance:setRedPointInfo(redKey, true)

				break
			end
		end

		local redWeek = RedPointModel.ID_YEARCAR_WEEK_PRE .. actId

		RedPointController.instance:setRedPointInfo(redWeek, false)

		if isActive and not self:getHasGainWeeklyPrize(actId) then
			RedPointController.instance:setRedPointInfo(redWeek, true)
		end

		local redMonthAll = RedPointModel.ID_YEARCAR_MONTH_PRE .. actId

		RedPointController.instance:setRedPointInfo(redMonthAll, false)

		local cfgList = YearCardConfig.instance:getMonthRewardCfgs(actId)

		if not cfgList then
			printError("年费报错日志 actId：", actId)

			cfgList = {}
		end

		for k, cfg in ipairs(cfgList) do
			local redMonth = RedPointModel.ID_YEARCAR_MONTH_PRE .. actId .. "_" .. cfg.prizeId

			RedPointController.instance:setRedPointInfo(redMonth, false)

			if isActive and YearCardController.instance:isCanGet(actId, cfg) and not self:getIsGainMonthPrize(actId, cfg.prizeId) then
				RedPointController.instance:setRedPointInfo(redMonth, true)
				RedPointController.instance:setRedPointInfo(redMonthAll, true)
			end
		end

		local redSpaceProgress = RedPointModel.ID_YEARCAR_SPACEPROGRESS .. actId

		RedPointController.instance:setRedPointInfo(redSpaceProgress, false)

		local cfgList = YearCardConfig.instance:getSpaceProgressPrizeCfgs(actId)

		for k, cfg in ipairs(cfgList or {}) do
			if isActive then
				::label_7_0::

				local isRed = YearCardController.instance:isCanGainSpaceProgress(actId, cfg.prizeId)

				if isRed then
					RedPointController.instance:setRedPointInfo(redSpaceProgress, true)

					break
				end
			end
		end
	end
end

function YearCardModel:setSingleAnnuityInfo(v)
	if not self.annuityInfoDic[v.activityId] then
		local annuityInfo = {}

		annuityInfo.activityId = v.activityId
		annuityInfo.money = v.money
		annuityInfo.active = v.active
		annuityInfo.hasGainFixedPrize = v:HasField("hasGainFixedPrize") and v.hasGainFixedPrize or nil
		annuityInfo.hasGainWeeklyPrize = v:HasField("hasGainWeeklyPrize") and v.hasGainWeeklyPrize or nil
		annuityInfo.monthPrizes = {}

		for k1, monthPrize in ipairs(v.monthPrizes) do
			local t = {}

			t.prizeId = monthPrize.prizeId
			t.gainArr = {}

			for k2, isGain in ipairs(monthPrize.gainArr) do
				t.gainArr[k2] = isGain
			end

			annuityInfo.monthPrizes[k1] = t
		end

		annuityInfo.expireTimeMillis = v:HasField("expireTimeMillis") and v.expireTimeMillis or nil
		annuityInfo.progressPrizeIds = {}

		for k1, v1 in ipairs(v.gainedProgressPrizeIds) do
			annuityInfo.progressPrizeIds[k1] = checkint(v1)
		end

		annuityInfo.annuityGifts = {}
		annuityInfo.preorderBuyTimes = {}

		for k1, giftInfo in ipairs(v.annuityGifts) do
			annuityInfo.annuityGifts[checkint(giftInfo.giftId)] = checkint(giftInfo.buyTimes)
			annuityInfo.preorderBuyTimes[giftInfo.giftId] = giftInfo.preorderBuyTimes
		end

		annuityInfo.activeCount = checkint(v.activeCount)
		annuityInfo.gainedSpaceProgressPrizeIds = {}

		for k1, v1 in ipairs(v.gainedSpaceProgressPrizeIds) do
			annuityInfo.gainedSpaceProgressPrizeIds[checkint(v1)] = true
		end

		annuityInfo.hasGainForwardPayPrize = v.hasGainForwardPayPrize
		annuityInfo.activeProgress = v.activeProgress
		annuityInfo.exchangeList = GameUtil.pbToTable(v.exchangeList)
		self.annuityInfoDic[v.activityId] = annuityInfo
	end
end

function YearCardModel:setHasGainWeeklyPrize(activityId, hasGainWeeklyPrize)
	if self.annuityInfoDic[activityId] then
		self.annuityInfoDic[activityId].hasGainWeeklyPrize = hasGainWeeklyPrize
	end

	self:updateRedPoint()
end

function YearCardModel:getHasGainWeeklyPrize(activityId)
	if self.annuityInfoDic[activityId] then
		return self.annuityInfoDic[activityId].hasGainWeeklyPrize
	else
		return false
	end
end

function YearCardModel:setHasGainFixedPrize(activityId, hasGainFixedPrize)
	if self.annuityInfoDic[activityId] then
		self.annuityInfoDic[activityId].hasGainFixedPrize = hasGainFixedPrize
	end
end

function YearCardModel:setActivateAnnuity(activityId)
	if self.annuityInfoDic[activityId] then
		self.annuityInfoDic[activityId].active = true
	end
end

function YearCardModel:isActiveAnnuity(activityId)
	if self.annuityInfoDic[activityId] then
		return self.annuityInfoDic[activityId].active
	else
		return false
	end
end

function YearCardModel:setIsGainMonthPrize(activityId, prizeId)
	printInfo("test setIsGainMonthPrize", activityId, prizeId)

	if self.annuityInfoDic[activityId] and self.annuityInfoDic[activityId].monthPrizes then
		for i, v in ipairs(self.annuityInfoDic[activityId].monthPrizes) do
			if v.prizeId == prizeId then
				local count = #v.gainArr

				for i = 1, count do
					v.gainArr[i] = true
				end

				break
			end
		end
	end

	self:updateRedPoint()
end

function YearCardModel:getIsGainMonthPrize(activityId, prizeId)
	if self.annuityInfoDic[activityId] then
		local list = self.annuityInfoDic[activityId].monthPrizes

		for i, v in ipairs(list) do
			if v.prizeId == prizeId then
				local totalCount = #v.gainArr
				local curGainCount = 0

				for i, isGain in ipairs(v.gainArr) do
					if isGain then
						curGainCount = curGainCount + 1
					end
				end

				if totalCount > 0 and curGainCount == totalCount then
					return true
				end
			end
		end
	end

	return false
end

function YearCardModel:getIsGetedRewardById(activityId, prizeId, id)
	if self.annuityInfoDic[activityId] then
		local list = self.annuityInfoDic[activityId].monthPrizes

		for i, v in ipairs(list) do
			if v.prizeId == prizeId then
				for i, isGain in ipairs(v.gainArr) do
					if i == id then
						return isGain
					end
				end

				return false
			end
		end
	end

	return false
end

function YearCardModel:getAnnuityInfo(activityId)
	return self.annuityInfoDic[activityId]
end

function YearCardModel:getAnnuityRankInfo(activityId)
	return self.annuityRankInfoDic[activityId]
end

function YearCardModel:getCurAnnuityId()
	return self.curAnnuityId
end

function YearCardModel:setCurAnnuityId(activityId)
	self.curAnnuityId = activityId
end

function YearCardModel:getIfGetAnnuityInfo(activityId)
	if self.annuityInfoDic[activityId] then
		return true
	end

	return false
end

function YearCardModel:setIfGetAnnuityInfo(torf)
	return
end

function YearCardModel:getEndTime(activityId)
	if self.annuityInfoDic[activityId] and self.annuityInfoDic[activityId].expireTimeMillis then
		return checknumber(self.annuityInfoDic[activityId].expireTimeMillis) / 1000
	else
		local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.FirstCharge, activityId)

		if actCfg then
			return GameUtil.string2time(actCfg.endTime)
		end

		return 1640293200
	end
end

function YearCardModel:getCurActIdByServerTime()
	local actTimeCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FirstCharge)

	if actTimeCfg then
		return actTimeCfg.activityId, actTimeCfg
	else
		return 0, nil
	end
end

function YearCardModel:setProgressPrizeId(actId, prizeId)
	local info = self:getAnnuityInfo(actId)

	if info then
		table.insert(info.progressPrizeIds, prizeId)
	end

	self:updateRedPoint()
end

function YearCardModel:getProgressPrizeIdState(actId, prizeId)
	local info = self:getAnnuityInfo(actId)

	if info then
		return table.keyof(info.progressPrizeIds, prizeId)
	end

	return false
end

function YearCardModel:getIsAbleToGetProgressPrizeId(actId, prizeId)
	local info = self:getAnnuityInfo(actId)

	if info then
		local progressCfg = YearCardConfig.instance:getProgressCfg(actId, prizeId)

		if progressCfg then
			local isHasGain = self:getProgressPrizeIdState(actId, prizeId)
			local isTimeAble = ServerTime.now() >= GameUtil.string2time(progressCfg.gainPrizeStartTime)
			local isMoneyAble = progressCfg.progressReq <= info.money

			return not isHasGain and isTimeAble and isMoneyAble, isHasGain, isTimeAble, isMoneyAble
		end
	end

	return false
end

function YearCardModel:isAbleToBuyGiftId(actId, giftId)
	local isAbleToBuy, isDateMatch, isBuyTimeLimit, isActive, isInPreoderTime, isUnlockCondition, isPreoderLimit = false, false, true, false, false, true, false
	local info = self:getAnnuityInfo(actId)

	if info then
		local giftCfg

		if actId < YearCardController.NewTypeActId then
			giftCfg = YearCardConfig.instance:getGiftCfg(actId, giftId)
		else
			giftCfg = YearCardConfig.instance:getNewGiftCfg(actId, giftId)

			if not string.nilorempty(giftCfg.unlockConditions) then
				local arr = string.split(giftCfg.unlockConditions, "#")
				local conditionStr = arr[1]
				local arr2 = string.split(arr[2], ",")
				local buyGiftId = checknumber(arr2[1])
				local buyTimeConst = checknumber(arr2[2])

				if not info.preorderBuyTimes[buyGiftId] then
					if conditionStr == "not_can_buy" then
						isUnlockCondition = info.preorderBuyTimes[buyGiftId] < buyTimeConst
					elseif conditionStr == "can_buy" then
						isUnlockCondition = buyTimeConst <= info.preorderBuyTimes[buyGiftId]
					end
				end
			end

			if not string.nilorempty(giftCfg.preorderStartTime) then
				isInPreoderTime = GameUtil.checkIsInTimePeriod(giftCfg.preorderStartTime, giftCfg.preorderEndTime)

				if isInPreoderTime then
					if not info.preorderBuyTimes[giftId] then
						local buyTime = 0

						isPreoderLimit = buyTime >= giftCfg.preorderTimesLimit
					end
				end
			end
		end

		isDateMatch = ServerTime.now() >= GameUtil.string2time(giftCfg.giftStartTime)
		isBuyTimeLimit = (info.annuityGifts[giftId] or 0) >= giftCfg.timesLimit
		isAbleToBuy = isDateMatch and not isBuyTimeLimit and not info.active and isUnlockCondition
		isActive = info.active
	end

	return isAbleToBuy, isDateMatch, isBuyTimeLimit, isActive, isInPreoderTime, isUnlockCondition, isPreoderLimit
end

function YearCardModel:onBuyGiftSuc(msg)
	local actId = checkint(msg.activityId)
	local info = self:getAnnuityInfo(actId)

	if info then
		local giftId = checkint(msg.giftId)

		info.annuityGifts[giftId] = (info.annuityGifts[giftId] or 0) + 1
		info.money = checkint(msg.newProgress)
		info.activeProgress = checkint(msg.activeProgress)

		if msg.preorderBuy then
			info.preorderBuyTimes[giftId] = (info.preorderBuyTimes[giftId] or 0) + 1
		end

		local actCfg = PayShopConfig.instance:getAnnuityCfgById(actId)
		local flag = info.active

		info.active = info.money >= actCfg.price

		if flag ~= info.active then
			info.activeCount = info.activeCount + 1

			FloatWordMgr.instance:show(lang("年费已激活成功，请点击领取进度奖励"))
			YearCardController.instance:getUserAnnuityInfo()
		end

		self:updateRedPoint()
	end
end

function YearCardModel:onGetRankInfo(msg)
	local actId = checkint(msg.activityId)
	local info = self:getAnnuityRankInfo(actId)

	if not info then
		info = {
			rankList = {}
		}
		info.myRank = -1
	end

	info.rankList = msg.infoList
	info.myRank = msg.myRank
	self.annuityRankInfoDic[actId] = info
end

function YearCardModel:onGainForWardPrize(msg)
	local actId = checkint(msg.actId)
	local info = self:getAnnuityInfo(actId)

	if info then
		info.hasGainForwardPayPrize = true
	end
end

function YearCardModel:isAbleToGetForwardPayPrize(actId)
	local curActId = checkint(actId)
	local info = self:getAnnuityInfo(curActId)

	if info then
		local isActive = info.active
		local isHasGainForWardPrize = info.hasGainForwardPayPrize
		local cfg = PayShopConfig.instance:getAnnuityCfgById(curActId)
		local curTimeType = GameUtil.getTimePeriodType(cfg.forwardPayOpenTime, cfg.forwardPayEndTime)
		local isInTime = curTimeType == GameUtil.inTimePeriod

		return isActive and not isHasGainForWardPrize and isInTime
	end

	return false
end

function YearCardModel:onGainSpaceProgressPrize(msg)
	local actId = checkint(msg.actId)
	local info = self:getAnnuityInfo(actId)

	if info then
		info.gainedSpaceProgressPrizeIds = {}

		for k1, v1 in ipairs(msg.gainedSpaceProgressPrizeIds) do
			info.gainedSpaceProgressPrizeIds[checkint(v1)] = true
		end
	end
end

function YearCardModel:getCurActiveCount(actId)
	local info = self:getAnnuityInfo(actId)

	if info then
		return info.activeCount
	end

	return 0
end

function YearCardModel:isGainSpaceProgress(actId, prizeId)
	local info = self:getAnnuityInfo(actId)

	if info and info.gainedSpaceProgressPrizeIds then
		return info.gainedSpaceProgressPrizeIds[prizeId]
	end

	return false
end

function YearCardModel:getExchangeList(activityId)
	if self.annuityInfoDic[activityId] then
		return self.annuityInfoDic[activityId].exchangeList
	end
end

function YearCardModel:onExchangeRes(msg)
	local info = self.annuityInfoDic[msg.activityId]

	if info then
		if not info.exchangeList then
			local isHit = false

			for i, v in ipairs(info.exchangeList) do
				if v.giftId == msg.exchangeInfo.giftId then
					isHit = true
					v.buyTimes = msg.exchangeInfo.buyTimes

					break
				end
			end

			if not isHit then
				table.table.insert(info.exchangeList, GameUtil.pbToTable(msg.exchangeInfo))

				info.exchangeList = info.exchangeList
			end
		end
	end
end

YearCardModel.instance = YearCardModel.New()

return YearCardModel
