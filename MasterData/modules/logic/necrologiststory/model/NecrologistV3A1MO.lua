-- chunkname: @modules/logic/necrologiststory/model/NecrologistV3A1MO.lua

module("modules.logic.necrologiststory.model.NecrologistV3A1MO", package.seeall)

local NecrologistV3A1MO = class("NecrologistV3A1MO", NecrologistStoryGameBaseMO)

function NecrologistV3A1MO:onInit()
	return
end

function NecrologistV3A1MO:onUpdateData()
	local data = self:getData()
	local initBaseId = NecrologistStoryV3A1Config.instance:getDefaultBaseId()

	self.curBaseId = data.curBaseId or initBaseId
	self.curTime = data.curTime
	self.areaUnlockDict = {}

	if data.areaUnlockList then
		for _, areaId in ipairs(data.areaUnlockList) do
			self.areaUnlockDict[areaId] = true
		end
	end

	local curBaseConfig = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(self.curBaseId)

	self.areaUnlockDict[curBaseConfig.areaId] = true
	self.hasEnterList = {}

	if data.hasEnterList then
		for _, baseId in ipairs(data.hasEnterList) do
			self.hasEnterList[baseId] = true
		end
	end
end

function NecrologistV3A1MO:onSaveData()
	local data = self:getData()

	data.curBaseId = self.curBaseId
	data.curTime = self.curTime
	data.areaUnlockList = {}

	for areaId, _ in pairs(self.areaUnlockDict) do
		table.insert(data.areaUnlockList, areaId)
	end

	data.hasEnterList = {}

	for baseId, _ in pairs(self.hasEnterList) do
		table.insert(data.hasEnterList, baseId)
	end
end

function NecrologistV3A1MO:setBaseEntered(baseId)
	if self:isBaseEntered(baseId) then
		return
	end

	NecrologistStoryRpc.instance:sendFinishNecrologistStoryModeRequest(self.id, baseId)

	self.hasEnterList[baseId] = true

	self:setDataDirty()
end

function NecrologistV3A1MO:isBaseEntered(baseId)
	return self.hasEnterList[baseId] ~= nil
end

function NecrologistV3A1MO:getCurBaseId()
	return self.curBaseId
end

function NecrologistV3A1MO:setCurBaseId(baseId)
	local curBaseId = self:getCurBaseId()

	if curBaseId == baseId then
		return
	end

	self.curBaseId = baseId

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A1_MoveToBase, baseId)
	self:setDataDirty()
end

function NecrologistV3A1MO:getCurTime()
	local time = self.curTime

	if time == nil then
		local curBaseId = self:getCurBaseId()
		local config = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(curBaseId)

		time = config.startTime
		self.curTime = config.startTime
	end

	return time
end

function NecrologistV3A1MO:setTime(time)
	if time == self.curTime then
		return
	end

	self.curTime = time

	self:setDataDirty()
end

function NecrologistV3A1MO:addTime(time)
	local curTime = self:getCurTime()

	self:setTime(curTime + time)
end

function NecrologistV3A1MO:isAreaUnlock(areaId)
	return self.areaUnlockDict[areaId] ~= nil
end

function NecrologistV3A1MO:setAreaUnlock(areaId)
	if self:isAreaUnlock(areaId) then
		return
	end

	self.areaUnlockDict[areaId] = true

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A1_UnlockArea, areaId)
	self:setDataDirty()
end

function NecrologistV3A1MO:onStoryStateChange(storyId, state)
	if state == NecrologistStoryEnum.StoryState.Finish then
		local storyCfg = NecrologistStoryV3A1Config.instance:getStoryConfig(storyId)

		self:tryFinishBase(storyCfg.baseId)
	end
end

function NecrologistV3A1MO:tryFinishBase(baseId)
	local allStoryFinish = self:isBaseAllStoryFinish(baseId)

	if allStoryFinish then
		local config = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(baseId)

		if config.unlockAreaId > 0 then
			self:setAreaUnlock(config.unlockAreaId)
		end
	end
end

function NecrologistV3A1MO:isBaseCanFinish(baseId)
	local allStoryFinish = self:isBaseAllStoryFinish(baseId)

	if allStoryFinish then
		local config = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(baseId)

		if config.unlockAreaId > 0 and self:isAreaUnlock(config.unlockAreaId) then
			return true
		end
	end
end

function NecrologistV3A1MO:isBaseFinish(baseId)
	local config = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(baseId)

	if config.type == NecrologistStoryEnum.BaseType.InteractiveBase then
		return false
	end

	return (self:isBaseAllStoryFinish(baseId))
end

function NecrologistV3A1MO:isBaseAllStoryFinish(baseId, notCheckEnd)
	if not baseId or baseId == 0 then
		return true
	end

	local initBaseId = NecrologistStoryV3A1Config.instance:getDefaultBaseId()
	local storyList = NecrologistStoryV3A1Config.instance:getBaseStoryList(baseId) or {}
	local isInitBase = baseId == initBaseId
	local endStoryId = isInitBase and storyList[#storyList]

	for _, storyId in ipairs(storyList) do
		local storyState = self:getStoryState(storyId)

		if ((storyId == endStoryId and (notCheckEnd or not self:isInEndBase()) or nil) and NecrologistStoryEnum.StoryState.Finish) ~= NecrologistStoryEnum.StoryState.Finish then
			return false
		end
	end

	return true
end

function NecrologistV3A1MO:getCurTargetData()
	if self:isInEndBase() then
		return nil
	end

	local targetList = NecrologistStoryV3A1Config.instance:getBaseTargetList()
	local curBaseId = self:getCurBaseId()
	local curTime = self:getCurTime()
	local data

	for _, config in ipairs(targetList) do
		if curBaseId <= config.id then
			data = {
				isEnter = curBaseId == config.id
			}
			data.isFail = data.isEnter and curTime ~= config.endTime or curTime > config.endTime
			data.config = config

			break
		end
	end

	return data
end

function NecrologistV3A1MO:isInEndBase()
	local curBaseId = self:getCurBaseId()
	local initBaseId = NecrologistStoryV3A1Config.instance:getDefaultBaseId()

	if curBaseId ~= initBaseId then
		return false
	end

	return self:isAreaUnlock(4)
end

function NecrologistV3A1MO:getGameState()
	local curTargetData = self:getCurTargetData()
	local initBaseId = NecrologistStoryV3A1Config.instance:getDefaultBaseId()

	if curTargetData and curTargetData.isFail then
		return NecrologistStoryEnum.GameState.Fail
	end

	local curBaseId = self:getCurBaseId()

	if self:isInEndBase() and self:isBaseAllStoryFinish(curBaseId) then
		return NecrologistStoryEnum.GameState.Win
	end

	return NecrologistStoryEnum.GameState.Normal
end

function NecrologistV3A1MO:resetProgressByFail()
	local curBaseId = self:getCurBaseId()
	local resetId, resetTime = NecrologistStoryV3A1Config.instance:getCurStartTime(curBaseId)

	self.curBaseId = resetId
	self.curTime = resetTime

	self:setDataDirty()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A1_GameReset)
end

function NecrologistV3A1MO:canReset()
	local curBaseId = self:getCurBaseId()
	local resetId, resetTime = NecrologistStoryV3A1Config.instance:getCurStartTime(curBaseId)

	return self.curBaseId ~= resetId or self.curTime ~= resetTime
end

function NecrologistV3A1MO:setIsExitGame(isExit)
	self.isExitGame = isExit
end

function NecrologistV3A1MO:getIsExitGame()
	return self.isExitGame
end

return NecrologistV3A1MO
