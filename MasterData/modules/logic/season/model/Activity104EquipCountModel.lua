-- chunkname: @modules/logic/season/model/Activity104EquipCountModel.lua

module("modules.logic.season.model.Activity104EquipCountModel", package.seeall)

local Activity104EquipCountModel = class("Activity104EquipCountModel", BaseModel)

Activity104EquipCountModel.DefaultId = -1

function Activity104EquipCountModel:clear()
	self._desc2IdMap = nil
	self._optionsList = nil
	self._curId = nil
	self._itemCountDict = nil
end

function Activity104EquipCountModel:init(activityId)
	self._curId = Activity104EquipCountModel.DefaultId
	self.activityId = activityId
end

function Activity104EquipCountModel:refreshData(itemList)
	self._index2IdMap = {}
	self._optionsList = {}

	local countDict = {}

	if itemList then
		for _, mo in pairs(itemList) do
			countDict[mo.itemId] = countDict[mo.itemId] or 0
			countDict[mo.itemId] = countDict[mo.itemId] + 1
		end
	end

	self._itemCountDict = countDict

	local count2ItemDcit = {}

	for itemId, count in pairs(countDict) do
		count2ItemDcit[count] = count2ItemDcit[count] or {}
		count2ItemDcit[count][itemId] = true
	end

	local list = {}

	for count, dict in pairs(count2ItemDcit) do
		table.insert(list, count)
	end

	table.sort(list, function(a, b)
		return a < b
	end)

	local index = 0

	for i = 4, 1, -1 do
		local count = i

		self._index2IdMap[index] = count

		table.insert(self._optionsList, self:getOptionTxt(count))

		index = index + 1
	end

	local defaultId = Activity104EquipCountModel.DefaultId
	local noTagDesc = self:getOptionTxt(defaultId)

	self._index2IdMap[index] = defaultId

	table.insert(self._optionsList, noTagDesc)
end

function Activity104EquipCountModel:getOptionTxt(id, color)
	if id == Activity104EquipCountModel.DefaultId then
		return luaLang("common_all")
	end

	local idStr = tostring(id)

	if color then
		idStr = string.format("<color=%s>%s</color>", color, idStr)
	end

	return formatLuaLang("season104_compose_filter_txt", idStr)
end

function Activity104EquipCountModel:getOptions()
	return self._optionsList
end

function Activity104EquipCountModel:getSelectIdByIndex(index)
	return self._index2IdMap[index]
end

function Activity104EquipCountModel:isCardNeedShow(itemId, curCount)
	if self._curId == Activity104EquipCountModel.DefaultId or not self._curId then
		return true
	end

	if not self._itemCountDict[itemId] then
		local itemCount = 0
		local canShowCount = itemCount - self._curId

		return curCount < canShowCount
	end
end

function Activity104EquipCountModel:selectIndex(tagIndex)
	local id = self:getSelectIdByIndex(tagIndex)

	if id ~= nil then
		self._curId = id
	end
end

function Activity104EquipCountModel:getCurId()
	return self._curId
end

return Activity104EquipCountModel
