-- chunkname: @IQIGame\\Module\\Equip\\EquipData.lua

EquipData = {
	isMaxLv = false,
	exp = 0,
	isLock = false,
	lv = 0,
	baseAttribute = {
		Main = {},
		Other = {}
	},
	AttributeDic = {}
}

function EquipData.New()
	local o = Clone(EquipData)

	return o
end

function EquipData:Update(equipData, ItemData)
	for key, value in pairs(ItemData) do
		if key ~= "equip" then
			self[key] = value
		end
	end

	self.itemCid = equipData.itemCid
	self.equipCid = equipData.equipCid
	self.exp = equipData.exp
	self.lv = equipData.lv
	self.heroCid = equipData.heroCid
	self.isLock = equipData.lock
	self.isMaxLv = self.lv == self:GetMaxLv()
	self.sourceSlaverAttrs = equipData.slaverAttrs
	self.baseAttribute.Main = EquipData.InitMainAttributeData(equipData.masterAttrs)
	self.baseAttribute.Other = EquipData.InitOtherAttributeData(equipData.slaverAttrs)
	self.AttributeDic = EquipData.GetAttributeTable(equipData.masterAttrs, equipData.slaverAttrs)
end

function EquipData.InitMainAttributeData(attrs)
	local attrTable = {}

	for attrID, attrValue in pairs(attrs) do
		local attrItem = {}

		attrItem.id = CfgEquipAttrTable[attrID].MasterAttrType
		attrItem.equipAttrID = attrID
		attrItem.originalValue = attrValue

		local cfgAttribute = CfgAttributeTable[attrItem.id]

		attrItem.Name = cfgAttribute.Name
		attrItem.OldAddAttNum = attrValue
		attrItem.AddAttNum = EquipApi:FormatAttrValue(cfgAttribute.IsPer, attrValue)

		if cfgAttribute.ImageUrl and cfgAttribute.ImageUrl ~= "" then
			attrItem.ImageUrl = UIGlobalApi.IconPath .. cfgAttribute.ImageUrl
		end

		attrItem.config = cfgAttribute

		table.insert(attrTable, attrItem)
	end

	return attrTable
end

function EquipData.InitOtherAttributeData(attrs)
	local attrTable = {}

	table.sort(attrs, function(a, b)
		return a.equipLevel < b.equipLevel
	end)

	for _, attr in pairs(attrs) do
		local attrItem = {}

		attrItem.id = attr.attrType
		attrItem.onlyId = attr.attrId

		if attrItem.onlyId == 20254 then
			local a = 1
		end

		local cfgAttribute = CfgAttributeTable[attrItem.id]

		attrItem.Name = cfgAttribute.Name
		attrItem.OldAddAttNum = attr.attrValue
		attrItem.AddAttNum = EquipApi:FormatAttrValue(cfgAttribute.IsPer, attr.attrValue)

		if cfgAttribute.ImageUrl and cfgAttribute.ImageUrl ~= "" then
			attrItem.ImageUrl = UIGlobalApi.IconPath .. cfgAttribute.ImageUrl
		end

		attrItem.config = cfgAttribute

		table.insert(attrTable, attrItem)
	end

	return attrTable
end

function EquipData.GetAttributeTable(mainAttrs, otherAttrs)
	local curAttrTable = {}

	for attrID, attr in pairs(mainAttrs) do
		curAttrTable[CfgEquipAttrTable[attrID].MasterAttrType] = attr
	end

	for _, attr in pairs(otherAttrs) do
		curAttrTable[attr.attrType] = attr.attrValue
	end

	return curAttrTable
end

function EquipData:GetMaxLv()
	local maxLevel = 0
	local cfg = EquipModule.GetEquipLevelConfig()

	for level, v in pairs(cfg[self:GetEquipCfg().Quality][self:GetEquipCfg().Place]) do
		maxLevel = math.max(maxLevel, level)
	end

	return maxLevel
end

function EquipData:GetCfg()
	return CfgItemTable[self.cid]
end

function EquipData:GetEquipCfg()
	return CfgEquipTable[self.equipCid]
end

function EquipData:GetAttributeNumForType(attributeId, base)
	local value = self:GetAttributeValue(attributeId, nil)
	local config = CfgAttributeTable[attributeId]

	if config.RelationId then
		for i, relatedID in pairs(config.RelationId) do
			value = value + self:GetAttributeValue(relatedID, base)
		end
	end

	return value
end

function EquipData:GetAttributeValue(attributeId, base)
	local value = 0

	if self.AttributeDic[attributeId] ~= nil then
		value = self.AttributeDic[attributeId]
	end

	local config = CfgAttributeTable[attributeId]

	if config.IsPer then
		local percent = value

		value = base and base * percent or percent
	end

	return value
end

function EquipData:GetEquipCfgByLevel()
	for k, v in pairsCfg(CfgEquipLevelTable) do
		if v.Quality == self:GetEquipCfg().Quality and v.Place == self:GetEquipCfg().Place and v.Level == self.lv then
			return v
		end
	end

	return nil
end

function EquipData:SortByLevel(target, ascending)
	return sortByValue(self.lv, target.lv, ascending)
end

function EquipData:CompareWithLevel(target, ascending)
	return sortByValue(self.lv, target.lv, ascending)
end

function EquipData:CompareWithQuality(target, ascending)
	return sortByValue(self:GetCfg().Quality, target:GetCfg().Quality, ascending)
end

function EquipData:CompareWithSuitID(target, ascending)
	local sourceSuitId = TernaryConditionalOperator(self:GetEquipCfg().SuitId[1], self:GetEquipCfg().SuitId[1], 0)
	local targetSuitId = TernaryConditionalOperator(target:GetEquipCfg().SuitId[1], target:GetEquipCfg().SuitId[1], 0)

	return sortByValue(sourceSuitId, targetSuitId, ascending)
end

function EquipData:CompareWithID(target, ascending)
	return sortByValue(self.id, target.id, ascending)
end
