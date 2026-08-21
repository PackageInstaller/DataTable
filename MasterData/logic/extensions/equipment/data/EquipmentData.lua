-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/data/EquipmentData.lua

module("logic.extensions.equipment.data.EquipmentData", package.seeall)

local M = class("EquipmentData", ItemData)
local json = require("cjson")
local _quality2key = {
	[GameEnum.QualityEnum.S] = "quaS",
	[GameEnum.QualityEnum.A] = "quaA",
	[GameEnum.QualityEnum.B] = "quaB",
	[GameEnum.QualityEnum.C] = "quaC"
}

function M:ctor(params)
	M.super.ctor(self, params)

	self._heroId = false
	self._equipId = self._uuid
	self._itemId = params.itemId
	self._isDiscard = params.discard
	self._decomposedItem = nil
	self._decomposedItemId = false
	self._decomposedItemCount = false
	self._suitId = -1
	self._attr = false
	self._attrList = false
	self._level = 1
	self._exp = 0
	self._throwTimes = 0
	self._quality = false
	self._career = false
	self._part = false
	self._originDiceAttr = false

	self:initInfoCo()
	self:initAttrCo()
	self:setDefaultOriginalD6()

	if not string.nilorempty(params.extJson) then
		local EquipInfoNO = json.decode(params.extJson)
		local heroId = EquipInfoNO.heroId
		local level = EquipInfoNO.level
		local exp = EquipInfoNO.exp
		local attrs = EquipInfoNO.attrs
		local originDiceAttr = EquipInfoNO.originDiceAttr
		local extraDiceAttrs = EquipInfoNO.extraDiceAttrs
		local extraDiceAttrNum = EquipInfoNO.extraDiceAttrNum

		self:setLevelAndExp(level, exp)
		self:refreshAttrs(attrs)
		self:setDiceAttr(originDiceAttr)
		self:setExtraDiceAttrs(extraDiceAttrs)
		self:setHeroId(heroId)
		self:setExtraDiceAttrNum(extraDiceAttrNum)
	end
end

function M:initInfoCo()
	self._quality = self._itemInfo.quality
	self._career = self._itemInfo.career
	self._part = self._itemInfo.part
	self._modelId = self._itemInfo.modelId
end

function M:initAttrCo()
	local equipCo = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentAttr, self._itemId)

	if equipCo then
		self._decomposedItem = equipCo.decomposedItem
		self._suitId = equipCo.suitId

		self:refreshAttrs(equipCo.attr)
	end
end

function M:getMaxLevel()
	local equipCo = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentQuality, self._quality)

	return equipCo.levelLimit
end

function M:isMaxLv()
	return self:getLevel() >= self:getMaxLevel()
end

function M:getMaxLevelUpExp()
	local maxLevel = self:getMaxLevel()
	local maxExp = 0

	for level = self._level, maxLevel - 1 do
		maxExp = maxExp + self:getLevelUpNeedExp(level)
	end

	return math.max(0, maxExp - self:getCurrentExp())
end

function M:getTargetLevelUpExp(targetLevel)
	local maxExp = 0

	for level = self._level, targetLevel - 1 do
		maxExp = maxExp + self:getLevelUpNeedExp(level)
	end

	return math.max(0, maxExp - self:getCurrentExp())
end

function M:getCurTotalExp()
	local maxLevel = self:getMaxLevel()
	local maxExp = 0
	local curExp = 0

	for lv = 1, maxLevel - 1 do
		maxExp = maxExp + self:getLevelUpNeedExp(lv)

		if lv == self._level - 1 then
			curExp = maxExp
		end
	end

	curExp = curExp + self._exp

	return curExp, maxExp
end

function M:getUpgradeLevel(exp)
	local totalExp = self:getCurrentExp() + exp
	local maxLevel = self:getMaxLevel()
	local upgradeLevel = 0
	local key = _quality2key[self._quality]

	for level = self._level, maxLevel - 1 do
		local equipCo = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentUpgrade, level)

		totalExp = totalExp - equipCo[key][self._part]

		if totalExp < 0 then
			upgradeLevel = level

			return upgradeLevel, totalExp + equipCo[key][self._part]
		end
	end

	return maxLevel, totalExp
end

function M:getCurrentExp()
	return self._exp
end

function M:getLevelUpNeedExp(level)
	if level == self:getMaxLevel() then
		return 0
	end

	local equipCo = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentUpgrade, level)

	if not equipCo then
		return 0
	end

	local key = _quality2key[self._quality]
	local needExp = equipCo[key][self._part]

	return needExp
end

function M:getHeroId()
	return self._heroId
end

function M:getHeroData()
	if self:getIsEquip() then
		return HeroDepotModel.instance:getHeroInfoByID(self._heroId)
	end
end

function M:setHeroId(heroId)
	self._heroId = heroId
end

function M:getCareer()
	return self._career
end

function M:getIsContainCareer(career)
	return table.indexof(self:getCareer() or {}, career)
end

function M:getQuality()
	return self._quality
end

function M:getSuitId()
	return self._suitId
end

function M:getLevel()
	return self._level
end

function M:getLevelDesc()
	return string.format("Lv.%d/%d", self:getLevel(), self:getMaxLevel())
end

function M:setLevelAndExp(level, exp)
	self._level = level
	self._exp = exp

	self:_refreshDecomposedCanGetExp()
end

function M:refreshAttrs(attrs)
	self._attrList = {}

	for _, EquipAttrNO in ipairs(attrs or {}) do
		table.insert(self._attrList, EquipAttrMO.New(EquipAttrNO))
	end
end

function M:setDefaultOriginalD6()
	local temp = {
		value = 0,
		diceAttrId = 111,
		level = 0
	}

	self:setDiceAttr(temp)
end

function M:setDiceAttr(originDiceAttr)
	if originDiceAttr and originDiceAttr.diceAttrId > 0 then
		self._originDiceAttr = DiceAttrMO.New(originDiceAttr)
	else
		self._originDiceAttr = false
	end
end

function M:setFackD6(setFackD6)
	self._level = self:getMaxLevel()
	self._extraDiceAttrs = {}

	for k, FixedDiceNO in ipairs(setFackD6 or {}) do
		table.insert(self._extraDiceAttrs, DiceAttrMO.New(FixedDiceNO.attrs[1]))
	end

	self:setExtraDiceAttrNum(#self._extraDiceAttrs)
end

function M:getOriginalD6()
	return self._originDiceAttr
end

function M:hasOriginalD6()
	return self._originDiceAttr and true or false
end

function M:setExtraDiceAttrs(extraDiceAttrs)
	self._extraDiceAttrs = {}

	for _, DiceAttrNO in ipairs(extraDiceAttrs or {}) do
		table.insert(self._extraDiceAttrs, DiceAttrMO.New(DiceAttrNO))
	end
end

function M:setExtraDiceAttrNum(extraDiceAttrNum)
	self._extraDiceAttrNum = extraDiceAttrNum
end

function M:getExtraDiceAttrNum()
	return self._extraDiceAttrNum or 0
end

function M:getExtraDiceAttrs()
	return self._extraDiceAttrs or {}
end

function M:getFixedD6ByHoleIndex(holeIndex)
	for _, fixedD6Mo in ipairs(self:getExtraDiceAttrs()) do
		if fixedD6Mo:getEffectIndex() == holeIndex then
			return fixedD6Mo
		end
	end
end

function M:getAllDiceAttr()
	local ret = {}

	if self._originDiceAttr then
		table.insert(ret, self._originDiceAttr)
	end

	if self._extraDiceAttrs then
		table.insertto(ret, self._extraDiceAttrs)
	end

	return ret
end

function M:getDiceAttrById(id)
	if self._originDiceAttr and self._originDiceAttr:getAttrId() == id then
		return self._originDiceAttr
	end

	if self._extraDiceAttrs then
		for i = 1, #self._extraDiceAttrs do
			if self._extraDiceAttrs[i]:getAttrId() == id then
				return self._extraDiceAttrs[i]
			end
		end
	end

	return false
end

function M:getPart()
	return self._part
end

function M:getModelId()
	return self._modelId
end

function M:getSuitData()
	return EquipSuitModel.instance:getSuitDataById(self._suitId)
end

function M:isSuitTagsContainTargetTag(tagIds)
	if not tagIds then
		return false
	end

	if not self._suitTags then
		local suitData = self:getSuitData()
		local activeSkillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(suitData:getSuitEffect())

		if activeSkillCOWrapper then
			self._suitTags = activeSkillCOWrapper:getDescTagIdDic() or {}
		else
			self._suitTags = {}
		end
	end

	for key, value in pairs(tagIds) do
		if self._suitTags[value] then
			return true
		end
	end

	return false
end

function M:getDiceTagsMatchNum(tagIds)
	local num = 0

	if not tagIds then
		return num
	end

	if not self._originDiceAttrTags then
		if self._originDiceAttr then
			local tags = self._originDiceAttr:getTags()

			tags = tags and TableUtil.tableToMap(tags) or {}
			self._originDiceAttrTags = tags
		else
			self._originDiceAttrTags = {}
		end
	end

	if not self._extraDiceAttrsTags or self._lastRefreshNum ~= #self._extraDiceAttrs then
		self._lastRefreshNum = #self._extraDiceAttrs
		self._extraDiceAttrsTags = {}

		for i = 1, #self._extraDiceAttrs or {} do
			local tags = self._extraDiceAttrs[i]:getTags()

			tags = tags and TableUtil.tableToMap(tags) or {}
			self._extraDiceAttrsTags[i] = tags
		end
	end

	if self:_isInTags(tagIds, self._originDiceAttrTags) then
		num = num + 1
	end

	for i = 1, #self._extraDiceAttrsTags do
		if self:_isInTags(tagIds, self._extraDiceAttrsTags[i]) then
			num = num + 1
		end
	end

	return num
end

function M:_isInTags(targetTags, tags)
	if tags then
		for i = 1, #targetTags do
			if tags[targetTags[i]] then
				return true
			end
		end
	end

	return false
end

function M:getAttrList()
	return self._attrList or {}
end

function M:getAttrById(id)
	if self._attrList then
		for i = 1, #self._attrList do
			if id == self._attrList[i]:getAttrId() then
				return self._attrList[i]
			end
		end
	end
end

function M:getTargetLevelAttrList(lvUp)
	local addList = {}
	local attrCo = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentAttr, self._itemId)
	local attrGrowth = EquipmentConfig.instance:getAttrGrowth(attrCo.growthId, lvUp)

	for k, v in pairs(self._attrList) do
		local id = v:getAttrId()

		if attrGrowth and attrGrowth[id] then
			addList[id] = attrGrowth[id]
		else
			addList[id] = 0
		end
	end

	return addList
end

function M:getIsEquip()
	return self._heroId and self._heroId ~= 0
end

function M:getIsHoleUnlock(index)
	local unlockHoleCount = self:getUnlockHoleCount()

	return index <= unlockHoleCount and index > 0
end

function M:getIsCurrentEquip(heroId)
	return self._heroId == heroId
end

function M:getItemId()
	return self._itemId
end

function M:getDecomposedItem()
	if not self._decomposedItemId then
		local info = string.gmatch(self._decomposedItem, "(%d+):(%d+)")

		for id, count in info do
			self._decomposedItemId = tonumber(id)
			self._decomposedItemCount = tonumber(count)
		end

		self._decomposedItem = nil
	end

	return self._decomposedItemId, self._decomposedItemCount
end

function M:_refreshDecomposedCanGetExp()
	self._canGetExp = 0

	local itemList = EquipUtil.calRecycleGetItems(self)

	for id, count in pairs(itemList) do
		local perExp = EquipmentConfig.instance:getItemAddEquipExp(tonumber(id))

		self._canGetExp = self._canGetExp + perExp * count
	end

	return self._canGetExp
end

function M:getDecomposedCanGetExp()
	return self._canGetExp or 0
end

function M:getUnlockHoleCount()
	local list = EquipmentConfig.instance:getConstNumList("DiceOpenLevels")

	for index = #list, 1, -1 do
		if self._level >= list[index] then
			return index
		end
	end

	return 0
end

function M:setIsDiscard(isDiscard)
	self._isDiscard = isDiscard
end

function M:getIsDiscard()
	return self._isDiscard
end

function M:getHoleStatus(index)
	local holeIndex = index - 1

	if index == 1 then
		if self:hasOriginalD6() then
			return EquipEnum.HoleStatus.Unalterable
		else
			return EquipEnum.HoleStatus.Seal
		end
	elseif self:getIsHoleUnlock(holeIndex) then
		if self:getFixedD6ByHoleIndex(holeIndex) then
			return EquipEnum.HoleStatus.Unlock
		else
			return EquipEnum.HoleStatus.NoCalibration
		end
	else
		local list = EquipmentConfig.instance:getConstNumList("DiceOpenLevels")
		local unlockLevel = list[holeIndex]

		if unlockLevel > self:getMaxLevel() then
			return EquipEnum.HoleStatus.Seal
		else
			return EquipEnum.HoleStatus.Lock
		end
	end
end

function M:checkForEmptyHoleRedPoint(onlyCalculate)
	local key = string.format("%s_%s", RedDotType.ERedDotKey.EQUIPMENT_DETAIL, self:getUuid())

	if EquipIntensifyController.instance:isEquipCanLvUpAnyMore(self, 1) then
		if not onlyCalculate then
			GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
				isActive = true,
				key = key
			})
		end

		return true
	end

	return false
end

return M
