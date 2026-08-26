-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougeChoiceEventMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougeChoiceEventMO", package.seeall)

local RougeChoiceEventMO = class("RougeChoiceEventMO", RougeBaseEventMO)

function RougeChoiceEventMO:init(eventCo, data)
	RougeChoiceEventMO.super.init(self, eventCo, data)
	self:updateCanChoiceSet()

	self.choiceSelect = self.jsonData.choiceSelect
end

function RougeChoiceEventMO:update(eventCo, data)
	RougeChoiceEventMO.super.update(self, eventCo, data)
	self:updateCanChoiceSet()

	self.choiceSelect = self.jsonData.choiceSelect
end

function RougeChoiceEventMO:updateCanChoiceSet()
	self.canChoiceList = self.jsonData.canChoiceSet

	if self.canChoiceList then
		table.sort(self.canChoiceList, self.sortChoice)
	end
end

function RougeChoiceEventMO:getChoiceIdList()
	return self.canChoiceList
end

function RougeChoiceEventMO.sortChoice(a, b)
	return a < b
end

function RougeChoiceEventMO:__tostring()
	return RougeChoiceEventMO.super.__tostring(self)
end

return RougeChoiceEventMO
