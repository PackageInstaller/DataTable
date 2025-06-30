-- chunkname: @IQIGame\\UI\\Common\\Equip\\EquipScreenData.lua

local Data = {
	suitIDs = {},
	qualities = {},
	mainProperties = {},
	subProperties = {}
}

function Data.New()
	local obj = Clone(Data)

	return obj
end

function Data:GetSelectIDs(sortType)
	if sortType == Constant.EquipScreenType.Suit then
		return self:GetSuitIDs()
	elseif sortType == Constant.EquipScreenType.Quality then
		return self:GetQualityIDs()
	elseif sortType == Constant.EquipScreenType.MainProperty then
		return self:GetMainPropertyIDs()
	elseif sortType == Constant.EquipScreenType.SubProperty then
		return self:GetSubPropertyIDs()
	else
		return {}
	end
end

function Data:UpdateValue(sortType, value)
	if sortType == Constant.EquipScreenType.Suit then
		self:SetSuitID(value)
	elseif sortType == Constant.EquipScreenType.Quality then
		self:SetQualityID(value)
	elseif sortType == Constant.EquipScreenType.MainProperty then
		self:SetMainPropertyID(value)
	elseif sortType == Constant.EquipScreenType.SubProperty then
		self:SetSubPropertiesValue(value)
	end
end

function Data:GetSuitIDs()
	return self.__GetArrayIndexOneValue(self.suitIDs, Constant.EquipSortNormalValue)
end

function Data:SetSuitID(value)
	self.suitIDs = {}

	table.insert(self.suitIDs, value)
end

function Data:GetQualityIDs()
	return self.__GetArrayIndexOneValue(self.qualities, Constant.EquipSortNormalValue)
end

function Data:SetQualityID(value)
	self.qualities = {}

	table.insert(self.qualities, value)
end

function Data:GetMainPropertyIDs()
	return self.__GetArrayIndexOneValue(self.mainProperties, Constant.EquipSortNormalValue)
end

function Data:SetMainPropertyID(value)
	self.mainProperties = {}

	table.insert(self.mainProperties, value)
end

function Data:GetSubPropertyIDs()
	if self.subProperties == nil then
		self.subProperties = {}
	end

	if #self.subProperties == 0 then
		table.insert(self.subProperties, Constant.EquipSortNormalValue)
	end

	return self.subProperties
end

function Data:SetSubPropertiesValue(value)
	if value == 0 then
		self.subProperties = {}

		table.insert(self.subProperties, Constant.EquipSortNormalValue)

		return
	end

	if self.subProperties[1] == 0 then
		self.subProperties = {}
	end

	local tempIndex = 0

	ForArray(self.subProperties, function(_index, _value)
		if _value ~= value then
			return
		end

		tempIndex = _index

		return true
	end)

	if tempIndex == 0 then
		if #self.subProperties == 4 then
			return
		end

		table.insert(self.subProperties, value)
	else
		table.remove(self.subProperties, tempIndex)
	end
end

function Data:SetSubProperties(value)
	self.subProperties = value
end

function Data.__GetArrayIndexOneValue(values, defaultValue)
	if values == nil then
		values = {}
	end

	if #values == 0 then
		table.insert(values, defaultValue)
	end

	return values
end

function Data:Check(equipData)
	local result = self:__CheckOneValue(self:GetQualityIDs(), equipData:GetCfg().Quality)

	if not result then
		return false
	end

	result = self:___CheckSuitId(self:GetSuitIDs(), equipData:GetEquipCfg().SuitId)

	if not result then
		return false
	end

	result = self:___CheckAttribute(self:GetMainPropertyIDs(), equipData.baseAttribute.Main)

	if not result then
		return false
	end

	result = self:___CheckAttribute(self:GetSubPropertyIDs(), equipData.baseAttribute.Other)

	if not result then
		return false
	end

	return true
end

function Data:__CheckOneValue(values, sourceValue)
	if values[1] == 0 then
		return true
	end

	return values[1] == sourceValue
end

function Data:___CheckSuitId(sourceValues, targetValues)
	if sourceValues[1] == 0 then
		return true
	end

	local result = false

	ForArray(targetValues, function(_, _targetValue)
		ForArray(sourceValues, function(_, _sourceValue)
			if _targetValue ~= _sourceValue then
				return
			end

			result = true

			return true
		end)

		if result == true then
			return true
		end
	end)

	return result
end

function Data:___CheckAttribute(values, attributeTable)
	if values[1] == 0 then
		return true
	end

	local result = false

	ForArray(values, function(_, _attrId)
		ForPairs(attributeTable, function(_, _attrData)
			if _attrId ~= _attrData.equipAttrID then
				return
			end

			result = true

			return true
		end)

		if result == true then
			return true
		end
	end)

	return result
end

return Data
