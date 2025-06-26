-- chunkname: @IQIGame\\Module\\Common\\Screen\\CommonScreenData.lua

local CommonScreenItemData = {
	screenType = 0,
	choiceIDList = {}
}

function CommonScreenItemData:GetSingleChoiceID()
	return self.choiceIDList[1]
end

function CommonScreenItemData:SetValue(value)
	if self.limitData.maxChoiceCount == 1 then
		return self:__SetSingleValue(value)
	else
		return self:__SetMultipleValue(value)
	end
end

function CommonScreenItemData:__SetSingleValue(value)
	if self.limitData.excludeAll and value == Constant.CommonScreenAllValueID then
		return false
	end

	if self.choiceIDList[1] == value then
		if self.limitData.excludeAll then
			return false
		end

		self.choiceIDList[1] = Constant.CommonScreenAllValueID
	else
		self.choiceIDList[1] = value
	end

	return true
end

function CommonScreenItemData:__SetMultipleValue(value)
	if value == Constant.CommonScreenAllValueID then
		if self.choiceIDList[1] == Constant.CommonScreenAllValueID then
			return false
		end

		self.choiceIDList = {}

		table.insert(self.choiceIDList, Constant.CommonScreenAllValueID)

		return true
	end

	local tempIndex = self:IndexOfValue(value)

	if tempIndex == 0 then
		if #self.choiceIDList == self.limitData.maxChoiceCount then
			return false
		end

		if self.choiceIDList[1] == Constant.CommonScreenAllValueID then
			self.choiceIDList = {}
		end

		table.insert(self.choiceIDList, value)
	elseif #self.choiceIDList == 1 then
		if self.limitData.excludeAll then
			return false
		end

		self.choiceIDList = {}

		table.insert(self.choiceIDList, Constant.CommonScreenAllValueID)
	else
		table.remove(self.choiceIDList, tempIndex)
	end

	return true
end

function CommonScreenItemData:IndexOfValue(value)
	local resultIndex = 0

	if self.limitData.maxChoiceCount == 1 then
		if self.choiceIDList[1] == value then
			resultIndex = 1
		end
	else
		ForArray(self.choiceIDList, function(_index, _value)
			if _value ~= value then
				return
			end

			resultIndex = _index

			return true
		end)
	end

	return resultIndex
end

local CommonScreenData = {
	screenType = 0,
	itemsTable = {},
	valueTable = {}
}

function CommonScreenData.New()
	local data = Clone(CommonScreenData)

	data:__Init()

	return data
end

function CommonScreenData:__Init()
	self.itemsTable = {}
	self.valueTable = {}
end

function CommonScreenData:AddScreenItem(screenType, limitData)
	local item = Clone(CommonScreenItemData)

	item.screenType = screenType
	item.limitData = limitData
	item.choiceIDList = {}

	if item.limitData.excludeAll == true then
		local idList = CommonScreenModule.GetSubScreenCfgIDList(self.screenType, screenType)

		table.insert(item.choiceIDList, idList[1])
	else
		table.insert(item.choiceIDList, Constant.CommonScreenAllValueID)
	end

	self.itemsTable[screenType] = item

	return item
end

function CommonScreenData:GetScreenLimitData(screenType)
	local itemData = self.itemsTable[screenType]

	if itemData == nil then
		return nil
	end

	return itemData.limitData
end

function CommonScreenData:ChangeItemChoiceIDByValue(subScreenType, value, updateValueTable)
	if value == 0 then
		return self:ChangeItemChoiceID(subScreenType, value, updateValueTable)
	end

	local id = CommonScreenModule.GetSubScreenCfgIDByValue(self.screenType, subScreenType, value)

	if id == 0 then
		return false
	end

	return self:ChangeItemChoiceID(subScreenType, id, updateValueTable)
end

function CommonScreenData:ChangeItemChoiceID(subScreenType, id, updateValueTable)
	local item = self.itemsTable[subScreenType]

	if not item:SetValue(id) then
		return false
	end

	if updateValueTable == true then
		self:UpdateValueTable()
	end

	return true
end

function CommonScreenData:UpdateValueTable()
	self.valueTable = {}

	ForPairs(self.itemsTable, function(subScreenType, itemData)
		if self.valueTable[subScreenType] == nil then
			self.valueTable[subScreenType] = {}
		end

		if itemData:GetSingleChoiceID() == Constant.CommonScreenAllValueID then
			return
		end

		ForPairs(itemData.choiceIDList, function(_, _cfgID)
			local cfg = CommonScreenModule.GetScreenCfgByID(self.screenType, _cfgID)

			table.insert(self.valueTable[subScreenType], cfg.Value)
		end)
	end)
end

return CommonScreenData
