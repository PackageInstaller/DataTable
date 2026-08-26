-- chunkname: @modules/logic/season/model/Activity104EquipTagModel.lua

module("modules.logic.season.model.Activity104EquipTagModel", package.seeall)

local Activity104EquipTagModel = class("Activity104EquipTagModel", BaseModel)

Activity104EquipTagModel.NoTagId = -1

function Activity104EquipTagModel:clear()
	self._desc2IdMap = nil
	self._optionsList = nil
	self._curTag = nil
	self._curTagStr = nil
end

function Activity104EquipTagModel:init(activityId)
	self._curTag = Activity104EquipTagModel.NoTagId
	self._curTagStr = tostring(self._curTag)
	self.activityId = activityId

	self:initConfig()
end

function Activity104EquipTagModel:initConfig()
	local cfgDict = SeasonConfig.instance:getSeasonTagDict(self.activityId)

	self._index2IdMap = {}
	self._optionsList = {}

	local noTagDesc = luaLang("common_all")

	self._index2IdMap[0] = Activity104EquipTagModel.NoTagId

	table.insert(self._optionsList, noTagDesc)

	local list = {}

	if cfgDict then
		for _, cfg in pairs(cfgDict) do
			table.insert(list, cfg)
		end
	end

	table.sort(list, function(a, b)
		return a.order < b.order
	end)

	local index = 1

	for _, cfg in ipairs(list) do
		self._index2IdMap[index] = cfg.id

		table.insert(self._optionsList, cfg.desc)

		index = index + 1
	end
end

function Activity104EquipTagModel:getOptions()
	return self._optionsList
end

function Activity104EquipTagModel:getSelectIdByIndex(tagIndex)
	return self._index2IdMap[tagIndex]
end

function Activity104EquipTagModel:isCardNeedShow(itemTags)
	if self._curTag == Activity104EquipTagModel.NoTagId or not self._curTag then
		return true
	end

	local tags = string.split(itemTags, "#")

	for _, tag in pairs(tags) do
		if self._curTagStr == tag then
			return true
		end
	end

	return false
end

function Activity104EquipTagModel:selectTagIndex(tagIndex)
	local tagId = self:getSelectIdByIndex(tagIndex)

	if tagId ~= nil then
		self._curTag = tagId
		self._curTagStr = tostring(self._curTag)
	else
		logNormal("tagIndex = " .. tostring(tagIndex) .. " not found!")
	end
end

function Activity104EquipTagModel:getCurTagId()
	return self._curTag
end

return Activity104EquipTagModel
