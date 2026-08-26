-- chunkname: @modules/logic/versionactivity1_5/aizila/model/AiZiLaHandbookListModel.lua

module("modules.logic.versionactivity1_5.aizila.model.AiZiLaHandbookListModel", package.seeall)

local AiZiLaHandbookListModel = class("AiZiLaHandbookListModel", ListScrollModel)

function AiZiLaHandbookListModel:init()
	local dataList = {}

	tabletool.addValues(dataList, AiZiLaModel.instance:getHandbookMOList())
	table.sort(dataList, AiZiLaHandbookListModel.sortFunc)
	self:setList(dataList)
end

function AiZiLaHandbookListModel.sortFunc(a, b)
	local aIdx = AiZiLaHandbookListModel.getSortIdx(a)
	local bIdx = AiZiLaHandbookListModel.getSortIdx(b)

	if aIdx ~= bIdx then
		return aIdx < bIdx
	end

	local aCfg = a:getConfig()
	local bCfg = b:getConfig()

	if aCfg.rare ~= bCfg.rare then
		return aCfg.rare > bCfg.rare
	end

	if a.itemId ~= b.itemId then
		return a.itemId < b.itemId
	end
end

function AiZiLaHandbookListModel.getSortIdx(a)
	if AiZiLaModel.instance:isCollectItemId(a.itemId) then
		if a:getQuantity() > 0 then
			return 1
		end

		return 10
	end

	return 100
end

function AiZiLaHandbookListModel:_refreshSelect()
	local selectMO = self:getById(self._selectItemId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function AiZiLaHandbookListModel:setSelect(itemId)
	self._selectItemId = itemId

	self:_refreshSelect()
end

function AiZiLaHandbookListModel:getSelect()
	return self._selectItemId
end

function AiZiLaHandbookListModel:getSelectMO()
	return self:getById(self._selectItemId)
end

AiZiLaHandbookListModel.instance = AiZiLaHandbookListModel.New()

return AiZiLaHandbookListModel
