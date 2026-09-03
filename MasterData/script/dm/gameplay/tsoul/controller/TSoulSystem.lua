-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/controller/TSoulSystem.lua

TSoulSystem = class("TSoulSystem", Facade, _M)

TSoulSystem:has("_tSoulService", {
	is = "r"
}):injectWith("TSoulService")

local SortExtend = {}

function TSoulSystem:initialize(developSystem)
	super.initialize(self)

	self._developSystem = developSystem
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._player = self._developSystem:getPlayer()
	self._tSoulList = self._player:getTSoulList()

	self:initExtendParam()

	self._sortExtand = {}
end

EVT_TSOUL_REFHRESH_SUCC = "EVT_TSOUL_REFHRESH_SUCC"
EVT_TSOUL_LOCK_SUCC = "EVT_TSOUL_LOCK_SUCC"
EVT_FORTSOULCOMPOUND_SUCC = "EVT_FORTSOULCOMPOUND_SUCC"
KTsoulAttrNum = 4
HeroTSoulType = {
	KThree = 3,
	KOne = 1,
	KTwo = 2
}
KTSoulAttrBgState = {
	KKong = 2,
	KLock = 3,
	KNormal = 1
}
KTSoulAttrBgName = {
	[KTSoulAttrBgState.KNormal] = "timesoul_img_sxd_1.png",
	[KTSoulAttrBgState.KKong] = "timesoul_img_sxd_2.png",
	[KTSoulAttrBgState.KLock] = "timesoul_img_sxd_3.png"
}
KTSoulRareityName = {
	"timesoul_img_shipodi_hui.png",
	"timesoul_img_shipodi_lv.png",
	"timesoul_img_shipodi_lan.png",
	"timesoul_img_shipodi_zi.png",
	"timesoul_img_shipodi_cheng.png",
	"timesoul_img_shipodi_hong.png"
}

local Tsoul_SuitLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_SuitLevel", "content")

function TSoulSystem:getTSoulById(id)
	return self._tSoulList:getTSoulById(id)
end

function TSoulSystem:getTSoulByIndex(heroId, index)
	local heroData = self._heroSystem:getHeroById(heroId)

	if not heroData then
		return nil
	end

	local tSoulId = heroData:getTSoulIdByPos(index)

	if not tSoulId then
		return nil
	end

	return self._tSoulList:getTSoulById(tSoulId)
end

function TSoulSystem:getTSoulListByPosition(param)
	local ret = {}

	if not param then
		return ret
	end

	local pos = param.pos
	local heroId = param.heroId
	local heroData = self._heroSystem:getHeroInfoById(heroId)
	local type = heroData.type
	local tSoulIds = self._tSoulList:getTSoulsByPosition(pos)

	for id, v in pairs(tSoulIds) do
		local tsoul = self._tSoulList:getTSoulById(id)
		local ocu = tsoul:getOccupation()
		local heroLimit = tsoul:getHeroLimit()

		if tsoul then
			local flag = not (ocu and next(ocu) and not table.indexof(ocu, type))

			if flag and heroLimit and next(heroLimit) and not table.indexof(heroLimit, heroId) then
				flag = false
			end

			if flag then
				table.insert(ret, tsoul)
			end
		end
	end

	return ret
end

function TSoulSystem:getDemountTSouls()
	local ret = {}
	local allList = self._tSoulList:getTSoulsList()

	for i, v in ipairs(allList) do
		if v:getHeroId() == "" then
			table.insert(ret, v)
		end
	end

	return ret
end

function TSoulSystem:getAllTSouls()
	return (self._tSoulList:getTSoulsList())
end

function TSoulSystem:getTSoulSortList()
	local ret = {}
	local tSoulIds = self._tSoulList:getTSoulMap()
	local unlockLevel = self:getCompoundUnlockLevel()

	for id, v in pairs(tSoulIds) do
		local tsoul = self._tSoulList:getTSoulById(id)
		local rarity = tsoul:getRarity()

		if tsoul and rarity <= tonumber(unlockLevel) then
			table.insert(ret, tsoul)
		end
	end

	table.sort(ret, function(a, b)
		if a:getRarity() == b:getRarity() then
			if a:getLevel() == b:getLevel() then
				return a:getConfig().Type < b:getConfig().Type
			else
				return a:getLevel() > b:getLevel()
			end
		else
			return a:getRarity() > b:getRarity()
		end
	end)

	return ret
end

function TSoulSystem:getAllAttrByHeroId(id)
	local ret = {}
	local heroData = self._heroSystem:getHeroById(id)

	if heroData then
		for i = 1, HeroTSoulType.KThree do
			local tSoulData = self:getTSoulByIndex(id, i)

			if tSoulData then
				for k, v in pairs(tSoulData:getBaseAttr()) do
					ret[k] = ret[k] or 0
					ret[k] = ret[k] + v
				end

				for k, v in pairs(tSoulData:getAddAttr()) do
					ret[k] = ret[k] or 0
					ret[k] = ret[k] + v
				end
			end
		end
	end

	return ret
end

function TSoulSystem:getSuitIdsByHeroId(id)
	local ret = {}
	local heroData = self._heroSystem:getHeroById(id)

	if heroData then
		for i = 1, HeroTSoulType.KThree do
			local tSoulData = self:getTSoulByIndex(id, i)

			if tSoulData then
				local suitId = tSoulData:getSuitId()

				if suitId then
					if not ret[suitId] then
						ret[suitId] = {}
						ret[suitId].pos = {}
					end

					table.insert(ret[suitId].pos, i)

					ret[suitId].index = i
					ret[suitId].suitId = suitId
					ret[suitId][tSoulData:getId()] = 1
				end
			end
		end
	end

	local data = {}

	for k, v in pairs(ret) do
		data[#data + 1] = v
	end

	table.sort(data, function(a, b)
		return a.index < b.index
	end)

	return data
end

function TSoulSystem:getIsMaxLevelBySuitId(suitId, tsoulIds, heroId)
	if table.nums(tsoulIds.pos) ~= HeroTSoulType.KThree then
		return false
	end

	local config = self:getConfigSuitBySuitId(suitId)
	local configSuitIds = config.Part
	local haveIds = {}

	for i = 1, 3 do
		local have = self:getTSoulByIndex(heroId, i)

		haveIds[have:getConfigId()] = have:getId()
	end

	if configSuitIds and next(configSuitIds) then
		for i, v in ipairs(configSuitIds) do
			local data = self:getTSoulById(haveIds[v])

			if haveIds[v] and data and data:getIsMaxLevel() then
				-- block empty
			else
				return false
			end
		end
	end

	return true
end

function TSoulSystem:getMaxLevelBySuitId(suitId, tsoulIds, heroId)
	if table.nums(tsoulIds.pos) ~= HeroTSoulType.KThree then
		return 0, Tsoul_SuitLevel["15"]
	end

	local config = self:getConfigSuitBySuitId(suitId)
	local configSuitIds = config.Part
	local haveIds = {}

	for i = 1, 3 do
		local have = self:getTSoulByIndex(heroId, i)

		haveIds[have:getConfigId()] = have:getId()
	end

	local maxLevel = {}

	for level, id in pairs(Tsoul_SuitLevel) do
		table.insert(maxLevel, level)
	end

	table.sort(maxLevel, function(a, b)
		return tonumber(a) > tonumber(b)
	end)

	if configSuitIds and next(configSuitIds) then
		for _, level in pairs(maxLevel) do
			local count = 0

			for i, v in ipairs(configSuitIds) do
				local data = self:getTSoulById(haveIds[v])

				if haveIds[v] and data and data:getLevel() >= tonumber(level) then
					count = count + 1

					if count == 3 then
						return tonumber(level), Tsoul_SuitLevel[level]
					end
				else
					break
				end
			end
		end
	end

	return 0, Tsoul_SuitLevel["15"]
end

function TSoulSystem:getConfigSuitBySuitId(id)
	return ConfigReader:getRecordById("TsoulSuit", id)
end

local Tsoul_EXPDown = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_EXPDown", "content")

function TSoulSystem:getExpBySuitId(tsoulData)
	local levelId = tsoulData:getLevelId()
	local data = ConfigReader:getRecordById("TsoulExp", levelId)
	local rareity = tsoulData:getRarity()
	local curExp = tsoulData:getExp()
	local rate = Tsoul_EXPDown[tostring(rareity)]

	return math.floor((data.TotalExp + curExp) * rate)
end

function TSoulSystem:getTsouItemsForIntensify(chooseId)
	local function filter(entry)
		return entry:getHeroId() == "" and entry:getId() ~= chooseId
	end

	local ret = {}
	local list = self._tSoulList:getTSoulsList()

	for id, entry in ipairs(list) do
		if filter(entry) then
			ret[#ret + 1] = {
				eatCount = 0,
				noShowNum = true,
				allCount = 1,
				id = entry:getId(),
				tsoulConfigId = entry:getConfigId(),
				exp = self:getExpBySuitId(entry),
				rariety = entry:getRarity(),
				level = entry:getLevel(),
				sort = entry:getSort()
			}
		end
	end

	return ret
end

local Tsoul_Expitem_Exp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_Expitem_Exp", "content")

function TSoulSystem:getCostItems()
	local items = {}

	for id, exp in pairs(Tsoul_Expitem_Exp) do
		local entry = self._bagSystem:getEntryById(id)

		if entry and entry.item and entry.count > 0 then
			local item = {
				eatCount = 0,
				itemId = id,
				exp = exp,
				allCount = entry.count,
				quality = entry.item:getQuality(),
				sort = entry.item:getSort()
			}

			table.insert(items, item)
		else
			local itemData = ConfigReader:requireRecordById("ItemConfig", id)
			local item = {
				eatCount = 0,
				allCount = 0,
				itemId = id,
				exp = exp,
				quality = itemData.Quality,
				sort = itemData.Sort
			}

			table.insert(items, item)
		end
	end

	table.sort(items, function(a, b)
		if a.quality == b.quality then
			return a.sort < b.sort
		end

		return a.quality < b.quality
	end)

	return items
end

function TSoulSystem:getMaxLevelCost(tsouId, nextlv)
	local tsoulData = self:getTSoulById(tsouId)
	local maxLv = nextlv or tsoulData:getMaxLevel()

	if maxLv == tsoulData:getMaxLevel() then
		maxLv = maxLv - 1
	end

	local curlv = tsoulData:getLevel()
	local curExp = tsoulData:getExp()
	local levelId = tsoulData:getLevelId()
	local totalExp = 0

	for i = curlv, maxLv do
		local data = ConfigReader:getRecordById("TsoulExp", levelId)

		totalExp = totalExp + data.Exp
		levelId = data.NextId
	end

	return totalExp - curExp
end

function TSoulSystem:getPreviewLevelAndExp(tsouId, items, tsoulItems)
	local tsoulData = self:getTSoulById(tsouId)
	local curlv = tsoulData:getLevel()
	local curExp = tsoulData:getExp()
	local maxLv = tsoulData:getMaxLevel()
	local totalExp = 0

	for i, v in ipairs(items) do
		totalExp = totalExp + v.exp * v.eatCount
	end

	for i, v in ipairs(tsoulItems) do
		totalExp = totalExp + v.exp * v.eatCount
	end

	local tmpTotal = totalExp

	while totalExp > 0 do
		local nextExp = self:getNextTsoulExp(tsouId, curlv)
		local need = nextExp - curExp

		if need <= totalExp then
			totalExp = totalExp - need
			curlv = curlv + 1
			curExp = 0

			if maxLv == curlv then
				break
			end
		else
			curExp = curExp + totalExp

			break
		end
	end

	return {
		curlv = curlv,
		curExp = curExp,
		addExp = tmpTotal
	}
end

function TSoulSystem:getNextTsoulExp(tsouId, curlv)
	local tsoulData = self:getTSoulById(tsouId)
	local levelId = tsoulData:getLevelId()
	local rareity = tsoulData:getRarity()
	local data = ConfigReader:getDataTable("TsoulExp")

	for k, v in pairs(data) do
		if v.ShowLevel == curlv and v.Rareity == rareity and v.NextId and v.NextId ~= "" then
			return v.Exp
		end
	end

	return 0
end

function TSoulSystem:getTSoulQuickSelect()
	local playerId = self._developSystem:getPlayer():getRid()
	local str = cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.KTSoulQuickSelect)

	if str and str ~= "" then
		return string.split(str, "_")
	end

	return {
		0,
		0,
		0,
		0,
		0
	}
end

function TSoulSystem:setTSoulQuickSelect(param)
	local str = table.concat(param, "_")
	local playerId = self._developSystem:getPlayer():getRid()

	cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.KTSoulQuickSelect, str)
end

local GemAddattr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "GemAddattr", "content")

function TSoulSystem:getNextIntensifyLv(lv)
	for i = 1, #GemAddattr do
		if lv < GemAddattr[i] then
			return GemAddattr[i]
		end
	end

	return GemAddattr[#GemAddattr]
end

function TSoulSystem:getQuickItems(tsoulId, curLv, items, tsoulItems)
	local data = self:getTSoulQuickSelect()
	local nextLv = self:getNextIntensifyLv(curLv)
	local nextNeed = self:getMaxLevelCost(tsoulId, nextLv)

	print("=========nextLv  nextNeed  " .. nextLv .. " " .. nextNeed)

	local totalExp = 0

	for i, itemData in ipairs(items) do
		itemData.eatCount = 0
	end

	for i, itemData in ipairs(tsoulItems) do
		itemData.eatCount = 0
	end

	if tonumber(data[1]) == 1 then
		for i, itemData in ipairs(items) do
			for j = 1, itemData.allCount do
				totalExp = totalExp + itemData.exp
				itemData.eatCount = itemData.eatCount + 1

				if nextNeed <= totalExp then
					break
				end
			end

			if nextNeed <= totalExp then
				break
			end
		end
	end

	if totalExp < nextNeed then
		for i, itemData in ipairs(tsoulItems) do
			local tdata = self:getTSoulById(itemData.id)

			if tonumber(data[itemData.rariety]) == 1 and not tdata:getLock() then
				totalExp = totalExp + itemData.exp
				itemData.eatCount = itemData.eatCount + 1

				if nextNeed <= totalExp then
					break
				end
			end
		end
	end

	return items, tsoulItems, totalExp
end

function TSoulSystem:setBeforeIntensifyInfo(id)
	self._tempTSoulData = {}

	local tsoudata = self:getTSoulById(id)
	local base = tsoudata:getBaseAttr()
	local addAttr = tsoudata:getAddAttr()

	self._tempTSoulData.lv = tsoudata:getLevel()
	self._tempTSoulData.baseAttr = table.copy(base, {})
	self._tempTSoulData.addAttr = table.copy(addAttr, {})
end

function TSoulSystem:getBeforeIntensifyInfo()
	return self._tempTSoulData
end

function TSoulSystem:getSuitConfig()
	local ret = {}
	local data = ConfigReader:getDataTable("TsoulSuit")

	for k, v in pairs(data) do
		ret[#ret + 1] = v
	end

	table.sort(ret, function(a, b)
		if a.SuitRareity == b.SuitRareity then
			return a.Sort < b.Sort
		else
			return a.SuitRareity > b.SuitRareity
		end
	end)

	return ret
end

TSoulShowSort = {
	SortByRaretyDown = 2,
	SortByLevelUp = 3,
	SortByRaretyUp = 1,
	SortByLevelDown = 4
}

local tSoulShowSortFun = {
	[TSoulShowSort.SortByRaretyUp] = function(a, b)
		if a:getRarity() == b:getRarity() then
			if a:getLevel() == b:getLevel() then
				return a:getSort() < b:getSort()
			else
				return a:getLevel() > b:getLevel()
			end
		else
			return a:getRarity() > b:getRarity()
		end
	end,
	[TSoulShowSort.SortByRaretyDown] = function(a, b)
		if a:getRarity() == b:getRarity() then
			if a:getLevel() == b:getLevel() then
				return a:getSort() < b:getSort()
			else
				return a:getLevel() < b:getLevel()
			end
		else
			return a:getRarity() < b:getRarity()
		end
	end,
	[TSoulShowSort.SortByLevelUp] = function(a, b)
		if a:getLevel() == b:getLevel() then
			if a:getRarity() == b:getRarity() then
				return a:getSort() < b:getSort()
			else
				return a:getRarity() > b:getRarity()
			end
		else
			return a:getLevel() > b:getLevel()
		end
	end,
	[TSoulShowSort.SortByLevelDown] = function(a, b)
		if a:getLevel() == b:getLevel() then
			if a:getRarity() == b:getRarity() then
				return a:getSort() < b:getSort()
			else
				return a:getRarity() < b:getRarity()
			end
		else
			return a:getLevel() < b:getLevel()
		end
	end
}
local tSoulShowIntensifySortFun = {
	[TSoulShowSort.SortByRaretyUp] = function(a, b)
		if a.rariety == b.rariety then
			if a.level == b.level then
				if a.sort == b.sort then
					return a.id < b.id
				else
					return a.sort < b.sort
				end
			else
				return a.level > b.level
			end
		else
			return a.rariety > b.rariety
		end
	end,
	[TSoulShowSort.SortByRaretyDown] = function(a, b)
		if a.rariety == b.rariety then
			if a.level == b.level then
				if a.sort == b.sort then
					return a.id < b.id
				else
					return a.sort < b.sort
				end
			else
				return a.level < b.level
			end
		else
			return a.rariety < b.rariety
		end
	end,
	[TSoulShowSort.SortByLevelUp] = function(a, b)
		if a.level == b.level then
			if a.rariety == b.rariety then
				if a.sort == b.sort then
					return a.id < b.id
				else
					return a.sort < b.sort
				end
			else
				return a.rariety > b.rariety
			end
		else
			return a.level > b.level
		end
	end,
	[TSoulShowSort.SortByLevelDown] = function(a, b)
		if a.level == b.level then
			if a.rariety == b.rariety then
				if a.sort == b.sort then
					return a.id < b.id
				else
					return a.sort < b.sort
				end
			else
				return a.rariety < b.rariety
			end
		else
			return a.level < b.level
		end
	end
}

function TSoulSystem:sortTSoulList(list, type, recommendIds)
	if type then
		if not tSoulShowSortFun[type] then
			local func = tSoulShowSortFun[1]

			table.sort(list, function(a, b)
				if recommendIds and next(recommendIds) then
					if self:checkListContain(recommendIds, a:getId()) and not self:checkListContain(recommendIds, b:getId()) then
						return true
					elseif not self:checkListContain(recommendIds, a:getId()) and self:checkListContain(recommendIds, b:getId()) then
						return false
					end
				end

				return func(a, b)
			end)
		end
	end
end

function TSoulSystem:sortTSoulIntensifyList(list, type)
	if type then
		if not tSoulShowIntensifySortFun[type] then
			local func = tSoulShowIntensifySortFun[1]

			table.sort(list, function(a, b)
				return func(a, b)
			end)
		end
	end
end

function TSoulSystem:checkListContain(ids, id)
	for i = 1, #ids do
		if id == ids[i] then
			return true
		end
	end

	return false
end

local Tsoul_Open = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_Open", "content")

function TSoulSystem:getRedPointForLevel(heroId, posIndex)
	posIndex = posIndex or HeroTSoulType.KThree

	local heroData = self._heroSystem:getHeroById(heroId)

	if not heroData then
		return false
	end

	local quality = heroData:getQuality()

	for i = 1, posIndex do
		local tSoulData = self:getTSoulByIndex(heroId, i)

		if not tSoulData and quality >= Tsoul_Open[i] then
			local param = {}

			param.pos = i
			param.heroId = heroId

			local listData = self:getTSoulListByPosition(param)

			for i, v in ipairs(listData) do
				if v:getHeroId() == "" then
					return true
				end
			end
		end
	end

	return false
end

function TSoulSystem:getRedPointForRarity(heroId, posIndex)
	local ret = {
		false,
		false,
		false
	}

	posIndex = posIndex or HeroTSoulType.KThree

	local heroData = self._heroSystem:getHeroById(heroId)

	if not heroData then
		return ret
	end

	local function checkRed(pos, noRatiry)
		local param = {}

		param.pos = pos
		param.heroId = heroId

		local tSoulData = self:getTSoulByIndex(heroId, pos)

		if tSoulData then
			local rarity = tSoulData:getRarity()
			local level = tSoulData:getLevel()
			local suitId = tSoulData:getSuitId()
			local listData = self:getTSoulListByPosition(param)

			for k, v in pairs(listData) do
				if noRatiry then
					if v:getHeroId() == "" and v:getRarity() == rarity and v:getSuitId() == suitId and level < v:getLevel() then
						return true
					end
				elseif v:getHeroId() == "" and (rarity < v:getRarity() or v:getRarity() == rarity and v:getSuitId() == suitId and level < v:getLevel()) then
					return true
				end
			end
		end

		return false
	end

	local suitIds = self:getSuitIdsByHeroId(heroId)

	for i, v in ipairs(suitIds) do
		if #v.pos >= 2 then
			for _, pos in ipairs(v.pos) do
				if checkRed(pos, true) then
					ret[pos] = true
				end
			end
		else
			local pos = v.pos[1]

			if checkRed(pos) then
				ret[pos] = true
			end
		end
	end

	return ret
end

function TSoulSystem:enterTSoulInfoView(info)
	require("dm.gameplay.tsoul.view.HeroTSoulInfoView")

	return HeroTSoulInfoView:new(info)
end

function TSoulSystem:requestTSoulMounting(params, callback, blockUI)
	self._tSoulService:requestTSoulMounting(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_TSOUL_REFHRESH_SUCC, {
				pos = params.pos
			}))
			self:dispatch(ShowTipEvent({
				tip = Strings:get("TimeSoul_Main_SuitUI_01")
			}))

			if callback then
				callback()
			end
		end
	end)
end

function TSoulSystem:requestTSoulDemount(params, blockUI, callback)
	self._tSoulService:requestTSoulDemount(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_TSOUL_REFHRESH_SUCC))
			self:dispatch(ShowTipEvent({
				tip = Strings:get("TimeSoul_Main_SuitUI_02")
			}))

			if callback then
				callback()
			end
		end
	end)
end

function TSoulSystem:requestTSoulReplace(params, blockUI, callback)
	self._tSoulService:tsoulReplace(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			self:dispatch(Event:new(EVT_TSOUL_REFHRESH_SUCC, {
				pos = params.pos
			}))
			self:dispatch(ShowTipEvent({
				tip = Strings:get("TimeSoul_Main_SuitUI_03")
			}))

			if callback then
				callback()
			end
		end
	end)
end

function TSoulSystem:requestTSoulIntensify(params, blockUI, callback)
	self:setBeforeIntensifyInfo(params.tsoulIntensifyId)
	self._tSoulService:tsoulIntensify(params, true, function(response)
		if response.resCode == GS_SUCCESS and callback then
			callback()
		end
	end)
end

function TSoulSystem:requestTSoulLock(params, blockUI, callback)
	self._tSoulService:tsoulLock(params, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_TSOUL_LOCK_SUCC, {
				id = params.tsoulId
			}))
		end
	end)
end

function TSoulSystem:getStoneNameByIdAndType(id, type)
	local stoneCfg = ConfigReader:getRecordById("Tsoul", id)
	local comCfg = ConfigReader:getRecordById("Tsoul", (type or nil) and stoneCfg.SuccessReward)

	return Strings:get(comCfg.Name) or ""
end

function TSoulSystem:getCompoundCostCfgByLevel(level)
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "FortuneWheel_SynthesisCost", "content")

	return config[tonumber(level)]
end

function TSoulSystem:getCompoundRateBYStoneCount(cnt)
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "FortuneWheel_SynthesisRate", "content")

	return config[tostring(cnt)] or 0
end

function TSoulSystem:getCompoundRate(cnt)
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "FortuneWheel_SynthesisRate_W", "content")

	return config[tostring(cnt)] or 0
end

function TSoulSystem:getCompoundMinimum()
	local Minimum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "FortuneWheel_SynthesisMinimum", "content")

	return tonumber(Minimum)
end

function TSoulSystem:getCompoundUnlockLevel()
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "FortuneWheel_LevelUnlock", "content")
	local data = {}

	for key, value in pairs(config) do
		table.insert(data, {
			unlockLevel = key,
			playerLevel = value
		})
	end

	table.sort(data, function(a, b)
		return a.playerLevel < b.playerLevel
	end)

	local unlockLevel = 0

	for i = #data, 1, -1 do
		if self._player:getLevel() >= tonumber(data[i].playerLevel) then
			unlockLevel = data[i].unlockLevel

			break
		end
	end

	return unlockLevel
end

function TSoulSystem:getCompoundMaxLevel()
	local config = ConfigReader:getDataByNameIdAndKey("ConfigValue", "FortuneWheel_LevelUnlock", "content")
	local data = {}
	local maxLevel = 0

	for key, value in pairs(config) do
		table.insert(data, {
			unlockLevel = key,
			playerLevel = value
		})

		if maxLevel < tonumber(key) then
			maxLevel = tonumber(key)
		end
	end

	return maxLevel
end

function TSoulSystem:stoneCompound(mainStone, deputyStones, blockUI, callback)
	local info = {
		mainId = mainStone,
		costIds = deputyStones
	}

	self._tSoulService:stoneCompound(info, true, function(response)
		if response.resCode == GS_SUCCESS then
			if callBack then
				callBack(response)
			end

			self:dispatch(Event:new(EVT_FORTSOULCOMPOUND_SUCC, response))
		end
	end)
end

local TargetOccupation = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_TypeOrder", "content")
local TargetOccupation2 = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tsoul_TypeOrder2", "content")
local TSoulType = {
	1,
	2,
	3
}
local SortExtendFunc = {
	{
		func = function(sortExtendType, stone)
			return stone:getConfig().Type == TSoulType[sortExtendType]
		end
	},
	{
		func = function(sortExtendType, stone)
			return stone:getRarity() == sortExtendType
		end
	}
}

function TSoulSystem:setSortExtand(sortType, sortExtendType)
	if sortType == 0 then
		for i, v in ipairs(SortExtend) do
			self._sortExtand[i] = {}
		end

		return
	end

	self._sortExtand[sortType] = self._sortExtand[sortType] or {}

	if self:isSortExtendTypeExist(sortType, sortExtendType) then
		for i = 1, #self._sortExtand[sortType] do
			local v = self._sortExtand[sortType][i]

			if v == sortExtendType then
				break
			end
		end
	else
		self._sortExtand[sortType][#self._sortExtand[sortType] + 1] = sortExtendType
	end
end

function TSoulSystem:resetSortExtand()
	for i, v in ipairs(SortExtend) do
		self._sortExtand[i] = {}
	end
end

function TSoulSystem:isSortExtendTypeExist(sortType, sortExtendType)
	for i = 1, #self._sortExtand[sortType] do
		local v = self._sortExtand[sortType][i]

		if v == sortExtendType then
			return true
		end
	end

	return false
end

function TSoulSystem:getSortExtendIds(ids)
	local list = {}

	for k = 1, #ids do
		if self:checkHasExtend() then
			if self:chooseHero(ids[k]) then
				list[#list + 1] = ids[k]
			end
		else
			list[#list + 1] = ids[k]
		end
	end

	table.sort(list, function(a, b)
		if a:getRarity() == b:getRarity() then
			if a:getLevel() == b:getLevel() then
				return a:getConfig().Type < b:getConfig().Type
			else
				return a:getLevel() > b:getLevel()
			end
		else
			return a:getRarity() < b:getRarity()
		end
	end)

	return list
end

function TSoulSystem:checkHasExtend()
	for i, v in ipairs(self._sortExtand) do
		if v and #v > 0 then
			return true
		end
	end

	return false
end

function TSoulSystem:chooseHero(heroId)
	local checkMark = 0

	for sortType, sortExtend in ipairs(self._sortExtand) do
		if sortExtend and #sortExtend > 0 then
			for i = 1, #sortExtend do
				if SortExtendFunc[sortType] and SortExtendFunc[sortType].func(sortExtend[i], heroId) then
					checkMark = checkMark + 1

					break
				end
			end
		elseif sortExtend and #sortExtend == 0 then
			checkMark = checkMark + 1
		end
	end

	if checkMark == #self._sortExtand then
		return true
	end

	return false
end

function TSoulSystem:getSortExtendNum()
	return #SortExtend
end

function TSoulSystem:getSortExtandParam(sortType)
	return SortExtend[sortType]
end

function TSoulSystem:getSortExtendMaxNum()
	local num = 0

	for i, v in ipairs(SortExtend) do
		num = math.max(num, #v)
	end

	return num
end

function TSoulSystem:initExtendParam()
	SortExtend = SortExtend or {}
	SortExtend[1] = {}

	for i = 1, #TargetOccupation2 do
		SortExtend[1][i] = Strings:get(TargetOccupation2[i])
	end

	SortExtend[2] = {}

	for i = 1, #TargetOccupation do
		SortExtend[2][i] = Strings:get(TargetOccupation[i])
	end
end
