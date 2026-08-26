-- chunkname: @modules/logic/necrologiststory/model/NecrologistStoryPlotMO.lua

module("modules.logic.necrologiststory.model.NecrologistStoryPlotMO", package.seeall)

local NecrologistStoryPlotMO = pureTable("NecrologistStoryPlotMO")

function NecrologistStoryPlotMO:init(id)
	self.id = id
	self.config = NecrologistStoryConfig.instance:getPlotGroupCo(id)
	self.state = NecrologistStoryEnum.StoryState.Lock
	self.situationValueDict = {}
	self.plotMarkDict = {}
	self.selectedOptionDict = {}
	self.unlockEndingDict = {}
	self.curOptionDict = {}
	self.curEndingId = 0
end

function NecrologistStoryPlotMO:updateInfo(info)
	self.state = info.state
	self.situationValueDict = {}
	self.selectedOptionDict = {}
	self.unlockEndingDict = {}
	self.curOptionDict = {}
	self.curEndingDict = {}

	for i = 1, #info.values do
		local valData = info.values[i]

		self.situationValueDict[valData.key] = valData.value
	end

	for i = 1, #info.selectedOptions do
		local optionId = info.selectedOptions[i]

		self.selectedOptionDict[optionId] = true
	end

	for i = 1, #info.unlockEndIds do
		local endingId = info.unlockEndIds[i]

		self.unlockEndingDict[endingId] = true
	end

	for i = 1, #info.lastSelectedOptions do
		local optionId = info.lastSelectedOptions[i]

		self.curOptionDict[optionId] = true
	end

	self.curEndingId = info.lastEndId
end

function NecrologistStoryPlotMO:getState()
	return self.state
end

function NecrologistStoryPlotMO:setState(state)
	self.state = state
end

function NecrologistStoryPlotMO:getSituationValueTab()
	return self.situationValueDict
end

function NecrologistStoryPlotMO:setSituationValueTab(dict)
	self.situationValueDict = {}

	local tab = self.situationValueDict

	for key, value in pairs(dict) do
		tab[key] = value
	end
end

function NecrologistStoryPlotMO:setOptionUnlocked(optionId)
	self.selectedOptionDict[optionId] = true
end

function NecrologistStoryPlotMO:setEndingUnlock(endingId)
	self.unlockEndingDict[endingId] = true
end

function NecrologistStoryPlotMO:isOptionUnlocked(optionId)
	return self.selectedOptionDict[optionId] or false
end

function NecrologistStoryPlotMO:isEndingUnlocked(endingId)
	return self.unlockEndingDict[endingId] or false
end

function NecrologistStoryPlotMO:isOptionSelected(optionId)
	return self.curOptionDict[optionId] or false
end

function NecrologistStoryPlotMO:isEndingSelected(endingId)
	return self.curEndingId == endingId
end

function NecrologistStoryPlotMO:resetOptionAndEnding(optionId, optionIds)
	if not optionId then
		self.curOptionDict = {}
		self.curEndingId = 0

		return true
	end

	self.curEndingId = 0

	for key, value in pairs(self.curOptionDict) do
		if optionIds[key] or optionId < key then
			self.curOptionDict[key] = false
		end
	end

	self.curOptionDict[optionId] = true

	return true
end

function NecrologistStoryPlotMO:resetEnding(endingId)
	if self.curEndingId == endingId then
		return false
	end

	self.curEndingId = endingId

	return true
end

function NecrologistStoryPlotMO:getSaveData()
	local data = NecrologistStoryModule_pb.NecrologistStoryPlotInfo()

	data.id = self.id
	data.state = self.state

	for key, value in pairs(self.situationValueDict) do
		local valueData = NecrologistStoryModule_pb.NecrologistStorySituationValue()

		valueData.key = key
		valueData.value = value

		table.insert(data.values, valueData)
	end

	for key, value in pairs(self.selectedOptionDict) do
		table.insert(data.selectedOptions, key)
	end

	for key, value in pairs(self.unlockEndingDict) do
		table.insert(data.unlockEndIds, key)
	end

	data.lastEndId = self.curEndingId

	for key, value in pairs(self.curOptionDict) do
		if value then
			table.insert(data.lastSelectedOptions, key)
		end
	end

	return data
end

return NecrologistStoryPlotMO
