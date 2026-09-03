-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/controller/BagSystem.lua

BagSystem = class("BagSystem", Facade, _M)

BagSystem:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
BagSystem:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
BagSystem:has("_composeTimes", {
	is = "r"
})
BagSystem:has("_uRCount", {
	is = "r"
})
BagSystem:has("_uREquipState", {
	is = "r"
})

local crusadeEnergyReset

function BagSystem:initialize()
	super.initialize(self)

	self._isFirst = true
	self._showStack = {
		false
	}
	self._viewVector = {}
	self._sharedScheduler = nil
	self._powerResetMap = {}
	self._composeTimes = {}
	self._uRCount = 0
	self._uREquipState = {}
	self._uREquipState.uRSuiteMap = {}
	self._uREquipState.uRStatMap = {}
	crusadeEnergyReset = self:initConfigSystem("Reset", "Crusade_Energy_Recovery")
end

function BagSystem:initPowerReset()
	for k, v in pairs(PowerConfigMap) do
		if v.tableName and v.configId then
			self._powerResetMap[k] = self:initConfigSystem(v.tableName, v.configId)
		end
	end
end

function BagSystem:initConfigSystem(tableName, configId)
	local srcCfg = ConfigReader:getRecordById(tableName, configId)

	if srcCfg == nil and configId == "AcitvityHalloweenStamina_Reset" then
		srcCfg = {
			ResetSystem = {
				addValue = 1,
				storage = 5000,
				cd = 540,
				initial = 200,
				resetMode = "CD",
				limit = 400
			}
		}
	end

	assert(srcCfg ~= nil, "表" .. tableName .. "没有id为" .. configId .. "的数据")

	return (srcCfg or nil) and (srcCfg.ResetSystem or nil)
end

function BagSystem:userInject(injector)
	self._gameServerAgent = injector:getInstance("GameServerAgent")
end

function BagSystem:tryEnter(data)
	local bagView = self:getInjector():getInstance("BagView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, bagView, nil, data))
end

function BagSystem:synchronize(data, isDiff)
	self:dispatch(Event:new(EVT_BAG_SYNCHRONIZED, {}))

	if isDiff then
		self:updataURExhangeRedPoint(data)
	end
end

function BagSystem:getBag()
	return self._developSystem:getPlayer():getBag()
end

function BagSystem:getEntryById(entryId)
	return self:getBag():getEntryById(entryId)
end

function BagSystem:getEntryRedStateById(entryId, index)
	local entry = self:getBag():getEntryById(entryId)

	if entry then
		return self:getBag():getEntryById(entryId).redPoint
	end

	return false
end

function BagSystem:getComposeRedStateByEntryId(entryId)
	local configData = ConfigReader:getRecordById("Compose", entryId)
	local item = self:getBag():getEntryById(entryId).item
	local result, tipsCode = self:canUse({
		item = item
	})

	if not result then
		return false
	end

	for i = 1, 4 do
		local itemM = configData["Item" .. i]
		local state = self:getComposeMaterialRedStateById(itemM)

		if not state then
			return false
		end
	end

	if configData.Currency then
		local haveNum = self._developSystem:getGolds()

		if haveNum < configData.Currency.amount then
			return false
		end
	end

	return true
end

function BagSystem:getComposeMaterialRedStateById(MaterialData)
	local itemM = MaterialData

	if itemM then
		local allEquips = self._developSystem:getPlayer():getEquipList():getEquips()

		if itemM.type == "Item" then
			local haveNum = self:getItemCount(itemM.id)

			if haveNum < itemM.amount then
				return false
			end
		elseif itemM.type == "Equip" then
			local haveNum = 0

			for k, v in pairs(allEquips) do
				if v:getEquipId() == itemM.id and v:getLevel() == 1 and self:checkComposeUsed(v:getEquipId(), v:getId()) == false then
					haveNum = haveNum + 1
				end
			end

			if haveNum < itemM.amount then
				return false
			end
		elseif itemM.type == "EquipAll" then
			local haveNum = 0

			for k, v in pairs(allEquips) do
				if tonumber(v:getRarity()) == tonumber(itemM.Quality) and v:getLevel() == 1 and self:checkComposeUsed(v:getEquipId(), v:getId()) == false then
					haveNum = 1

					break
				end
			end

			if haveNum == 0 then
				return false
			end
		else
			local haveNum = 0

			for k, v in pairs(allEquips) do
				if v:getPosition() == itemM.type and tonumber(v:getRarity()) == tonumber(itemM.Quality) and v:getLevel() == 1 and self:checkComposeUsed(v:getEquipId(), v:getId()) == false then
					haveNum = 1

					break
				end
			end

			if haveNum == 0 then
				return false
			end
		end

		return true
	end
end

function BagSystem:checkComposeUsed(equipId, uuid)
	local key_equip = equipId .. "_" .. uuid
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local equipSystem = developSystem:getEquipSystem()
	local usedList = equipSystem:getComposeUsedEquips()
	local used = false

	for key, value in pairs(usedList) do
		if key_equip == value then
			used = true

			break
		end
	end

	return used
end

function BagSystem:hideEntryRedById(entryId)
	self:getBag():hideEntryRedById(entryId)
end

function BagSystem:getBagTabRedByType(type)
	return self:getBag():getBagTabRedByType(type)
end

function BagSystem:isBagRedPointShow()
	return self:getBagTabRedByType(ItemPages.kConsumable)
end

function BagSystem:clearBagTabRedPointByType(type)
	self:getBag():clearBagTabRedByType(type)
end

function BagSystem:getPowerResetByCurrencyId(currencyId)
	if not self._powerResetMap[currencyId] then
		self:initPowerReset()
	end

	assert(self._powerResetMap[currencyId], "not find resetConfig in local _powerResetMap, id " .. currencyId)

	return self._powerResetMap[currencyId]
end

function BagSystem:getPowerByCurrencyId(currencyId)
	local resetConfig = PowerConfigMap[currencyId]

	assert(resetConfig, "not find config in local PowerConfigMap, id " .. currencyId)

	if not self._powerResetMap[currencyId] then
		self:initPowerReset()
	end

	local resetSystem = self._powerResetMap[currencyId]
	local entry = self:getEntryById(currencyId)
	local count = 0
	local lastRecoverTime = 0

	if entry and resetSystem then
		lastRecoverTime = entry.item:getLastRecoverTime()

		if lastRecoverTime == 0 then
			lastRecoverTime = self._gameServerAgent:remoteTimestamp()
		end

		count = entry.count

		local powerLimit = resetSystem.limit

		if count < powerLimit then
			local curTime = self._gameServerAgent:remoteTimestamp()
			local changeCount = math.max(0, math.floor((curTime - lastRecoverTime) / resetSystem.cd))

			count = math.min(count + changeCount, powerLimit)
		end
	end

	return count, lastRecoverTime
end

function BagSystem:getPower()
	if not self._powerResetMap[CurrencyIdKind.kPower] then
		self:initPowerReset()
	end

	local entry = self:getEntryById(CurrencyIdKind.kPower)
	local count = 0
	local lastRecoverTime = 0
	local resetSystem = self._powerResetMap[CurrencyIdKind.kPower]

	if entry then
		lastRecoverTime = entry.item:getLastRecoverTime()
		count = entry.count

		local level = self._developSystem:getPlayer():getLevel()

		if count < self:getRecoveryPowerLimit(level) then
			local curTime = self._gameServerAgent:remoteTimestamp()
			local changeCount = math.max(0, math.floor((curTime - lastRecoverTime) / resetSystem.cd))

			count = math.min(count + changeCount, self:getRecoveryPowerLimit(level))
		end
	end

	return count, lastRecoverTime
end

function BagSystem:getCrusadeEnergy()
	local entry = self:getEntryById(CurrencyIdKind.kCrusadeEnergy)
	local count = 0
	local lastRecoverTime = 0

	if entry then
		lastRecoverTime = entry.item:getLastRecoverTime()
		count = entry.count

		local resetSystem = crusadeEnergyReset

		if count < resetSystem.storage then
			local curTime = self._gameServerAgent:remoteTimestamp()
			local changeCount = math.max(0, math.floor((curTime - lastRecoverTime) / resetSystem.cd))

			count = math.min(count + changeCount, resetSystem.storage)
		end
	end

	return count, lastRecoverTime
end

function BagSystem:getAcitvitySummerPower()
	return self:getPowerByCurrencyId(CurrencyIdKind.kAcitvitySummerPower)
end

function BagSystem:getDiamond()
	local entry = self:getEntryById(CurrencyIdKind.kDiamond)

	return (entry or nil) and (entry.count or 0)
end

function BagSystem:getHonor()
	local entry = self:getEntryById(CurrencyIdKind.kHonor)

	return (entry or nil) and (entry.count or 0)
end

function BagSystem:getTrial()
	local entry = self:getEntryById(CurrencyIdKind.kTrial)

	return (entry or nil) and (entry.count or 0)
end

function BagSystem:getEquipDebris()
	local entry = self:getEntryById(CurrencyIdKind.kEquipPiece)

	return (entry or nil) and (entry.count or 0)
end

function BagSystem:getActivity()
	local entry = self:getEntryById(CurrencyIdKind.kActivity)

	return (entry or nil) and (entry.count or 0)
end

function BagSystem:getCountByCurrencyType(costType)
	local entry = self:getEntryById(costType)

	return (entry or nil) and (entry.count or 0)
end

function BagSystem:deleteItems(list)
	if list.items then
		for k, v in pairs(list.items) do
			self:getBag():removeItem(k)
		end
	end
end

function BagSystem:isItem(itemId)
	local config = {}

	if config then
		return true
	end

	return false
end

function BagSystem:getLastSyncTime()
	return self:getBag():getLastSyncTime()
end

function BagSystem:getItemCount(itemId)
	local entry = self:getEntryById(tostring(itemId))

	if itemId == CurrencyIdKind.kPower then
		return self:getPower()
	end

	return (entry ~= nil or nil) and (entry.count or 0)
end

function BagSystem:getEntryItemById(itemId)
	local entry = self:getEntryById(tostring(itemId))

	if entry then
		return entry.item
	end
end

function BagSystem:getRecoveryPowerLimit(level)
	local config = ConfigReader:getRecordById("LevelConfig", tostring(level))
	local powerLimit = config and config.ActionPointLimit

	return powerLimit or 0
end

function BagSystem:getMaxPowerLimit()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stamina_Max", "content") or 3000
end

function BagSystem:getCanBuyPowerNum()
	local aBuyTimes = self:getBuyTimesByType(TimeRecordType.kBuyStamina)
	local value = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Stamina_Price", "content")

	return value[aBuyTimes + 1]
end

function BagSystem:isPowerFull(addNum)
	addNum = addNum or self:getCanBuyPowerNum()

	local curPower = self:getPower()
	local maxPowerLimit = self:getMaxPowerLimit()
	local newPower = curPower + addNum

	return maxPowerLimit < newPower
end

function BagSystem:getItemConfig(itemId)
	return ConfigReader:getRecordById("ItemConfig", tostring(itemId))
end

function BagSystem:createItemIcon(itemId)
	local count = 0
	local entry = self:getEntryById(itemId)

	if entry and entry.count then
		count = entry.count
	end

	local info = {
		id = itemId,
		amount = count
	}

	return IconFactory:createItemIcon(info), count
end

function BagSystem:getItemIsVisible(itemId)
	local entry = self:getEntryById(itemId)

	if entry and entry.item then
		return entry.item:getIsVisible()
	end

	return ConfigReader:getDataByNameIdAndKey("ItemConfig", itemId, "Isvisible") == 1
end

function BagSystem:getItemBatchUseCount()
	local minCnt = ConfigReader:getRecordById("ConfigValue", "Item_MuluseMin").content
	local maxCnt = ConfigReader:getRecordById("ConfigValue", "Item_MuluseMax").content

	return minCnt, maxCnt
end

function BagSystem:goToViewByUrl(curEntryId)
	local entry = self:getEntryById(curEntryId)

	if not entry then
		return
	end

	local item = entry.item
	local url = item:getUrl()
	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(url)
	local pages = item:getType()
	local subtype = item:getSubType()

	if params and (subtype == ItemTypes.K_HERO_F or subtype == ItemTypes.K_MASTER_F or subtype == ItemTypes.K_EQUIP_STAR or subtype == ItemTypes.K_EQUIP_ORNAMENT) then
		params.id = item:getTargetId()
	end

	if not entry then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
	else
		entry:response(context, params)
	end
end

function BagSystem:getAllEntryIds(filterFunc, style)
	filterFunc = filterFunc or function(entry)
		return true
	end

	local allEntryIds = self:getBag():getEntryIds(filterFunc)
	local heroSystem = self._developSystem:getHeroSystem()

	local function isHeroFragamentCanComp(item)
		if item and item:getType() == ItemPages.kFragament and item:getSubType() == ItemTypes.K_HERO_F and heroSystem:checkHeroCanComp(item:getTargetId()) then
			return true
		end

		return false
	end

	table.sort(allEntryIds, function(entryIdA, entryIdB)
		local entryA = self:getEntryById(entryIdA)
		local entryB = self:getEntryById(entryIdB)
		local itemA = entryA.item
		local itemB = entryB.item

		repeat
			local aCanCompFlag = isHeroFragamentCanComp(itemA) and 1 or 0
			local bCanCompFlag = isHeroFragamentCanComp(itemB) and 1 or 0

			if aCanCompFlag + bCanCompFlag ~= 0 and aCanCompFlag + bCanCompFlag == 1 then
				return aCanCompFlag == 1
			end

			do break end
			break
		until true

		return self:SortFunc(itemA, itemB)
	end)

	return allEntryIds
end

function BagSystem:canUse(info)
	local limitLevel, limitVipLevel = info.limitLevel, info.limitVipLevel

	if not limitLevel and info.item then
		limitLevel = tonumber(info.item:getUseLevel())
	end

	if not limitVipLevel and info.item then
		limitVipLevel = tonumber(info.item:getUseVipLevel())
	end

	if limitLevel > self._developSystem:getLevel() then
		return false, "Tips_1160000"
	end

	if limitVipLevel > self._developSystem:getVipLevel() then
		return false, "Tips_1160001"
	end

	return true
end

function BagSystem:isEnergy(rewardData)
	if type(rewardData) == "table" then
		return tonumber(rewardData.type) == 2 and tostring(rewardData.code) == CurrencyIdKind.kPower
	end
end

function BagSystem:getPowerEntryIds()
	local function filterFunc(entry)
		local item = entry.item

		return item:getSubType() == ComsumableKind.kActionPoint
	end

	return (self:getBag():getEntryIds(filterFunc))
end

function BagSystem:tryUseActionPointItem(itemId, count)
	local canUse = true
	local entry = self:getBag():getEntryById(itemId)

	if not entry then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("ITEM_USE_TIPS")
		}))

		return
	end

	local item = entry and entry.item

	if item and item:getType() == ItemPages.kConsumable then
		local rewardData = item:getReward()
		local firstReward = rewardData and rewardData[1]

		if self:isEnergy(firstReward) then
			local addEnergy = (firstReward.amount or 0) * count
			local maxCount = self:getMaxPowerLimit()

			if maxCount < addEnergy + self._developSystem:getEnergy() then
				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:find("Power_FullOver")
				}))

				canUse = false
			end
		end
	end

	if canUse then
		local itemType = ConfigReader:getDataByNameIdAndKey("ItemConfig", itemId, "Type")

		if itemType == ItemTypes.K_ORE_COLLECT then
			local function callBack(rewards)
				if rewards and #rewards > 0 then
					local view = self:getInjector():getInstance("getRewardView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						needClick = true,
						rewards = rewards
					}))
				end
			end

			self:requestOreUseItem(itemId, count, callBack)

			return canUse
		end

		local reward = item:getReward()

		self:requestUseItem(itemId, count, self:isShowGetReward(reward) and function(rewards)
			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				needClick = true,
				rewards = rewards
			}))
			self:dispatch(Event:new(EVT_SWEEPPOWERCHANGE_SERVER, {}))
		end or function(rewards)
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("Tips_Using_Success")
			}))
		end)
	end

	return canUse
end

function BagSystem:isShowGetReward(reward)
	if reward and table.getn(reward) > 0 then
		local rewardsNow = {}

		for i = 1, table.nums(reward) do
			if reward[i] and reward[i].code then
				local code = reward[i].code
				local type = reward[i].type
				local filter = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Activity_Point_Hide", "content")

				if type == RewardType.kEquip or type == RewardType.kEquipExplore then
					rewardsNow[#rewardsNow + 1] = reward[i]
				elseif not table.indexof(filter, code) and type ~= RewardType.kSpecialValue then
					rewardsNow[#rewardsNow + 1] = reward[i]
				end
			end
		end

		if table.getn(rewardsNow) > 0 then
			return true
		end
	end

	return false
end

function BagSystem:requestBoxChooseItem(entryId, amount, rewardId, callback)
	local data = {
		itemId = entryId,
		count = amount,
		selectId = rewardId
	}
	local bagService = self:getInjector():getInstance(BagService)

	bagService:requestUseBoxChooseItem(data, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback(response.data)
		end
	end)

	return true
end

function BagSystem:getTabFilterMap()
	if self._tabFilterMap then
		return self._tabFilterMap
	end

	self._tabFilterMap = {
		[BagItemShowType.kAll] = function(item)
			return item:getType() ~= ItemPages.kCurrency
		end,
		[BagItemShowType.kCompose] = function(item)
			return item:getType() == ItemPages.kCompose
		end,
		[BagItemShowType.kEquip] = function(item)
			return item:getType() == ItemPages.kEquip
		end,
		[BagItemShowType.kStuff] = function(item)
			return item:getType() == ItemPages.kStuff and item:getSubType() ~= ItemTypes.K_EQUIP_STAR
		end,
		[BagItemShowType.kFragament] = function(item)
			return item:getType() == ItemPages.kFragament
		end,
		[BagItemShowType.kConsumable] = function(item)
			return item:getType() == ItemPages.kConsumable
		end,
		[BagItemShowType.kTSoul] = function(item)
			return item:getType() == ItemPages.kTsoul
		end,
		[BagItemShowType.kOther] = function(item)
			return item:getType() == ItemPages.kOther
		end
	}

	return self._tabFilterMap
end

function BagSystem:requestBagList(callback)
	local bagService = self:getInjector():getInstance(BagService)

	bagService:requestBagList(nil, true, function(response)
		if response.resCode == GS_SUCCESS then
			local bag = self:getBag()

			bag:synchronize(response.data)

			if callback then
				callback()
			end
		end
	end)
end

function BagSystem:sysHero(heroId, data)
	heroId = tostring(heroId)

	local heroSystem = self._developSystem:getHeroSystem()
	local hero = heroSystem:getHeroById(heroId)

	if hero then
		hero:synchronize(data)
	end
end

function BagSystem:requestHeroCompose(itemId, callback)
	local bagService = self:getInjector():getInstance(BagService)
	local heroSystem = self._developSystem:getHeroSystem()
	local data = {
		itemId = itemId
	}

	bagService:requestHeroCompose(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			local heroList = {}

			heroList[tostring(response.data.id)] = response.data

			heroSystem:getHeroList():synchronize(heroList)
			self:dispatch(Event:new(EVT_HEROCOMPOSE_SUCC, {}))

			if callback then
				callback(response.data)
			end
		end
	end)
end

function BagSystem:requestScrollCompose(_data, callback)
	local bagService = self:getInjector():getInstance(BagService)
	local data = {
		itemId = _data.itemId,
		selected = _data.selected
	}

	bagService:requestScrollCompose(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data.reward)
			end
		elseif response.resCode == 10180 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("bag_ScrollNotEnougth")
			}))
		elseif response.resCode == 10181 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("bag_MaterialNotEnougth")
			}))
		elseif response.resCode == 10182 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("bag_coinNotEnougth")
			}))
		end
	end)
end

function BagSystem:getScrollComposeRedState(_data, callback)
	return
end

function BagSystem:requestHeroDebrisChange(heroId, num, callback)
	local bagService = self:getInjector():getInstance(BagService)
	local data = {
		heroId = heroId,
		num = num
	}

	bagService:requestHeroDebrisChange(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_HERODEBRISCHANGE_SUCC, {}))
		end
	end)
end

function BagSystem:requestMasterDebrisChange(masterId, num, callback)
	local bagService = self:getInjector():getInstance(BagService)
	local data = {
		masterId = masterId,
		num = num
	}

	bagService:requestMasterDebrisChange(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_MASTERDEBRISCHANGE_SUCC, {}))
		end
	end)
end

function BagSystem:requestUseItem(entryId, amount, callback)
	local data = {
		itemId = entryId,
		count = amount
	}
	local bagService = self:getInjector():getInstance(BagService)

	bagService:requestUseItem(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response.data.rewards)
			end

			self:dispatch(Event:new(EVT_SELL_ITEM_SUCC))
		end
	end)
end

function BagSystem:requestOreUseItem(entryId, amount, callback)
	local rewardIdList = {}

	rewardIdList.IR_Gold = self:getItemCount("IR_Gold") or 0
	rewardIdList.IR_Crystal = self:getItemCount("IR_Crystal") or 0

	local expList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "ExpChargeItem", "content")

	for _, id in pairs(expList) do
		rewardIdList[id] = self:getItemCount(id) or 0
	end

	local data = {
		itemId = entryId,
		count = amount
	}
	local bagService = self:getInjector():getInstance(BagService)

	bagService:requestUseItem(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			local rewards = {}

			for id, num in pairs(rewardIdList) do
				local numNow = self:getItemCount(id) or 0

				if num < numNow then
					local data = {}

					data.amount = numNow - num
					data.code = id
					data.type = 2
					rewards[#rewards + 1] = data
				end
			end

			if callback then
				callback(rewards)
			end

			self:dispatch(Event:new(EVT_SELL_ITEM_SUCC))
		end
	end)
end

function BagSystem:requestSellItem(itemId, num, callback)
	local bagService = self:getInjector():getInstance(BagService)
	local data = {
		itemId = itemId,
		count = num
	}

	bagService:requestSellItem(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_SELL_ITEM_SUCC))
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:find("Tips_1160003")
			}))
		end
	end)
end

function BagSystem:requestHeroStoneCompose(itemId, num, callback)
	local bagService = self:getInjector():getInstance(BagService)
	local data = {
		itemId = itemId,
		times = num
	}

	bagService:requestHeroStoneCompose(data, true, function(response)
		if response.resCode == GS_SUCCESS then
			callback(response.data.reward)
		end
	end)
end

function BagSystem:requestUseRechargeItem(params, callback)
	local bagService = self:getInjector():getInstance(BagService)
	local data = {
		itemId = params.itemId,
		itemName = params.itemName
	}

	bagService:requestUseRechargeItem(data, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			if not response.data.rewards then
				local rewards = response.data.reward

				self:dispatch(Event:new(EVT_BAG_USE_RECHARGEITEM_SUCC, {
					rewards = rewards,
					itemName = data.itemName
				}))
			end
		end
	end)
end

function BagSystem:isUsedRechargeItem(type)
	local types = {
		[ItemTypes.K_MONTHCARD] = 1,
		[ItemTypes.K_PACKAGESHOP] = 1,
		[ItemTypes.K_SHOPRESET] = 1,
		[ItemTypes.K_MONTHFOREVER] = 1,
		[ItemTypes.K_ACTIVITY] = 1
	}

	if types[type] then
		return true
	end

	return false
end

function BagSystem:delItems(list)
	if list.bagMap then
		for k, v in pairs(list.bagMap) do
			self:getBag():removeItem(k)
		end
	end
end

function BagSystem:getTimeRecordById(timeRecordType)
	return self:getBag():getTimeRecordById(timeRecordType)
end

function BagSystem:getBuyTimesByType(timeRecordType)
	return self:getTimeRecordById(timeRecordType):getTime()
end

function BagSystem:formatCurrencyString(currencyId)
	local count = self:getItemCount(currencyId)

	if count <= 999999 then
		return tostring(count)
	else
		count = count - count % 1000

		return string.format("%.1f万", count / 10000)
	end
end

local CostNotEnoughDetalMap = {
	[CurrencyIdKind.kPower] = {
		tip = "Tips_3010015",
		popup = function(parent)
			return
		end
	}
}

function BagSystem:checkCostEnough(costId, needCost, style)
	if costId == nil then
		return
	end

	needCost = needCost or 0

	local result = CurrencySystem:checkEnoughCurrency(self, costId, needCost, style)

	if result ~= nil then
		return result
	end

	local itemCount = self:getItemCount(costId)
	local isEnough = needCost <= itemCount

	if not isEnough and style then
		if not style.type then
			local type = "tip"

			if CostNotEnoughDetalMap[costId] then
				local detalFunc = CostNotEnoughDetalMap[costId][type]

				if detalFunc then
					detalFunc(self)
				end
			end

			if style.notShowTip == nil or style.notShowTip == false then
				local itemConfig = ConfigReader:getRecordById("ResourcesIcon", costId)

				itemConfig = itemConfig or ConfigReader:getRecordById("ItemConfig", costId)

				local name = itemConfig and Strings:get(itemConfig.Name) or costId

				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("ItemNotEngouh_Text", {
						item = name
					})
				}))
			end
		end
	end

	return isEnough
end

function BagSystem:checkCostAllEnough(costId, costId2, needCost, style)
	if costId == nil then
		return
	end

	needCost = needCost or 0

	local itemCount1 = self:getItemCount(costId)
	local itemCount2 = self:getItemCount(costId2)
	local isEnough = needCost <= itemCount1 + itemCount2

	if not isEnough and style then
		if not style.type then
			local type = "tip"

			if CostNotEnoughDetalMap[costId] then
				local detalFunc = CostNotEnoughDetalMap[costId][type]

				if detalFunc then
					detalFunc(self)
				end
			end

			if style.notShowTip == nil or style.notShowTip == false then
				local itemConfig = ConfigReader:getRecordById("ResourcesIcon", costId)

				itemConfig = itemConfig or ConfigReader:getRecordById("ItemConfig", costId)

				local name = itemConfig and Strings:get(itemConfig.Name) or costId

				self:dispatch(ShowTipEvent({
					duration = 0.2,
					tip = Strings:get("ItemNotEngouh_Text", {
						item = name
					})
				}))
			end
		end
	end

	return isEnough
end

function BagSystem:getColorByItemId(id, num)
	local isCurrency = false

	for k, v in pairs(CurrencyIdKind) do
		if id == v then
			isCurrency = true

			break
		end
	end

	if isCurrency then
		local config = ConfigReader:getRecordById("ResourcesIcon", id)

		if config then
			local seg = config.Segmentation
			local _Quality = config.Quality
			local name = Strings:get(config.Name)

			for k, v in pairs(seg) do
				if num < v then
					return _Quality[k], name
				elseif num >= seg[#seg] then
					return _Quality[#seg], name
				end
			end
		end
	else
		local configitem = ConfigReader:getRecordById("ItemConfig", id)

		if configitem then
			local color = configitem.Quality
			local name = Strings:get(configitem.Name)

			return color, name
		end
	end
end

function BagSystem:showTips(data)
	if self._isFirst then
		self._isFirst = false

		return
	end

	if not self:getShowTips() then
		return
	end

	local filter = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Activity_Point_Hide", "content")
	local count = 0

	self._tipsQueue = {}

	for k, v in pairs(data) do
		local show = true

		for kf, vf in pairs(filter) do
			if v.itemId == vf then
				show = false
			end
		end

		local olditem = self:getEntryById(k)
		local addnum = 0

		addnum = olditem and v.count - olditem.count or v.count

		if addnum > 0 then
			local color, name = self:getColorByItemId(k, addnum)
			local colorvalue = GameStyle:getColor(color)

			colorvalue = colorvalue or GameStyle:getColor(1)

			local rr = string.format("%#x", colorvalue.r)
			local gg = string.format("%#x", colorvalue.g)
			local bb = string.format("%#x", colorvalue.b)
			local rgb = {
				rr,
				gg,
				bb
			}
			local rgbhex = ""

			for k, v in pairs(rgb) do
				rgbhex = rgbhex .. string.split(v, "x")[2]
			end

			rgbhex = "#" .. rgbhex

			local str = ""
			local templateStr = Strings:get("Map_Reward_Text", {
				fontName = TTF_FONT_FZYH_M,
				colorvalue = rgbhex,
				itemname = name,
				itemnum = addnum
			})

			str = str .. templateStr

			if show == true then
				count = count + 1
				self._tipsQueue[count] = str
			end
		end
	end

	local delay = 0.2

	self._showConut = 0
	self._schedulerID = LuaScheduler:getInstance():schedule(handler(self, self.showQueueTips), delay, false)
end

function BagSystem:showQueueTips()
	self._showConut = self._showConut + 1

	if self._showConut <= #self._tipsQueue then
		self:dispatch(ShowTipEvent({
			duration = 0.4,
			tip = self._tipsQueue[self._showConut]
		}))
	elseif self._schedulerID then
		LuaScheduler:getInstance():unschedule(self._schedulerID)

		self._schedulerID = nil
	end
end

function BagSystem:pushShowStack(show)
	table.insert(self._showStack, show)
end

function BagSystem:popShowStack()
	table.remove(self._showStack)
end

function BagSystem:getShowTips()
	local stackTopIndex = #self._showStack

	return self._showStack[stackTopIndex]
end

function BagSystem:updateView()
	if #self._viewVector == 0 then
		return
	end

	local obj = self._viewVector[#self._viewVector]

	if not obj or not checkDependInstance(obj) then
		table.remove(self._viewVector)

		return
	else
		local currencyId = obj._currencyId

		if not PowerConfigMap[currencyId] and currencyId ~= CurrencyIdKind.kCrusadeEnergy then
			table.remove(self._viewVector)

			return
		end

		if not self._powerResetMap[currencyId] then
			self:initPowerReset()
		end

		local view = obj:getView()
		local textNode = view:getChildByFullName("text_bg.text")
		local curPower, lastRecoverTime = 0, 0
		local actRecoverCd = 0
		local powerLimit = 0
		local text = ""
		local tipPanel = view:getChildByFullName("tips")
		local str1, str2

		if tipPanel then
			str1 = tipPanel:getChildByName("oneTimes")
			str2 = tipPanel:getChildByName("allTimes")
		end

		local recoverStr = ""

		if currencyId == CurrencyIdKind.kPower then
			local level = self._developSystem:getPlayer():getLevel()

			curPower, lastRecoverTime = self:getPower()
			powerLimit = self:getRecoveryPowerLimit(level)
			text = math.min(curPower, (self:getMaxPowerLimit())) .. "/" .. powerLimit

			textNode:setString(math.min(curPower, (self:getMaxPowerLimit())) .. "/" .. powerLimit)

			local resetSystem = self._powerResetMap[currencyId]

			if powerLimit <= curPower then
				str1:setString("00:00:00")
				str2:setString("00:00:00")
			else
				local curTime = self._gameServerAgent:remoteTimestamp()
				local a, b = math.modf((curTime - lastRecoverTime) / resetSystem.cd)
				local remainTime = (1 - b) * resetSystem.cd
				local remainTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", remainTime)

				str1:setString(remainTimeStr)

				local allDoneTime = (powerLimit - curPower - 1) * resetSystem.cd + remainTime
				local allDoneTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", allDoneTime)

				str2:setString(allDoneTimeStr)
			end

			local recoverText = tipPanel:getChildByName("recoverText")

			recoverText:setString(Strings:get("Power_RecPerMin", {
				num = resetSystem.cd / 60
			}))
		elseif PowerConfigMap[currencyId] then
			local resetSystem = self._powerResetMap[currencyId]

			curPower, lastRecoverTime = self:getPowerByCurrencyId(currencyId)
			powerLimit = resetSystem.limit
			actRecoverCd = resetSystem.cd
			recoverStr = PowerConfigMap[currencyId].perMin

			textNode:setString(curPower .. "/" .. resetSystem.limit)

			if powerLimit <= curPower then
				str1:setString("00:00:00")
				str2:setString("00:00:00")
			else
				local curTime = self._gameServerAgent:remoteTimestamp()
				local a, b = math.modf((curTime - lastRecoverTime) / actRecoverCd)
				local remainTime = (1 - b) * actRecoverCd
				local remainTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", remainTime)

				str1:setString(remainTimeStr)

				local allDoneTime = (powerLimit - curPower - 1) * actRecoverCd + remainTime
				local allDoneTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", allDoneTime)

				str2:setString(allDoneTimeStr)
			end

			local recoverText = tipPanel:getChildByName("recoverText")

			recoverText:setString(Strings:get(recoverStr, {
				num = actRecoverCd / 60
			}))
		elseif currencyId == CurrencyIdKind.kCrusadeEnergy then
			curPower, lastRecoverTime = self:getCrusadeEnergy()
			powerLimit = crusadeEnergyReset.storage
			actRecoverCd = crusadeEnergyReset.cd

			local powerNum = view:getChildByFullName("main.bg_bottom.namePanel.powerPanel.powerNum")

			if powerNum and obj.updataPower then
				obj:updataPower()
			end

			if str1 then
				if powerLimit <= curPower then
					str1:setString("00:00:00")
					str2:setString("00:00:00")
				else
					local curTime = self._gameServerAgent:remoteTimestamp()
					local a, b = math.modf((curTime - lastRecoverTime) / actRecoverCd)
					local remainTime = (1 - b) * actRecoverCd
					local remainTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", remainTime)

					str1:setString(remainTimeStr)

					local allDoneTime = (powerLimit - curPower - 1) * actRecoverCd + remainTime
					local allDoneTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", allDoneTime)

					str2:setString(allDoneTimeStr)
				end
			end
		end
	end
end

function BagSystem:bindSchedulerOnView(object)
	self._viewVector[#self._viewVector + 1] = object

	if self._sharedScheduler == nil then
		self._sharedScheduler = LuaScheduler:getInstance():schedule(handler(self, self.updateView), 1, true)
	end
end

function BagSystem:checkRedpointShow()
	return self:checkBagRedpointShowByType()
end

function BagSystem:checkBagRedpointShowByType(tiemType)
	return
end

function BagSystem:showNewHero(heroIds, index)
	if index > #heroIds then
		return
	end

	local heroId
	local isNew = false

	if heroIds[index][1].type == 3 then
		heroId = heroIds[index][1].code
		isNew = true
	else
		heroId = heroIds[index][1].heroId
		isNew = false
	end

	local dispatcher = DmGame:getInstance()
	local view = dispatcher._injector:getInstance("newHeroView")

	dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		heroId = heroId,
		newHero = isNew,
		callback = function()
			self:showNewHero(heroIds, index + 1)
		end
	}))
end

function BagSystem:SortFunc(itemA, itemB)
	local sortA = itemA:getSort()
	local sortB = itemB:getSort()
	local rankA = itemA:getTypeSort() or math.floor(sortA / 1000)
	local rankB = itemB:getTypeSort() or math.floor(sortB / 1000)

	if ItemTypes.K_EQUIP_NEW == itemA:getSubType() and ItemTypes.K_EQUIP_NEW == itemB:getSubType() then
		local qualityA = itemA:getQuality()
		local qualityB = itemB:getQuality()

		if qualityA ~= qualityB then
			return qualityB < qualityA
		end

		if sortA ~= sortB then
			return sortB < sortA
		end

		return itemA:getLevel() > itemB:getLevel()
	elseif ItemTypes.K_SOUL == itemA:getSubType() and ItemTypes.K_SOUL == itemB:getSubType() then
		local qualityA = itemA:getQuality()
		local qualityB = itemB:getQuality()
		local positionA = itemA:getPosition()
		local positionB = itemB:getPosition()

		if qualityA ~= qualityB then
			return qualityB < qualityA
		end

		if positionA ~= positionB then
			return positionB < positionA
		end

		return itemA:getLevel() > itemB:getLevel()
	else
		if rankA ~= rankB then
			return rankB < rankA
		end

		local qualityA = itemA:getQuality()
		local qualityB = itemB:getQuality()

		if qualityA ~= qualityB then
			return qualityB < qualityA
		end

		return sortB < sortA
	end
end

function BagSystem:isHasCompose()
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local data = customDataSystem:getValue(PrefixType.kGlobal, UserDefaultKey.kBag_Compose_Show, "0")
	local value = tonumber(data)

	if value > 0 then
		return true
	end

	local function filterFunc(entry)
		local item = entry.item

		return item:getSubType() == ComsumableKind.kCOMPOSE_URSelect
	end

	local entryIds = self:getBag():getEntryIds(filterFunc)

	if entryIds and #entryIds > 0 then
		customDataSystem:setValue(PrefixType.kGlobal, UserDefaultKey.kBag_Compose_Show, "100")
	end

	return entryIds and #entryIds > 0
end

function BagSystem:setComposeTimes(composeTimes)
	for key, value in pairs(composeTimes) do
		self._composeTimes[key] = value
	end
end

function BagSystem:setURCount(count)
	self._uRCount = count
end

function BagSystem:setUREquipState(info)
	if info.uRStatMap then
		for k, v in pairs(info.uRStatMap) do
			self._uREquipState.uRStatMap[k] = v
		end
	end

	if info.uRSuiteMap then
		for k, v in pairs(info.uRSuiteMap) do
			local t = {}

			for _, id in pairs(v) do
				table.insert(t, id)
			end

			self._uREquipState.uRSuiteMap[k] = t
		end
	end
end

function BagSystem:requestItemLock(param, callback, blockUI)
	local param_request = {
		itemId = param.itemId
	}
	local bagService = self:getInjector():getInstance(BagService)

	bagService:requestItemLock(param_request, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_ITEM_LOCK_SUCC, {
				viewtype = param.viewtype
			}))
		end
	end, blockUI)
end

function BagSystem:getAllComposeEntrys(composeStoneId, curComposeId)
	if self._composeToPos == nil then
		self._composeToPos = ConfigReader:getRecordById("ConfigValue", "URStone_Exchange").content
	end

	local composeIds = {}

	if self._composeToPos[composeStoneId] then
		local pos = self._composeToPos[composeStoneId]
		local dataTable = ConfigReader:getDataTable("Compose")

		for k, v in pairs(dataTable) do
			if pos == v.ComposePosition then
				local haveCount = self:getItemCount(k)

				if curComposeId and curComposeId == k then
					haveCount = haveCount - 1
				else
					local currentTime = self._composeTimes[k]

					if (currentTime and currentTime >= 1 or nil) and false then
						haveCount = haveCount - 1
					end
				end

				if haveCount > 0 then
					composeIds[#composeIds + 1] = k
				end
			end
		end
	end

	table.sort(composeIds, function(a, b)
		local sortA = self:getEntryById(a).item:getSort()
		local sortB = self:getEntryById(b).item:getSort()

		return sortA < sortB
	end)

	return composeIds
end

function BagSystem:getComposePos(composeItemId)
	if self._composeToPos == nil then
		self._composeToPos = ConfigReader:getRecordById("ConfigValue", "URStone_Exchange").content
	end

	return self._composeToPos[composeItemId]
end

UPMapStatus = {
	kNot_Collect_NOT_Over = 1,
	kFinish_YiLingQu = 2,
	KFinish_WeiLingQu = 0
}

function BagSystem:getURMapConfig(urMapId)
	return ConfigReader:getRecordById("UREuipmentMap", urMapId)
end

function BagSystem:getURMapStateById(urMapId)
	local state = UPMapStatus.kNot_Collect_NOT_Over
	local urMapState = self:getUREquipState()
	local config = self:getURMapConfig(urMapId)

	if urMapState.uRSuiteMap and urMapState.uRSuiteMap[urMapId] and next(urMapState.uRSuiteMap) and #config.EquipList == #urMapState.uRSuiteMap[urMapId] then
		if urMapState.uRStatMap[urMapId] and urMapState.uRStatMap[urMapId] == 1 then
			state = UPMapStatus.KFinish_WeiLingQu
		elseif urMapState.uRStatMap[urMapId] and urMapState.uRStatMap[urMapId] == 2 then
			state = UPMapStatus.kFinish_YiLingQu
		end
	end

	return state
end

function BagSystem:getHasURMapEquipId(urMapId, eqId)
	local urMapState = self:getUREquipState()

	if not urMapState or not urMapState.uRSuiteMap then
		return false
	end

	local gotEquips = urMapState.uRSuiteMap[urMapId]

	if gotEquips and next(gotEquips) and table.indexof(gotEquips, eqId) then
		return true
	end

	return false
end

function BagSystem:getURMapInfo()
	local info = {}
	local dataTable = ConfigReader:getDataTable("UREuipmentMap")

	for k, v in pairs(dataTable) do
		local tmp = {}

		tmp.config = v
		tmp.state = self:getURMapStateById(k)

		table.insert(info, tmp)
	end

	table.sort(info, function(a, b)
		if a.state ~= b.state then
			return a.state < b.state
		else
			return a.config.Sort < b.config.Sort
		end
	end)

	return info
end

function BagSystem:getURMapIdByItemId(itemId)
	local index = -1
	local info = self:getURMapInfo()

	for i, v in ipairs(info) do
		local data = v.config

		for i, v in ipairs(data.EquipList) do
			if itemId == v.scrollID then
				index = i
			end
		end
	end

	return index
end

function BagSystem:getProcessByURMapId(urMapId)
	local urMapState = self:getUREquipState()
	local ret1, ret2 = 0
	local configData = self:getURMapConfig(urMapId)

	return (urMapState.uRSuiteMap[urMapId] or nil) and #urMapState.uRSuiteMap[urMapId], #configData.EquipList
end

function BagSystem:getProcessOfURMap()
	local ret = 0
	local info = self:getURMapInfo()

	for k, v in pairs(info) do
		ret = ret + #v.config.EquipList
	end

	return ret
end

function BagSystem:getURSuiteRewards(urMapId, callback)
	local param = {
		UREquipmentMapId = urMapId
	}
	local bagService = self:getInjector():getInstance(BagService)

	bagService:getURSuiteRewards(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			local rewards = response.data

			if rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = rewards
				}))
			end

			self:dispatch(Event:new(EVT_URMAP_GetReward_SUCC, {}))
		end
	end, true)
end

function BagSystem:mainInfoURSuite(callback)
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local result, tip = systemKeeper:isUnlock("URMap_Unlock")

	if not result then
		if callback then
			callback()
		end

		return
	end

	local param = {}
	local bagService = self:getInjector():getInstance(BagService)

	bagService:mainInfoURSuite(param, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end, true)
end

function BagSystem:getURMapRedPoint()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local result, tip = systemKeeper:isUnlock("URMap_Unlock")

	if not result then
		return false
	end

	local taskSys = self._developSystem:getTaskSystem()
	local hasRedPoint = taskSys:hasUnreceivedTask(TaskType.kURMap)

	if hasRedPoint then
		return true
	end

	local urMapInfo = self:getURMapInfo()

	for k, v in pairs(urMapInfo) do
		if v.state == UPMapStatus.KFinish_WeiLingQu then
			return true
		end
	end

	return self:checkURMapCountKey()
end

function BagSystem:checkURMapCountKey()
	local dataTable = ConfigReader:getDataTable("UREuipmentMap")
	local playerId = self._developSystem:getPlayer():getRid()

	if not cc.UserDefault:getInstance():getIntegerForKey(playerId .. UserDefaultKey.KURMapCountKey) then
		local cur = ""

		return cur ~= table.nums(dataTable)
	end
end

function BagSystem:setURMapCountKeyValue()
	local dataTable = ConfigReader:getDataTable("UREuipmentMap")
	local playerId = self._developSystem:getPlayer():getRid()
	local cur = table.nums(dataTable)

	cc.UserDefault:getInstance():setIntegerForKey(playerId .. UserDefaultKey.KURMapCountKey, cur)
end

function BagSystem:checkCanUseCompose(item)
	local result = true
	local composeTimes = self:getComposeTimes()

	if item:getSubType() == ItemTypes.K_COMPOSE and composeTimes then
		local configData = ConfigReader:getRecordById("Compose", item:getId())

		if configData and configData.Times and configData.Times > 0 then
			local currentTime = composeTimes[item:getId()]

			if currentTime and currentTime >= configData.Times then
				result = false
			end
		end
	end

	return result
end

function BagSystem:getRepeatURItems()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local equipSystem = developSystem:getEquipSystem()
	local ids = {}
	local bagIds = self:getAllEntryIds()
	local kTabFilterMap = self:getTabFilterMap()
	local filterFunc = kTabFilterMap[BagItemShowType.kCompose]

	for _, entryId in ipairs(bagIds) do
		local entry = self:getEntryById(entryId)
		local isvislble = self:getItemIsVisible(entryId)

		if entry and isvislble and filterFunc(entry.item) then
			local configData = ConfigReader:getRecordById("Compose", entryId)

			if configData and configData.IfTrans and configData.IfTrans > 0 then
				if self:checkCanUseCompose(entry.item) then
					if entry.count > 1 then
						table.insert(ids, {
							isEatAll = true,
							itemId = entryId,
							allCount = entry.count - 1
						})
					end
				else
					table.insert(ids, {
						isEatAll = true,
						itemId = entryId,
						allCount = entry.count
					})
				end
			end
		end
	end

	return ids
end

function BagSystem:transferURScroll(params, callback)
	local param = {}

	param.items = params

	local bagService = self:getInjector():getInstance(BagService)

	bagService:transferURScroll(param, function(response)
		if response.resCode == GS_SUCCESS then
			local rewards = response.data.rewards

			if rewards then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = {
						rewards
					}
				}))
			end

			if callback then
				callback()
			end
		end
	end, true)
end

function BagSystem:getRedPointForShopExchange()
	return self:getURExchangeRedPoint()
end

function BagSystem:updataURExhangeRedPoint(data)
	local isRed = false
	local ret = false

	for k, v in pairs(data) do
		local itemConfig = self:getItemConfig(k)

		if itemConfig and itemConfig.Page == ItemPages.kCompose then
			local entry = self:getEntryById(k)

			ret = true

			if self:checkCanUseCompose(entry.item) then
				if entry.count > 1 then
					isRed = true

					break
				end
			else
				isRed = true

				break
			end
		end
	end

	if not ret then
		return
	end

	self:setURExchangeRedPoint(isRed)
end

function BagSystem:getURExchangeRedPoint()
	local playerId = self:getDevelopSystem():getPlayer():getRid()

	return cc.UserDefault:getInstance():getBoolForKey(playerId .. UserDefaultKey.KURExchangeRedPoint)
end

function BagSystem:setURExchangeRedPoint(status)
	local playerId = self:getDevelopSystem():getPlayer():getRid()

	cc.UserDefault:getInstance():setBoolForKey(playerId .. UserDefaultKey.KURExchangeRedPoint, status)
end

function BagSystem:isHasTSoulItem()
	local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	local data = customDataSystem:getValue(PrefixType.kGlobal, UserDefaultKey.kBag_TSoul_Show, "0")
	local value = tonumber(data)

	if value > 0 then
		return true
	end

	local function filterFunc(entry)
		local item = entry.item

		return item:getSubType() == ItemTypes.K_SOUL
	end

	local entryIds = self:getBag():getEntryIds(filterFunc)

	if entryIds and #entryIds > 0 then
		customDataSystem:setValue(PrefixType.kGlobal, UserDefaultKey.kBag_TSoul_Show, "100")
	end

	return entryIds and #entryIds > 0
end

function BagSystem:getEntryBySubType(subType)
	local function filterFunc(entry)
		local item = entry.item

		return item:getSubType() == subType
	end

	return (self:getBag():getEntryIds(filterFunc))
end
