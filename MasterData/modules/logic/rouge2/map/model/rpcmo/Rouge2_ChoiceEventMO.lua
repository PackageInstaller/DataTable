-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_ChoiceEventMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_ChoiceEventMO", package.seeall)

local Rouge2_ChoiceEventMO = class("Rouge2_ChoiceEventMO", Rouge2_BaseEventMO)

function Rouge2_ChoiceEventMO:init(eventCo, data)
	Rouge2_ChoiceEventMO.super.init(self, eventCo, data)
	self:updateCanChoiceSet()
	self:updateJsonData()
end

function Rouge2_ChoiceEventMO:updateJsonData()
	self.choiceSelectList = self.jsonData.choiceSelectList
	self.choiceSelectCheckResList = self.jsonData.choiceSelectCheckResList
	self.curSelect = self.jsonData.curSelect
	self.curCheckRes = self.jsonData.curCheckRes
	self.choiceEpisodeId = self.jsonData.choiceEpisodeId

	self:updateChoiceCheckRateMap()
	self:updateChoiceExSelectMap()
end

function Rouge2_ChoiceEventMO:updateChoiceCheckRateMap()
	self.choiceCheckRateMap = {}

	if self.jsonData.choiceCheckRateMap then
		for choiceId, checkRate in pairs(self.jsonData.choiceCheckRateMap) do
			self.choiceCheckRateMap[tonumber(choiceId)] = checkRate
		end
	end
end

function Rouge2_ChoiceEventMO:updateChoiceExSelectMap()
	self.choiceExSelectMap = {}

	if self.jsonData.choiceExSelectMap then
		for choiceId, exSelectNum in pairs(self.jsonData.choiceExSelectMap) do
			self.choiceExSelectMap[tonumber(choiceId)] = exSelectNum
		end
	end
end

function Rouge2_ChoiceEventMO:update(eventCo, data)
	Rouge2_ChoiceEventMO.super.update(self, eventCo, data)
	self:updateCanChoiceSet()
	self:updateJsonData()
end

function Rouge2_ChoiceEventMO:updateCanChoiceSet()
	self.canChoiceList = self.jsonData.canChoiceSet

	if self.canChoiceList then
		table.sort(self.canChoiceList, self.sortChoice)
	end
end

function Rouge2_ChoiceEventMO:getChoiceIdList()
	return self.canChoiceList
end

function Rouge2_ChoiceEventMO:getCurCheckResult()
	return self.curCheckRes
end

function Rouge2_ChoiceEventMO:getChoiceEpisodeId()
	return self.choiceEpisodeId
end

function Rouge2_ChoiceEventMO:getChoiceSelectList()
	return self.choiceSelectList
end

function Rouge2_ChoiceEventMO:getChoiceSelectCheckResList()
	return self.choiceSelectCheckResList
end

function Rouge2_ChoiceEventMO:getChoiceCheckRate(choiceId)
	return self.choiceCheckRateMap and self.choiceCheckRateMap[choiceId]
end

function Rouge2_ChoiceEventMO:isCanExSelect(choiceId)
	if self.choiceExSelectMap then
		return self.choiceExSelectMap ~= 0
	end
end

function Rouge2_ChoiceEventMO:getChoiceSelectNum(choiceId)
	local selectNum = 0

	if self.choiceSelectList then
		for _, selectChoiceId in ipairs(self.choiceSelectList) do
			if selectChoiceId == choiceId then
				selectNum = selectNum + 1
			end
		end
	end

	return selectNum
end

function Rouge2_ChoiceEventMO:getCurSelectChoiceId()
	return self.curSelect
end

function Rouge2_ChoiceEventMO.sortChoice(a, b)
	return a < b
end

function Rouge2_ChoiceEventMO:__tostring()
	return Rouge2_ChoiceEventMO.super.__tostring(self)
end

return Rouge2_ChoiceEventMO
