-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/model/PayShopModel.lua

module("logic.extensions.payshop.model.PayShopModel", package.seeall)

local PayShopModel = class("PayShopModel", BaseModel)

PayShopModel.GetAllPayShopBuyTimesRes = "PayShopModel.GetAllPayShopBuyTimesRes"
PayShopModel.ChangeMibaoShopBuyTimes = "PayShopModel.ChangeMibaoShopBuyTimes"
PayShopModel.ChangeZQTHState = "PayShopModel.ChangeZQTHState"
PayShopModel.ForceUpdateView = "PayShopModel.ForceUpdateView"
PayShopModel.GoodsIdNeedJump = {
	[50053] = "ui#yearcardmain2026view#zhigou",
	[50070] = "ui#yearcardmain2026view#zhigou"
}
PayShopModel.GoodsIdNeedSetNotSell = {
	[50053] = 1,
	[50070] = 1
}

local table_sort = table.sort

function PayShopModel:ctor()
	self._goodsDefineId_2_jobIds = {}
end

function PayShopModel:onInit()
	self._cacheTagParma2Table = {}

	self:onReset()
	self:_parseInsert2MatStrKeyList()
	self:_resetIgnoreUpdateCfg()
end

function PayShopModel:onReset()
	self.mibaoAllBuyTimes = {}
	self.accConsumeGainedList = {}

	local accList = PayShopConfig.instance:getAccConsumeCfg()

	for i, v in ipairs(accList) do
		local single = TableUtil.deepcopy(v)

		single.get = false
		single.leftConsume = math.floor(v.leftConsume / 100)

		table.insert(self.accConsumeGainedList, single)
	end

	self.consumeMoney = 0
	self.curAnnuityId = 0

	self:resetAnnuityInfo()

	self._ifGetAnnuityInfo = false
	self.consumeGainedList = {}

	local firstChargeList = PayShopConfig.instance:getConsumeCfg()

	for i, v in ipairs(firstChargeList) do
		local single = v

		single.get = false

		table.insert(self.consumeGainedList, single)
	end

	self.firstConsumeMoney = 0
	self._isRecordTabIds = false
	self._recordDiscountId = false
	self._jumpPageTabTypes = false
	self._giftGainState = {}
	self._viewJumpInTag = false
	self._recordSkinSortIds = {}
	self._cacheGoodsfDefineId2MountId = {}
	self._petSearchStr = ""
end

function PayShopModel:getPetSearchStr()
	return self._petSearchStr
end

function PayShopModel:setPetSearchStr(str)
	self._petSearchStr = str
end

function PayShopModel:_parseInsert2MatStrKeyList()
	self._matStr2Cfgs = {}

	local cfgs = PayShopConfig.instance:getPayShopMibaoCfgs()

	for i, cfg in ipairs(cfgs.dataList) do
		local temp1 = string.split(cfg.content, "#")

		for _, matStr in ipairs(temp1) do
			local sindex, eindex = string.find(matStr, "^%d+:%d+")

			if sindex then
				local str = string.sub(matStr, sindex, eindex)
				local idList = self._matStr2Cfgs[str]

				if not idList then
					idList = {}
					self._matStr2Cfgs[str] = idList
				end

				idList[cfg.id] = cfg
			end
		end
	end
end

function PayShopModel:getLevel1TabCfgs()
	local tempCfgs = PayShopConfig.instance:getLevel1TabCfgs()
	local data = {}

	for i, v in ipairs(tempCfgs) do
		local isPass = self:_checkLevel1TabOpen(v.type)

		if isPass then
			table.insert(data, v)
		end
	end

	table.sort(data, function(a, b)
		return a.rank < b.rank
	end)

	return data
end

function PayShopModel:getLevel2TabCfgs(typeId)
	local data = {}
	local level2TabCfgs = PayShopConfig.instance:getLevel2TabCfgs(typeId)

	if level2TabCfgs then
		for k, v in pairs(level2TabCfgs) do
			local isOpen = self:_checkLevel2TabOpen(typeId, v.id)

			if isOpen then
				table.insert(data, v)
			end
		end
	end

	table.sort(data, function(a, b)
		return a.rank < b.rank
	end)

	return data
end

function PayShopModel:getLevel3TabCfgs(typeId, leve2Id)
	local data = {}
	local level3TabCfgs = PayShopConfig.instance:getLevel3TabCfgs(typeId, leve2Id)

	if level3TabCfgs then
		for k, v in pairs(level3TabCfgs) do
			local isOpen = self:_checkLevel3TabOpen(typeId, leve2Id, v.id)

			if isOpen then
				table.insert(data, v)
			end
		end
	end

	table.sort(data, function(a, b)
		return a.rank < b.rank
	end)

	return data
end

function PayShopModel:_checkLevel1TabOpen(typeId)
	local cfg = PayShopConfig.instance:getLevel1TabCfg(typeId)
	local isOpen = self:_checkOneTabCfgCommonCondition(cfg)

	if isOpen then
		local level2TabCfgs = PayShopConfig.instance:getLevel2TabCfgs(typeId)

		if level2TabCfgs then
			for k, v in pairs(level2TabCfgs) do
				isOpen = self:_checkLevel2TabOpen(typeId, v.id)

				if isOpen then
					break
				end
			end
		end
	end

	return isOpen
end

function PayShopModel:_checkLevel2TabOpen(typeId, id)
	local cfg = PayShopConfig.instance:getLevel2TabCfg(typeId, id)
	local isOpen = self:_checkOneTabCfgCommonCondition(cfg)

	if isOpen then
		local level3TabCfgs = PayShopConfig.instance:getLevel3TabCfgs(typeId, id)

		if level3TabCfgs then
			for k, v in pairs(level3TabCfgs) do
				isOpen = self:_checkLevel3TabOpen(typeId, id, v.id)

				if isOpen then
					break
				end
			end
		else
			isOpen = self:_checkTabContainGoods(cfg)
		end
	end

	return isOpen
end

function PayShopModel:_checkLevel3TabOpen(typeId, leve2Id, id)
	local cfg = PayShopConfig.instance:getLevel3TabCfg(typeId, leve2Id, id)
	local isOpen = false
	local commonOpen = self:_checkOneTabCfgCommonCondition(cfg)

	if commonOpen then
		isOpen = true

		if typeId == GameEnum.PayShopFirstTab.Mibao then
			isOpen = self:_getPayShopMibaoOneTabData(cfg)
		end
	end

	return isOpen
end

function PayShopModel:_checkTabCfgCommonCondition(cfgs)
	local data = {}

	for i, cfg in pairs(cfgs) do
		local isPass = self:_checkOneTabCfgCommonCondition(cfg)

		if isPass then
			table.insert(data, cfg)
		end
	end

	return data
end

function PayShopModel:_checkOneTabCfgCommonCondition(cfg)
	local isPass = false
	local isFuncOpen = cfg.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)

	if cfg.funcId == 93 then
		local fcfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.funcId)

		isFuncOpen = FuncOpenController.instance:getConditionReached(fcfg.openCondition, fcfg.openTime) and FuncOpenController.instance:getTimeReached(fcfg.activityType)
	end

	if isFuncOpen and cfg.funcId > 0 and cfg.funcId == GameEnum.FuncType.Family then
		isFuncOpen = FamilyController.instance:getFamilyLv() > 0
	end

	if isFuncOpen then
		if string.nilorempty(cfg.startTime) and string.nilorempty(cfg.endTime) and true or GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
			local isActivityOpen = FuncOpenController.instance:getTimeReached(cfg.activityType, cfg.activityIds)

			if isActivityOpen then
				isPass = true
			end
		end
	end

	isPass = self:_checkTabOpSpecialCondition(isPass, cfg.checkOpParam)

	return isPass
end

function PayShopModel:_checkTabOpSpecialCondition(isPass, checkOpParam)
	if isPass and not string.nilorempty(checkOpParam) then
		if string.find(checkOpParam, "challengeCardOffLine") then
			local isOffline = self:_checkMonthcardOffline(4)

			isPass = not isOffline
		elseif string.find(checkOpParam, "mengxinCardOffLine") then
			local isOffline = self:_checkMonthcardOffline(5)

			isPass = not isOffline
		elseif string.find(checkOpParam, "monthCardOffLine") then
			local stime = 1659646800

			if stime <= ServerTime.nowServerLook() then
				local times = MonthCardModel.instance:getActiveCardLeftTime(MonthCardModel.MonthCardId)

				if times <= 0 and not MonthCardModel.instance:checkCardRedDot(MonthCardModel.MonthCardId) then
					isPass = false
				end
			end
		elseif string.find(checkOpParam, "resMonthCardOffLine") then
			local stime = 1659646800

			if stime <= ServerTime.nowServerLook() then
				local times = MonthCardModel.instance:getActiveCardLeftTime(MonthCardModel.ResMonthCardId)

				if times <= 0 and not MonthCardModel.instance:checkCardRedDot(MonthCardModel.ResMonthCardId) then
					isPass = false
				end
			end
		elseif string.find(checkOpParam, "checkMonthCardOffLineById") then
			local arr = string.split(checkOpParam, "#")

			if #arr > 1 then
				local cardId = checknumber(arr[2])
				local isOffline = self:_checkMonthcardOffline(cardId)

				isPass = not isOffline
			end
		elseif string.find(checkOpParam, "checkBackMonthCardOffLineById") then
			local arr = string.split(checkOpParam, "#")

			if #arr > 2 then
				local cardId = checknumber(arr[2])
				local actId = checknumber(arr[3])
				local isOffline = self:_checkMonthcardOffline(cardId)
				local isEnd = PlayerReturnModel.instance:isOpenActivityEnd()

				isPass = false

				if not isEnd then
					local isActive = MonthCardModel.instance:isCardActive(cardId)

					if isActive then
						isPass = true
					else
						local cfg = MonthCardConfig.instance:getCfgById(cardId)

						if cfg and not string.nilorempty(cfg.offlineTime) then
							local endTime = GameUtil.string2time(cfg.offlineTime)

							isPass = endTime > ServerTime.now()
						else
							isPass = true
						end
					end
				else
					isPass = MonthCardModel.instance:isCardActive(cardId)
				end
			end
		end
	end

	return isPass
end

function PayShopModel:_checkMonthcardOffline(cardId)
	local isActive = MonthCardModel.instance:isCardActive(cardId)

	if not isActive then
		local cfg = MonthCardConfig.instance:getCfgById(cardId)

		if cfg and not string.nilorempty(cfg.offlineTime) then
			local endTime = GameUtil.string2time(cfg.offlineTime)

			return endTime <= ServerTime.now()
		end
	end

	return false
end

function PayShopModel:_checkTabContainGoods(tabCfg)
	if tabCfg.viewName == ViewName.PayShopMibaoView then
		local showType = checkint(tabCfg.param)

		if showType > 0 then
			local cfgs = PayShopConfig.instance:getGoodsCfgsByShopTypeAndShowType(GameEnum.PayShopShopType.Payshop, showType)

			if #cfgs > 0 then
				for _, cfg in pairs(cfgs) do
					if self:_checkGoodItemCfgIsOnsale(cfg) then
						return true
					end
				end
			end
		end

		return false
	end

	return true
end

function PayShopModel:getMibaoTabData()
	local cfgs = PayShopConfig.instance:getMibaoViewTopTabCfgs()

	return self:_getPayShopMibaoTabDatas(cfgs)
end

function PayShopModel:_getPayShopMibaoTabDatas(cfgs)
	local data = {}

	for i, tabCfg in pairs(cfgs) do
		if self:_getPayShopMibaoOneTabData(tabCfg) then
			table.insert(data, tabCfg)
		end
	end

	table_sort(data, function(a, b)
		return a.id < b.id
	end)

	return data
end

function PayShopModel:_getPayShopMibaoOneTabData(tabCfg)
	local canAdd = false

	if tabCfg.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(tabCfg.funcId) then
		canAdd = true

		if not string.nilorempty(tabCfg.startTime) and not string.nilorempty(tabCfg.endTime) then
			canAdd = GameUtil.checkIsInTimePeriod(tabCfg.startTime, tabCfg.endTime)
		end

		if canAdd then
			local items = PayShopConfig.instance:getPayShopMibaoGoodsCfgsByTabId(checknumber(tabCfg.param))

			canAdd = items and #items > 0

			if canAdd then
				canAdd = false

				local tabCanShow = false

				for _, cfg in ipairs(items) do
					local timeEnough = GameUtil.checkIsInTimePeriod(cfg.onlineTime, cfg.offlineTime)

					if timeEnough and (cfg.rechargeShowMoney <= 0 or cfg.rechargeShowMoney <= RoleModel.instance:getMyConsumeMoney()) then
						canAdd = true

						if not tabCfg.isAllTimeLimitBuy then
							break
						end
					end

					if canAdd then
						tabCanShow = self:getPayShopGoodsCanBuyById(cfg.id)

						if tabCanShow then
							break
						end
					end
				end

				if canAdd and tabCfg.isAllTimeLimitBuy and not tabCanShow then
					canAdd = false
				end
			end
		end
	end

	return canAdd
end

function PayShopModel:getMiBaoGoodDatasByTabId(id, sellKey, jobIds)
	local kVList = {}

	for _, v in ipairs(self.mibaoAllBuyTimes) do
		kVList[v.id] = v
	end

	local cfgList = PayShopConfig.instance:getPayShopMibaoGoodsCfgsByTabId(id)
	local finalList = {}

	if not cfgList then
		return {}
	end

	local lastList = {}
	local data
	local cfgKVList = {}
	local jobIdsKV = {}

	for i, v in ipairs(jobIds or {}) do
		jobIdsKV[v] = v
	end

	for k, v in pairs(cfgList) do
		cfgKVList[v.id] = v
		data = kVList[v.id]

		if self:_isGoodsMatchJob(v, sellKey, jobIdsKV) and (data or v.sellTargetLimit == "none" or v.sellTargetLimit == "monthCard" or v.sellTargetLimit == "vip" or v.payType == GameEnum.PayShopPayType.JUMPGOODS) then
			data = data or {
				times = 0,
				id = v.id
			}

			local timeEnough = GameUtil.checkIsInTimePeriod(v.onlineTime, v.offlineTime)
			local moneyEnough = v.rechargeShowMoney <= 0 or v.rechargeShowMoney <= RoleModel.instance:getMyConsumeMoney()

			if moneyEnough and timeEnough then
				if v.limitTimes > 0 and data.times >= v.limitTimes then
					table.insert(lastList, data)
				else
					table.insert(finalList, data)
				end
			end
		end
	end

	table.sort(finalList, function(a, b)
		return cfgKVList[a.id].rank < cfgKVList[b.id].rank
	end)

	for i, v in ipairs(lastList) do
		table.insert(finalList, v)
	end

	return finalList
end

function PayShopModel:_isGoodsMatchJob(goodsCfg, sellKey, jobIdsKV)
	if sellKey == GameEnum.PayShopTabSellType.SellPet or sellKey == GameEnum.PayShopTabSellType.SellSkin then
		if not jobIdsKV or not next(jobIdsKV) then
			return true
		end

		local jobIdsKV_cache = self._goodsDefineId_2_jobIds[goodsCfg.id]

		if not jobIdsKV_cache then
			jobIdsKV_cache = {}
			self._goodsDefineId_2_jobIds[goodsCfg.id] = jobIdsKV_cache

			local contens = string.split(goodsCfg.content, "#")

			for i, cfgStr in ipairs(contens) do
				if string.find(cfgStr, MatType.PET_SKIN .. ":%d+:") or string.find(cfgStr, MatType.Pet .. ":%d+:") then
					local arr = string.split(cfgStr, ":")
					local skinId = checkint(arr[2])
					local idx1 = PetSkinConfig.instance:getFirstJobIdx(skinId)

					if idx1 > 0 then
						jobIdsKV_cache[idx1] = idx1
					end

					local idx2 = PetSkinConfig.instance:getSecondJobIdx(skinId)

					if idx2 > 0 then
						jobIdsKV_cache[idx2] = idx2
					end
				end
			end
		end

		for k, v in pairs(jobIdsKV or {}) do
			if jobIdsKV_cache[k] then
				return true
			end
		end
	else
		return true
	end
end

function PayShopModel:_checkGoodItemCfgIsOnsale(cfg)
	local timeEnough = GameUtil.checkIsInTimePeriod(cfg.onlineTime, cfg.offlineTime)
	local moneyEnough = cfg.rechargeShowMoney <= 0 or cfg.rechargeShowMoney <= RoleModel.instance:getMyConsumeMoney()

	if moneyEnough and timeEnough and FuncOpenController.instance:getConditionReached(cfg.openCondition) then
		return true
	end
end

function PayShopModel:setMibaoBuyTimes(list)
	self.mibaoAllBuyTimes = list
end

function PayShopModel:changeBuyTimes(buyTimes)
	GlobalDispatcher:dispatch(GlobalNotify.UpdatePayShopRedDot, GameEnum.PayShopFirstTab.Mibao)

	if not buyTimes then
		return
	end

	local kvList = {}

	for i, v in ipairs(buyTimes) do
		kvList[v.id] = v
	end

	if self.mibaoAllBuyTimes then
		for _, v in ipairs(self.mibaoAllBuyTimes) do
			if kvList[v.id] then
				v.times = kvList[v.id].times

				if v.id == self._recordDiscountId then
					self._recordDiscountId = nil
					v.discountTimes = v.discountTimes + (kvList[v.id].totalBuyTimes - v.totalBuyTimes)
				end

				v.totalBuyTimes = kvList[v.id].totalBuyTimes

				GlobalDispatcher:dispatch(PayShopModel.ChangeMibaoShopBuyTimes, v.id, v.times)
			end
		end
	end
end

function PayShopModel:getMibaoBuyTimesById(id)
	for i, v in ipairs(self.mibaoAllBuyTimes) do
		if v.id == id then
			return v.times or 0
		end
	end

	return 0
end

function PayShopModel:getMibaoTotalBuyTimesById(id)
	local times = 0

	if self.mibaoAllBuyTimes then
		for i, v in ipairs(self.mibaoAllBuyTimes) do
			if v.id == id then
				times = v.totalBuyTimes

				break
			end
		end
	end

	return times
end

function PayShopModel:getPayShopGoodsCanBuyById(id)
	local mibaoCfg = PayShopConfig.instance:getPayShopGoodsCfgById(id)

	if not mibaoCfg then
		if Framework.OSDef.isEditor then
			printError("===秘宝缺失配置 id", id)
		else
			self:_checkUpdateCfg(id)
		end

		return false
	end

	if self:_checkGoodItemCfgIsOnsale(mibaoCfg) then
		local buyCount = self:getMibaoBuyTimesById(id)

		if mibaoCfg.limitTimes == 0 or buyCount < mibaoCfg.limitTimes then
			return true
		end
	end

	return false
end

function PayShopModel:_checkUpdateCfg(id)
	local value = self:_getIgnoreUpdateValue()

	if value == "isIgnore" then
		return
	end

	local tips = "检测商城资源有更新，是否重启游戏更新资源？"

	TipsFacade.instance:openPopupWindow("更新提示", tips, function()
		BootstrapLauncher.instance:applicationQuit()
	end, function()
		self:_recordIgnoreUpdateCfg()
	end, "确定", "取消")

	if not Framework.OSDef.isEditor then
		if not Framework.HotUpdate.VersionMgr.Instance.localVersion then
			local localVersion = ""

			printError("===秘宝缺失配置 id", id, "localVersion", localVersion)
		end
	end
end

function PayShopModel:_recordIgnoreUpdateCfg()
	Framework.LocalStorage.Instance:SetString("PayShopModel_IgnoreUpdateCfg", "isIgnore")
end

function PayShopModel:_getIgnoreUpdateValue()
	return Framework.LocalStorage.Instance:GetString("PayShopModel_IgnoreUpdateCfg")
end

function PayShopModel:_resetIgnoreUpdateCfg()
	Framework.LocalStorage.Instance:SetString("PayShopModel_IgnoreUpdateCfg", "notIgnore")
end

function PayShopModel:setAccConsumeMoney(money)
	self.consumeMoney = money
end

function PayShopModel:getAccConsumeMoney()
	return math.floor(self.consumeMoney / 100)
end

function PayShopModel:setAccConsumeGainedList(hasGainedList)
	for i, v in ipairs(hasGainedList) do
		self.accConsumeGainedList[i].get = v
	end
end

function PayShopModel:setAccConListById(i, v)
	self.accConsumeGainedList[i].get = v
end

function PayShopModel:getAccConsumeGainedList()
	return self.accConsumeGainedList
end

function PayShopModel:getAccConsumeNext()
	local index = 0

	for i, v in ipairs(self.accConsumeGainedList) do
		if math.floor(self.consumeMoney / 100) < v.leftConsume and v.showType ~= 0 then
			index = i

			break
		end
	end

	if index == 0 then
		return self.accConsumeGainedList[#self.accConsumeGainedList]
	elseif index > #self.accConsumeGainedList then
		return nil
	else
		return self.accConsumeGainedList[index]
	end
end

function PayShopModel:setHasGainWeeklyPrize(activityId, hasGainWeeklyPrize)
	YearCardModel.instance:setHasGainWeeklyPrize(activityId, hasGainWeeklyPrize)
end

function PayShopModel:getHasGainWeeklyPrize(activityId)
	return YearCardModel.instance:getHasGainWeeklyPrize(activityId)
end

function PayShopModel:setHasGainFixedPrize(activityId, hasGainFixedPrize)
	YearCardModel.instance:setHasGainFixedPrize(activityId, hasGainFixedPrize)
end

function PayShopModel:setActivateAnnuity(activityId)
	YearCardModel.instance:setActivateAnnuity(activityId)
end

function PayShopModel:isActiveAnnuity(activityId)
	return YearCardModel.instance:isActiveAnnuity(activityId)
end

function PayShopModel:setIsGainMonthPrize(activityId, prizeId)
	YearCardModel.instance:setIsGainMonthPrize(activityId, prizeId)
end

function PayShopModel:getIsGainMonthPrize(activityId, prizeId)
	return YearCardModel.instance:getIsGainMonthPrize(activityId, prizeId)
end

function PayShopModel:resetAnnuityInfo()
	YearCardModel.instance:resetAnnuityInfo()
end

function PayShopModel:setAnnuityInfo(single)
	YearCardModel.instance:setAnnuityInfo(single)
end

function PayShopModel:getAnnuityInfo(activityId)
	return YearCardModel.instance:getAnnuityInfo(activityId)
end

function PayShopModel:getCurAnnuityId()
	return YearCardModel.instance:getCurAnnuityId()
end

function PayShopModel:setCurAnnuityId(activityId)
	YearCardModel.instance:setCurAnnuityId(activityId)
end

function PayShopModel:getIfGetAnnuityInfo(activityId)
	return YearCardModel.instance:getIfGetAnnuityInfo(activityId)
end

function PayShopModel:setIfGetAnnuityInfo(torf)
	YearCardModel.instance:setIfGetAnnuityInfo(torf)
end

function PayShopModel:checGoodsFreeBuyDot(id)
	local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(id)

	if not cfg then
		if Framework.OSDef.isEditor then
			printError("===秘宝缺失配置 id", id)
		else
			self:_checkUpdateCfg(id)
		end

		return false
	end

	local moneyEnough = cfg.rechargeShowMoney <= 0 or RoleModel.instance:getMyConsumeMoney() >= cfg.rechargeShowMoney
	local timeEnough = GameUtil.checkIsInTimePeriod(cfg.onlineTime, cfg.offlineTime)

	if timeEnough and moneyEnough and cfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
		local payGoodsId = cfg.originalGoodsId

		if string.nilorempty(payGoodsId) and self:getPayShopGoodsCanBuyById(id) then
			return true
		end
	end

	return false
end

function PayShopModel:checkHasFreeGoodsDot()
	for i, v in ipairs(self.mibaoAllBuyTimes) do
		local dot = self:checGoodsFreeBuyDot(v.id)

		if dot then
			return true
		end
	end

	return false
end

function PayShopModel:recordCurrTabIds(firTabId, secTabId, thiTabId)
	self.currFirTabId = firTabId
	self.currSecTabId = secTabId
	self.currThiTabId = thiTabId
end

function PayShopModel:getRecodTabIds()
	return self.currFirTabId, self.currSecTabId, self.currThiTabId
end

function PayShopModel:setRecordTag(bool)
	self._isRecordTabIds = bool
end

function PayShopModel:isRecordTabIds()
	return self._isRecordTabIds
end

function PayShopModel:getCanBuyGoodCfgsByMatStr(matStr)
	local list = {}

	if not string.nilorempty(matStr) then
		local sindex, eindex = string.find(matStr, "^%d+:%d+")

		if sindex then
			local str = string.sub(matStr, sindex, eindex)
			local idList = self._matStr2Cfgs[str]

			if idList then
				for id, cfg in pairs(idList) do
					local canbuy = self:getPayShopGoodsCanBuyById(id)

					if canbuy then
						table.insert(list, cfg)
					end
				end
			end
		end
	end

	return list
end

function PayShopModel:checkHasNewMonthcardVersion()
	local hasNew = false
	local cfg = MonthCardConfig.instance:getCfgById(1)

	if cfg.version > 0 then
		local value = GameUtil.getUserData("MonthCardNewVersion")

		value = checknumber(value)
		hasNew = value < cfg.version
	end

	return hasNew
end

function PayShopModel:setNewMonthcardVersion()
	local cfg = MonthCardConfig.instance:getCfgById(1)

	GameUtil.saveUserData("MonthCardNewVersion", cfg.version)
end

function PayShopModel:checkDiamondRechagerResetDot()
	local cfgs = PayShopConfig.instance:getPayshopResetCfgs()
	local key = "DiamondRechagerResetDot"

	for k, list in pairs(cfgs) do
		if type(k) == "number" then
			local timeStr = GameUtil.getUserData(key)
			local nowTime = ServerTime.nowServerLook()

			if string.nilorempty(timeStr) then
				return true
			else
				local lastTime = checknumber(timeStr)

				for _, v in ipairs(list) do
					local time = GameUtil.string2time(v.resetTime)

					if time <= nowTime and lastTime < time then
						return true
					end
				end
			end
		end
	end

	return false
end

function PayShopModel:setDiamondRechagerResetDotClickTime()
	local key = "DiamondRechagerResetDot"
	local nowTime = ServerTime.nowServerLook()

	GameUtil.saveUserData(key, tostring(nowTime))
end

function PayShopModel:getBuyData(defineId)
	for i, v in ipairs(self.mibaoAllBuyTimes) do
		if v.id == defineId then
			return v
		end
	end
end

function PayShopModel:_isSellKeyTab(tabCfg)
	return not string.nilorempty(tabCfg.sellKey)
end

function PayShopModel:getDiscountGroup(shopItemId)
	local plans = {}
	local scfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopItemId)

	if scfg and scfg.discountPlans then
		for i, planId in ipairs(scfg.discountPlans) do
			local pcfg = PayShopConfig.instance:getDiscountPlanCfg(planId)

			if pcfg then
				table.insert(plans, pcfg)
			end
		end
	end

	return plans
end

function PayShopModel:checkCanDisCount(shopItemId)
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopItemId)

	if goodsCfg and goodsCfg.discountPlans then
		for i, planId in ipairs(goodsCfg.discountPlans) do
			if PayShopController.instance:checkDiscountPlanConditionPass(planId) then
				return true
			end
		end
	end
end

function PayShopModel:getBestDiscountPlanIdByGoodsDefineId(defineId)
	local bestId = 0
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(defineId)

	if not goodsCfg then
		return 0
	end

	if not goodsCfg.discountPlans then
		return 0
	end

	local useTime = self:getUseDiscountTimes(goodsCfg.id)

	if goodsCfg.discountLimitTimes > 0 and useTime >= goodsCfg.discountLimitTimes then
		return 0
	end

	local dcfgs = {}

	for i, v in ipairs(goodsCfg.discountPlans) do
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(v)

		if PayShopController.instance:checkDiscountPlanConditionPass(v) then
			table.insert(dcfgs, dcfg)
		end
	end

	if #dcfgs > 0 then
		local dcfg = dcfgs[1]
		local payType = dcfg.payType
		local minCostNum = -1
		local costNum = 0

		for i, v in ipairs(dcfgs) do
			if payType == GameEnum.PayShopPayType.RMB then
				costNum = PayConfig.instance:getPayMoneyYuan(v.discountPrice)
			elseif payType == GameEnum.PayShopPayType.GAMEGOODS then
				local list = string.split(dcfg.discountPrice, ":")

				costNum = checknumber(list[#list])
			end

			if minCostNum <= 0 then
				minCostNum = costNum
				bestId = v.id
			elseif costNum < minCostNum then
				minCostNum = costNum
				bestId = v.id
			end
		end
	end

	return bestId
end

function PayShopModel:getUseDiscountTimes(shopItemId)
	local data = self:getBuyData(shopItemId)

	return (data or nil) and (data.discountTimes or 0)
end

function PayShopModel:getLimitPerStr(goodsCfg)
	local preStr = "限购："

	if goodsCfg.limitType == "daily" then
		preStr = "每日限购："
	elseif goodsCfg.limitType == "weekly" then
		preStr = "每周限购："
	elseif goodsCfg.limitType == "monthly" then
		preStr = "每月限购："
	elseif goodsCfg.limitType == "allTime" then
		preStr = "永久限购："
	elseif goodsCfg.sellTargetLimit == "monthCard" then
		preStr = "月卡限购："
	elseif goodsCfg.sellTargetLimit == "vip" then
		preStr = "VIP限购："
	end

	return preStr
end

function PayShopModel:getBuyItemMinCostPayGoodsId(shopItemId)
	local scfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopItemId)
	local payGoodsId = scfg.originalGoodsId
	local dcfgs = self:getDiscountGroup(shopItemId)
	local minNum = -1
	local minNumItem = -1
	local hsaItem = false
	local discountPlanId = -1

	if dcfgs and #dcfgs > 0 then
		for i, v in ipairs(dcfgs) do
			local nowCost = -1
			local costItemStr = v.discountCost

			if MaterialMgr.getMatEnough(costItemStr) then
				if v.payType == GameEnum.PayShopPayType.RMB then
					nowCost = PayConfig.instance:getPayMoneyYuan(v.discountPrice)

					if hsaItem == false and (minNum == -1 or nowCost < minNum) then
						minNum = nowCost
						payGoodsId = v.discountPrice
						discountPlanId = v.id
					end
				else
					hsaItem = true

					local arr = string.split(v.discountPrice, ":")

					nowCost = checkint(arr[#arr])

					if minNumItem == -1 or nowCost < minNumItem then
						minNumItem = nowCost
						payGoodsId = v.discountPrice
						discountPlanId = v.id
					end
				end
			end
		end
	end

	if discountPlanId == -1 then
		return payGoodsId, discountPlanId
	else
		if scfg.payType == GameEnum.PayShopPayType.RMB then
			minNum = PayConfig.instance:getPayMoneyYuan(payGoodsId)
		else
			local arr = string.split(payGoodsId, ":")

			minNum = checkint(arr[#arr])
		end

		return payGoodsId, discountPlanId
	end
end

function PayShopModel:recordDiscountId(shopItemId)
	self._recordDiscountId = shopItemId
end

function PayShopModel:recordJumpPageParam(jumpPageTabTypes)
	self._jumpPageTabTypes = jumpPageTabTypes
end

function PayShopModel:getJumpPageParam()
	return self._jumpPageTabTypes
end

function PayShopModel:setDiscountGiftInfo(giftGainState)
	self._giftGainState = GameUtil.pbToTable(giftGainState) or {}
end

function PayShopModel:gainDiscountGiftRes(giftId)
	self._giftGainState[giftId] = true
end

function PayShopModel:gainAllDiscountGiftRes()
	local activityType = GameEnum.ActivityType.PAY_SHOP_DISCOUNT_GIFT
	local acfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

	if acfg then
		local cfgs = PayShopConfig.instance:getDiscountGiftCfgs(acfg.activityId)

		for i, v in ipairs(cfgs) do
			self._giftGainState[v.giftId] = true
		end
	end
end

function PayShopModel:isGainDiscountGift(giftId)
	return self._giftGainState[giftId]
end

function PayShopModel:isGetAllDiscountGift(activityId)
	local cfgs = PayShopConfig.instance:getDiscountGiftCfgs(activityId)

	if cfgs then
		for i, v in ipairs(cfgs) do
			if not self:isGainDiscountGift(v.giftId) then
				return false
			end
		end
	end

	return true
end

function PayShopModel:recordJumpInTag(jumpInTag)
	self._viewJumpInTag = jumpInTag
end

function PayShopModel:getJumpInTag()
	return self._viewJumpInTag
end

function PayShopModel:parseGoodsTagParam2Table(tagParam)
	if self._cacheTagParma2Table[tagParam] then
		return self._cacheTagParma2Table[tagParam]
	end

	local list = {}

	if not string.nilorempty(tagParam) then
		local temp = string.split(tagParam, "#")

		for i, str in ipairs(temp) do
			local temp2 = string.split(str, ",")
			local id = checkint(temp2[1])
			local data = {
				id = id
			}

			if id == GameEnum.PayshopSellSkinTagType.LimitSell then
				-- block empty
			elseif id == GameEnum.PayshopSellSkinTagType.NewGoods then
				data.showDay = checkint(temp2[2])
				data.word = temp2[3]
			elseif id == GameEnum.PayshopSellSkinTagType.Recommend then
				data.word = temp2[2]
			elseif id == GameEnum.PayshopSellSkinTagType.Discount then
				-- block empty
			end

			table.insert(list, data)
		end

		self._cacheTagParma2Table[tagParam] = list
	end

	return list
end

function PayShopModel:getTagParamTableActiveId(ptable, defineId)
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(defineId)
	local activeId = -1

	ptable = ptable or {}

	table.sort(ptable, function(a, b)
		return GameEnum.PayshopSellSkinTagRank[a.id] < GameEnum.PayshopSellSkinTagRank[b.id]
	end)

	for i, v in ipairs(ptable) do
		local id = v.id

		if id == GameEnum.PayshopSellSkinTagType.LimitSell then
			local endTime = GameUtil.string2time(goodsCfg.offlineTime)
			local leftTime = endTime - ServerTime.nowServerLook()

			if leftTime > 0 then
				activeId = id

				break
			end
		elseif id == GameEnum.PayshopSellSkinTagType.NewGoods then
			local startTime = GameUtil.string2time(goodsCfg.onlineTime)
			local endTime = startTime + 86400 * v.showDay

			if endTime > ServerTime.nowServerLook() then
				activeId = id

				break
			end
		elseif id == GameEnum.PayshopSellSkinTagType.Recommend then
			activeId = id

			break
		elseif id == GameEnum.PayshopSellSkinTagType.Discount then
			local planId = self:getBestDiscountPlanIdByGoodsDefineId(goodsCfg.id)

			if planId and planId > 0 then
				activeId = id

				break
			end
		end
	end

	return activeId
end

function PayShopModel:sortGoodsBySkinSortId(sortId, viewDatas)
	viewDatas = viewDatas or {}

	local newViewDatas

	if sortId == GameEnum.PayshopSkinSortType.NotGet then
		newViewDatas = self:_sortGoodsSkinByTypeNotGet(viewDatas)
	elseif sortId == GameEnum.PayshopSkinSortType.Rare then
		newViewDatas = self:_sortGoodsSkinByTypeRare(viewDatas)
	elseif sortId == GameEnum.PayshopSkinSortType.DiamondBuy then
		newViewDatas = self:_sortGoodsSkinByTypeDiamond(viewDatas)
	elseif sortId == GameEnum.PayshopSkinSortType.PifuCoinBuy then
		newViewDatas = self:_sortGoodsSkinByTypePifuCoin(viewDatas)
	elseif sortId == GameEnum.PayshopSkinSortType.OnlineTime then
		newViewDatas = self:_sortGoodsSkinByTypeOnlineTime(viewDatas)
	end

	return newViewDatas or viewDatas
end

function PayShopModel:_sortGoodsSkinByTypeNotGet(viewDatas)
	local newViewDatas
	local content = ""
	local cfg
	local isHad = false
	local raceId = 0
	local needSortList = {}
	local notSortList = {}

	for i, v in ipairs(viewDatas) do
		isHad = false
		cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.goodsData.id)
		content = cfg.content

		if cfg.payType == GameEnum.PayShopPayType.JUMPGOODS then
			newViewDatas = newViewDatas or {}

			table.insert(newViewDatas, v)
		elseif string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":") then
			local arr1 = string.split(content, "#")

			for i, str in ipairs(arr1) do
				if string.find(str, "^" .. MatType.PET_SKIN .. ":") then
					local arr2 = string.split(str, ":")
					local matId = checkint(arr2[2])
					local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(matId)
					local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

					isHad = skinStatus == PetskinController.SKIN_STATUS_HAD
					raceId = petSkinCfg.raceId

					break
				end
			end

			if not isHad then
				local sortData = self:_getSkinCommonSortParam(cfg.id)

				sortData.viewData = v
				sortData.rare = petSkinCfg.quality

				table.insert(needSortList, sortData)
			end
		else
			table.insert(notSortList, v)
		end
	end

	if #needSortList > 0 then
		ArraySort.sortOn(needSortList, {
			"onlineTime",
			"rare",
			"tagType",
			"price"
		}, {
			ArraySort.DESCENDING,
			ArraySort.DESCENDING,
			ArraySort.NONE,
			ArraySort.NONE
		})

		newViewDatas = newViewDatas or {}

		for i, v in ipairs(needSortList) do
			table.insert(newViewDatas, v.viewData)
		end
	end

	if #notSortList > 0 then
		newViewDatas = newViewDatas or {}

		table.insertto(newViewDatas, notSortList)
	end

	return newViewDatas or viewDatas
end

function PayShopModel:_sortGoodsSkinByTypeRare(viewDatas)
	local newViewDatas
	local content = ""
	local cfg
	local isHad = false
	local finalList = {}
	local lastList = {}
	local needSortList = {}
	local notSortList = {}

	for i, v in ipairs(viewDatas) do
		cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.goodsData.id)
		content = cfg.content

		local buyData = self:getBuyData(cfg.id)

		if cfg.limitTimes > 0 and buyData.times >= cfg.limitTimes then
			table.insert(lastList, v)
		elseif cfg.payType == GameEnum.PayShopPayType.JUMPGOODS then
			table.insert(finalList, v)
		elseif string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":") then
			local arr1 = string.split(content, "#")

			isHad = false

			for i, str in ipairs(arr1) do
				if string.find(str, "^" .. MatType.PET_SKIN .. ":") then
					local arr2 = string.split(str, ":")
					local skinId = checkint(arr2[2])
					local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
					local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

					isHad = skinStatus == PetskinController.SKIN_STATUS_HAD

					if not isHad then
						local ptable = self:parseGoodsTagParam2Table(cfg.tagParam)
						local tagType = self:getTagParamTableActiveId(ptable, cfg.id)

						if tagType <= 0 then
							tagType = 999
						end

						local price = 0

						if cfg.payType == GameEnum.PayShopPayType.RMB then
							price = PayShopConfig.instance:getPayMoneyYuan(cfg.originalGoodsId)
						elseif cfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
							local temp = string.split(cfg.originalGoodsId, ":")

							price = checkint(temp[#temp])
						end

						local sortData = self:_getSkinCommonSortParam(cfg.id)

						sortData.viewData = v
						sortData.rare = petSkinCfg.quality

						table.insert(needSortList, sortData)
					end

					break
				end
			end

			if isHad then
				table.insert(lastList, v)
			end
		else
			table.insert(notSortList, v)
		end
	end

	ArraySort.sortOn(needSortList, {
		"rare",
		"onlineTime",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})

	for i, v in ipairs(needSortList) do
		table.insert(finalList, v.viewData)
	end

	table.insertto(finalList, notSortList)
	table.insertto(finalList, lastList)

	return finalList
end

function PayShopModel:_sortGoodsSkinByTypeDiamond(viewDatas)
	local newViewDatas
	local content = ""
	local cfg
	local isHad = false
	local finalList = {}
	local lastList = {}
	local diamondList = {}
	local diamond_pifuList = {}
	local norSortList = {}
	local notSortList = {}

	for i, v in ipairs(viewDatas) do
		cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.goodsData.id)
		content = cfg.content

		local buyData = self:getBuyData(cfg.id)

		if cfg.limitTimes > 0 and buyData.times >= cfg.limitTimes then
			table.insert(lastList, v)
		elseif cfg.payType == GameEnum.PayShopPayType.JUMPGOODS then
			table.insert(finalList, v)
		elseif string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":") then
			local arr1 = string.split(content, "#")

			isHad = false

			for i, str in ipairs(arr1) do
				if string.find(str, "^" .. MatType.PET_SKIN .. ":") then
					local arr2 = string.split(str, ":")
					local skinId = checkint(arr2[2])
					local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
					local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

					isHad = skinStatus == PetskinController.SKIN_STATUS_HAD

					if not isHad then
						local ptable = self:parseGoodsTagParam2Table(cfg.tagParam)
						local tagType = self:getTagParamTableActiveId(ptable, cfg.id)

						if tagType <= 0 then
							tagType = 999
						end

						local price = 0

						if cfg.payType == GameEnum.PayShopPayType.RMB then
							price = PayShopConfig.instance:getPayMoneyYuan(cfg.originalGoodsId)
						elseif cfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
							local temp = string.split(cfg.originalGoodsId, ":")

							price = checkint(temp[#temp])
						end

						local sortData = self:_getSkinCommonSortParam(cfg.id)

						sortData.viewData = v
						sortData.rare = petSkinCfg.quality

						local isDiamondPay = string.find(cfg.originalGoodsId, "^" .. MatType.GodGem .. ":%d+")
						local isDiamondReplacePay = false

						if cfg.deducePlanId > 0 then
							local deduceCfg = PayShopConfig.instance:getDeduceCfg(cfg.deducePlanId)

							isDiamondReplacePay = string.find(deduceCfg.deduction, "^" .. MatType.GodGem .. ":%d+")
						end

						if isDiamondPay and isDiamondReplacePay then
							table.insert(diamond_pifuList, sortData)

							break
						end

						if isDiamondPay then
							table.insert(diamondList, sortData)

							break
						end

						table.insert(norSortList, sortData)
					end

					break
				end
			end

			if isHad then
				table.insert(lastList, v)
			end
		else
			table.insert(notSortList, v)
		end
	end

	ArraySort.sortOn(diamondList, {
		"onlineTime",
		"rare",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})
	ArraySort.sortOn(diamond_pifuList, {
		"onlineTime",
		"rare",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})
	ArraySort.sortOn(norSortList, {
		"onlineTime",
		"rare",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})

	for i, v in ipairs(diamondList) do
		table.insert(finalList, v.viewData)
	end

	for i, v in ipairs(diamond_pifuList) do
		table.insert(finalList, v.viewData)
	end

	for i, v in ipairs(norSortList) do
		table.insert(finalList, v.viewData)
	end

	table.insertto(finalList, notSortList)
	table.insertto(finalList, lastList)

	return finalList
end

function PayShopModel:_sortGoodsSkinByTypePifuCoin(viewDatas)
	local newViewDatas
	local content = ""
	local cfg
	local isHad = false
	local finalList = {}
	local lastList = {}
	local diamondList = {}
	local diamond_pifuList = {}
	local norSortList = {}
	local notSortList = {}

	for i, v in ipairs(viewDatas) do
		cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.goodsData.id)
		content = cfg.content

		local buyData = self:getBuyData(cfg.id)

		if cfg.limitTimes > 0 and buyData.times >= cfg.limitTimes then
			table.insert(lastList, v)
		elseif cfg.payType == GameEnum.PayShopPayType.JUMPGOODS then
			table.insert(finalList, v)
		elseif string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":") then
			local arr1 = string.split(content, "#")

			isHad = false

			for i, str in ipairs(arr1) do
				if string.find(str, "^" .. MatType.PET_SKIN .. ":") then
					local arr2 = string.split(str, ":")
					local skinId = checkint(arr2[2])
					local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
					local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

					isHad = skinStatus == PetskinController.SKIN_STATUS_HAD

					if not isHad then
						local ptable = self:parseGoodsTagParam2Table(cfg.tagParam)
						local tagType = self:getTagParamTableActiveId(ptable, cfg.id)

						if tagType <= 0 then
							tagType = 999
						end

						local price = 0

						if cfg.payType == GameEnum.PayShopPayType.RMB then
							price = PayShopConfig.instance:getPayMoneyYuan(cfg.originalGoodsId)
						elseif cfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
							local temp = string.split(cfg.originalGoodsId, ":")

							price = checkint(temp[#temp])
						end

						local sortData = self:_getSkinCommonSortParam(cfg.id)

						sortData.viewData = v
						sortData.rare = petSkinCfg.quality

						local isPifuPay = string.find(cfg.originalGoodsId, "^" .. MatType.Coin .. ":" .. MatType.Coin_Skin .. ":")
						local hasReplacePay = cfg.deducePlanId > 0

						if isPifuPay and hasReplacePay then
							table.insert(diamond_pifuList, sortData)

							break
						end

						if isPifuPay then
							table.insert(diamondList, sortData)

							break
						end

						table.insert(norSortList, sortData)
					end

					break
				end
			end

			if isHad then
				table.insert(lastList, v)
			end
		else
			table.insert(notSortList, v)
		end
	end

	ArraySort.sortOn(diamondList, {
		"onlineTime",
		"rare",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})
	ArraySort.sortOn(diamond_pifuList, {
		"onlineTime",
		"rare",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})
	ArraySort.sortOn(norSortList, {
		"onlineTime",
		"rare",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})

	for i, v in ipairs(diamondList) do
		table.insert(finalList, v.viewData)
	end

	for i, v in ipairs(diamond_pifuList) do
		table.insert(finalList, v.viewData)
	end

	for i, v in ipairs(norSortList) do
		table.insert(finalList, v.viewData)
	end

	table.insertto(finalList, notSortList)
	table.insertto(finalList, lastList)

	return finalList
end

function PayShopModel:_sortGoodsSkinByTypeOnlineTime(viewDatas)
	local content = ""
	local cfg
	local isHad = false
	local finalList = {}
	local lastList = {}
	local norSortList = {}
	local notSortList = {}

	for i, v in ipairs(viewDatas) do
		cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.goodsData.id)
		content = cfg.content

		local buyData = self:getBuyData(cfg.id)

		if cfg.limitTimes > 0 and buyData.times >= cfg.limitTimes then
			table.insert(lastList, v)
		elseif cfg.payType == GameEnum.PayShopPayType.JUMPGOODS then
			table.insert(finalList, v)
		elseif string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":") then
			local arr1 = string.split(content, "#")

			isHad = false

			for i, str in ipairs(arr1) do
				if string.find(str, "^" .. MatType.PET_SKIN .. ":") then
					local arr2 = string.split(str, ":")
					local skinId = checkint(arr2[2])
					local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
					local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

					isHad = skinStatus == PetskinController.SKIN_STATUS_HAD

					if not isHad then
						local ptable = self:parseGoodsTagParam2Table(cfg.tagParam)
						local tagType = self:getTagParamTableActiveId(ptable, cfg.id)

						if tagType <= 0 then
							tagType = 999
						end

						local price = 0

						if cfg.payType == GameEnum.PayShopPayType.RMB then
							price = PayShopConfig.instance:getPayMoneyYuan(cfg.originalGoodsId)
						elseif cfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
							local temp = string.split(cfg.originalGoodsId, ":")

							price = checkint(temp[#temp])
						end

						local sortData = self:_getSkinCommonSortParam(cfg.id)

						sortData.viewData = v
						sortData.rare = petSkinCfg.quality

						table.insert(norSortList, sortData)
					end

					break
				end
			end

			if isHad then
				table.insert(lastList, v)
			end
		else
			table.insert(notSortList, v)
		end
	end

	ArraySort.sortOn(norSortList, {
		"onlineTime",
		"rare",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})

	for i, v in ipairs(norSortList) do
		table.insert(finalList, v.viewData)
	end

	table.insertto(finalList, notSortList)
	table.insertto(finalList, lastList)

	return finalList
end

function PayShopModel:_sortGoodsSkinByTypeDefault(viewDatas)
	local content = ""
	local cfg
	local isHad = false
	local finalList = {}
	local lastList = {}
	local norSortList = {}
	local notSortList = {}

	for i, v in ipairs(viewDatas) do
		cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.goodsData.id)
		content = cfg.content

		local buyData = self:getBuyData(cfg.id)

		if cfg.limitTimes > 0 and buyData.times >= cfg.limitTimes then
			table.insert(lastList, v)
		elseif cfg.payType == GameEnum.PayShopPayType.JUMPGOODS then
			table.insert(finalList, v)
		elseif string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":") then
			local arr1 = string.split(content, "#")

			isHad = false

			for i, str in ipairs(arr1) do
				if string.find(str, "^" .. MatType.PET_SKIN .. ":") then
					local arr2 = string.split(str, ":")
					local skinId = checkint(arr2[2])
					local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
					local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

					isHad = skinStatus == PetskinController.SKIN_STATUS_HAD

					if not isHad then
						local ptable = self:parseGoodsTagParam2Table(cfg.tagParam)
						local tagType = self:getTagParamTableActiveId(ptable, cfg.id)

						if tagType <= 0 then
							tagType = 999
						end

						local price = 0

						if cfg.payType == GameEnum.PayShopPayType.RMB then
							price = PayShopConfig.instance:getPayMoneyYuan(cfg.originalGoodsId)
						elseif cfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
							local temp = string.split(cfg.originalGoodsId, ":")

							price = checkint(temp[#temp])
						end

						local sortData = self:_getSkinCommonSortParam(cfg.id)

						sortData.viewData = v
						sortData.rare = petSkinCfg.quality

						table.insert(norSortList, sortData)
					end

					break
				end
			end

			if isHad then
				table.insert(lastList, v)
			end
		else
			table.insert(notSortList, v)
		end
	end

	ArraySort.sortOn(norSortList, {
		"onlineTime",
		"rare",
		"tagType",
		"price"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.NONE,
		ArraySort.NONE
	})

	for i, v in ipairs(norSortList) do
		table.insert(finalList, v.viewData)
	end

	table.insertto(finalList, notSortList)
	table.insertto(finalList, lastList)

	return finalList
end

function PayShopModel:_getSkinCommonSortParam(defineId)
	local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(defineId)
	local ptable = self:parseGoodsTagParam2Table(cfg.tagParam)
	local tagType = self:getTagParamTableActiveId(ptable, cfg.id)

	if tagType <= 0 then
		tagType = 999
	end

	local price = 0
	local planId = self:getBestDiscountPlanIdByGoodsDefineId(cfg.id)
	local payGoodsId = cfg.originalGoodsId

	if planId and planId > 0 then
		local dcfg = PayShopConfig.instance:getDiscountPlanCfg(planId)

		payGoodsId = dcfg.discountPrice
	end

	if cfg.payType == GameEnum.PayShopPayType.RMB then
		price = PayShopConfig.instance:getPayMoneyYuan(payGoodsId)
	elseif cfg.payType == GameEnum.PayShopPayType.GAMEGOODS then
		local temp = string.split(payGoodsId, ":")

		price = checkint(temp[#temp])
	end

	return {
		onlineTime = GameUtil.string2time(cfg.onlineTime),
		tagType = tagType,
		price = price
	}
end

function PayShopModel:recordSkinSortId(primerikey, id)
	self._recordSkinSortIds[primerikey] = id
end

function PayShopModel:getSkinSortId(primerikey)
	return self._recordSkinSortIds[primerikey] or GameEnum.PayshopSkinSortType.OnlineTime
end

function PayShopModel:calGoodsDefineId2MountId(list)
	self:_loadMountActiveData()

	local kvList = {}

	for k, v in pairs(list or {}) do
		local goodsDefineId = v.id

		if not self._cacheGoodsfDefineId2MountId[goodsDefineId] then
			local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsDefineId)
			local arr = string.split(goodsCfg.content, "#")

			for i, str in ipairs(arr) do
				local newKey = string.gsub(str, "(:%d+)$", "")

				if self._mountActiveItems[newKey] then
					self._cacheGoodsfDefineId2MountId[goodsDefineId] = {
						goodsDefineId = goodsDefineId,
						mountId = self._mountActiveItems[newKey],
						itemStr = newKey
					}

					break
				end
			end
		end

		kvList[goodsDefineId] = self._cacheGoodsfDefineId2MountId[goodsDefineId]
	end

	return table.values(kvList)
end

function PayShopModel:_loadMountActiveData()
	if self._mountActiveItems then
		return
	end

	self._mountActiveItems = {}

	local mountCfgs = MountConfig.instance:getAllMounts()

	for i, v in ipairs(mountCfgs) do
		local newKey = string.gsub(v.activationItem, "(:%d+)$", "")

		self._mountActiveItems[newKey] = v.id
	end
end

function PayShopModel:chechkFreeGoodsRedDotByShowType(showType)
	local list = PayShopConfig.instance:getFreeGoodsByShowType(showType)

	for k, v in pairs(list) do
		if self:getPayShopGoodsCanBuyById(v.id) then
			return true
		end
	end

	return false
end

function PayShopModel:chechShopGoodsSkillHave(goodsCfg)
	local isHave = false

	if goodsCfg == nil or string.nilorempty(goodsCfg.content) then
		return isHave
	end

	local content = goodsCfg.content

	if string.find(content, "^" .. MatType.PET_SKIN .. ":") or string.find(content, ".*#" .. MatType.PET_SKIN .. ":") then
		local arr1 = string.split(content, "#")

		for i, v in ipairs(arr1) do
			if string.find(v, "^" .. MatType.PET_SKIN .. ":") then
				local arr2 = string.split(v, ":")
				local matId = checkint(arr2[2])
				local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(matId)
				local skinStatus = PetskinController.instance:checkHasSkinStatus(petSkinCfg)

				isHave = skinStatus == PetskinController.SKIN_STATUS_HAD

				break
			end
		end
	end

	return isHave
end

PayShopModel.instance = PayShopModel.New()

return PayShopModel
