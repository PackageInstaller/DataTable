-- chunkname: @modules/logic/roomfishing/controller/FishingController.lua

module("modules.logic.roomfishing.controller.FishingController", package.seeall)

local FishingController = class("FishingController", BaseController)

function FishingController:onInit()
	return
end

function FishingController:onInitFinish()
	return
end

function FishingController:addConstEvents()
	return
end

function FishingController:reInit()
	self._lastGetFriendInfoTime = nil
	self._enterFishingTime = nil
	self._tmpPrePoolUserId = nil
end

function FishingController:enterFishingMode(isBack)
	local isUnlock = FishingModel.instance:isUnlockRoomFishing(true)

	if not isUnlock then
		return
	end

	if isBack then
		local visitUserId = FishingModel.instance:getCurShowingUserId()
		local myUserId = PlayerModel.instance:getMyUserId()

		self:sendExitFishingTrack(StatEnum.RoomFishingResult.VisitBack, visitUserId, myUserId, true)
	else
		self._enterFishingTime = UnityEngine.Time.realtimeSinceStartup
	end

	RoomController.instance:enterRoom(RoomEnum.GameMode.Fishing, nil, nil, nil, nil, nil, true)
end

function FishingController:openFishingStoreView()
	local isUnlock = FishingModel.instance:isUnlockRoomFishing()

	if not isUnlock then
		return
	end

	StoreRpc.instance:sendGetStoreInfosRequest({
		StoreEnum.StoreId.RoomFishingStore
	}, self._afterGetStoreInfo, self)
end

function FishingController:_afterGetStoreInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomFishingStoreView)
end

function FishingController:openFishingRewardView(myFishingInfo, otherFishingInfo)
	if not myFishingInfo and not otherFishingInfo then
		return
	end

	local isInGuid = GuideController.instance:isGuiding()
	local isForbid = GuideController.instance:isForbidGuides()

	if isInGuid and not isForbid then
		return
	end

	ViewMgr.instance:openView(ViewName.RoomFishingRewardView, {
		myFishingInfo = myFishingInfo,
		otherFishingInfo = otherFishingInfo
	})
end

function FishingController:selectFriendTab(selectedTab)
	FishingFriendListModel.instance:onSelectFriendTab(selectedTab)
	self:dispatchEvent(FishingEvent.OnSelectFriendTab)
end

function FishingController:getFishingInfo(userId, cb, cbObj)
	if userId then
		FishingRpc.instance:sendGetOtherFishingInfoRequest(userId, cb, cbObj)
	else
		FishingRpc.instance:sendGetFishingInfoRequest(cb, cbObj)
	end
end

function FishingController:beginFishing(times, cb, cbObj)
	if not times then
		return
	end

	local curPoolUserId = FishingModel.instance:getCurShowingUserId()
	local isFishing = FishingModel.instance:getIsFishingInUserPool(curPoolUserId)

	if isFishing then
		return
	end

	local poolId = FishingModel.instance:getCurFishingPoolId()
	local fishingTime = FishingConfig.instance:getFishingTime(poolId)
	local remainSecond = FishingModel.instance:getCurFishingPoolRefreshTime()
	local hasEnoughTime = ((fishingTime or nil) and fishingTime * times) < remainSecond

	if not hasEnoughTime then
		GameFacade.showToast(ToastEnum.NoTimeToFishing)

		return
	end

	local isEnough = FishingModel.instance:isEnoughToFish(times)

	if not isEnough then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomFishingCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, self.openFishingExchange, nil, nil, self)

		return
	end

	local maxInFishingCount = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxInFishingCount, true, "#")
	local myFishingCount = FishingModel.instance:getMyFishingCount()

	if myFishingCount >= maxInFishingCount[1] then
		GameFacade.showToast(maxInFishingCount[2], maxInFishingCount[1])

		return
	end

	FishingRpc.instance:sendFishingRequest(curPoolUserId, times, cb, cbObj)
	self:dispatchEvent(FishingEvent.ShowFishingTip, false)
end

function FishingController:checkGetBonus(cb, cbObj)
	local curPoolUserId = FishingModel.instance:getCurShowingUserId()
	local isCanGetBonus = FishingModel.instance:isCanGetMyFishingBonusInUser(curPoolUserId)
	local isShowMyself = FishingModel.instance:getIsShowingMySelf()

	if not isCanGetBonus and isShowMyself then
		local canGetMyFishingBonus = FishingModel.instance:isCanGetMyFishingBonus()
		local canGetFriendBonus = FishingModel.instance:isCanGetOtherFishingBonus()

		isCanGetBonus = canGetMyFishingBonus or canGetFriendBonus
	end

	if isCanGetBonus then
		FishingRpc.instance:sendGetFishingBonusRequest(cb, cbObj)

		return true
	end
end

function FishingController:exchangeFishingCurrency(exchangeTimes, cb, cbObj)
	local targetItemData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")
	local targetItemQuantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, targetItemData[1])
	local maxCanHasCount = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true) or 0

	if maxCanHasCount < targetItemQuantity + exchangeTimes then
		GameFacade.showToast(ToastEnum.MaxCanHasFishingCurrency, maxCanHasCount)

		return
	end

	local maxCountData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxExchangeCount, true, "#")
	local hasExchangedTimes = FishingModel.instance:getHasExchangedTimes()

	if hasExchangedTimes + exchangeTimes > maxCountData[1] then
		GameFacade.showToast(maxCountData[2], maxCountData[1])

		return
	end

	FishingRpc.instance:sendChangeFishingCurrencyRequest(exchangeTimes, cb, cbObj)
end

local GET_FRIEND_INFO_INTERVAL = 2

function FishingController:getFriendListInfo(cb, cbObj)
	local curTime = Time.realtimeSinceStartup

	if (self._lastGetFriendInfoTime or nil) and curTime - self._lastGetFriendInfoTime < GET_FRIEND_INFO_INTERVAL then
		self:updateFriendListInfo()

		if cb then
			cb(cbObj)
		end
	else
		self._lastGetFriendInfoTime = curTime

		FishingRpc.instance:sendGetFishingFriendsRequest(cb, cbObj)
	end
end

function FishingController:visitOtherFishingPool(userId)
	if not userId then
		return
	end

	local myUserId = PlayerModel.instance:getMyUserId()

	if userId == myUserId then
		GameFacade.showToast(ToastEnum.VisitMyselfFishingPool)

		return
	end

	self._tmpPrePoolUserId = FishingModel.instance:getCurShowingUserId()

	FishingRpc.instance:sendGetOtherFishingInfoRequest(userId, self._afterGetOtherInfo, self)
end

function FishingController:_afterGetOtherInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local isShowMyself = FishingModel.instance:getIsShowingMySelf()

	if isShowMyself then
		if not StatEnum.RoomFishingResult.Visit then
			local result = StatEnum.RoomFishingResult.VisitNext

			self:sendExitFishingTrack(result, self._tmpPrePoolUserId, msg.userId, true)

			self._tmpPrePoolUserId = nil

			RoomController.instance:enterRoom(RoomEnum.GameMode.FishingVisit, nil, nil, {
				hasFishingVisitInfo = true,
				userId = msg.userId
			}, nil, nil, true)
		end
	end
end

function FishingController:updateFishingInfo(userId, fishingPoolInfo, friendInfo)
	if userId then
		FishingModel.instance:updateOtherPoolInfo(userId, fishingPoolInfo, friendInfo)
	else
		FishingModel.instance:updateMyselfPoolInfo(fishingPoolInfo)
	end

	ViewMgr.instance:closeView(ViewName.CommonExchangeView)
	self:dispatchEvent(FishingEvent.OnFishingInfoUpdate, userId)
end

function FishingController:onFishing(poolUserId, fishTimes, fishingProgressInfo)
	FishingModel.instance:updateMyProgressInfo(fishingProgressInfo)
	self:dispatchEvent(FishingEvent.OnFishingProgressUpdate)
end

function FishingController:onGetFishingBonus(info)
	FishingModel.instance:setHasGotShareRewardTimes(info and info.todayAcceptShareCount)

	local fishingProgressInfos = info and info.bonusInfo

	if not fishingProgressInfos then
		return
	end

	local myFishingInfo = {
		time = 0,
		poolIdList = {},
		fishingTimesDict = {}
	}
	local otherFishingInfo = {
		time = 0,
		poolIdList = {},
		fishingTimesDict = {}
	}

	for _, progressInfo in ipairs(fishingProgressInfos) do
		local poolId = progressInfo.poolId
		local fishTimes = progressInfo.fishTimes
		local startTime = progressInfo.startTime
		local endTime = progressInfo.finishTime
		local fishingInfo = progressInfo.type == FishingEnum.FishingProgressType.Myself and myFishingInfo or otherFishingInfo
		local hasFishingTimes = fishingInfo.fishingTimesDict[poolId]

		if hasFishingTimes then
			fishingInfo.fishingTimesDict[poolId] = hasFishingTimes + fishTimes
		else
			fishingInfo.fishingTimesDict[poolId] = fishTimes

			table.insert(fishingInfo.poolIdList, poolId)
		end

		fishingInfo.time = fishingInfo.time + endTime - startTime
	end

	self:openFishingRewardView(myFishingInfo, otherFishingInfo)
	self:getFishingInfo()
end

function FishingController:onExchangeFishingCurrency(exchangeTimes, hasExchangedTimes)
	FishingModel.instance:setHasExchangedTimes(hasExchangedTimes)
end

function FishingController:updateFriendListInfo(notFishingFriendInfo, forceUpdate)
	if notFishingFriendInfo or forceUpdate then
		FishingFriendListModel.instance:updateFriendListInfo(notFishingFriendInfo)
	else
		FishingFriendListModel.instance:setFriendList()
	end
end

function FishingController:openFishingExchange()
	local maxCountData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxExchangeCount, true, "#")
	local hasExchangedTimes = FishingModel.instance:getHasExchangedTimes()

	if hasExchangedTimes >= maxCountData[1] then
		GameFacade.showToast(maxCountData[2], maxCountData[1])

		return
	end

	local costMatData = MaterialDataMO.New()
	local targetMatData = MaterialDataMO.New()
	local costId = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.ExchangeCostCurrency, true)

	costMatData:initValue(MaterialEnum.MaterialType.Currency, costId)
	targetMatData:initValue(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomFishing)
	MaterialTipController.instance:openExchangeTipView(costMatData, targetMatData, self.exchangeFishingCurrency, self, self.getMaxFishingCurrencyExchangeTime, self, self.getFishingCurrencyExchangeNum, self)
end

function FishingController:getMaxFishingCurrencyExchangeTime()
	local maxLimit = 0
	local maxCostExchangeTimes = FishingConfig.instance:getMaxCostExchangeTimes()
	local maxCostNum = FishingConfig.instance:getExchangeCost(maxCostExchangeTimes)
	local costId = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.ExchangeCostCurrency, true)
	local itemQuantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, costId)
	local hasExchangedTimes = FishingModel.instance:getHasExchangedTimes()
	local newHasExchangeTimes = hasExchangedTimes + 1

	if maxCostExchangeTimes <= newHasExchangeTimes then
		maxLimit = math.floor(itemQuantity / maxCostNum)
	else
		local totalCostQuantity = 0

		while maxLimit < maxCostExchangeTimes do
			local costQuantity = FishingConfig.instance:getExchangeCost(newHasExchangeTimes)

			totalCostQuantity = totalCostQuantity + costQuantity

			if totalCostQuantity <= itemQuantity then
				maxLimit = maxLimit + 1
				newHasExchangeTimes = newHasExchangeTimes + 1
			else
				break
			end
		end

		if totalCostQuantity < itemQuantity then
			local canExchangeTimes = math.floor((itemQuantity - totalCostQuantity) / maxCostNum)

			maxLimit = maxLimit + canExchangeTimes
		end
	end

	local maxCanExchange = 0
	local maxCountData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxExchangeCount, true, "#")
	local maxExchangedTimes = maxCountData[1]

	if hasExchangedTimes < maxExchangedTimes then
		maxCanExchange = math.min(maxExchangedTimes - hasExchangedTimes, maxLimit)
	end

	local targetItemData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.OneFishCost, true, "#")
	local targetItemQuantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, targetItemData[1])
	local maxCanHasCount = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MaxHasFishingCurrency, true) or 0

	if targetItemQuantity <= maxCanHasCount then
		maxCanExchange = math.min(maxCanExchange, maxCanHasCount - targetItemQuantity)
	end

	return maxCanExchange, maxLimit
end

function FishingController:getFishingCurrencyExchangeNum(totalExchangeTimes)
	local totalCostQuantity = 0
	local hasExchangedTimes = FishingModel.instance:getHasExchangedTimes()

	for i = hasExchangedTimes + 1, hasExchangedTimes + totalExchangeTimes do
		local costQuantity = FishingConfig.instance:getExchangeCost(i)

		totalCostQuantity = totalCostQuantity + costQuantity
	end

	return totalCostQuantity, totalExchangeTimes
end

function FishingController:sendExitFishingTrack(result, beforeRoleId, afterRoleId, resetTime)
	if not self._enterFishingTime then
		return
	end

	local critterCoinQuantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomTrade)
	local fishingCoinQuantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.RoomFishing)
	local resourceMOList = FishingModel.instance:getBackpackItemList()
	local fishingResourcesList = {}

	for i, mo in ipairs(resourceMOList) do
		local cfg = ItemModel.instance:getItemConfigAndIcon(mo.type, mo.id)
		local var_25_0 = {
			materialtype = mo.type,
			materialid = mo.id
		}

		if cfg then
			var_25_0.materialname = cfg.name or ""
		end

		var_25_0.materialnum = mo.quantity
		fishingResourcesList[i] = var_25_0
	end

	local visitType = ""
	local myUserId = PlayerModel.instance:getMyUserId()

	if not string.nilorempty(afterRoleId) and afterRoleId ~= myUserId then
		local isFriend = SocialModel.instance:isMyFriendByUserId(afterRoleId)

		if not isFriend or not StatEnum.RoomFishingVisitType.Friend then
			::label_25_0::

			visitType = StatEnum.RoomFishingVisitType.Stranger
		end
	end

	local var_25_1 = {
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - self._enterFishingTime
	}

	var_25_1[StatEnum.EventProperties.RoomPivotLevel] = RoomModel.instance:getRoomLevel() or 0
	var_25_1[StatEnum.EventProperties.HaveFishingNum] = fishingCoinQuantity
	var_25_1[StatEnum.EventProperties.HaveCrittersCoin] = critterCoinQuantity
	var_25_1[StatEnum.EventProperties.FishingGroundBox] = fishingResourcesList
	var_25_1[StatEnum.EventProperties.BeforeRoleId] = beforeRoleId or ""
	var_25_1[StatEnum.EventProperties.AfterRoleId] = afterRoleId or ""
	var_25_1[StatEnum.EventProperties.VisitType] = visitType

	StatController.instance:track(StatEnum.EventName.ExitRoomFishing, var_25_1)

	self._enterFishingTime = resetTime and UnityEngine.Time.realtimeSinceStartup or nil
end

FishingController.instance = FishingController.New()

return FishingController
