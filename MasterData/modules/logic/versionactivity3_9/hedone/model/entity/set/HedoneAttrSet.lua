-- chunkname: @modules/logic/versionactivity3_9/hedone/model/entity/set/HedoneAttrSet.lua

module("modules.logic.versionactivity3_9.hedone.model.entity.set.HedoneAttrSet", package.seeall)

local HedoneAttrSet = class("HedoneAttrSet", HedoneBaseSet)

function HedoneAttrSet:onCtor()
	self._baseDict = {}
	self._valueDict = {}
	self._buffUid2ModList = {}
	self._attrId2ModDict = {}
end

function HedoneAttrSet:initAttrBaseValue(attrId, attrSubId, initValue)
	local baseValue = self:getAttrBaseValue(attrId, attrSubId)

	if baseValue then
		return
	end

	local cfg = HedoneConfig.instance:getHedoneAttributeCfg(attrId, true)

	if not cfg then
		return
	end

	local valid, isNeedSubId = HedoneGameHelper.checkAttrSubId(attrId, attrSubId, true)

	if not valid then
		return
	end

	if attrId == HedoneGameEnum.Attribute.Hp then
		self:setHp(initValue)
	else
		local max = HedoneConfig.instance:getHedoneAttributeMax(attrId)
		local min = HedoneConfig.instance:getHedoneAttributeMin(attrId)

		if isNeedSubId then
			local subDict = GameUtil.tabletool_checkDictTable(self._baseDict, attrId)

			subDict[attrSubId] = GameUtil.clamp(initValue, min, max)
		else
			self._baseDict[attrId] = GameUtil.clamp(initValue, min, max)
		end

		self:_calAttrValue(attrId, attrSubId)
	end
end

function HedoneAttrSet:_calAttrValue(attrId, attrSubId)
	local hpAttrId = HedoneGameEnum.Attribute.Hp

	if not attrId or attrId == hpAttrId then
		return
	end

	local valid, isNeedSubId = HedoneGameHelper.checkAttrSubId(attrId, attrSubId, true)

	if not valid then
		return
	end

	local baseValue = self:getAttrBaseValue(attrId, attrSubId)

	if not baseValue then
		logError(string.format("HedoneAttrSet:_calAttrValue error, no attribute base value, attrId:%s attrSubId:%s", attrId, attrSubId))

		return
	end

	local value = baseValue
	local modDict = self._attrId2ModDict[attrId]

	if modDict then
		for modifier, _ in pairs(modDict) do
			local isCanModify = modifier:getIsCanModify(attrId, attrSubId)

			value = isCanModify and modifier:modify(value) or value
		end
	end

	local oldValue = self:getAttrValueInSet(attrId, attrSubId)
	local max = HedoneConfig.instance:getHedoneAttributeMax(attrId)
	local min = HedoneConfig.instance:getHedoneAttributeMin(attrId)
	local newValue = GameUtil.clamp(value, min, max)

	if isNeedSubId then
		local subDict = GameUtil.tabletool_checkDictTable(self._valueDict, attrId)

		subDict[attrSubId] = newValue
	else
		self._valueDict[attrId] = newValue
	end

	if attrId == HedoneGameEnum.Attribute.HpCap then
		local hpCap = self:getAttrValueInSet(attrId)
		local curHP = self:getAttrValueInSet(hpAttrId)

		if hpCap < curHP then
			self:setHp(hpCap)
		end
	end

	local unitMO = self:getUnitMO()

	unitMO:notifyAttributeChange(attrId, attrSubId, oldValue, newValue)
end

function HedoneAttrSet:setHp(newHp)
	if not newHp then
		return
	end

	local hpCapAttrId = HedoneGameEnum.Attribute.HpCap
	local hpCapBaseVal = self:getAttrBaseValue(hpCapAttrId)

	if not hpCapBaseVal then
		logError("HedoneAttrSet:setHp error, hpCap must be set before setting Hp")

		return
	end

	local hpAttrId = HedoneGameEnum.Attribute.Hp
	local min = HedoneConfig.instance:getHedoneAttributeMin(hpAttrId)
	local hpCap = self:getAttrValueInSet(hpCapAttrId)

	newHp = GameUtil.clamp(newHp, min, hpCap)
	self._baseDict[hpAttrId] = newHp
	self._valueDict[hpAttrId] = newHp

	return newHp
end

function HedoneAttrSet:addBuffModifierList2Set(buffUid, buffId, modifierList)
	if not modifierList or #modifierList <= 0 then
		return
	end

	if self._buffUid2ModList[buffUid] then
		logError(string.format("HedoneAttrSet:addBuffModifierList2Set error, Buff modifier list already exists, buffUid:%s buffId:%s", buffUid, buffId))

		return
	end

	for _, modifier in ipairs(modifierList) do
		local result = self:_validateModifier(modifier)

		if result then
			self:_applyModifierToSet(modifier)
		end
	end
end

function HedoneAttrSet:_validateModifier(modifier)
	if not modifier then
		return false
	end

	local attrId, attrSubId = modifier:getModifyAttr()
	local isValid = attrId and self:getAttrBaseValue(attrId, attrSubId)

	if not isValid then
		if attrId then
			logError(string.format("HedoneAttrSet:addBuffModifierList2Set error, no attribute base value, attrId:%s attrSubId:%s", attrId, attrSubId))
		else
			local modUid = modifier:getModUid()
			local belongBuffId = modifier:getBelongBuffId()

			logError(string.format("HedoneAttrSet:addBuffModifierList2Set error, no modify attrId, modUid:%s belongBuffId:%s", modUid, belongBuffId))
		end
	end

	return not not isValid
end

function HedoneAttrSet:_applyModifierToSet(modifier)
	if not modifier then
		return
	end

	local buffUid = modifier:getBelongBuffUid()
	local attrId, attrSubId = modifier:getModifyAttr()

	if attrId == HedoneGameEnum.Attribute.Hp then
		self:_modifyHp(modifier)
	else
		local buffModList = GameUtil.tabletool_checkDictTable(self._buffUid2ModList, buffUid)

		table.insert(buffModList, modifier)

		local attrModDict = GameUtil.tabletool_checkDictTable(self._attrId2ModDict, attrId)

		attrModDict[modifier] = true

		self:_calAttrValue(attrId, attrSubId)
	end
end

function HedoneAttrSet:_modifyHp(modifier)
	local hpAttrId = HedoneGameEnum.Attribute.Hp
	local isCanModify = modifier and modifier:getIsCanModify(hpAttrId, nil, true)

	if not isCanModify then
		return
	end

	local oldHp = self:getAttrValueInSet(hpAttrId)
	local newHp = oldHp
	local affectType = modifier:getModAffectType()

	if affectType == HedoneGameEnum.BuffAffectType.changeAttrFixed then
		newHp = modifier:modify(oldHp)
	else
		local hpCap = self:getAttrValueInSet(HedoneGameEnum.Attribute.HpCap)
		local modifiedHp = modifier:modify(hpCap)

		newHp = oldHp + modifiedHp
	end

	self:setHp(newHp)
end

function HedoneAttrSet:removeBuffModifierListInSet(buffUid)
	local modifierList = self._buffUid2ModList[buffUid]

	if not modifierList then
		return
	end

	local affectedAttrs = {}

	for _, modifier in ipairs(modifierList) do
		local attrId, attrSubId = modifier:getModifyAttr()

		if attrId and attrId ~= HedoneGameEnum.Attribute.Hp then
			local attrModDict = self._attrId2ModDict[attrId]

			if attrModDict then
				attrModDict[modifier] = nil
			end

			local subIdDict = GameUtil.tabletool_checkDictTable(affectedAttrs, attrId)

			if attrSubId then
				subIdDict[attrSubId] = true
			end
		end
	end

	self._buffUid2ModList[buffUid] = nil

	for attrId, subIdDict in pairs(affectedAttrs) do
		for subId in pairs(subIdDict) do
			self:_calAttrValue(attrId, subId)
		end

		if not next(subIdDict) then
			self:_calAttrValue(attrId)
		end
	end
end

function HedoneAttrSet:getAttrBaseValue(attrId, attrSubId)
	local baseValue
	local valid, isNeedSubId = HedoneGameHelper.checkAttrSubId(attrId, attrSubId, true)

	if not valid then
		return baseValue
	end

	local data = self._baseDict[attrId]

	baseValue = isNeedSubId and data and data[attrSubId] or data

	return baseValue
end

function HedoneAttrSet:getValueDict()
	return self._valueDict
end

function HedoneAttrSet:getAttrValueInSet(attrId, attrSubId)
	local value = 0
	local valid, isNeedSubId = HedoneGameHelper.checkAttrSubId(attrId, attrSubId, true)

	if valid then
		local data = self._valueDict[attrId]

		value = isNeedSubId and (data and data[attrSubId] or 0) or data or 0
	end

	return value
end

return HedoneAttrSet
