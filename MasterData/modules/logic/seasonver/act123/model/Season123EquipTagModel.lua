-- chunkname: @modules/logic/seasonver/act123/model/Season123EquipTagModel.lua

module("modules.logic.seasonver.act123.model.Season123EquipTagModel", package.seeall)

local Season123EquipTagModel = class("Season123EquipTagModel", BaseModel)

Season123EquipTagModel.NoTagId = -1

function Season123EquipTagModel:clear()
	self._desc2IdMap = nil
	self._optionsList = nil
	self._curTag = nil
	self._curTagStr = nil
end

function Season123EquipTagModel:init(activityId)
	self._curTag = Season123EquipTagModel.NoTagId
	self._curTagStr = tostring(self._curTag)
	self.activityId = activityId

	self:initConfig()
end

function Season123EquipTagModel:initConfig()
	local actId = Season123Model.instance:getCurSeasonId()

	if not actId then
		return
	end

	local cfgList = Season123Config.instance:getSeasonTagDesc(actId)

	self._index2IdMap = {}
	self._optionsList = {}

	local noTagDesc = luaLang("common_all")

	self._index2IdMap[0] = Season123EquipTagModel.NoTagId

	table.insert(self._optionsList, noTagDesc)

	local list = {}

	if cfgList then
		for _, cfg in pairs(cfgList) do
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

function Season123EquipTagModel:getOptions()
	return self._optionsList
end

function Season123EquipTagModel:getSelectIdByIndex(tagIndex)
	return self._index2IdMap[tagIndex]
end

function Season123EquipTagModel:isCardNeedShow(itemTags)
	if self._curTag == Season123EquipTagModel.NoTagId or not self._curTag then
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

function Season123EquipTagModel:selectTagIndex(tagIndex)
	local tagId = self:getSelectIdByIndex(tagIndex)

	if tagId ~= nil then
		self._curTag = tagId
		self._curTagStr = tostring(self._curTag)
	else
		logNormal("tagIndex = " .. tostring(tagIndex) .. " not found!")
	end
end

function Season123EquipTagModel:getCurTagId()
	return self._curTag
end

return Season123EquipTagModel
