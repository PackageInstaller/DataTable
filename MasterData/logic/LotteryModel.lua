-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/model/LotteryModel.lua

module("logic.extensions.lottery.model.LotteryModel", package.seeall)

local LotteryModel = class("LotteryModel", BaseModel)

LotteryModel.UpdataZhaohuanTimes = "UpdataZhaohuanTimes"
LotteryModel.ZhaohuanSelectPetUpdate = "ZhaohuanSelectPetUpdate"

function LotteryModel:ctor()
	self.buyUseCount = 0
	self.poolPrizeList = nil
	self.poolTimesList = nil
	self.freeTimesList = nil
	self.lastSSRList = nil
	self.wishPetsList = nil
	self.openTabIndex = 1
	self.buyGoldInfo = nil
	self.isAnnualFee = false
	self.shopInfoList = nil
	self.isCallSSR = false
	self.callPoolId = 6
	self.progPrizeInfo = nil
	self.isFirstLogin = true
	self._groupUnlockList = nil
	self._cacheGroupList = nil
	self._bigPrizesInfo = nil
	self._bigPrizesResult = nil
end

function LotteryModel:onInit()
	LotteryModel.super.onInit(self)
	self:onReset()
end

function LotteryModel:onReset()
	self.poolTimesList = nil
	self.lastSSRList = nil
	self.wishPetsList = nil
	self.openTabIndex = 1
	self.buyGoldInfo = nil
	self.freeTimesList = nil
	self.isAnnualFee = false
	self.shopInfoList = nil

	local userId = RoleModel.instance:getUserId()
	local num = UnityEngine.PlayerPrefs.GetInt("LotterySixPool" .. userId)

	self.isCallSSR = checknumber(num) == self.callPoolId
	self.progPrizeInfo = nil
	self.isFirstLogin = true
	self._groupUnlockList = nil
	self._cacheGroupList = nil
	self._bigPrizesInfo = nil
	self._bigPrizesResult = nil
	self._selfSelectPool = {}
	self._poolSkipAnim = {}
end

function LotteryModel:getOpenPoolIndex(index, poolId)
	index = index or 1
	poolId = checknumber(poolId)

	local isGroup = self:IsPoolGroup(poolId)
	local list = isGroup and self:GetAllOpenPoolCfgs(poolId) or self:GetAllOpenPoolCfgs()

	if list == nil or #list == 0 then
		return index, list
	end

	if poolId <= 0 and list[index] and not list[index].isPre then
		return index, list
	end

	for i = 1, #list do
		if not list[i].isPre then
			if poolId <= 0 then
				index = i

				break
			end

			if list[i].groupCfg then
				local temp = table.indexof(list[i].groupCfg.poolIds, poolId)

				if temp and temp > 0 then
					index = i

					break
				end
			elseif list[i].poolCfg.poolId == poolId then
				index = i

				break
			end
		end
	end

	index = math.max(index, 1)

	return index, list
end

function LotteryModel:GetAllOpenPoolCfgs(poolId)
	self._cacheGroupList = self._cacheGroupList or {}

	local groupCfgs = self:GetAllOpenGroupCfgs(poolId)
	local allCfg = LotteryConfig.instance:GetPoolCfg()
	local allList = {}

	for _, cfg in pairs(allCfg or {}) do
		local isOpen, isPre = self:getPoolIsOpenParams(cfg)

		if isOpen then
			if not cfg.prePool and checknumber(cfg.funcId) > 0 then
				if FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
					table.insert(allList, {
						poolCfg = cfg
					})
				end
			else
				table.insert(allList, {
					poolCfg = cfg,
					isPre = isPre
				})
			end
		end
	end

	if groupCfgs and #groupCfgs > 0 then
		for i = 1, #groupCfgs do
			if groupCfgs[i] and groupCfgs[i].poolCfg and groupCfgs[i].groupCfg then
				table.insert(allList, {
					poolCfg = groupCfgs[i].poolCfg,
					groupCfg = groupCfgs[i].groupCfg
				})
			end
		end
	end

	if #allList > 1 then
		table.sort(allList, function(a, b)
			return a.poolCfg.tabSort < b.poolCfg.tabSort
		end)
	end

	return allList
end

function LotteryModel:getPoolIsOpenParams(cfg)
	if cfg == nil or checknumber(cfg.tabSort) <= 0 or cfg.poolInGroup then
		return false, false, 0
	end

	local nowTime = ServerTime.nowServerLook()
	local startTime = 0
	local endTime = 0

	if cfg.openType <= LotteryController.OpenPoolType.OpenTime then
		if string.nilorempty(cfg.openDateTime) and string.nilorempty(cfg.endDateTime) then
			return true, false, 0
		end

		startTime = GameUtil.string2time(cfg.openDateTime)
		endTime = GameUtil.string2time(cfg.endDateTime)

		if endTime < startTime then
			if startTime <= nowTime then
				endTime = endTime + 86400
			elseif nowTime <= endTime then
				startTime = startTime - 86400
			end
		end
	elseif cfg.openType == LotteryController.OpenPoolType.StartDay then
		local openTimes = RoleModel.instance:getAreaOpenTimeSec()

		startTime, endTime = GameUtil.getTimestampOnStartAndEnd(openTimes, cfg.startDay, cfg.durationDay)
	elseif cfg.openType == LotteryController.OpenPoolType.BackDay then
		local prInfo = PlayerReturnModel.instance:getOpenActivityInfo()

		if prInfo and checknumber(prInfo.actId) > 0 and nowTime < prInfo.endTime then
			startTime = prInfo.endTime - 2592000
			endTime = prInfo.endTime
		else
			return false, false, 0
		end
	elseif cfg.openType == LotteryController.OpenPoolType.PlayerCreate then
		local time = RoleModel.instance:getActiveTimeSec()
		local day = GameUtil.getDaysByTimestamp(time, ServerTime.now())

		startTime, endTime = GameUtil.getTimestampOnStartAndEnd(time, checknumber(cfg.startDay), checknumber(cfg.durationDay))

		if day >= checknumber(cfg.startDay) and endTime >= ServerTime.now() then
			return true, false, endTime
		else
			return false, false, endTime
		end
	end

	if startTime <= nowTime and nowTime < endTime then
		return true, false, endTime
	end

	if cfg.prePool and nowTime < startTime then
		if cfg.openType == LotteryController.OpenPoolType.BackDay then
			return true, false, endTime
		else
			return true, true, endTime
		end
	end

	return false, false, 0
end

function LotteryModel:GetAllOpenGroupCfgs(poolId)
	local allCfgs = LotteryConfig.instance:GetAllPoolGroupCfgs()
	local tempList = {}

	poolId = checknumber(poolId)

	if poolId <= 0 then
		return tempList
	end

	self._cacheGroupList = self._cacheGroupList or {}

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and checknumber(cfg.recommendPoolId) > 0 and GameUtil.checkIsInTimePeriod(cfg.openTime, cfg.endTime) then
			local id = cfg.recommendPoolId

			if self:IsPoolGroupUnlock(cfg.groupId) then
				local temp = table.indexof(cfg.poolIds, poolId)

				if temp and temp > 0 then
					id = cfg.poolIds[temp]
				elseif checknumber(self._cacheGroupList[cfg.groupId]) > 0 then
					id = self._cacheGroupList[cfg.groupId]
				end
			end

			local poolCfg = LotteryConfig.instance:GetPoolCfg(id)

			if poolCfg then
				self._cacheGroupList[cfg.groupId] = id

				table.insert(tempList, {
					poolCfg = poolCfg,
					groupCfg = cfg
				})
			else
				self._cacheGroupList[cfg.groupId] = nil
			end
		end
	end

	return tempList
end

function LotteryModel:GetUseZhaohuanCount(poolId)
	local info = {
		todayCount = 0,
		useCount = 0
	}

	if checknumber(poolId) <= 0 then
		return info
	end

	if self.poolTimesList == nil or self.poolTimesList[poolId] == nil then
		return info
	end

	return self.poolTimesList[poolId]
end

function LotteryModel:SetUseZhaohuanCount(poolInfo, freeInfos, groupInfos)
	self.freeTimesList = freeInfos
	self.poolTimesList = {}
	self.lastSSRList = {}
	self.wishPetsList = {}
	self._groupUnlockList = {}

	for _, info in pairs(poolInfo or {}) do
		self:updateOneInfo(info)
	end

	for _, info in pairs(groupInfos or {}) do
		if info and checknumber(info.groupId) > 0 then
			self._groupUnlockList[info.groupId] = info.hasUnlockPool
		end
	end

	GlobalDispatcher:dispatch(LotteryModel.UpdataZhaohuanTimes)
end

function LotteryModel:updateOneInfo(info)
	if info and info.poolId then
		local poolId = checknumber(info.poolId)

		if poolId > 0 then
			self.poolTimesList[poolId] = {}
			self.poolTimesList[poolId].useCount = checknumber(info.times)
			self.poolTimesList[poolId].todayCount = checknumber(info.dailyDrawTimes)
			self.lastSSRList[poolId] = checknumber(info.lastSSR)

			if checknumber(info.wishPetRaceId) > 0 then
				self.wishPetsList[poolId] = checknumber(info.wishPetRaceId)
			end

			self:updataSelfSelectInfo(poolId, info.selfSelectInfo)
		end
	end
end

function LotteryModel:getUseCountByPoolId(poolId)
	if self.poolTimesList and self.poolTimesList[poolId] then
		return checknumber(self.poolTimesList[poolId].useCount)
	end

	return 0
end

function LotteryModel:GetHaveFreeCount(poolId)
	local timesList = {
		[1] = 0,
		[10] = 0
	}

	if self.freeTimesList == nil then
		return timesList, false
	end

	local poolCfg = LotteryConfig.instance:GetPoolCfg(poolId)
	local isComm = true

	if poolCfg and not string.nilorempty(poolCfg.consume) then
		local list = string.split(poolCfg.consume, ":")

		if list and checknumber(list[2]) == 36 then
			isComm = false
		end
	end

	local isGold = false

	for _, info in pairs(self.freeTimesList) do
		if info and checknumber(info.freeType) > 0 then
			if info.freeType == 3 then
				if not isComm then
					timesList[1] = timesList[1] + checknumber(info.dailyOnceFreeTimes)
					timesList[10] = timesList[10] + checknumber(info.dailyTenFreeTimes)

					if checknumber(info.dailyOnceFreeTimes) > 0 or checknumber(info.dailyTenFreeTimes) then
						isGold = true
					end
				end
			elseif (poolCfg and poolCfg.dailyFree or nil) and true then
				timesList[1] = timesList[1] + checknumber(info.dailyOnceFreeTimes)
				timesList[10] = timesList[10] + checknumber(info.dailyTenFreeTimes)
			end
		end
	end

	return timesList, isComm, isGold
end

function LotteryModel:UpdataZhaohuanCount(poolId, count, lastSSR)
	self.poolTimesList = self.poolTimesList or {}
	self.lastSSRList = self.lastSSRList or {}
	self.lastSSRList[poolId] = checknumber(lastSSR)

	if self.poolTimesList[poolId] == nil then
		self.poolTimesList[poolId] = {
			todayCount = 0,
			useCount = 0
		}
	end

	self.poolTimesList[poolId].useCount = self.poolTimesList[poolId].useCount + count
	self.poolTimesList[poolId].todayCount = self.poolTimesList[poolId].todayCount + count
end

function LotteryModel:UpdataWishPetsList(poolId, wishPetId)
	self.wishPetsList = self.wishPetsList or {}
	self.wishPetsList[poolId] = wishPetId

	GlobalDispatcher:dispatch("UpdataLotteryWishPets")
end

function LotteryModel:updataSelfSelectInfo(poolId, selfSelectInfo)
	if selfSelectInfo then
		self._selfSelectPool[poolId] = GameUtil.pbToTable(selfSelectInfo)
	else
		printError(">>>>>>>>>>>>>>>>>>>>>>>>>> NNNNNNNNNNN", poolId)
	end
end

function LotteryModel:getSelfSelectInfo(poolId)
	return self._selfSelectPool[poolId]
end

function LotteryModel:updateSelfSelectPet(poolId, gridId, raceId)
	local info = self._selfSelectPool[poolId]

	if info then
		info.selfSelectPets = info.selfSelectPets or {}

		local hasFind = false

		for i, v in ipairs(info.selfSelectPets) do
			if v.gridId == gridId then
				v.raceId = raceId
				info.selfSelectPets[i] = v
				hasFind = true

				break
			end
		end

		if hasFind == false then
			local obj = {}

			obj.gridId = gridId
			obj.raceId = raceId

			table.insert(info.selfSelectPets, obj)
		end

		self._selfSelectPool[poolId] = info
	end
end

function LotteryModel:resetSelfSelectPet(poolId)
	local info = self._selfSelectPool[poolId]

	if info then
		info.selfSelectPets = {}
		self._selfSelectPool[poolId] = info
	end
end

function LotteryModel:getSelfSelectTimes(poolId)
	local info = self._selfSelectPool[poolId]

	if info then
		return checknumber(info.selfSelectTimes)
	end

	return 0
end

function LotteryModel:updateSelfSelectTimes(poolId)
	local info = self._selfSelectPool[poolId]

	if info then
		local t = checknumber(info.selfSelectTimes)

		info.selfSelectTimes = math.max(0, t - 1)
	end
end

function LotteryModel:SCAcceptUnlockGroup(groupId, isUnlock)
	self._groupUnlockList = self._groupUnlockList or {}
	self._groupUnlockList[groupId] = isUnlock

	GlobalDispatcher:dispatch("UpdataUnlockGroup", groupId)
end

function LotteryModel:IsPoolGroupUnlock(groupId)
	if self._groupUnlockList == nil then
		return false
	end

	return self._groupUnlockList[groupId]
end

function LotteryModel:SetPoolGroupPoolId(groupId, poolId)
	self._cacheGroupList = self._cacheGroupList or {}
	self._cacheGroupList[groupId] = poolId

	GlobalDispatcher:dispatch("UpdataChoiseGroupPoolId", poolId)
end

function LotteryModel:IsPoolGroup(poolId)
	poolId = checknumber(poolId)

	local cfg = LotteryConfig.instance:GetPoolCfg(poolId)

	if cfg and cfg.poolInGroup then
		return true
	end

	return false
end

function LotteryModel:GetBuyCountInfo()
	local allCount = LotteryConfig.instance:GetDayAllCount()

	return self.buyUseCount, tonumber(allCount)
end

function LotteryModel:GetLotteryPoolIdIndex(poolId, isSetTab)
	local index = 1

	if checknumber(poolId) > 0 then
		local list = self:GetAllOpenPoolCfgs()

		if list and #list > 0 then
			for i = 1, #list do
				if list[i] and list[i].poolCfg.poolId == poolId then
					index = i

					break
				end
			end
		end
	end

	if isSetTab then
		self.openTabIndex = index
	end

	return index
end

function LotteryModel:GetShoppingGiftInfo(strKey)
	if string.nilorempty(strKey) then
		return nil
	end

	local strs = string.split(strKey, ":")

	if strs == nil or string.nilorempty(strs[1]) or string.nilorempty(strs[2]) then
		return nil
	end

	local data = LotteryConfig.instance:GetCommonPrizeCfgByKey(strs[2])

	if data == nil or string.nilorempty(data.value) then
		return nil
	end

	local list = string.split(data.value, ",")

	if list == nil or #list == 0 then
		return nil
	end

	if checknumber(strs[1]) == 1 then
		for i = 1, #list do
			if not string.nilorempty(list[i]) then
				local strList = string.split(list[i], ":")
				local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(checknumber(strList[1]))

				if cfg and GameUtil.checkIsInTimePeriod(cfg.onlineTime, cfg.offlineTime) then
					if checknumber(strList[2]) == GameEnum.PayShopShopType.Payshop then
						if cfg.limitTimes == 0 or PayShopModel.instance:getMibaoBuyTimesById(cfg.id) < cfg.limitTimes then
							local zheStr = checknumber(cfg.disCount) <= 0 and "热销" or checknumber(cfg.disCount) / 100 .. "折"

							return {
								btnType = 1,
								itemType = 2,
								itemId = cfg.id,
								zheStr = zheStr,
								itemName = strList[3],
								icon = cfg.icon,
								payType = cfg.payType
							}
						end
					elseif checknumber(strList[2]) == GameEnum.PayShopShopType.Shop then
						if ShopModel.instance:getGoodsCount(cfg.id) > 0 then
							local isDiscount = PayShopController.instance:checkTimeStr(cfg.discountTime)
							local zheStr = "热销"

							if isDiscount and cfg.payType ~= GameEnum.PayShopPayType.RMB then
								local oldList = string.split(cfg.originalGoodsId, ":")
								local newList = string.split(cfg.discountGoodsId, ":")

								zheStr = math.floor(checknumber(newList[3]) / checknumber(newList[3]) * 10) .. "折"
							end

							return {
								btnType = 1,
								itemType = 1,
								itemId = cfg.id,
								zheStr = zheStr,
								itemName = strList[3],
								icon = cfg.content,
								payType = cfg.payType
							}
						end
					else
						FloatWordMgr.instance:show("配置了不支持的类型，伙计别瞎搞！")
					end
				end
			end
		end
	elseif checknumber(strs[1]) == 2 then
		local params = string.split(list[2], "#")

		return {
			zheStr = "热销",
			btnType = 2,
			jumpTo = list[1],
			itemName = params[1],
			icon = params[2]
		}
	end

	return nil
end

function LotteryModel:GetLotteryExplicitCfg(poolId)
	local cfg = LotteryConfig.instance:GetPoolCfg(poolId)

	if cfg == nil or checknumber(cfg.cycleCount) <= 0 then
		return -1
	end

	local useCount = 0

	if self.poolTimesList and self.poolTimesList[poolId] then
		useCount = self.poolTimesList[poolId].useCount
	end

	local lastSSR = 0

	if self.lastSSRList and checknumber(self.lastSSRList[poolId]) > 0 then
		lastSSR = self.lastSSRList[poolId]
	end

	if useCount <= lastSSR then
		return cfg.cycleCount
	end

	local supCount = useCount - lastSSR

	while supCount >= cfg.cycleCount do
		supCount = supCount - cfg.cycleCount
	end

	return cfg.cycleCount - supCount
end

function LotteryModel:GetLotteryProgressCfg(poolId)
	local allCfgs = LotteryConfig.instance:GetProgPrizeCfgs(poolId)

	if allCfgs == nil or #allCfgs == 0 then
		return nil
	end

	local useCount = 0

	if self.poolTimesList and self.poolTimesList[poolId] then
		useCount = self.poolTimesList[poolId].useCount
	end

	local cfg
	local index = 1

	for i = 1, #allCfgs do
		if allCfgs[i] and useCount < allCfgs[i].times then
			cfg = allCfgs[i]
			index = i

			break
		end
	end

	local data = {
		isFull = true
	}

	if cfg == nil or string.nilorempty(cfg.prize) then
		return data
	end

	local count = 0

	if index > 1 and allCfgs[index - 1] then
		count = allCfgs[index - 1].times
	end

	data.isFull = false
	data.startCount = count
	data.endCount = cfg.times
	data.useCount = useCount

	local list = string.split(cfg.prize, "#")

	if list and #list > 0 then
		data.goodsInfo = string.split(list[1], ":")
	end

	return data
end

function LotteryModel:getExpandShopRedponit(strKey)
	if string.nilorempty(strKey) then
		return false
	end

	local strs = string.split(strKey, ":")

	if strs == nil or string.nilorempty(strs[1]) or string.nilorempty(strs[2]) then
		return false
	end

	local data = LotteryConfig.instance:GetCommonPrizeCfgByKey(strs[2])

	if data == nil or string.nilorempty(data.value) then
		return false
	end

	local list = string.split(data.value, ",")

	if list == nil or string.nilorempty(list[3]) then
		return false
	end

	local ids = string.split(list[3], "#")

	for _, v in pairs(ids or {}) do
		if v and RedPointModel.instance:isActive(v) then
			return true
		end
	end

	return false
end

function LotteryModel:GetLotteryRedpointNew()
	if not FuncOpenModel.instance:getFuncLockDescription(43) then
		return false
	end

	if self.isFirstLogin then
		return self:GetLotteryRedpoint()
	end

	local allCfgs = self:GetAllOpenPoolCfgs()

	if allCfgs == nil or #allCfgs == 0 then
		return false
	end

	for i = 1, #allCfgs do
		if allCfgs[i] and allCfgs[i].poolCfg.dailyFree then
			local freeList = self:GetHaveFreeCount()

			if freeList and freeList[10] > 0 then
				return true
			end
		end
	end

	return false
end

function LotteryModel:GetLotteryRedpoint()
	local allCfgs = self:GetAllOpenPoolCfgs()

	if allCfgs == nil or #allCfgs == 0 then
		return false
	end

	for i = 1, #allCfgs do
		if allCfgs[i] and self:GetSubRedpointByCfg(allCfgs[i].poolCfg, true) then
			return true
		end
	end

	return false
end

function LotteryModel:GetSubRedpointByRP(redId)
	if not FuncOpenModel.instance:getFuncLockDescription(43) then
		return false
	end

	if checknumber(redId) <= 0 then
		return false
	end

	local allCfgs = self:GetAllOpenPoolCfgs()

	if allCfgs == nil or #allCfgs == 0 then
		return false
	end

	for i = 1, #allCfgs do
		if allCfgs[i] and checknumber(allCfgs[i].poolCfg.redpointId) == redId and self:GetSubRedpointByCfg(allCfgs[i].poolCfg) then
			return true
		end
	end

	return false
end

function LotteryModel:GetSubRedpointByCfg(cfg, isMain)
	if cfg == nil then
		return false
	end

	if self:GetSubRedpointByBigPrize(cfg.poolId) or self:getExpandShopRedponit(cfg.expandGiftKey) then
		return true
	end

	if cfg.dailyFree then
		local freeList = self:GetHaveFreeCount()

		if freeList and freeList[10] > 0 then
			return true
		end
	end

	local isShowRed = false
	local countList = LotteryConfig.instance:GetChouJiangTypeData()

	if countList == nil or countList[2] == nil then
		return isShowRed
	end

	if string.nilorempty(cfg.consume) then
		return isShowRed
	end

	local goodsList = string.split(cfg.consume, ":")

	if goodsList == nil or #goodsList < 3 then
		return isShowRed
	end

	local have = MaterialModel.instance:getMaterialsNumber(checknumber(goodsList[1]), checknumber(goodsList[2])) or 0
	local need = checknumber(goodsList[3])
	local zkStr, zk = self:getPoolConsumePlan(cfg)

	if not string.nilorempty(zkStr) then
		need = checknumber(zk)
	end

	local num = isMain and checknumber(countList[2]) or checknumber(countList[1])

	isShowRed = have >= need * num

	if isShowRed or string.nilorempty(cfg.consumeSubstitute) then
		return isShowRed
	end

	goodsList = string.split(cfg.consumeSubstitute, ":")

	if goodsList == nil or #goodsList < 3 then
		return isShowRed
	end

	have = MaterialModel.instance:getMaterialsNumber(checknumber(goodsList[1]), checknumber(goodsList[2])) or 0
	need = checknumber(goodsList[3])
	num = isMain and checknumber(countList[2]) or checknumber(countList[1])
	isShowRed = have >= need * num

	return isShowRed
end

function LotteryModel:GetSubRedpointByBigPrize(poolId)
	for _, list in pairs(allList or {}) do
		if list and #list > 0 then
			for i = 1, #list do
				if self:getSubRedpointByPosId(poolId, checknumber(list[i])) then
					return true
				end
			end
		end
	end

	return false
end

function LotteryModel:getSubRedpointByPosId(poolId, posId)
	local bigInfo = self:getLotteryBigPrizeInfo(poolId)

	if bigInfo and bigInfo.posInfo and bigInfo.posInfo[posId] then
		return false
	end

	return self:isSinglePosCanSetBigPrize(poolId, posId)
end

function LotteryModel:SetLotterySixPool(poolId, rare)
	if self.isCallSSR or self.callPoolId ~= poolId then
		return
	end

	if rare ~= 4 then
		return
	end

	self.isCallSSR = true

	local userId = RoleModel.instance:getUserId()

	UnityEngine.PlayerPrefs.SetInt("LotterySixPool" .. userId, poolId)
end

function LotteryModel:SetAllShopInfoDatas(data, poolId)
	if self.shopInfoList == nil then
		self.shopInfoList = {
			godList = {},
			commonList = {}
		}
	end

	if checknumber(poolId) > 0 then
		self.shopInfoList.godList = self.shopInfoList.godList or {}
		self.shopInfoList.godList[poolId] = {}
	else
		self.shopInfoList.commonList = {}
	end

	if data == nil then
		return
	end

	if checknumber(poolId) > 0 then
		self.shopInfoList.godList[poolId] = self.shopInfoList.godList[poolId] or {}

		for _, info in pairs(data.god or {}) do
			if info and checknumber(info.num) > 0 then
				self.shopInfoList.godList[poolId][info.itemId] = info.num
			end
		end
	else
		for _, info in pairs((not data.common or nil) and {}) do
			if info and checknumber(info.num) > 0 then
				self.shopInfoList.commonList[info.itemId] = info.num
			end
		end
	end

	GlobalDispatcher:dispatch("UpdataZhaohuanShop")
end

function LotteryModel:SetSingleShopInfoData(goodsId, poolId)
	if self.shopInfoList == nil then
		self.shopInfoList = {
			godList = {},
			commonList = {}
		}
	end

	if checknumber(poolId) <= 0 then
		if self.shopInfoList.commonList[goodsId] == nil then
			self.shopInfoList.commonList[goodsId] = 0
		end

		self.shopInfoList.commonList[goodsId] = self.shopInfoList.commonList[goodsId] + 1
	else
		self.shopInfoList.godList[poolId] = self.shopInfoList.godList[poolId] or {}

		if self.shopInfoList.godList[poolId][goodsId] == nil then
			self.shopInfoList.godList[poolId][goodsId] = 0
		end

		self.shopInfoList.godList[poolId][goodsId] = self.shopInfoList.godList[poolId][goodsId] + 1
	end

	GlobalDispatcher:dispatch("UpdataZhaohuanShop")
end

function LotteryModel:GetAllGoodsItems(poolId)
	if not self:IsShowScoreBtn(poolId) then
		return {}
	end

	self.shopInfoList = self.shopInfoList or {}

	local poolCfg = LotteryConfig.instance:GetPoolCfg(poolId)
	local list = string.split(poolCfg.pointPrize, ":")
	local have = MaterialModel.instance:getMaterialsNumber(tonumber(list[1]), tonumber(list[2]))
	local isGodShop = tonumber(list[2]) == 19
	local shopList, allCfgs

	if not isGodShop then
		allCfgs = LotteryConfig.instance:GetCommonShopItemCfgs()
		shopList = self.shopInfoList.commonList or {}
	else
		allCfgs = LotteryConfig.instance:GetGodShopItemCfgs(poolId)
		shopList = {}

		if self.shopInfoList.godList and self.shopInfoList.godList[poolId] then
			shopList = self.shopInfoList.godList[poolId]
		end
	end

	if allCfgs == nil then
		return {}
	end

	local tempList = {}

	for _, cfg in pairs(allCfgs or {}) do
		if cfg and (isGodShop or cfg.online) then
			local petInfo = string.split(cfg.prize, ":")
			local data = {}

			data.itemId = cfg.itemId
			data.cost = string.split(cfg.cost, ":")
			data.prize = petInfo
			data.haveNum = cfg.limit
			data.useNum = checknumber(shopList[cfg.itemId])
			data.isHave = false

			if petInfo and checknumber(petInfo[2]) > 0 and HandbookModel.instance:isHasPet(tonumber(petInfo[2])) then
				data.isHave = true
			end

			table.insert(tempList, data)
		end
	end

	if #tempList > 1 then
		table.sort(tempList, function(a, b)
			if a.isHave == b.isHave then
				return false
			end

			return a.isHave
		end)
	end

	return tempList, have
end

function LotteryModel:IsShowScoreBtn(poolId)
	local poolCfg = LotteryConfig.instance:GetPoolCfg(poolId)

	if poolCfg == nil or string.nilorempty(poolCfg.pointPrize) then
		return false
	end

	local list = string.split(poolCfg.pointPrize, ":")

	if list == nil or #list < 2 then
		return false
	end

	if tonumber(list[2]) ~= 19 then
		return true
	end

	local cfgList = LotteryConfig.instance:GetGodShopItemCfgs(poolId)

	return cfgList ~= nil
end

function LotteryModel:SetProgressPrizeDatas(poolId, data)
	self.progPrizeInfo = nil

	local allCfgs = LotteryConfig.instance:GetProgPrizeCfgs(poolId)

	if data == nil or allCfgs == nil or #allCfgs == 0 then
		return
	end

	self.progPrizeInfo = {}

	for i = 1, #allCfgs do
		local goodsList = self:GetProgressPrizeCfg(allCfgs[i], data)

		if goodsList and #goodsList > 0 then
			for j = 1, #goodsList do
				local list = string.split(goodsList[j], ":")

				if list and #list > 2 then
					table.insert(self.progPrizeInfo, {
						materialType = checknumber(list[1]),
						id = checknumber(list[2]),
						num = checknumber(list[3])
					})
				end
			end
		end
	end
end

function LotteryModel:GetProgressPrizeCfg(cfg, numList)
	if cfg == nil then
		return nil
	end

	for k, num in pairs(numList or {}) do
		if cfg.times == checknumber(num) and not string.nilorempty(cfg.prize) then
			return string.split(cfg.prize, "#")
		end
	end

	return nil
end

function LotteryModel:GetProgressPrizeDatas()
	return self.progPrizeInfo
end

function LotteryModel:GetWishPoolPetId(poolId)
	if self.wishPetsList == nil or checknumber(self.wishPetsList[poolId]) <= 0 then
		return
	end

	return checknumber(self.wishPetsList[poolId])
end

function LotteryModel:GetWishPoolStage(poolId)
	if checknumber(poolId) <= 0 then
		return -1
	end

	local cfg = LotteryConfig.instance:GetPoolCfg(poolId)

	if cfg == nil or cfg.wishLock < 0 then
		return -1
	end

	if cfg.wishLock == 0 then
		return 0
	end

	local useInfo = self:GetUseZhaohuanCount(poolId)

	return 1, cfg.wishLock, useInfo.useCount
end

function LotteryModel:GetWishLegendList(poolId)
	local num = 4
	local basePoolCfg = LotteryConfig.instance:GetBasePoolCfg(poolId)
	local tempList = {}
	local nowTime = ServerTime.now()

	for rate, list in pairs(basePoolCfg or {}) do
		if num <= checknumber(rate) and list and #list > 0 then
			for i = 1, #list do
				local needTimer = GameUtil.string2time(list[i].onlineTime)

				if needTimer <= nowTime and (not string.nilorempty(list[i].joinValidator) or nil) and FuncOpenController.instance:getConditionReached(list[i].joinValidator) then
					table.insert(tempList, list[i].raceId)
				end
			end
		end
	end

	return tempList, (self.wishPetsList and checknumber(self.wishPetsList[poolId]) > 0 or nil) and self.wishPetsList[poolId]
end

function LotteryModel:GetWishPoolRedPoint(poolId)
	local stage, need, have = self:GetWishPoolStage(poolId)

	if stage < 0 then
		return false
	end

	if stage > 0 and checknumber(need) > checknumber(have) then
		return false
	end

	if self.wishPetsList == nil or checknumber(self.wishPetsList[poolId]) <= 0 then
		return true
	end

	return false
end

function LotteryModel:getPoolConsumePlan(poolCfg)
	if poolCfg == nil or checknumber(poolCfg.discountPlanId) <= 0 then
		return nil, nil, nil
	end

	local list = LotteryConfig.instance:getConsumeDiscountCfg(poolCfg.discountPlanId)

	if list == nil then
		return nil, nil, nil
	end

	local temp

	for _, cfg in pairs(list) do
		if cfg and not string.nilorempty(cfg.discountTime) then
			local aa = string.split(cfg.discountTime, "|")

			if aa[1] ~= "时段" then
				temp = cfg

				break
			end

			local bb = string.split(aa[2], ",")

			if GameUtil.checkIsInTimePeriod(bb[1], bb[2]) then
				temp = cfg

				break
			end
		end
	end

	if temp == nil or string.nilorempty(temp.discountPrice) then
		return nil, nil, nil
	end

	local aa = string.split(temp.discountPrice, ":")
	local bb = string.split(poolCfg.consume, ":")

	if aa[1] == bb[1] and aa[2] == bb[2] then
		local zk = math.ceil(10 * checknumber(aa[3]) / checknumber(bb[3]))

		return string.format("%s%s折", temp.discountTag, zk), checknumber(aa[3]), temp
	end

	return nil, nil, nil
end

function LotteryModel:getLotteryOperateInfo(matStr)
	if string.nilorempty(matStr) then
		return nil, nil
	end

	local allCfgs = LotteryConfig.instance:getOperateCfgs()

	if allCfgs == nil or #allCfgs == 0 then
		return nil, nil
	end

	local isPass = true
	local goodsCfg

	for i = 1, #allCfgs do
		if allCfgs[i] and #allCfgs[i].itemIds > 0 then
			if not (allCfgs[i].funcId > 0 and FuncOpenModel.instance:getFuncIsOpen(allCfgs[i].funcId) or true) then
				if allCfgs[i].isShow then
					if string.nilorempty(allCfgs[i].consume) or allCfgs[i].consume == matStr then
						return allCfgs[i].indexId, false
					else
						return nil, nil
					end
				end
			else
				isPass = true

				for j = 1, #allCfgs[i].itemIds do
					goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(allCfgs[i].itemIds[j])

					if goodsCfg and goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 then
						local times = PayShopModel.instance:getMibaoBuyTimesById(allCfgs[i].itemIds[j])

						if checknumber(times) < goodsCfg.limitTimes then
							isPass = false

							break
						end
					else
						isPass = false

						break
					end
				end

				if not isPass then
					if string.nilorempty(allCfgs[i].consume) or allCfgs[i].consume == matStr then
						return allCfgs[i].indexId, true
					else
						return nil, nil
					end
				end
			end
		end
	end

	return nil, nil
end

function LotteryModel:getLotteryBigPrizeInfo(poolId)
	if self._bigPrizesInfo == nil or self._bigPrizesInfo[poolId] == nil then
		return {
			poolId = poolId,
			posInfo = {},
			gainInfo = {}
		}
	end

	return self._bigPrizesInfo[poolId]
end

function LotteryModel:getLotteryBigPrizeResult(poolId, isReset)
	if self._bigPrizesResult == nil then
		return false, 0
	end

	if self._bigPrizesResult.poolId ~= poolId then
		self._bigPrizesResult = nil

		return false, 0
	end

	local value = self._bigPrizesResult.isReset
	local challengeId = self._bigPrizesResult.changeSetId

	if isReset then
		self._bigPrizesResult = nil
	end

	return value, checknumber(challengeId)
end

function LotteryModel:isAllLotteryBigPrizeGain(poolId)
	if self._bigPrizesInfo == nil or self._bigPrizesInfo[poolId] == nil or self._bigPrizesInfo[poolId].gainInfo == nil then
		return false
	end

	local allPos = LotteryConfig.instance:getPoolSelectPrizeCfgs(poolId)

	if allPos == nil then
		return true
	end

	for row, list in pairs(allPos) do
		if row and list and #list > 0 then
			for i = 1, #list do
				if list[i] and self:isSinglePosCanSetBigPrize(poolId, posId) then
					return false
				end
			end
		end
	end

	return true
end

function LotteryModel:isSinglePosCanSetBigPrize(poolId, posId)
	if self._bigPrizesInfo == nil or self._bigPrizesInfo[poolId] == nil then
		return true
	end

	local info = self._bigPrizesInfo[poolId].gainInfo

	if info == nil or info[posId] == nil then
		return true
	end

	poolId = checknumber(poolId)
	posId = checknumber(posId)

	local cfgs = LotteryConfig.instance:getPoolSelectItemCfgs(poolId, posId)

	if cfgs == nil or #cfgs == 0 then
		return false
	end

	for _, v in pairs(cfgs) do
		if v and (v.limit <= 0 or v.limit > checknumber(info[posId][v.id])) then
			return true
		end
	end

	return false
end

function LotteryModel:isHaveSetBigPrizeGain(poolId)
	if self._bigPrizesInfo == nil or self._bigPrizesInfo[poolId] == nil then
		return false
	end

	for _, info in pairs(self._bigPrizesInfo[poolId].posInfo or {}) do
		if info and info.posId and info.prizeId then
			return true
		end
	end

	return false
end

function LotteryModel:isSetAllBigPrizeGain(poolId)
	if self._bigPrizesInfo == nil or self._bigPrizesInfo[poolId] == nil then
		return false
	end

	local posInfo = self._bigPrizesInfo[poolId].posInfo
	local allCfgs = LotteryConfig.instance:getPoolSelectPrizeCfgs(poolId)

	for _, list in pairs(allCfgs or {}) do
		if list and #list > 0 then
			for i = 1, #list do
				if posInfo == nil or posInfo[list[i]] == nil or posInfo[list[i]].prizeId == nil then
					return false
				end
			end
		end
	end

	return true
end

function LotteryModel:getSetSelectPrizeId(poolId, posId)
	local selectPrizeInfo = self._bigPrizesInfo[poolId]

	if not selectPrizeInfo.posInfo then
		if selectPrizeInfo.posInfo[posId] then
			if not selectPrizeInfo.posInfo[posId].prizeId then
				return 0
			end
		end
	end
end

function LotteryModel:getBigPrizeInfo(poolId)
	return self._bigPrizesInfo[poolId]
end

function LotteryModel:scSendLotterySelectPrizeDrawResult(msg, poolId)
	if msg == nil then
		self._bigPrizesResult = nil

		return
	end

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

	self._bigPrizesResult = {}
	self._bigPrizesResult.changeSetId = msg.changeSetId
	self._bigPrizesResult.poolId = poolId
	self._bigPrizesResult.isReset = msg.isReset
end

function LotteryModel:scSendLotterySelectPrizeInfo(msg)
	self._bigPrizesInfo = self._bigPrizesInfo or {}

	if msg == nil or msg.poolId == nil then
		return
	end

	if self._bigPrizesInfo[msg.poolId] == nil then
		self._bigPrizesInfo[msg.poolId] = {}
	end

	self._bigPrizesInfo[msg.poolId].poolId = msg.poolId
	self._bigPrizesInfo[msg.poolId].posInfo = {}

	for _, v in pairs(msg.posInfo or {}) do
		if v and v.posId and v.prizeId then
			self._bigPrizesInfo[msg.poolId].posInfo[v.posId] = {
				isGain = false,
				posId = v.posId,
				prizeId = v.prizeId
			}

			if msg.gainPosIds and table.indexof(msg.gainPosIds, v.posId) then
				self._bigPrizesInfo[msg.poolId].posInfo[v.posId].isGain = true
			end
		end
	end

	self._bigPrizesInfo[msg.poolId].gainInfo = {}

	for _, v in pairs(msg.gainTimes or {}) do
		if v and v.posId and v.prizeId then
			if self._bigPrizesInfo[msg.poolId].gainInfo[v.posId] == nil then
				self._bigPrizesInfo[msg.poolId].gainInfo[v.posId] = {}
			end

			self._bigPrizesInfo[msg.poolId].gainInfo[v.posId][v.prizeId] = checknumber(v.times)
		end
	end
end

function LotteryModel:scSendLotterySelectPrizeSetPos(poolId, posInfo)
	if self._bigPrizesInfo == nil or self._bigPrizesInfo[poolId] == nil then
		return
	end

	for _, v in pairs(posInfo or {}) do
		if v and v.posId and v.prizeId then
			self._bigPrizesInfo[poolId].posInfo[v.posId] = {
				isGain = false,
				posId = v.posId,
				prizeId = v.prizeId
			}
		end
	end
end

function LotteryModel:scSendLotterySelectPrizeReset(poolId)
	if self._bigPrizesInfo == nil or self._bigPrizesInfo[poolId] == nil then
		return
	end

	self._bigPrizesInfo[poolId].posInfo = {}
end

function LotteryModel:changePoolSkipAnim(poolId)
	local poolCfg = LotteryConfig.instance:GetPoolCfg(poolId)

	if not poolCfg.skipAnim then
		self._poolSkipAnim[poolId] = false

		return
	end

	self._poolSkipAnim[poolId] = not self._poolSkipAnim[poolId]
end

function LotteryModel:getPoolSkipAnim(poolId)
	return self._poolSkipAnim[poolId]
end

LotteryModel.instance = LotteryModel.New()

return LotteryModel
