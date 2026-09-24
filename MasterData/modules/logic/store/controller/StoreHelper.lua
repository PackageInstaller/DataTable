-- chunkname: @modules/logic/store/controller/StoreHelper.lua

module("modules.logic.store.controller.StoreHelper", package.seeall)

local StoreHelper = class("StoreHelper", BaseController)

function StoreHelper.getRecommendStoreSecondTabConfig()
	local secondTabConfigs = StoreModel.instance:getRecommendSecondTabs(StoreEnum.StoreId.RecommendStore, true)
	local showSecondTabConfigs = {}
	local relationStoreIdsDic = {}

	if secondTabConfigs and #secondTabConfigs > 0 then
		local SummonPools = SummonMainModel.getValidPools()
		local openSummonPoolDic = {}

		for i, v in ipairs(SummonPools) do
			openSummonPoolDic[v.id] = v
		end

		for i = 1, #secondTabConfigs do
			local co = StoreConfig.instance:getStoreRecommendConfig(secondTabConfigs[i].id)

			if co == nil then
				table.insert(showSecondTabConfigs, secondTabConfigs[i])
			elseif StoreHelper._inOpenTime(co) then
				local pass, _, storeIdsDic = StoreHelper._checkRelations(co.relations, secondTabConfigs, openSummonPoolDic)

				for storeId, _ in pairs(storeIdsDic) do
					relationStoreIdsDic[storeId] = true
				end

				if pass then
					table.insert(showSecondTabConfigs, secondTabConfigs[i])
				end
			end
		end
	end

	local storeIds = {}

	for i, v in pairs(relationStoreIdsDic) do
		table.insert(storeIds, i)
	end

	return showSecondTabConfigs, storeIds
end

function StoreHelper._inOpenTime(co)
	local serverTime = ServerTime.now()
	local openTime = string.nilorempty(co.onlineTime) and serverTime or TimeUtil.stringToTimestamp(co.onlineTime) - ServerTime.clientToServerOffset()
	local endTime = string.nilorempty(co.offlineTime) and serverTime or TimeUtil.stringToTimestamp(co.offlineTime) - ServerTime.clientToServerOffset()

	return co.isOffline == 0 and openTime <= serverTime and serverTime <= endTime
end

function StoreHelper._inRecommendGroupBTopTime(co)
	local serverTime = ServerTime.now()
	local openTime = string.nilorempty(co.onlineTime) and serverTime or TimeUtil.stringToTimestamp(co.onlineTime) - ServerTime.clientToServerOffset()
	local registerTime = ServerTime.timeInLocal(PlayerModel.instance:getPlayerRegisterTime() / 1000)

	if openTime <= registerTime then
		return false
	end

	local turnBackMo = TurnbackModel.instance:getCurTurnbackMo()

	if turnBackMo and turnBackMo:isInOpenTime() and openTime <= ServerTime.timeInLocal(turnBackMo.startTime) then
		return false
	end

	local duration = co.topDay == nil and 0 or co.topDay * TimeUtil.OneDaySecond
	local endTime = openTime + duration

	return co.isOffline == 0 and openTime <= serverTime and serverTime <= endTime
end

function StoreHelper.getRecommendStoreGroup(co, includeGroupD)
	if includeGroupD then
		local type = co.topType

		if type == StoreEnum.AdjustOrderType.MonthCard then
			if PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 0) == 0 or SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
				return StoreEnum.GroupOrderType.GroupA
			end

			local monthCardInfo = StoreModel.instance:getMonthCardInfo()

			if monthCardInfo ~= nil and monthCardInfo:getRemainDay() >= StoreEnum.MonthCardStatus.NotPurchase then
				return StoreEnum.GroupOrderType.GroupD
			end
		elseif type == StoreEnum.AdjustOrderType.SeasonCard then
			if PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 0) == 0 or SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
				return StoreEnum.GroupOrderType.GroupA
			end

			local monthCardInfo = StoreModel.instance:getMonthCardInfo()

			if monthCardInfo ~= nil and monthCardInfo:getRemainDay() >= StoreEnum.MonthCardStatus.NotPurchase then
				return StoreEnum.GroupOrderType.GroupD
			end
		elseif type == StoreEnum.AdjustOrderType.BattlePass and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay then
			return StoreEnum.GroupOrderType.GroupD
		end
	end

	if co.topDay < 0 then
		return StoreEnum.GroupOrderType.GroupA
	elseif co.topDay == 0 then
		return StoreEnum.GroupOrderType.GroupC
	elseif not StoreHelper._inRecommendGroupBTopTime(co) then
		return StoreEnum.GroupOrderType.GroupC
	end

	return StoreEnum.GroupOrderType.GroupB
end

function StoreHelper.getRecommendStoreGroupAndOrder(co, includeGroupD)
	local group = StoreHelper.getRecommendStoreGroup(co, includeGroupD)

	if not string.nilorempty(co.adjustOrder) then
		local groupOrderData = string.split(co.adjustOrder, "|")

		for _, data in ipairs(groupOrderData) do
			local info = string.split(data, "#")

			if group == tonumber(info[2]) then
				return group, tonumber(info[1])
			end
		end
	end

	return group, co.order
end

function StoreHelper.checkMonthCardLevelUpTagOpen()
	local serverTime = ServerTime.now()
	local offtime = CommonConfig.instance:getConstStr(ConstEnum.MonthCardLevelUpTime)
	local endTime = string.nilorempty(offtime) and serverTime or TimeUtil.stringToTimestamp(offtime) - ServerTime.clientToServerOffset()

	return serverTime <= endTime
end

function StoreHelper.checkNewMatUpTagOpen(goodsId)
	if not goodsId then
		return false
	end

	local str = CommonConfig.instance:getConstStr(ConstEnum.StorePackageNewMatChargeGoodIds)

	if string.nilorempty(str) then
		return false
	end

	local ok = false
	local strList = string.split(str, "#")

	for _, id in ipairs(strList or {}) do
		if tonumber(id) == goodsId then
			ok = true

			break
		end
	end

	if not ok then
		return false
	end

	local offtime = CommonConfig.instance:getConstStr(ConstEnum.StorePackageNewMatTime)

	if string.nilorempty(offtime) then
		return false
	end

	return ServerTime.now() <= TimeUtil.stringToTimestamp(offtime)
end

function StoreHelper._checkRelations(relations, secondTabConfigs, openSummonPoolDic)
	local arr = GameUtil.splitString2(relations, true)
	local needPackageInfo = false
	local show = false
	local relationStoreIdsDic = {}

	if string.nilorempty(relations) == false and arr and #arr > 0 then
		for i, v in ipairs(arr) do
			local pass = true
			local relationType = v[1]
			local relationId = v[2]

			if relationType == StoreEnum.RecommendRelationType.Summon then
				if openSummonPoolDic[relationId] == nil then
					pass = false
				end
			elseif relationType == StoreEnum.RecommendRelationType.PackageStoreGoods then
				local storePackageGoodsMO = StoreModel.instance:getGoodsMO(relationId)

				pass = (storePackageGoodsMO == nil or storePackageGoodsMO:isSoldOut()) and false
				needPackageInfo = true
			elseif relationType == StoreEnum.RecommendRelationType.StoreGoods then
				local storeGoodsMO = StoreModel.instance:getGoodsMO(relationId)

				pass = (storeGoodsMO == nil or storeGoodsMO:isSoldOut() or storeGoodsMO:alreadyHas()) and false

				local goodsConfig = StoreConfig.instance:getGoodsConfig(relationId)

				if goodsConfig then
					relationStoreIdsDic[goodsConfig.storeId] = true
				end
			elseif relationType == StoreEnum.RecommendRelationType.OtherRecommendClose then
				local co = StoreConfig.instance:getStoreRecommendConfig(relationId)

				if StoreHelper._inOpenTime(co) and StoreHelper._checkRelations(co.relations, secondTabConfigs, openSummonPoolDic) then
					pass = false
				end
			elseif relationType == StoreEnum.RecommendRelationType.BattlePass then
				if BpModel.instance:isEnd() then
					pass = false
				end
			elseif relationType == StoreEnum.RecommendRelationType.PackageStoreGoodsNoBuy then
				local storePackageGoodsMO = StoreModel.instance:getGoodsMO(relationId)

				if storePackageGoodsMO and not storePackageGoodsMO:isSoldOut() then
					show = false
					pass = false

					break
				end
			end

			show = show or pass
		end
	else
		show = true
	end

	return show, needPackageInfo, relationStoreIdsDic
end

function StoreHelper.getRemainExpireTime(storeEntranceCfg)
	local time = storeEntranceCfg.endTime

	if type(time) == "string" and not string.nilorempty(time) then
		time = TimeUtil.stringToTimestamp(time)

		return time - ServerTime.now()
	elseif type(time) == "number" then
		return time * 0.001 - ServerTime.now()
	end

	return 0
end

function StoreHelper.getRemainExpireTimeDeep(storeEntranceCfg)
	local deadlineTimeSec = StoreHelper.getRemainExpireTime(storeEntranceCfg)

	if deadlineTimeSec == 0 then
		local secondTabs = StoreModel.instance:getSecondTabs(storeEntranceCfg.id, true, true)

		for i = 1, #secondTabs do
			local timeSec = StoreHelper.getRemainExpireTime(secondTabs[i])

			if timeSec > 0 then
				deadlineTimeSec = math.max(timeSec, deadlineTimeSec)
			end
		end
	end

	return deadlineTimeSec
end

function StoreHelper.getRemainExpireTimeByStoreId(storeId)
	local deadlineTimeSec = 0
	local storeMo = StoreModel.instance:getStoreMO(storeId)
	local goods = storeMo and storeMo:getGoodsList()

	if goods and next(goods) then
		for _, v in pairs(goods) do
			if not string.nilorempty(v.config.offlineTime) and type(v.config.offlineTime) == "string" then
				local curGoodDeadlineTimeSec = TimeUtil.stringToTimestamp(v.config.offlineTime) - ServerTime.now()

				if curGoodDeadlineTimeSec > 0 then
					deadlineTimeSec = deadlineTimeSec == 0 and curGoodDeadlineTimeSec or math.min(curGoodDeadlineTimeSec, deadlineTimeSec)
				end
			end
		end
	end

	return deadlineTimeSec
end

function StoreHelper.getRemainExpireTimeDeepByStoreId(storeId)
	local deadlineTimeSec = 0
	local secondTabs = StoreModel.instance:getSecondTabs(storeId, true, true)

	for i = 1, #secondTabs do
		local timeSec = StoreHelper.getRemainExpireTimeByStoreId(secondTabs[i].id)

		if timeSec > 0 then
			deadlineTimeSec = deadlineTimeSec == 0 and timeSec or math.min(timeSec, deadlineTimeSec)
		end
	end

	return deadlineTimeSec
end

function StoreHelper.checkIsShowCoBrandedTag(goodsId)
	if not goodsId then
		return false
	end

	local str = CommonConfig.instance:getConstStr(ConstEnum.StorePackageShowCoBradedTagGoodIds)

	if string.nilorempty(str) then
		return false
	end

	local strList = string.split(str, "#")

	for _, id in ipairs(strList or {}) do
		if tonumber(id) == goodsId then
			return true
		end
	end

	return false
end

function StoreHelper.getEndTimeStampByGoodsCfgMO(goodsCfg, goodsMO)
	local showRefreshTime = StoreHelper.getShowRefreshTimeByGoodsCfg(goodsCfg)

	if showRefreshTime == StoreEnum.RefreshTime.Day then
		return ServerTime.getToadyEndTimeStamp(true)
	elseif showRefreshTime == StoreEnum.RefreshTime.Week then
		return ServerTime.getWeekEndTimeStamp(true)
	elseif showRefreshTime == StoreEnum.RefreshTime.Month then
		return ServerTime.getMonthEndTimeStamp(true)
	elseif showRefreshTime == StoreEnum.RefreshTime.Version and goodsMO and goodsMO.offlineTime then
		return goodsMO.offlineTime
	end

	return -1
end

function StoreHelper.isHasRefreshTimeByGoodsCfg(goodsCfg)
	local showRefreshTime = StoreHelper.getShowRefreshTimeByGoodsCfg(goodsCfg)

	return StoreEnum.RefreshTime.Forever == showRefreshTime
end

function StoreHelper.getShowRefreshTimeByGoodsCfg(goodsCfg)
	if goodsCfg then
		if goodsCfg.refreshTime == StoreEnum.RefreshTime.Forever and goodsCfg.showRefreshTime then
			return goodsCfg.showRefreshTime
		end

		return goodsCfg.refreshTime or StoreEnum.RefreshTime.Forever
	end

	return StoreEnum.RefreshTime.Forever
end

function StoreHelper.getShowRefreshTimeByGoodsMO(goodsMO)
	if goodsMO then
		local refreshTime = goodsMO.refreshTime

		if refreshTime == StoreEnum.RefreshTime.Forever and goodsMO.config and goodsMO.config.showRefreshTime then
			return goodsMO.config.showRefreshTime
		end

		return refreshTime or StoreEnum.RefreshTime.Forever
	end

	return StoreEnum.RefreshTime.Forever
end

function StoreHelper.getPackageIconBgIndex(goodsId, id, underlay)
	if not goodsId then
		return ChargePackageEnum.ItemBg.High
	end

	if underlay <= ChargePackageEnum.PackageType.SingleCurrencyPackage then
		return ChargePackageEnum.ItemBg.High
	end

	local mo = StoreModel.instance:getGoodsMO(goodsId)

	if not mo or not mo.isChargeGoods then
		return ChargePackageEnum.ItemBg.High
	end

	local price = PayModel.instance:getProductOriginPriceNum(id)
	local count = #ChargePackageEnum.ItemBgPriceList

	for i = count, 1, -1 do
		local targetPrice = ChargePackageEnum.ItemBgPriceList[i]

		if targetPrice < price then
			return i
		end
	end

	return ChargePackageEnum.ItemBg.Low
end

function StoreHelper.checkMonthCardRecommendTabIsFirst(tabId)
	local monthCardInfo = StoreModel.instance:getMonthCardInfo()

	if monthCardInfo == nil then
		return true
	end

	local remainDay = monthCardInfo:getRemainDay()

	if remainDay < StoreEnum.MonthCardStatus.NotEnoughThreeDay or SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
		return true
	end

	local seasonCard = StoreConfig.instance:getSeasonCardStoreChargeId()
	local seasonCardGoodsInfo = StoreModel.instance:getGoodsMO(seasonCard)

	if seasonCardGoodsInfo and not seasonCardGoodsInfo:isSoldOut() then
		return true
	end

	return false
end

function StoreHelper.checkDefaultTabIsFirst(tabId)
	local isShow, isActRedDot = StoreModel.instance:isTabMainRedDotShow(tabId)

	return isShow or isActRedDot
end

StoreHelper.checkStoreFirstHandler = {
	[StoreEnum.StoreId.MonthCardRecommend] = StoreHelper.checkMonthCardRecommendTabIsFirst
}

function StoreHelper.tryGetStoreDefaultTabHandler(tabId)
	if StoreHelper.checkStoreFirstHandler[tabId] then
		return StoreHelper.checkStoreFirstHandler[tabId]
	end

	return StoreHelper.checkDefaultTabIsFirst
end

function StoreHelper.getDefaultSelectFirstStoreTab(tabConfigList)
	if tabConfigList and next(tabConfigList) then
		for _, tabConfig in ipairs(tabConfigList) do
			local tabId = tabConfig.id

			if StoreEnum.DefaultSelectFirstTabList[tabId] then
				local handler = StoreHelper.tryGetStoreDefaultTabHandler(tabId)

				if handler and handler(tabId) then
					return tabId
				end
			end
		end
	end

	return StoreEnum.StoreId.Package
end

function StoreHelper.getDailyRefreshStoreList()
	local list = {}

	for _, storeId in ipairs(StoreEnum.DailyRefreshStoreIdList) do
		table.insert(list, storeId)
	end

	return list
end

function StoreHelper.getSkinGoodsPriceInfo(goodsConfig, optSkinId, optDeductionItemIndices)
	local info = StoreSkinPriceMO.New()

	info:reset(goodsConfig, optSkinId, optDeductionItemIndices)

	return info
end

function StoreHelper.getRewardGroupRateInfoList(itemEffect)
	itemEffect = tonumber(itemEffect)

	local rewardCO = lua_reward.configDict[itemEffect]
	local i = 0
	local list

	repeat
		i = i + 1

		local rewardGroup = rewardCO["rewardGroup" .. i]

		if string.nilorempty(rewardGroup) then
			return list
		end

		local strList = string.split(rewardGroup, ":")

		if strList then
			local group = strList[1]

			list = DungeonConfig.instance:getRewardGroupCOList(group)
		end
	until not strList or #strList == 0

	return list
end

return StoreHelper
