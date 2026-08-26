-- chunkname: @modules/logic/room/model/common/RoomThemeFilterListModel.lua

module("modules.logic.room.model.common.RoomThemeFilterListModel", package.seeall)

local RoomThemeFilterListModel = class("RoomThemeFilterListModel", ListScrollModel)

function RoomThemeFilterListModel:onInit()
	self:_clearData()
end

function RoomThemeFilterListModel:reInit()
	self:_clearData()
end

function RoomThemeFilterListModel:clear()
	RoomThemeFilterListModel.super.clear(self)
	self:_clearData()
end

function RoomThemeFilterListModel:_clearData()
	self:_clearSelectData()
end

function RoomThemeFilterListModel:_clearSelectData()
	self._selectIdList = {}
	self._isAll = false
end

function RoomThemeFilterListModel:init()
	self:_clearData()

	local themeCfgList = RoomConfig.instance:getThemeConfigList()
	local moList = {}

	for i, themeCfg in ipairs(themeCfgList) do
		local mo = RoomThemeMO.New()

		mo:init(themeCfg.id, themeCfg)
		table.insert(moList, mo)
	end

	table.sort(moList, RoomThemeFilterListModel.sortMOFunc)
	self:setList(moList)
end

function RoomThemeFilterListModel.sortMOFunc(a, b)
	if a.id ~= b.id then
		return a.id > b.id
	end
end

function RoomThemeFilterListModel:clearFilterData()
	self:_clearSelectData()
	self:onModelUpdate()
end

function RoomThemeFilterListModel:getIsAll()
	return self._isAll
end

function RoomThemeFilterListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function RoomThemeFilterListModel:isSelectById(themeId)
	if self._isAll then
		return true
	end

	if tabletool.indexOf(self._selectIdList, themeId) then
		return true
	end

	return false
end

function RoomThemeFilterListModel:selectAll()
	if self._isAll == true then
		return
	end

	self._selectIdList = {}

	local moList = self:getList()

	for i, mo in ipairs(moList) do
		table.insert(self._selectIdList, mo.id)
	end

	self:_checkAll()
	self:onModelUpdate()
end

function RoomThemeFilterListModel:setSelectById(id, isSelect)
	if not self:getById(id) then
		return
	end

	if isSelect == true then
		if not tabletool.indexOf(self._selectIdList, id) then
			table.insert(self._selectIdList, id)
			self:_checkAll()
			self:onModelUpdate()
		end
	elseif isSelect == false then
		local index = tabletool.indexOf(self._selectIdList, id)

		if index then
			table.remove(self._selectIdList, index)
			self:_checkAll()
			self:onModelUpdate()
		end
	end
end

function RoomThemeFilterListModel:_checkAll()
	local moList = self:getList()

	if #moList > #self._selectIdList then
		self._isAll = false
	end
end

function RoomThemeFilterListModel:getSelectIdList()
	return self._selectIdList
end

function RoomThemeFilterListModel:initThemeData(themeList)
	self:_clearData()

	local moList = {}

	for i, id in ipairs(themeList) do
		local mo = RoomThemeMO.New()
		local themeCfg = RoomConfig.instance:getThemeConfig(id)

		mo:init(id, themeCfg)
		table.insert(moList, mo)
	end

	table.sort(moList, RoomThemeFilterListModel.sortMOFunc)
	self:setList(moList)
end

RoomThemeFilterListModel.instance = RoomThemeFilterListModel.New()

return RoomThemeFilterListModel
