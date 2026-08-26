-- chunkname: @modules/logic/necrologiststory/model/NecrologistStoryGameBaseMO.lua

module("modules.logic.necrologiststory.model.NecrologistStoryGameBaseMO", package.seeall)

local NecrologistStoryGameBaseMO = class("NecrologistStoryGameBaseMO")

function NecrologistStoryGameBaseMO:ctor()
	self.id = nil
	self.data = nil
	self.dataIsDirty = false
	self.isAutoSave = true
end

function NecrologistStoryGameBaseMO:init(id)
	self.id = id
	self.plotInfoDict = {}

	self:onInit()
end

function NecrologistStoryGameBaseMO:updateInfo(info)
	local infoStr = info.info

	self.data = string.nilorempty(infoStr) and {} or cjson.decode(infoStr)
	self.plotInfoDict = {}

	for i = 1, #info.plotInfos do
		local plotInfo = info.plotInfos[i]

		self:updatePlotInfo(plotInfo)
	end

	self:onUpdateData()

	self.dataIsDirty = false

	self:fixStoryData()
end

function NecrologistStoryGameBaseMO:fixStoryData()
	local isDirty = false

	for k, v in pairs(self.plotInfoDict) do
		local curState = v:getState()

		if curState == NecrologistStoryEnum.StoryState.Lock then
			local config = v.config
			local state = self:calStoryStateByPreId(config.preId)

			if state ~= curState then
				v:setState(state)

				isDirty = true
			end
		end
	end

	if isDirty then
		self:setDataDirty()
	end
end

function NecrologistStoryGameBaseMO:getPlotInfo(plotId, createIfNotExist)
	local mo = self.plotInfoDict[plotId]

	if not mo and createIfNotExist then
		mo = NecrologistStoryPlotMO.New()

		mo:init(plotId)

		self.plotInfoDict[plotId] = mo
	end

	return mo
end

function NecrologistStoryGameBaseMO:updatePlotInfo(plotInfo)
	local plotMo = self:getPlotInfo(plotInfo.id, true)

	plotMo:updateInfo(plotInfo)
end

function NecrologistStoryGameBaseMO:getData()
	self.data = self.data or {}

	return self.data
end

function NecrologistStoryGameBaseMO:saveData(callback, callbackObj)
	if not self.dataIsDirty then
		if callback then
			callback(callbackObj)
		end

		return
	end

	self:onSaveData()
	NecrologistStoryRpc.instance:sendUpdateNecrologistStoryRequest(self.id, self, callback, callbackObj)
end

function NecrologistStoryGameBaseMO:setDataDirty()
	self.dataIsDirty = true

	if self.isAutoSave then
		self:saveData()
	end
end

function NecrologistStoryGameBaseMO:getStoryState(storyId)
	local plotMo = self:getPlotInfo(storyId)
	local state = plotMo and plotMo:getState()

	if state == nil then
		local config = NecrologistStoryConfig.instance:getPlotGroupCo(storyId)

		state = self:calStoryStateByPreId(config.preId)
	end

	return state
end

function NecrologistStoryGameBaseMO:calStoryStateByPreId(preId)
	local state

	if preId == 0 then
		state = NecrologistStoryEnum.StoryState.Normal
	else
		local prePlotMo = self:getPlotInfo(preId)
		local preState = prePlotMo and prePlotMo:getState()

		state = preState == NecrologistStoryEnum.StoryState.Finish and NecrologistStoryEnum.StoryState.Normal or NecrologistStoryEnum.StoryState.Lock
	end

	return state
end

function NecrologistStoryGameBaseMO:isStoryFinish(storyId)
	local state = self:getStoryState(storyId)

	return state == NecrologistStoryEnum.StoryState.Finish
end

function NecrologistStoryGameBaseMO:setStoryState(storyId, state)
	local plotMo = self:getPlotInfo(storyId)

	if plotMo then
		local curState = self:getStoryState(storyId)

		if curState == state or curState == NecrologistStoryEnum.StoryState.Finish then
			return
		end
	else
		plotMo = self:getPlotInfo(storyId, true)
	end

	plotMo:setState(state)
	self:onStoryStateChange(storyId, state)

	if state == NecrologistStoryEnum.StoryState.Finish then
		HeroStoryRpc.instance:sendHeroStoryPlotFinishRequest(storyId)
	end

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryStateChange, storyId)
	self:setDataDirty()
end

function NecrologistStoryGameBaseMO:getPlotSituationTab(excludePlotId)
	local dict = {}

	setmetatable(dict, {
		__index = function(t, k)
			return 0
		end
	})

	for plotId, info in pairs(self.plotInfoDict) do
		if plotId ~= excludePlotId then
			for key, value in pairs(info:getSituationValueTab()) do
				dict[key] = dict[key] + value
			end
		end
	end

	return dict
end

function NecrologistStoryGameBaseMO:setPlotSituationTab(plotId, dict)
	local plotMo = self:getPlotInfo(plotId, true)

	plotMo:setSituationValueTab(dict)
	self:setDataDirty()
end

function NecrologistStoryGameBaseMO:setPlotOptionSelected(plotId, optionId, optionIds)
	local plotMo = self:getPlotInfo(plotId, true)
	local isDirty = false

	if not plotMo:isOptionUnlocked(optionId) then
		plotMo:setOptionUnlocked(optionId)

		isDirty = true
	end

	if (self:resetOtherOption(plotId, optionId, optionIds) or nil) and true then
		self:setDataDirty()
	end
end

function NecrologistStoryGameBaseMO:setPlotEndingUnlock(plotId, endingId)
	local plotMo = self:getPlotInfo(plotId, true)
	local isDirty = false

	if not plotMo:isEndingUnlocked(endingId) then
		plotMo:setEndingUnlock(endingId)

		isDirty = true
	end

	if (self:resetOtherEnding(plotId, endingId) or nil) and true then
		self:setDataDirty()
	end
end

function NecrologistStoryGameBaseMO:resetOtherOption(plotId, optionId, optionIds)
	local isDirty = false

	for id, info in pairs(self.plotInfoDict) do
		if plotId < id then
			if info:resetOptionAndEnding() then
				isDirty = true
			end
		elseif id == plotId and info:resetOptionAndEnding(optionId, optionIds) then
			isDirty = true
		end
	end

	return isDirty
end

function NecrologistStoryGameBaseMO:resetOtherEnding(plotId, endingId)
	local isDirty = false

	for id, info in pairs(self.plotInfoDict) do
		if id == plotId then
			if info:resetEnding(endingId) then
				isDirty = true
			end
		elseif info:resetEnding(0) then
			isDirty = true
		end
	end

	return isDirty
end

function NecrologistStoryGameBaseMO:toString()
	return (cjson.encode(self.data))
end

function NecrologistStoryGameBaseMO:onInit()
	return
end

function NecrologistStoryGameBaseMO:onUpdateData()
	return
end

function NecrologistStoryGameBaseMO:onSaveData()
	return
end

function NecrologistStoryGameBaseMO:onStoryStateChange(storyId, state)
	return
end

function NecrologistStoryGameBaseMO:setNecrologistStoryRequest(req)
	req.info = self:toString()

	for plotId, plotMo in pairs(self.plotInfoDict) do
		table.insert(req.plotInfos, plotMo:getSaveData())
	end
end

return NecrologistStoryGameBaseMO
