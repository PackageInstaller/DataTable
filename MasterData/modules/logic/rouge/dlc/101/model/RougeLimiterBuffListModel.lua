-- chunkname: @modules/logic/rouge/dlc/101/model/RougeLimiterBuffListModel.lua

module("modules.logic.rouge.dlc.101.model.RougeLimiterBuffListModel", package.seeall)

local RougeLimiterBuffListModel = class("RougeLimiterBuffListModel", ListScrollModel)

function RougeLimiterBuffListModel:onInit(buffType)
	local buffList = self:getBuffCosByType(buffType)

	self:setList(buffList)
	self:try2SelectEquipedBuff()
end

function RougeLimiterBuffListModel:getBuffCosByType(buffType)
	local versions = RougeModel.instance:getVersion()
	local buffCos = RougeDLCConfig101.instance:getAllLimiterBuffCosByType(versions, buffType)
	local result = {}

	if buffCos then
		for _, buffCo in ipairs(buffCos) do
			table.insert(result, buffCo)
		end
	end

	table.sort(result, self._buffSortFunc)

	return result
end

function RougeLimiterBuffListModel._buffSortFunc(aBuffCo, bBuffCo)
	local isABlank = aBuffCo.blank == 1
	local isBBlank = bBuffCo.blank == 1

	if isABlank ~= isBBlank then
		return isABlank
	end

	return aBuffCo.id < bBuffCo.id
end

function RougeLimiterBuffListModel:try2SelectEquipedBuff()
	local buffIndex, equipedBuffId = self:getEquipedBuffId()

	self:selectCell(buffIndex, true)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.OnSelectBuff, equipedBuffId, true)
end

function RougeLimiterBuffListModel:getEquipedBuffId()
	local buffCos = self:getList()

	for index, buffCo in ipairs(buffCos) do
		local buffState = RougeDLCModel101.instance:getLimiterBuffState(buffCo.id)

		if buffState == RougeDLCEnum101.BuffState.Equiped then
			return index, buffCo.id
		end
	end
end

RougeLimiterBuffListModel.instance = RougeLimiterBuffListModel.New()

return RougeLimiterBuffListModel
