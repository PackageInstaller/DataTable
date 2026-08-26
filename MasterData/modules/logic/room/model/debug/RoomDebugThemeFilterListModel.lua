-- chunkname: @modules/logic/room/model/debug/RoomDebugThemeFilterListModel.lua

module("modules.logic.room.model.debug.RoomDebugThemeFilterListModel", package.seeall)

local RoomDebugThemeFilterListModel = class("RoomDebugThemeFilterListModel", ListScrollModel)

function RoomDebugThemeFilterListModel:onInit()
	self:_clearData()
end

function RoomDebugThemeFilterListModel:reInit()
	self:_clearData()
end

function RoomDebugThemeFilterListModel:clear()
	RoomDebugThemeFilterListModel.super.clear(self)
	self:_clearData()
end

function RoomDebugThemeFilterListModel:_clearData()
	self:_clearSelectData()
end

function RoomDebugThemeFilterListModel:_clearSelectData()
	self._selectIdList = {}
	self._isAll = false
end

function RoomDebugThemeFilterListModel:init()
	self:_clearData()

	local themeCfgList = RoomConfig.instance:getThemeConfigList()
	local moList = {}

	for i, themeCfg in ipairs(themeCfgList) do
		local mo = RoomThemeMO.New()

		mo:init(themeCfg.id, themeCfg)
		table.insert(moList, mo)
	end

	table.sort(moList, RoomDebugThemeFilterListModel.sortMOFunc)
	self:setList(moList)
end

function RoomDebugThemeFilterListModel.sortMOFunc(a, b)
	if a.id ~= b.id then
		return a.id > b.id
	end
end

function RoomDebugThemeFilterListModel:clearFilterData()
	self:_clearSelectData()
	self:onModelUpdate()
end

function RoomDebugThemeFilterListModel:getIsAll()
	return self._isAll
end

function RoomDebugThemeFilterListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function RoomDebugThemeFilterListModel:isSelectById(themeId)
	if self._isAll then
		return true
	end

	if tabletool.indexOf(self._selectIdList, themeId) then
		return true
	end

	return false
end

function RoomDebugThemeFilterListModel:selectAll()
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

function RoomDebugThemeFilterListModel:setSelectById(id, isSelect)
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

function RoomDebugThemeFilterListModel:_checkAll()
	local moList = self:getList()

	if #moList > #self._selectIdList then
		self._isAll = false
	end
end

function RoomDebugThemeFilterListModel:checkSelectByItem(itemId, materialType)
	if not self:getIsAll() and self:getSelectCount() > 0 then
		local themeId = RoomConfig.instance:getThemeIdByItem(itemId, materialType)

		if not self:isSelectById(themeId) then
			return false
		end
	end

	return true
end

RoomDebugThemeFilterListModel.instance = RoomDebugThemeFilterListModel.New()

return RoomDebugThemeFilterListModel
