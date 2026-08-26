-- chunkname: @modules/logic/turnback/model/TurnbackModel.lua

module("modules.logic.turnback.model.TurnbackModel", package.seeall)

local TurnbackModel = class("TurnbackModel", BaseModel)

function TurnbackModel.sortFunc(a, b)
	local aCo = ItemConfig.instance:getItemConfig(a.type, a.id)
	local bCo = ItemConfig.instance:getItemConfig(b.type, b.id)

	if aCo.type == bCo.type then
		if aCo.rare == bCo.rare then
			if aCo.id == bCo.id then
				return a.num > b.num
			end

			return aCo.id < bCo.id
		end

		return aCo.rare > bCo.rare
	end

	return aCo.type > bCo.type
end

function TurnbackModel:onInit()
	self:reInit()
end

function TurnbackModel:reInit()
	self.turnbackSubModuleInfo = {}
	self.unExitSubModules = {}
	self.turnbackInfoMo = nil
	self.targetCategoryId = 0
	self.curTurnbackId = 0
	self.lastGetSigninDay = nil
	self._openpopview = false
	self._dropInfoList = nil
end

function TurnbackModel:setTurnbackInfo(info)
	local config = TurnbackConfig.instance:getTurnbackCo(info.id)

	if config then
		self.turnbackInfoMo = self.turnbackInfoMo or TurnbackInfoMo.New()

		self.turnbackInfoMo:init(info)
		self:setCurTurnbackId(info.id)
		self:setTaskInfoList()
		self:setSignInInfoList()
		self:initRecommendData()
		self:getBonusHeroConfigList()
		self:_calcAllBonus()
		self:setDropInfoList(info.dropInfos, info.commonDropInfos)
	end
end

function TurnbackModel:getTaskInfos()
	return self.resourceReturn.resourceReturnTasks
end

function TurnbackModel:setCurTurnbackId(turnbackId)
	self.curTurnbackId = turnbackId
end

function TurnbackModel:getCurTurnbackId()
	return self.curTurnbackId
end

function TurnbackModel:isNewType()
	return self.turnbackInfoMo:isNewType()
end

function TurnbackModel:getCurTurnbackMo()
	return self.turnbackInfoMo
end

function TurnbackModel:getLeaveTime()
	return self.turnbackInfoMo.leaveTime
end

function TurnbackModel:getLeaveDay()
	return self.turnbackInfoMo:getLeaveDay()
end

function TurnbackModel:getCurTurnbackMoWithNilError()
	local turnbackMo = self:getCurTurnbackMo()

	if not turnbackMo then
		logError("TurnbackModel:getCurTurnbackMoWithNilError, can't find turnbackMo")
	end

	return turnbackMo
end

function TurnbackModel:canShowTurnbackPop()
	if not self.turnbackInfoMo then
		return false
	elseif self.turnbackInfoMo.firstShow then
		return false
	end

	return true
end

function TurnbackModel:initTurnbackSubModules(turnbackId)
	local subModuleTab = TurnbackConfig.instance:getAllTurnbackSubModules(turnbackId)

	for index, subId in ipairs(subModuleTab) do
		local subModule = self.turnbackSubModuleInfo[subId]

		if not subModule then
			subModule = {
				id = subId,
				config = TurnbackConfig.instance:getTurnbackSubModuleCo(subId),
				order = index
			}
			self.turnbackSubModuleInfo[subId] = subModule
		end
	end

	self:removeUnExitSubModules(self.turnbackSubModuleInfo)
end

function TurnbackModel:setTargetCategoryId(subId)
	self.targetCategoryId = subId
end

function TurnbackModel:getTargetCategoryId(turnbackId)
	self:initTurnbackSubModules(turnbackId)

	if GameUtil.getTabLen(self.turnbackSubModuleInfo) == 0 then
		self.targetCategoryId = 0

		return 0
	end

	for _, v in pairs(self.turnbackSubModuleInfo) do
		if v.config.id == self.targetCategoryId and v.config.turnbackId == turnbackId then
			return self.targetCategoryId
		end
	end

	self.targetCategoryId = turnbackId == 2 and self:getTargetNewSubModules() or self:getTargetSubModules(turnbackId)

	return self.targetCategoryId
end

function TurnbackModel:getTargetSubModules(turnbackId)
	local signin = string.format("Turnback%sSignInView", turnbackId)
	local bp = string.format("Turnback%sBPView", turnbackId)
	local search = string.format("Turnback%sDoubleView", turnbackId)
	local store = string.format("Turnback%sStoreView", turnbackId)

	if self:haveSignInReward() then
		return TurnbackEnum.ActivityId[signin]
	elseif self:haveTaskReward() then
		return TurnbackEnum.ActivityId[bp]
	elseif TurnbackTaskModel.instance:checkSearchTaskCanReceive() then
		return TurnbackEnum.ActivityId[search]
	elseif not self:checkTodayBonusReceive() then
		return TurnbackEnum.ActivityId[store]
	end

	return TurnbackEnum.ActivityId[signin]
end

function TurnbackModel:getTargetNewSubModules()
	if TurnbackModel.instance:haveSignInReward() then
		return TurnbackEnum.ActivityId.NewSignIn
	elseif TurnbackModel.instance:haveTaskReward() then
		return TurnbackEnum.ActivityId.NewTaskView
	end

	return TurnbackEnum.ActivityId.NewSignIn
end

function TurnbackModel:haveOnceBonusReward()
	return not self.turnbackInfoMo.onceBonus
end

function TurnbackModel:haveSignInReward()
	return TurnbackSignInModel.instance:getTheFirstCanGetIndex() ~= 0
end

function TurnbackModel:setLastGetSigninReward(day)
	self.lastGetSigninDay = day
end

function TurnbackModel:getLastGetSigninReward()
	return self.lastGetSigninDay
end

function TurnbackModel:getNextDay()
	local day = self:getCurSignInDay()

	if day < 7 then
		return day + 1
	end
end

function TurnbackModel:haveTaskReward()
	local haveTaskItemReward = TurnbackTaskModel.instance:haveTaskItemReward()
	local curHasGetTaskBonus = self:getCurHasGetTaskBonus()
	local allTaskBonusItemCo = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)
	local taskBonusItemTab = {}

	if not allTaskBonusItemCo or not curHasGetTaskBonus then
		return
	end

	for index, bonusCo in ipairs(allTaskBonusItemCo) do
		local taskBonusItem = {}

		taskBonusItem.config = bonusCo
		taskBonusItem.hasGetState = false

		for k, hasGetTaskBonusId in ipairs(curHasGetTaskBonus) do
			if bonusCo.id == hasGetTaskBonusId then
				taskBonusItem.hasGetState = true

				break
			end
		end

		taskBonusItemTab[index] = taskBonusItem
	end

	local bonusPoint = self.turnbackInfoMo.bonusPoint
	local haveTaskBonusReward = false

	for _, taskBonusItem in ipairs(taskBonusItemTab) do
		if bonusPoint >= taskBonusItem.config.needPoint and taskBonusItem.hasGetState == false then
			haveTaskBonusReward = true

			break
		end
	end

	return haveTaskItemReward or haveTaskBonusReward
end

function TurnbackModel:addUnExitSubModule(subModuleId)
	self.unExitSubModules[subModuleId] = subModuleId
end

function TurnbackModel:removeUnExitSubModules(subModuleIds)
	if GameUtil.getTabLen(subModuleIds) == 0 then
		return
	end

	for _, moduleId in pairs(self.unExitSubModules) do
		for index, info in ipairs(subModuleIds) do
			if info.id == moduleId then
				table.remove(subModuleIds, index)
			end
		end
	end

	return subModuleIds
end

function TurnbackModel:removeUnExitCategory(subModuleTab)
	for index, subModuleId in ipairs(subModuleTab) do
		if subModuleId == TurnbackEnum.ActivityId.DungeonShowView and not self.turnbackInfoMo:isAdditionInOpenTime() then
			self:addUnExitSubModule(subModuleId)
			table.remove(subModuleTab, index)
		end

		if subModuleId == TurnbackEnum.ActivityId.RecommendView and (TurnbackRecommendModel.instance:getCanShowRecommendCount() == 0 or not self.turnbackInfoMo:isInReommendTime()) then
			self:addUnExitSubModule(subModuleId)
			table.remove(subModuleTab, index)
		end
	end

	return subModuleTab
end

function TurnbackModel:getRemainTime(endTime)
	local turnbackInfoMO = self:getCurTurnbackMo()

	if turnbackInfoMO then
		local time = endTime or turnbackInfoMO.endTime
		local remainTimeSec = time - ServerTime.now()
		local day = Mathf.Floor(remainTimeSec / TimeUtil.OneDaySecond)
		local hourSecond = remainTimeSec % TimeUtil.OneDaySecond
		local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
		local minuteSecond = hourSecond % TimeUtil.OneHourSecond
		local minute = Mathf.Floor(minuteSecond / TimeUtil.OneMinuteSecond)
		local second = Mathf.Floor(minuteSecond % TimeUtil.OneMinuteSecond)

		return day, hour, minute, second
	else
		return 0, 0, 0, 0
	end
end

function TurnbackModel:isInOpenTime()
	if self.turnbackInfoMo then
		return self.turnbackInfoMo:isInOpenTime()
	end
end

function TurnbackModel:setTaskInfoList()
	TurnbackTaskModel.instance:setTaskInfoList(self.turnbackInfoMo.tasks)
	TurnbackTaskModel.instance:refreshListNewTaskList()
end

function TurnbackModel:getBuyDoubleBonus()
	return self.turnbackInfoMo:getBuyDoubleBonus()
end

function TurnbackModel:setBuyDoubleBonus()
	self.turnbackInfoMo.hasBuyDoubleBonus = true
end

function TurnbackModel:updateHasGetTaskBonus(info)
	self.turnbackInfoMo:updateHasGetTaskBonus(info.hasGetTaskBonus)
end

function TurnbackModel:updateCurBonusPoint(pointNum)
	self.turnbackInfoMo.bonusPoint = pointNum
end

function TurnbackModel:getCurHasGetTaskBonus()
	return self.turnbackInfoMo.hasGetTaskBonus
end

function TurnbackModel:setOnceBonusGetState()
	self.turnbackInfoMo.onceBonus = true
end

function TurnbackModel:getOnceBonusGetState()
	return self.turnbackInfoMo.onceBonus
end

function TurnbackModel:setSignInInfoList()
	TurnbackSignInModel.instance:setSignInInfoList(self.turnbackInfoMo.signInInfos)
end

function TurnbackModel:getCurSignInDay()
	return self.turnbackInfoMo.signInDay
end

function TurnbackModel:initRecommendData()
	TurnbackRecommendModel.instance:initReommendShowState(self.curTurnbackId)
end

function TurnbackModel:isAdditionValid()
	local turnbackInfoMo = self:getCurTurnbackMo()

	return (turnbackInfoMo or nil) and turnbackInfoMo:isAdditionValid()
end

function TurnbackModel:isShowTurnBackAddition(chapterId)
	local isValid = self:isAdditionValid()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local isAdditionChapter = TurnbackConfig.instance:isTurnBackAdditionToChapter(turnbackId, chapterId)

	return isValid and isAdditionChapter
end

function TurnbackModel:getAdditionCountInfo()
	local turnbackId = self:getCurTurnbackId()
	local totalCount = TurnbackConfig.instance:getAdditionTotalCount(turnbackId)
	local turnbackInfoMo = self:getCurTurnbackMoWithNilError()

	return (turnbackInfoMo or nil) and turnbackInfoMo:getRemainAdditionCount(), totalCount
end

function TurnbackModel:getAdditionRewardList(rewardList)
	local result = {}

	if not rewardList then
		return result
	end

	local turnbackId = self:getCurTurnbackId()
	local additionRate = TurnbackConfig.instance:getAdditionRate(turnbackId)

	if additionRate and additionRate > 0 then
		for _, reward in ipairs(rewardList) do
			local additionReward = {
				isAddition = true
			}

			additionReward[1] = reward[1]
			additionReward[2] = reward[2]
			additionReward[3] = math.ceil(reward[3] * additionRate / 1000)

			table.insert(result, additionReward)
		end
	end

	return result
end

function TurnbackModel:getMonthCardShowState()
	local turnbackMO = self:getCurTurnbackMo()

	if turnbackMO == nil then
		return false
	end

	local config = turnbackMO.config

	if config == nil then
		return false
	end

	if config.monthCardAddedId == nil then
		return false
	end

	local monthCardAddConfig = StoreConfig.instance:getMonthCardAddConfig(config.monthCardAddedId)

	if monthCardAddConfig == nil then
		return false
	end

	return turnbackMO.monthCardAddedBuyCount < monthCardAddConfig.limit
end

function TurnbackModel:getCurrentTurnbackMonthCardId()
	local turnbackMO = self:getCurTurnbackMo()

	if turnbackMO == nil then
		return nil
	end

	local config = turnbackMO.config

	return config.monthCardAddedId
end

function TurnbackModel:addCurrentMonthBuyCount()
	local turnbackMO = self:getCurTurnbackMo()

	if turnbackMO == nil then
		return
	end

	turnbackMO.monthCardAddedBuyCount = turnbackMO.monthCardAddedBuyCount + 1
end

function TurnbackModel:getCurrentMonthBuyCount()
	local turnbackMO = self:getCurTurnbackMo()

	if turnbackMO == nil then
		return 999
	end

	return turnbackMO.monthCardAddedBuyCount
end

function TurnbackModel:getCanGetRewardList()
	local list = {}
	local coList = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)

	for index, co in ipairs(coList) do
		if self:checkBonusCanGetById(co.id) then
			table.insert(list, co.id)
		end
	end

	return list
end

function TurnbackModel:getNextUnlockReward()
	local point = self:getCurrentPointId()
	local coList = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)

	for _, co in ipairs(coList) do
		if point < co.needPoint then
			return co.id
		end
	end

	if point >= coList[#coList].needPoint then
		return coList[#coList].id
	end
end

function TurnbackModel:checkBonusCanGetById(id)
	local pointId = self:getCurrentPointId()
	local co = TurnbackConfig.instance:getTurnbackTaskBonusCo(self.curTurnbackId, id)

	if pointId >= co.needPoint and not self:checkBonusGetById(id) then
		return true
	end

	return false
end

function TurnbackModel:getCurrentPointId()
	local bonusPointType, bonusPointId = TurnbackConfig.instance:getBonusPointCo(self.curTurnbackId)
	local bonusPointMo = CurrencyModel.instance:getCurrency(bonusPointId)

	return (bonusPointMo or nil) and (bonusPointMo.quantity or 0)
end

function TurnbackModel:checkBonusGetById(id)
	local idList = self:getCurHasGetTaskBonus()

	for index, value in ipairs(idList) do
		if id == value then
			return true
		end
	end

	return false
end

function TurnbackModel:checkHasGetAllTaskReward()
	local idList = self:getCurHasGetTaskBonus()
	local coList = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)

	if #idList == #coList then
		return true
	end

	return false
end

function TurnbackModel:_calcAllBonus()
	self.bounsdict = {}
	self.allBonusList = {}

	local bonusList = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)

	for index, co in ipairs(bonusList) do
		self:_calcBonus(self.bounsdict, self.allBonusList, co.bonus)
	end
end

function TurnbackModel:getAllBonus()
	return self.allBonusList
end

function TurnbackModel:getAllBonusCount()
	return #self.allBonusList
end

function TurnbackModel:_calcBonus(dict, list, bonusStr)
	for _, str in pairs(string.split(bonusStr, "|")) do
		local sp = string.splitToNumber(str, "#")
		local id = sp[2]
		local num = sp[3]

		if not dict[id] then
			dict[id] = sp

			table.insert(list, sp)
		else
			dict[id][3] = dict[id][3] + num
		end
	end
end

function TurnbackModel:getFirstBonusHeroConfig()
	if not self.bonusHeroConfigList then
		local list = self:getBonusHeroConfigList()

		return list[1]
	else
		return self.bonusHeroConfigList[1]
	end
end

function TurnbackModel:getBonusHeroConfigList()
	if self.bonusHeroConfigList then
		return self.bonusHeroConfigList
	else
		self.bonusHeroConfigList = {}
		self.unlockHeroList = {}

		local list = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)

		for index, bonusCo in ipairs(list) do
			if bonusCo and not string.nilorempty(bonusCo.character) then
				self.firstBonusHeroConfig = self.firstBonusHeroConfig or bonusCo

				local id = bonusCo.id

				if self:checkBonusGetById(id) then
					table.insert(self.unlockHeroList, id)
				end

				table.insert(self.bonusHeroConfigList, bonusCo)
			end
		end
	end
end

function TurnbackModel:getUnlockHeroList()
	self.unlockHeroList = {}

	local list = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)

	for index, bonusCo in ipairs(list) do
		if bonusCo and not string.nilorempty(bonusCo.character) then
			local point = self:getCurrentPointId()

			if point >= bonusCo.needPoint then
				table.insert(self.unlockHeroList, bonusCo)
			else
				table.insert(self.unlockHeroList, bonusCo)

				return self.unlockHeroList
			end
		end
	end

	return self.unlockHeroList
end

function TurnbackModel:setDropInfoList(dropInfoList, commonDropInfos)
	self._dropInfoList = self._dropInfoList or {}

	local colist = TurnbackConfig.instance:getDropCoList()
	local infoDict = {}

	self._totalCouponCount = 0

	if dropInfoList and #dropInfoList > 0 then
		for i, dropinfo in ipairs(dropInfoList) do
			infoDict[dropinfo.type] = infoDict[dropinfo.type] or {}

			local info = {
				type = dropinfo.type,
				materialType = MaterialEnum.MaterialType.Currency,
				materialId = CurrencyEnum.CurrencyType.FreeDiamondCoupon,
				totalNum = dropinfo.totalNum,
				currentNum = dropinfo.currentNum
			}

			table.insert(infoDict[dropinfo.type], info)
		end
	end

	if commonDropInfos and #commonDropInfos > 0 then
		for i, dropinfo in ipairs(commonDropInfos) do
			infoDict[dropinfo.type] = infoDict[dropinfo.type] or {}

			table.insert(infoDict[dropinfo.type], dropinfo)
		end
	end

	if colist then
		for _, co in ipairs(colist) do
			local mo = self._dropInfoList[co.id]

			if not mo then
				mo = TurnbackDropInfoMo.New()

				mo:init(co)

				self._dropInfoList[co.id] = mo
			end

			mo:refreshInfo(infoDict[co.id])

			self._totalCouponCount = self._totalCouponCount + mo:getCouponCount()
		end
	end
end

function TurnbackModel:getDropInfoByType(type)
	return self._dropInfoList and self._dropInfoList[type]
end

function TurnbackModel:getDropInfos()
	return self._dropInfoList
end

function TurnbackModel:getDropInfoList()
	local level2list = {}
	local level3list = {}
	local checklist = {}
	local count = TurnbackConfig.instance:getDropCoCount()

	if self._dropInfoList and #self._dropInfoList > 0 then
		while #checklist < 4 do
			local type = math.random(1, count)

			if not tabletool.indexOf(checklist, type) then
				local co = TurnbackConfig.instance:getDropCoById(type)

				if co.level == 2 and #level2list < TurnbackEnum.Level2Count then
					local mo = self._dropInfoList[type]

					table.insert(level2list, mo)
					table.insert(checklist, type)
				elseif co.level == 3 and #level3list < TurnbackEnum.Level3Count then
					local mo = self._dropInfoList[type]

					table.insert(level3list, mo)
					table.insert(checklist, type)
				end
			end
		end
	end

	return level2list, level3list
end

function TurnbackModel:getTotalCouponCount()
	return self._totalCouponCount
end

function TurnbackModel:getContentWidth()
	local rewardColist = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)
	local left = 50
	local right = 50
	local itemspace = 100
	local count = #rewardColist
	local itemWidth = 100

	return left + right + itemWidth * count + itemspace * (count - 1)
end

function TurnbackModel:getCurrenUnLockPayReward()
	local rewardList = {}
	local idList = self:getCurHasGetTaskBonus()

	for index, id in ipairs(idList) do
		local co = TurnbackConfig.instance:getTurnbackTaskBonusCo(self.curTurnbackId, id)
		local mo = {}
		local temp = co and not string.nilorempty(co.extraBonus) and string.splitToNumber(co.extraBonus, "#")

		mo.type, mo.id, mo.num = temp[1], temp[2], temp[3]

		table.insert(rewardList, mo)
	end

	table.sort(rewardList, TurnbackModel.sortFunc)

	local config = TurnbackConfig.instance:getTurnbackCo(self.curTurnbackId)
	local temp = not string.nilorempty(config.buyBonus) and string.splitToNumber(config.buyBonus, "#")
	local buyBonus = {
		type = temp[1],
		id = temp[2],
		num = temp[3]
	}
	local unlockRewardList = {
		buyBonus
	}

	tabletool.addValues(unlockRewardList, rewardList)

	return unlockRewardList
end

function TurnbackModel:getCurrenLockAllReward()
	local rewardList = {}
	local colist = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self.curTurnbackId)
	local idList = self:getCurHasGetTaskBonus()

	for index, co in ipairs(colist) do
		if not tabletool.indexOf(idList, co.id) then
			local mo1 = {}
			local temp = co and not string.nilorempty(co.bonus) and string.splitToNumber(co.bonus, "#")

			mo1.type, mo1.id, mo1.num = temp[1], temp[2], temp[3]

			table.insert(rewardList, mo1)

			local mo2 = {}
			local temp = co and not string.nilorempty(co.extraBonus) and string.splitToNumber(co.extraBonus, "#")

			mo2.type, mo2.id, mo2.num = temp[1], temp[2], temp[3]

			table.insert(rewardList, mo2)
		end
	end

	table.sort(rewardList, TurnbackModel.sortFunc)

	return rewardList
end

function TurnbackModel:getCurrentTurnbackDay()
	local time = ServerTime.now() - self:getCurTurnbackMo().startTime

	return (math.ceil(time / TimeUtil.OneDaySecond))
end

function TurnbackModel:checkIsLastTurnbackDay()
	local time = self:getCurTurnbackMo().endTime - ServerTime.now()
	local day = math.floor(time / TimeUtil.OneDaySecond)

	return day < 1
end

function TurnbackModel:setDailyBonus(getDailyBonus)
	self.turnbackInfoMo:setDailyBonus(getDailyBonus)
end

function TurnbackModel:isClaimedDailyBonus(day)
	return self.turnbackInfoMo:isClaimedDailyBonus(day)
end

function TurnbackModel:checkTodayBonusReceive()
	local day = self:getCurrentTurnbackDay()

	return self:isClaimedDailyBonus(day)
end

function TurnbackModel:setOpenPopTipView(state)
	self._openpopview = state
end

function TurnbackModel:getOpenPopTipView()
	return self._openpopview
end

function TurnbackModel:getCurRewardCurrencyNum()
	local currencyInfo = self.turnbackInfoMo:getCurRewardCurrencyInfo()

	if currencyInfo then
		::label_77_0::

		local quantity = ItemModel.instance:getItemQuantity(currencyInfo[1], currencyInfo[2])

		return quantity or 0
	end
end

function TurnbackModel:onGetResourceReturnReward(hasGetReturnRewardIds)
	self.turnbackInfoMo:onGetResourceReturnReward(hasGetReturnRewardIds)
end

TurnbackModel.instance = TurnbackModel.New()

return TurnbackModel
