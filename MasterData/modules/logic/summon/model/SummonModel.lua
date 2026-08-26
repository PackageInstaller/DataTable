-- chunkname: @modules/logic/summon/model/SummonModel.lua

module("modules.logic.summon.model.SummonModel", package.seeall)

local SummonModel = class("SummonModel", BaseModel)

function SummonModel:onInit()
	self._summonResult = nil
	self._orderedSummonResult = nil
	self._duplicateCountList = nil
	self._freeEquipSummon = nil
	self._isEquipSendFree = nil
	self._summonPoolPackageRedDotDic = nil
	self._summonPoolPackageRedDotList = nil

	self:setIsDrawing(false)
end

function SummonModel:reInit()
	self._summonResult = nil
	self._orderedSummonResult = nil
	self._duplicateCountList = nil
	self._freeEquipSummon = nil
	self._isEquipSendFree = nil
	self._summonPoolPackageRedDotDic = nil
	self._summonPoolPackageRedDotList = nil

	self:setIsDrawing(false)
end

function SummonModel:updateSummonResult(summonResult, poolId)
	self._summonResult = {}
	self._orderedSummonResult = {}
	self._duplicateCountList = {}

	if summonResult and #summonResult > 0 then
		for i, result in ipairs(summonResult) do
			local summonResultMO = SummonResultMO.New()

			summonResultMO:init(result)

			if result.heroId and result.heroId ~= 0 then
				self._duplicateCountList[result.heroId] = self._duplicateCountList[result.heroId] or {}

				table.insert(self._duplicateCountList[result.heroId], result.duplicateCount or 0)
			end

			table.insert(self._summonResult, summonResultMO)
		end

		local order = {
			1,
			10,
			2,
			9,
			3,
			8,
			4,
			7,
			5,
			6
		}
		local tempSummonResult = {}

		for i = 1, #self._summonResult do
			table.insert(tempSummonResult, self._summonResult[i])
		end

		SummonModel.sortResult(tempSummonResult, poolId)

		self._orderedSummonResult = {}

		for i = 1, #tempSummonResult do
			self._orderedSummonResult[order[i]] = tempSummonResult[i]
		end
	end
end

function SummonModel.sortResult(list, poolId)
	if SummonConfig.poolIsLuckyBag(poolId) then
		table.sort(list, SummonModel.sortResultLuckyBag)
	else
		table.sort(list, SummonModel.sortResultByRare)
	end
end

function SummonModel.sortResultByRare(x, y)
	if x.heroId ~= 0 and y.heroId ~= 0 then
		local xCO = HeroConfig.instance:getHeroCO(x.heroId)
		local yCO = HeroConfig.instance:getHeroCO(y.heroId)

		if xCO.rare ~= yCO.rare then
			return xCO.rare > yCO.rare
		else
			return xCO.id > yCO.id
		end
	else
		local xCO = EquipConfig.instance:getEquipCo(x.equipId)
		local yCO = EquipConfig.instance:getEquipCo(y.equipId)

		if xCO.rare ~= yCO.rare then
			return xCO.rare > yCO.rare
		else
			return xCO.id > yCO.id
		end
	end
end

function SummonModel.sortHeroIsResultByRare(x, y)
	if x ~= 0 and y ~= 0 then
		local xCO = HeroConfig.instance:getHeroCO(x)
		local yCO = HeroConfig.instance:getHeroCO(y)

		if xCO.rare ~= yCO.rare then
			return xCO.rare > yCO.rare
		else
			return xCO.id > yCO.id
		end
	else
		local xCO = EquipConfig.instance:getEquipCo(x)
		local yCO = EquipConfig.instance:getEquipCo(y)

		if xCO.rare ~= yCO.rare then
			return xCO.rare > yCO.rare
		else
			return xCO.id > yCO.id
		end
	end
end

function SummonModel.sortResultByHeroIds(heroIds)
	local order = {
		1,
		10,
		2,
		9,
		3,
		8,
		4,
		7,
		5,
		6
	}
	local tempSummonResult = {}

	for i = 1, #heroIds do
		table.insert(tempSummonResult, heroIds[i])
	end

	table.sort(heroIds, SummonModel.sortHeroIsResultByRare)

	heroIds = {}

	for i = 1, #tempSummonResult do
		heroIds[order[i]] = tempSummonResult[i]
	end
end

function SummonModel.sortResultLuckyBag(a, b)
	local aIsLuckyBag = a:isLuckyBag()
	local bIsLuckyBag = b:isLuckyBag()

	if aIsLuckyBag ~= bIsLuckyBag then
		return aIsLuckyBag
	elseif aIsLuckyBag then
		return a.luckyBagId < b.luckyBagId
	else
		return SummonModel.sortResultByRare(a, b)
	end
end

function SummonModel:getSummonResult(sort)
	if sort then
		return self._orderedSummonResult
	else
		return self._summonResult
	end
end

function SummonModel:openSummonResult(index)
	local orderedSummonResult = self:getSummonResult(true)

	if orderedSummonResult and orderedSummonResult[index] and not orderedSummonResult[index]:isOpened() then
		local summonResultMO = orderedSummonResult[index]

		summonResultMO:setOpen()

		local duplicateCount = -1
		local minIndex = 0

		if not summonResultMO:isLuckyBag() then
			if not self._duplicateCountList[summonResultMO.heroId] then
				for i = 1, #self._duplicateCountList[summonResultMO.heroId] do
					if duplicateCount > self._duplicateCountList[summonResultMO.heroId][i] or duplicateCount < 0 then
						duplicateCount = self._duplicateCountList[summonResultMO.heroId][i]
						minIndex = i
					end
				end

				if minIndex > 0 then
					table.remove(self._duplicateCountList[summonResultMO.heroId], minIndex)
				end
			end
		end

		return summonResultMO, duplicateCount
	end
end

function SummonModel:openSummonEquipResult(index)
	local orderedSummonResult = self:getSummonResult(true)

	if orderedSummonResult and orderedSummonResult[index] and not orderedSummonResult[index]:isOpened() then
		local summonResultMO = orderedSummonResult[index]

		summonResultMO:setOpen()

		return summonResultMO, summonResultMO.isNew
	end
end

function SummonModel:isAllOpened()
	if not self._summonResult or #self._summonResult <= 0 then
		return true
	end

	for i, summonResultMO in ipairs(self._summonResult) do
		if not summonResultMO:isOpened() then
			return false
		end
	end

	return true
end

function SummonModel:setFreeEquipSummon(val)
	self._freeEquipSummon = val
end

function SummonModel:getFreeEquipSummon()
	return self._freeEquipSummon
end

function SummonModel:setSendEquipFreeSummon(val)
	self._isEquipSendFree = val
end

function SummonModel:getSendEquipFreeSummon()
	return self._isEquipSendFree
end

function SummonModel.getBestRare(summonResult)
	local bestRare = 2

	if not summonResult then
		return bestRare
	end

	for i, result in pairs(summonResult) do
		local rare = 2

		if result.heroId and result.heroId ~= 0 then
			local heroConfig = HeroConfig.instance:getHeroCO(result.heroId)

			rare = heroConfig.rare
		elseif result.equipId and result.equipId ~= 0 then
			local equipCo = EquipConfig.instance:getEquipCo(result.equipId)

			rare = equipCo.rare
		elseif result.luckyBagId and result.luckyBagId ~= 0 then
			rare = SummonEnum.LuckyBagRare
		end

		bestRare = math.max(bestRare, rare)
	end

	return bestRare
end

function SummonModel.getRewardList(summonResultList, showNewHero)
	local rewards = {}
	local rewardTypeDict = {}

	for i = 1, #summonResultList do
		local summonReward = summonResultList[i]
		local rewardItems = summonReward.heroId ~= 0 and SummonConfig.instance:getRewardItems(summonReward.heroId, summonReward.duplicateCount, showNewHero) or SummonModel.getEquipRewardItem(summonReward)

		for j = 1, #rewardItems do
			local rewardItem = rewardItems[j]

			rewardTypeDict[rewardItem.type] = rewardTypeDict[rewardItem.type] or {}
			rewardTypeDict[rewardItem.type][rewardItem.id] = (rewardTypeDict[rewardItem.type][rewardItem.id] or 0) + rewardItem.quantity
		end
	end

	for type, rewardIdDict in pairs(rewardTypeDict) do
		for id, quantity in pairs(rewardIdDict) do
			local mo = MaterialDataMO.New()

			mo:initValue(type, id, quantity)

			mo.config = ItemModel.instance:getItemConfig(type, id)

			table.insert(rewards, mo)
		end
	end

	return rewards
end

function SummonModel.appendRewardTicket(summonResultList, rewards, ticketId, ticketCount)
	local len = #summonResultList

	if len > 0 then
		local mo = MaterialDataMO.New()

		mo:initValue(MaterialEnum.MaterialType.Item, ticketId, ticketCount * len)

		mo.config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, ticketId)

		table.insert(rewards, mo)
	end
end

function SummonModel.getEquipRewardItem(summonReward)
	local rewardItems = {}

	if summonReward.returnMaterials then
		for _, matMO in ipairs(summonReward.returnMaterials) do
			table.insert(rewardItems, {
				type = matMO.materilType,
				id = matMO.materilId,
				quantity = matMO.quantity
			})
		end
	end

	return rewardItems
end

function SummonModel.sortRewards(x, y)
	local result

	if x.config.rare == y.config.rare then
		return nil
	else
		result = x.config.rare > y.config.rare
	end

	if result ~= nil then
		return result
	end

	result = (x.materilType ~= y.materilType or nil) and x.materilType > y.materilType

	if result ~= nil then
		return result
	end

	result = (x.materilId ~= y.materilId or nil) and x.materilId > y.materilId

	return result
end

function SummonModel.formatRemainTime(sec)
	if sec <= 0 then
		return string.format(luaLang("summonmain_deadline_time_min"), 0, 0)
	end

	sec = math.floor(sec)

	local day = math.floor(sec / 86400)
	local hour = math.floor(sec % 86400 / 3600)
	local min = math.floor(sec % 3600 / 60)

	if day > 0 then
		local tag = {
			day,
			hour,
			min
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time_day"), tag)
	elseif hour < 1 and min < 1 then
		return luaLang("summonmain_deadline_time_min")
	else
		local tag = {
			hour,
			min
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), tag)
	end
end

function SummonModel:setIsDrawing(isDrawing)
	self._isDrawing = isDrawing
end

function SummonModel:getIsDrawing()
	return self._isDrawing
end

function SummonModel:getSummonFullExSkillHero(poolId, heroIds)
	local poolCo = SummonConfig.instance:getSummonPool(poolId)
	local _checkHeroIds = {}

	if poolCo and not string.nilorempty(poolCo.upWeight) then
		local heroIds = string.split(poolCo.upWeight, "|")

		table.insert(_checkHeroIds, tonumber(heroIds[1]))
	end

	if heroIds ~= nil and #heroIds > 0 then
		_checkHeroIds = heroIds
	end

	for i = 1, #_checkHeroIds do
		local checkHeroId = _checkHeroIds[i]
		local level = 0
		local mo = HeroModel.instance:getByHeroId(checkHeroId)

		if mo then
			level = mo.exSkillLevel

			if mo.exSkillLevel >= 5 then
				return checkHeroId
			end
		end

		local exCo = SkillConfig.instance:getheroexskillco(checkHeroId)

		if exCo then
			local needCount = 0
			local needItemId, needItemType

			for j = 1, #exCo do
				if level < j then
					local co = exCo[j]

					if co then
						local itemco = string.splitToNumber(co.consume, "#")

						needItemType = itemco[1]
						needItemId = itemco[2]
						needCount = itemco[3] + needCount
					end
				end
			end

			if needItemId and needItemType then
				local haveCount = ItemModel.instance:getItemQuantity(needItemType, needItemId)

				if needCount <= haveCount then
					return checkHeroId
				end
			end
		end
	end

	return nil
end

function SummonModel:cacheReward(rewardList)
	if self._cacheReward == nil then
		self._cacheReward = {}
	end

	if self.cacheRewardCount == nil then
		self.cacheRewardCount = 0
	end

	if rewardList ~= nil then
		tabletool.addValues(self._cacheReward, rewardList)

		self.cacheRewardCount = self.cacheRewardCount + 1
	end
end

function SummonModel:getCacheReward()
	return self._cacheReward, self.cacheRewardCount
end

function SummonModel:clearCacheReward()
	if self._cacheReward then
		tabletool.clear(self._cacheReward)

		self.cacheRewardCount = nil
	end
end

function SummonModel:getSummonPoolUpList(poolId)
	local poolConfig = SummonConfig.instance:getSummonPool(poolId)

	if poolConfig.type == SummonEnum.Type.CustomPick or poolConfig.type == SummonEnum.Type.StrongCustomOnePick then
		local heroList = SummonPoolDetailCategoryListModel.buildCustomPickDict(poolId)

		return {
			[CharacterEnum.MaxRare] = heroList
		}
	else
		return SummonPoolDetailCategoryListModel.buildProbUpDict(poolId)
	end
end

function SummonModel:getSummonPoolPackageRedDotKey()
	return "SummonSummonPoolPackageRedDot_" .. tostring(PlayerModel.instance:getMyUserId())
end

function SummonModel:isSummonPoolPackageRedDotShow(poolId)
	if not self._summonPoolPackageRedDotDic then
		self._summonPoolPackageRedDotDic = {}

		local key = self:getSummonPoolPackageRedDotKey()
		local dataStr = PlayerPrefsHelper.getString(key, "")
		local list = string.splitToNumber(dataStr, "#")

		self._summonPoolPackageRedDotList = list

		for _, id in ipairs(list) do
			self._summonPoolPackageRedDotDic[id] = true
		end
	end

	return self._summonPoolPackageRedDotDic[poolId] == true
end

function SummonModel:setSummonPoolPackageRedDotShow(curPoolId, callback, callbackObj)
	local key = self:getSummonPoolPackageRedDotKey()
	local allPools = SummonMainModel.getValidPools()
	local isChange = false

	if allPools and next(allPools) then
		for _, pool in ipairs(allPools) do
			local poolId = pool.id
			local poolPackageConfigList = SummonConfig.instance:getSummonPoolPackageConfigList(poolId)

			if poolPackageConfigList and next(poolPackageConfigList) then
				for _, poolPackageConfig in ipairs(poolPackageConfigList) do
					if poolPackageConfig.packageRecommendSwitch == true and not self:isSummonPoolPackageRedDotShow(poolId) then
						isChange = true

						logNormal("添加卡池礼包红点记录 id" .. tostring(poolId))
						table.insert(self._summonPoolPackageRedDotList, poolId)

						self._summonPoolPackageRedDotDic[poolId] = true

						break
					end
				end
			end
		end
	end

	if isChange then
		local dataStr = table.concat(self._summonPoolPackageRedDotList, "#")

		PlayerPrefsHelper.setString(key, dataStr)
		SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolPackageRedDotChange, curPoolId)
	end

	if callback then
		callback(callbackObj)
	end
end

function SummonModel:clearSummonPoolPackageRedDot()
	local key = "SummonSummonPoolPackageRedDot_" .. tostring(PlayerModel.instance:getMyUserId())

	PlayerPrefsHelper.setString(key, "")

	self._summonPoolPackageRedDotDic = nil
	self._summonPoolPackageRedDotList = nil

	logError("清除卡池礼包红点记录")
end

SummonModel.instance = SummonModel.New()

return SummonModel
