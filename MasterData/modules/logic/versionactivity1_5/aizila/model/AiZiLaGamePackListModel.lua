-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaGamePackListModel.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaGamePackListModel", package.seeall)

local AiZiLaGamePackListModel = class("AiZiLaGamePackListModel", ListScrollModel)

function AiZiLaGamePackListModel:init()
	local dataList = {}

	tabletool.addValues(dataList, AiZiLaGameModel.instance:getItemList())

	if #dataList > 1 then
		table.sort(dataList, AiZiLaGamePackListModel.sortFunc)
	end

	self:setList(dataList)
end

function AiZiLaGamePackListModel.sortFunc(a, b)
	local aCfg = a:getConfig()
	local bCfg = b:getConfig()

	if aCfg.rare ~= bCfg.rare then
		return aCfg.rare > bCfg.rare
	end

	local acount = a:getQuantity()
	local bcount = b:getQuantity()

	if acount ~= bcount then
		return bcount < acount
	end

	if a.itemId ~= b.itemId then
		return a.itemId < b.itemId
	end
end

function AiZiLaGamePackListModel:_refreshSelect()
	local selectMO = self:getById(self._selectItemId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function AiZiLaGamePackListModel:setSelect(itemId)
	self._selectItemId = itemId

	self:_refreshSelect()
end

function AiZiLaGamePackListModel:getSelect()
	return self._selectItemId
end

function AiZiLaGamePackListModel:getSelectMO()
	return self:getById(self._selectItemId)
end

AiZiLaGamePackListModel.instance = AiZiLaGamePackListModel.New()

return AiZiLaGamePackListModel
