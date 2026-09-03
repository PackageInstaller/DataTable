-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/controller/EquipSystem.lua

EquipSystem = class("EquipSystem", Facade, _M)

EquipSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
EquipSystem:has("_strengthenConsumeItems", {
	is = "rw"
})
EquipSystem:has("_starConsumeItem", {
	is = "rw"
})
EquipSystem:has("_equipStarUpItem", {
	is = "rw"
})
EquipSystem:has("_selectData", {
	is = "rw"
})
EquipSystem:has("_oneKeyEquips", {
	is = "rw"
})

local HeroEquipBaseExp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipBaseExp", "content")
local HeroEquipExpItem = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExpItem", "content")

function EquipSystem:initialize(developSystem)
	super.initialize(self)

	self._developSystem = developSystem
	self._heroSystem = self._developSystem:getHeroSystem()
	self._bagSystem = self._developSystem:getBagSystem()
	self._equipModule = self._developSystem:getPlayer():getEquipList()
	self._oneKeyEquips = {}
	self._composeUsedEquips = {}
	self._strengthenConsumeItems = {}
	self._starConsumeItem = nil
	self._equipStarUpItem = {
		stiveNum = 0,
		items = {},
		equips = {}
	}
	self._selectData = {
		["14"] = "0",
		["13"] = "0",
		canUseStive = "0",
		canUseCompose = "1",
		onlyOneStar = "1",
		canUseStone = "1",
		["12"] = "1",
		["11"] = "1"
	}

	local value = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kEquipQuickSelectKey)

	if value == "" then
		local str = ""

		for key, value in pairs(self._selectData) do
			str = str == "" and key .. "_" .. value or str .. "&" .. key .. "_" .. value
		end

		cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kEquipQuickSelectKey, str)
	else
		local valueTemp = string.split(value, "&")

		for i = 1, #valueTemp do
			local keys = string.split(valueTemp[i], "_")

			self._selectData[keys[1]] = keys[2]
		end
	end
end

function EquipSystem:resetEquipQuickSelect()
	local value = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kEquipQuickSelectKey)
	local valueTemp = string.split(value, "&")

	for i = 1, #valueTemp do
		local keys = string.split(valueTemp[i], "_")

		self._selectData[keys[1]] = keys[2]
	end
end

function EquipSystem:resetEquipStarUpItem()
	self._equipStarUpItem = {
		stiveNum = 0,
		items = {},
		equips = {}
	}
end

function EquipSystem:setEquipStarUpItem(stiveNum, consumes)
	self._equipStarUpItem.stiveNum = stiveNum
	self._equipStarUpItem.items = consumes.items
	self._equipStarUpItem.equips = consumes.equips
end

function EquipSystem:checkEnabled(params)
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Equip")

	if unlock and params then
		local tabType = params.tabType

		if tabType == 2 then
			unlock, tips = self._systemKeeper:isUnlock("Equip_StarUp")
		end
	end

	return unlock, tips
end

function EquipSystem:tryEnter(params)
	local unlock, tips = self:checkEnabled(params)

	if not unlock then
		self:dispatch(ShowTipEvent({
			tip = tips
		}))
	else
		if not params then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Equip_UI25")
			}))

			return
		end

		if not params.equipId then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Equip_UI25")
			}))

			return
		end

		local EquipMainView = self:getInjector():getInstance("EquipMainView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, EquipMainView, nil, params))
	end
end

function EquipSystem:setStrengthenConsumeItems(id, num)
	if not num then
		local index = table.indexof(self._strengthenConsumeItems, id)

		if not index then
			if #self._strengthenConsumeItems >= EquipStrengthenConsumeNum then
				return
			end

			self._strengthenConsumeItems[#self._strengthenConsumeItems + 1] = id
		else
			table.remove(self._strengthenConsumeItems, index)
		end
	elseif num > 0 then
		if #self._strengthenConsumeItems >= EquipStrengthenConsumeNum then
			return
		end

		self._strengthenConsumeItems[#self._strengthenConsumeItems + 1] = id
	else
		local index = table.indexof(self._strengthenConsumeItems, id)

		if index then
			table.remove(self._strengthenConsumeItems, index)
		end
	end
end

function EquipSystem:canAddConsumeItem(id)
	if self:getEquipById(id) then
		local index = table.indexof(self._strengthenConsumeItems, id)

		if not index and #self._strengthenConsumeItems >= EquipStrengthenConsumeNum then
			return false
		end
	elseif #self._strengthenConsumeItems >= EquipStrengthenConsumeNum then
		return false
	end

	return true
end

function EquipSystem:hasConsumeItem(id)
	if self:getEquipById(id) then
		local index = table.indexof(self._strengthenConsumeItems, id)

		if not index then
			return false
		end
	else
		return false
	end

	return true
end

function EquipSystem:checkIsExpFull(equipData, id)
	local exp = self:getAddExpById(id)

	for i = 1, #self._strengthenConsumeItems do
		local consumeId = self._strengthenConsumeItems[i]
		local addExp = self:getAddExpById(consumeId)

		exp = exp + addExp
	end

	local curExp = equipData:getExp()
	local maxExp = equipData:getMaxExp()

	if maxExp >= exp + curExp then
		return false
	end

	return true
end

function EquipSystem:getPreExp(equipData, id)
	local exp = self:getAddExpById(id)

	for i = 1, #self._strengthenConsumeItems do
		local consumeId = self._strengthenConsumeItems[i]
		local addExp = self:getAddExpById(consumeId)

		exp = exp + addExp
	end

	local curExp = equipData:getExp()

	return exp + curExp
end

function EquipSystem:selectMiniExpEquipToStreng(targetEquipId)
	if #self._strengthenConsumeItems > 0 then
		return nil
	end

	local params = {
		exceptEquipId = targetEquipId
	}
	local equipList = self:getEquipList(EquipsShowType.kStrengthen, params)
	local miniExp = 99999999
	local miniId

	for i = 1, #equipList do
		local data = equipList[i]

		if data.item then
			local equipId = data.item:getId()
			local exp = self:getAddExpById(equipId)

			if exp < miniExp then
				miniExp = exp
				miniId = equipId
			end
		else
			local equipId = data:getId()
			local exp = self:getAddExpById(equipId)

			if exp < miniExp then
				miniExp = exp
				miniId = equipId
			end
		end
	end

	if miniId ~= nil then
		return miniId
	end

	return nil
end

function EquipSystem:checkQuickConsumeItems(targetEquipId)
	if #self._strengthenConsumeItems >= EquipStrengthenConsumeNum then
		return false
	end

	local equipData = self:getEquipById(targetEquipId)
	local items = {}

	table.copy(self._strengthenConsumeItems, items)

	local params = {
		exceptEquipId = targetEquipId
	}
	local equipList = self:getEquipList(EquipsShowType.kStrengthen, params)

	for i = 1, #equipList do
		local data = equipList[i]

		if data.item then
			local canAdd = true
			local itemId = data.item:getId()
			local count = data.count
			local consumeBum = self:getConsumeItemAmount(itemId)

			for index = 1, count - consumeBum do
				canAdd = self:canAddConsumeItem(itemId)

				if not canAdd then
					break
				end

				local hasConsumeItem = self:hasConsumeItem(itemId)

				if not hasConsumeItem then
					local isFull = self:checkIsExpFull(equipData, itemId)

					if not isFull then
						self:setStrengthenConsumeItems(itemId, 1)
					end
				end
			end

			if not canAdd then
				break
			end
		else
			local equipId = data:getId()
			local canAdd = self:canAddConsumeItem(equipId)

			if not canAdd then
				break
			end

			local hasConsumeItem = self:hasConsumeItem(equipId)

			if not hasConsumeItem then
				local isFull = self:checkIsExpFull(equipData, equipId)

				if not isFull then
					self:setStrengthenConsumeItems(equipId)
				end
			end
		end
	end

	for i = 1, #self._strengthenConsumeItems do
		if items[i] ~= self._strengthenConsumeItems[i] then
			return true
		end
	end

	return false
end

function EquipSystem:getConsumeItemAmount(id)
	local num = 0
	local length = #self._strengthenConsumeItems

	for i = 1, length do
		if self._strengthenConsumeItems[i] == id then
			num = num + 1
		end
	end

	return num
end

function EquipSystem:clearEquipConsumeItems()
	self._strengthenConsumeItems = {}
	self._starConsumeItem = nil
end

function EquipSystem:getEquipById(id)
	return self._equipModule:getEquipById(id)
end

EquipsShowType = {
	kStrengthen = "getStrengthenEquips",
	kAllUpdate = "getStrengthenStarAndEquips",
	kStarBreak = "getStarBreakEquips",
	kResolve = "getResolveEquips",
	kStar = "getStarEquips",
	kCompose = "getComposeEquips",
	kReplace = "getReplaceEquips"
}

function EquipSystem:getEquipList(viewType, param)
	local equips = self[viewType](self, param)

	return equips or {}
end

function EquipSystem:getComposeEquips(param)
	local showEquips = {}

	if not param then
		return showEquips
	end

	local type = param.type
	local enabledEquip = {}
	local disabledEquip = {}
	local equipIds = self._equipModule:getEquipsByType(type)

	if param.type == "EquipAll" then
		equipIds = self._equipModule:getEquipsAll()

		local tab = {}

		for k, v in pairs(equipIds) do
			for kk, vv in pairs(v) do
				tab[kk] = vv
			end
		end

		equipIds = tab
	end

	for equipId, _ in pairs(equipIds) do
		local equip = self:getEquipById(equipId)
		local ownHeroId = equip:getHeroId()
		local ownUnlock = equip:getUnlock()
		local level = equip:getLevel()
		local rarity = equip:getRarity()

		if tonumber(rarity) == tonumber(param.Quality) and level == 1 then
			if ownHeroId ~= "" then
				disabledEquip[#disabledEquip + 1] = equip
			elseif not ownUnlock then
				enabledEquip[#enabledEquip + 1] = equip
			else
				showEquips[#showEquips + 1] = equip
			end
		end
	end

	local function sortFun(a, b)
		local posA = table.indexof(EquipPositionToType, a:getPosition())
		local posB = table.indexof(EquipPositionToType, b:getPosition())

		if posA == posB then
			return a:getId() < b:getId()
		else
			return posA < posB
		end
	end

	table.sort(showEquips, sortFun)
	table.sort(disabledEquip, sortFun)
	table.sort(enabledEquip, sortFun)

	for i = 1, #enabledEquip do
		showEquips[#showEquips + 1] = enabledEquip[i]
	end

	for i = 1, #disabledEquip do
		showEquips[#showEquips + 1] = disabledEquip[i]
	end

	return showEquips
end

function EquipSystem:getReplaceEquips(param)
	local showEquips = {}

	if not param then
		return showEquips
	end

	local type = param.position
	local occupation = param.occupation
	local heroId = param.heroId

	if not type or not occupation and not heroId then
		return showEquips
	end

	local equipIds = self._equipModule:getEquipsByType(type)
end

function EquipSystem:getStrengthenEquips(param)
	param = param or {}

	local exceptEquipId = param.exceptEquipId
	local showEquips = {}
	local equips = self._equipModule:getEquips()

	local function checkShowEquip(equip)
		if exceptEquipId and exceptEquipId == equip:getId() then
			return false
		end

		if not equip:getUnlock() then
			return false
		end

		if equip:getHeroId() ~= "" then
			return false
		end

		if equip:getPosition() == HeroEquipType.kStarItem then
			return false
		end

		return equip:getLevel() == 1 and equip:getRarity() < 14
	end

	for id, equip in pairs(equips) do
		if checkShowEquip(equip) then
			showEquips[#showEquips + 1] = equip
		end
	end

	table.sort(showEquips, function(a, b)
		if a:getRarity() == b:getRarity() then
			if a:getStar() == b:getStar() then
				return a:getSort() < b:getSort()
			end

			return a:getStar() < b:getStar()
		end

		return a:getRarity() < b:getRarity()
	end)

	local expItem = {}
	local bagIds = self._bagSystem:getAllEntryIds()
	local kTabFilterMap = self._bagSystem:getTabFilterMap()
	local filterFunc = kTabFilterMap[BagItemShowType.kEquip]

	for _, entryId in ipairs(bagIds) do
		local entry = self._bagSystem:getEntryById(entryId)
		local isvislble = self._bagSystem:getItemIsVisible(entryId)

		if entry and isvislble and filterFunc(entry.item) and entry.item:getSubType() == ItemTypes.K_EQUIP_EXP then
			expItem[#expItem + 1] = entry
		end
	end

	table.sort(expItem, function(a, b)
		if a.item:getQuality() ~= b.item:getQuality() then
			return a.item:getQuality() < b.item:getQuality()
		end

		return a.item:getSort() < b.item:getSort()
	end)

	for i = 1, #showEquips do
		expItem[#expItem + 1] = showEquips[i]
	end

	return expItem
end

function EquipSystem:getStarEquips(param)
	local showEquips = {}

	if not param then
		return showEquips
	end

	local type = param.position
	local exceptEquipId = param.exceptEquipId
	local equipBaseId = param.equipBaseId

	if not type or not exceptEquipId or not equipBaseId then
		return showEquips
	end

	local equipIds = self._equipModule:getEquipsByType(type)

	for id, _ in pairs(equipIds) do
		local equip = self:getEquipById(id)

		if id ~= exceptEquipId and equip:getRarity() ~= 15 then
			local exp = equip:getEquipId() == equipBaseId and equip:getSameEquipStarExp() or equip:getIncludeEquipStarExp()

			equip.expData = {
				eatCount = 0,
				allCount = 1,
				id = id,
				equipBaseId = equip:getEquipId(),
				exp = exp
			}
			showEquips[#showEquips + 1] = equip
		end
	end

	table.sort(showEquips, function(a, b)
		local starItemA = a:getEquipId() == equipBaseId
		local starItemB = b:getEquipId() == equipBaseId

		if a:getRarity() == b:getRarity() then
			if starItemA and starItemB or not starItemA and not starItemB then
				if a:getStar() == b:getStar() then
					if a:getLevel() == b:getLevel() then
						return a:getSort() < b:getSort()
					end

					return a:getLevel() < b:getLevel()
				end

				return a:getStar() < b:getStar()
			end

			return starItemA and not starItemB
		end

		return a:getRarity() < b:getRarity()
	end)

	return showEquips
end

function EquipSystem:getStarBreakEquips(param)
	local showEquips = {}

	if not param then
		return showEquips
	end

	local type = param.position
	local exceptEquipId = param.exceptEquipId
	local equipBaseId = param.equipBaseId

	if not type or not exceptEquipId or not equipBaseId then
		return showEquips
	end

	local equipIds = self._equipModule:getEquipsByType(type)

	for id, _ in pairs(equipIds) do
		local equip = self:getEquipById(id)

		if id ~= exceptEquipId and equip:getEquipId() == equipBaseId then
			equip.expData = {
				allCount = 1,
				eatCount = 0,
				id = id,
				equipBaseId = equip:getEquipId()
			}
			showEquips[#showEquips + 1] = equip
		end
	end

	table.sort(showEquips, function(a, b)
		if a:getRarity() == b:getRarity() then
			if a:getStar() == b:getStar() then
				if a:getLevel() == b:getLevel() then
					return false
				end

				return a:getLevel() < b:getLevel()
			end

			return a:getStar() < b:getStar()
		end

		return a:getRarity() < b:getRarity()
	end)

	return showEquips
end

local HeroEquipStarExpItem = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStarExpItem", "content")

function EquipSystem:getStarItems()
	local items = {}

	for id, exp in pairs(HeroEquipStarExpItem) do
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

function EquipSystem:getStarBreakItems(commonItemId)
	local items = {}
	local entry = self._bagSystem:getEntryById(commonItemId)

	if entry and entry.item and entry.count > 0 then
		local item = {
			eatCount = 0,
			itemId = commonItemId,
			allCount = entry.count,
			quality = entry.item:getQuality()
		}

		table.insert(items, item)
	end

	return items
end

function EquipSystem:getResolveEquips()
	local showEquips = {}

	local function checkShowEquip(equip)
		if equip:getHeroId() ~= "" then
			return false
		end

		if equip:getPosition() == HeroEquipType.kStarItem then
			return false
		end

		return true
	end

	local equips = self._equipModule:getEquips()

	for id, equip in pairs(equips) do
		if checkShowEquip(equip) then
			showEquips[#showEquips + 1] = equip
		end
	end

	table.sort(showEquips, function(a, b)
		if a:getRarity() == b:getRarity() then
			if a:getStar() == b:getStar() then
				if a:getLevel() == b:getLevel() then
					if a:getSort() == b:getSort() then
						return a:getId() < b:getId()
					end

					return a:getSort() < b:getSort()
				end

				return a:getLevel() < b:getLevel()
			end

			return a:getStar() < b:getStar()
		end

		return a:getRarity() < b:getRarity()
	end)

	return showEquips
end

function EquipSystem:getAddExpById(equipId)
	if not equipId then
		return 0
	end

	local equipData = self:getEquipById(equipId)

	return equipData and HeroEquipBaseExp[tostring(equipData:getRarity())] or HeroEquipExpItem[equipId]
end

function EquipSystem:getResolveItemsById(equipId)
	local equipData = self:getEquipById(equipId)
	local goldNum, items, equips = equipData:getResolveItems()

	return goldNum, items, equips
end

function EquipSystem:hasRedPointByReplace(param)
	if not param then
		return false
	end

	local type = param.position
	local occupation = param.occupation
	local heroId = param.heroId
	local heroEquipId = param.heroEquipId

	if not type or not occupation or not heroId then
		return false
	end

	self._oneKeyEquips[heroId] = self._oneKeyEquips[heroId] or {}

	local hero = self._heroSystem:getHeroById(heroId)
	local nNrEquips = {}
	local srNssrEquips = {}
	local rNrEquipsLength = 0
	local srNssrEquipsLength = 0
	local equipIds = self._equipModule:getEquipsByType(type)

	local function isNOrREquip(equip)
		return equip:getRarity() <= 12
	end

	local function isSROrSSREquip(equip)
		return equip:getRarity() >= 13
	end

	local heroEquipInfo = self:getEquipById(heroEquipId)
	local heroEquipRarity = heroEquipInfo and heroEquipInfo:getRarity() or 0
	local heroEquipLevel = heroEquipInfo and heroEquipInfo:getLevel() or 0

	for equipId, _ in pairs(equipIds) do
		local equip = self:getEquipById(equipId)
		local equipRarity = equip:getRarity()
		local equipLevel = equip:getLevel()

		if heroEquipRarity <= equipRarity or equipRarity == heroEquipRarity - 1 and equipLevel >= heroEquipLevel + 10 then
			local ownHeroId = equip:getHeroId()
			local occupationType = equip:getOccupationType()
			local accord = false

			if occupationType == nil or occupationType == 0 then
				if table.indexof(equip:getOccupation(), occupation) then
					accord = true
				end
			elseif occupationType == 1 and table.indexof(equip:getOccupation(), heroId) then
				accord = true
			end

			if accord and (ownHeroId == "" or ownHeroId == heroId) then
				local preCombat = hero:getCombatByEquip(equipId)

				equip:setPreHeroCombat(preCombat)

				if isNOrREquip(equip) then
					rNrEquipsLength = rNrEquipsLength + 1
					nNrEquips[#nNrEquips + 1] = equip
				elseif isSROrSSREquip(equip) then
					srNssrEquipsLength = srNssrEquipsLength + 1
					srNssrEquips[#srNssrEquips + 1] = equip
				end
			end
		end
	end

	local function sortFunc(a, b)
		if a:getPreHeroCombat() == b:getPreHeroCombat() then
			if a:getRarity() == b:getRarity() then
				if a:getSort() == b:getSort() then
					return a:getId() > b:getId()
				end

				return a:getSort() > b:getSort()
			end

			return a:getRarity() > b:getRarity()
		end

		return a:getPreHeroCombat() > b:getPreHeroCombat()
	end

	if srNssrEquipsLength > 0 then
		table.sort(srNssrEquips, function(a, b)
			return sortFunc(a, b)
		end)

		local id = srNssrEquips[1]:getId()
		local equip = self:getEquipById(heroEquipId)

		if not equip or equip and equip:getRarity() <= 12 then
			self._oneKeyEquips[heroId][type] = id

			return true
		else
			local preCombat = hero:getCombatByEquip(heroEquipId)
			local rarity = equip:getRarity()

			if preCombat > srNssrEquips[1]:getPreHeroCombat() then
				return false
			end

			if preCombat < srNssrEquips[1]:getPreHeroCombat() then
				self._oneKeyEquips[heroId][type] = id

				return true
			end

			if srNssrEquips[1]:getPreHeroCombat() == preCombat and rarity < srNssrEquips[1]:getRarity() then
				self._oneKeyEquips[heroId][type] = id

				return true
			end
		end
	elseif rNrEquipsLength > 0 then
		table.sort(nNrEquips, function(a, b)
			return sortFunc(a, b)
		end)

		local id = nNrEquips[1]:getId()

		if not heroEquipId then
			self._oneKeyEquips[heroId][type] = id

			return true
		else
			local equip = self:getEquipById(heroEquipId)
			local preCombat = hero:getCombatByEquip(heroEquipId)
			local rarity = equip:getRarity()

			if preCombat > nNrEquips[1]:getPreHeroCombat() then
				return false
			end

			if preCombat < nNrEquips[1]:getPreHeroCombat() then
				self._oneKeyEquips[heroId][type] = id

				return true
			end

			if nNrEquips[1]:getPreHeroCombat() == preCombat and rarity < nNrEquips[1]:getRarity() then
				self._oneKeyEquips[heroId][type] = id

				return true
			end
		end
	end

	return false
end

function EquipSystem:resetOneKeyEquips()
	self._oneKeyEquips = {}
end

function EquipSystem:hasRedPointByEquipStarUp(equipId)
	local equip = self:getEquipById(equipId)

	if not equip then
		return false
	end

	if equip:isMaxStar() then
		return false
	end

	local level = equip:getLevel()
	local levelMax = equip:getMaxLevel()

	if level < levelMax then
		return false
	end

	local itemData = equip:getStarItem()[1]
	local hasNum = CurrencySystem:getCurrencyCount(self, itemData.itemId)
	local needNum = itemData.amount

	if hasNum < needNum then
		return false
	end

	local needNum = equip:getEquipItemNum()

	if needNum > 0 then
		local commonItemId = equip:getCommonItemId()
		local stiveItem = self:getStarBreakItems(commonItemId)

		if #stiveItem > 0 then
			return true
		end

		local type = equip:getPosition()
		local exceptEquipId = equip:getId()
		local equipBaseId = equip:getEquipId()
		local equipIds = self._equipModule:getEquipsByType(type)

		for id, _ in pairs(equipIds) do
			local equip = self:getEquipById(id)

			if id ~= exceptEquipId and equip:getEquipId() == equipBaseId and equip:getUnlock() and equip:getHeroId() == "" then
				return true
			end
		end
	else
		local needExp = equip:getEquipStarExp()
		local stiveItems = self:getStarItems()

		if #stiveItems == 0 then
			return false
		end

		local curExp = 0

		for i = 1, #stiveItems do
			local itemData = stiveItems[i]
			local amount = itemData.allCount
			local exp = itemData.exp

			for j = 1, amount do
				curExp = curExp + exp

				if needExp <= curExp then
					return true
				end
			end
		end
	end

	return false
end

function EquipSystem:requestEquipMounting(param, callback, blockUI)
	param = {
		heroId = param.heroId,
		equipId = param.equipId
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestEquipMounting(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_MOUNTING_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestEquipDemount(param, callback, blockUI)
	param = {
		heroId = param.heroId,
		equipId = param.equipId
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestEquipDemount(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_DEMOUNT_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestOneKeyEquipMounting(param, callback, blockUI)
	param = {
		heroId = param.heroId,
		heroEquips = param.heroEquips
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestOneKeyEquipMounting(param, function(response)
		if response.resCode == GS_SUCCESS then
			self:resetOneKeyEquips()

			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_ONEKEYMOUNTING_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestOneKeyEquipDemount(param, callback, blockUI)
	param = {
		heroId = param.heroId
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestOneKeyEquipDemount(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_ONEKEYDEMOUNT_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestEquipIntensify(param, callback, blockUI)
	self:clearEquipConsumeItems()

	param = {
		equipIntensifyId = param.equipIntensifyId
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestEquipIntensify(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_LEVELUP_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestEquipIntensifyTen(param, callback, blockUI)
	self:clearEquipConsumeItems()

	param = {
		equipIntensifyId = param.equipIntensifyId
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestEquipIntensifyTen(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_LEVELUP_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestOneKeyIntensify(param, callback, blockUI)
	param = {
		heroId = param.heroId
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestOneKeyIntensify(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_ONEKEY_LEVELUP_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestEquipStarUp(param, callback, blockUI)
	self:clearEquipConsumeItems()
	self:resetEquipStarUpItem()

	param = {
		equipId = param.equipId,
		items = param.items,
		consumeList = param.consumeList
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestEquipStarUp(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_STARUP_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestEquipLock(param, callback, blockUI)
	local param_request = {
		equipId = param.equipId
	}
	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestEquipLock(param_request, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_LOCK_SUCC, {
				viewtype = param.viewtype
			}))
		end
	end, blockUI)
end

function EquipSystem:requestEquipReplace(param, callback, blockUI)
	param = {
		heroId = param.heroId,
		equipId = param.equipId
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestEquipReplace(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_REPLACE_SUCC, {}))
		end
	end, blockUI)
end

function EquipSystem:requestEquipResolve(param, callback, blockUI)
	param = {
		equipId = param.equipIds
	}

	local equipService = self:getInjector():getInstance(EquipService)

	equipService:requestEquipResolve(param, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback()
			end

			self:dispatch(Event:new(EVT_EQUIP_RESOLVE_SUCC, response))
		end
	end, blockUI)
end

function EquipSystem:runIconShowAction(node, delayCount)
	local s = node:getScale()

	node:setOpacity(0)
	node:setScale(s * 1.2)

	local duration = 0.15
	local fadeIn = cc.FadeIn:create(duration)
	local scaleTo1 = cc.ScaleTo:create(duration, s)
	local spawn = cc.Spawn:create(fadeIn, scaleTo1)
	local delay = cc.DelayTime:create(delayCount * 0.1)

	node:runAction(cc.Sequence:create(delay, spawn))
end

function EquipSystem:clearComposeUsedEquips()
	self._composeUsedEquips = {}
end

function EquipSystem:addComposeUsedEquips(index, uuid)
	print("index----" .. index)

	self._composeUsedEquips[tonumber(index) + 1] = uuid
end

function EquipSystem:getComposeUsedEquips()
	return self._composeUsedEquips
end
