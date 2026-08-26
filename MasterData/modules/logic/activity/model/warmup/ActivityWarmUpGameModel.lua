-- chunkname: @modules/logic/activity/model/warmup/ActivityWarmUpGameModel.lua

module("modules.logic.activity.model.warmup.ActivityWarmUpGameModel", package.seeall)

local ActivityWarmUpGameModel = class("ActivityWarmUpGameModel", BaseModel)

function ActivityWarmUpGameModel:onInit()
	return
end

function ActivityWarmUpGameModel:reInit()
	return
end

function ActivityWarmUpGameModel:release()
	self._settings = nil
	self._blockDatas = nil
	self._matDatas = nil
	self._bindMap = nil
	self._targetMatList = nil
	self.curMatIndex = 0
end

function ActivityWarmUpGameModel:init(settings, totalPoolIds, keepPointerValue)
	self:release()

	self._settings = settings

	if self:checkParamAvalid() then
		self._blockDatas = self:genLevelData()
	end

	if not keepPointerValue then
		self.pointerVal = 0.5
	end

	self:initMatTarget(totalPoolIds)
	self:bindMaterials()
end

function ActivityWarmUpGameModel:initMatTarget(totalPoolIds)
	if #totalPoolIds <= 0 then
		logError("totalPoolIds length can't be Zero!")

		return
	end

	self._matDatas = tabletool.copy(totalPoolIds)
	self._targetMatList = {}
	self.curMatIndex = 1

	local copyIds = tabletool.copy(totalPoolIds)

	for i = 1, self._settings.blockCount do
		local len = #copyIds

		if len <= 0 then
			for k, v in pairs(totalPoolIds) do
				copyIds[k] = v
			end

			len = #copyIds
		end

		local rndIndex = math.random(len)
		local matId = copyIds[rndIndex]

		table.insert(self._targetMatList, matId)
		table.remove(copyIds, rndIndex)
	end
end

function ActivityWarmUpGameModel:bindMaterials()
	self._bindMap = {}

	local copyIds = tabletool.copy(self._targetMatList)

	for i, levelData in ipairs(self._blockDatas) do
		local len = #copyIds
		local rndIndex = math.random(len)

		self._bindMap[levelData] = copyIds[rndIndex]

		table.remove(copyIds, rndIndex)
	end
end

function ActivityWarmUpGameModel:getBlockDataByPointer(pointerValue)
	for _, data in ipairs(self._blockDatas) do
		if pointerValue >= data.startPos then
			if pointerValue <= data.endPos then
				return data
			end
		else
			return nil
		end
	end
end

function ActivityWarmUpGameModel:isCurrentTarget(levelData)
	local matId = self._bindMap[levelData]

	if matId == self._targetMatList[self.curMatIndex] then
		return true
	end

	return false
end

function ActivityWarmUpGameModel:matIsUsed(matId)
	for index, targetId in ipairs(self._targetMatList) do
		if index >= self.curMatIndex then
			return false
		end

		if targetId == matId then
			return true
		end
	end

	return false
end

function ActivityWarmUpGameModel:gotoNextTarget()
	self.curMatIndex = self.curMatIndex + 1
end

function ActivityWarmUpGameModel:isAllTargetClean()
	return self.curMatIndex > self._settings.blockCount
end

function ActivityWarmUpGameModel:getBlockDatas()
	return self._blockDatas
end

function ActivityWarmUpGameModel:getTargetMatIDs()
	return self._targetMatList
end

function ActivityWarmUpGameModel:getBindMatByBlock(blockData)
	return self._bindMap[blockData]
end

function ActivityWarmUpGameModel:getRoundInfo()
	if self._settings ~= nil then
		return self.round, self._settings.victoryRound
	end

	return nil
end

function ActivityWarmUpGameModel:genLevelData()
	local buckets = self:step1BreakInterval()
	local results = self:step2PickBasePos(buckets)

	self:step3Grow(results)

	return results
end

function ActivityWarmUpGameModel:step1BreakInterval()
	local minInterval = self._settings.minBlock + self._settings.blockInterval
	local count = math.floor(1 / minInterval)
	local splitArr = {}

	if count > 200 then
		logWarn("ActivityWarmUpGameModel data amount over 200!")
	end

	for i = 1, count do
		table.insert(splitArr, (i - 1) * minInterval)
	end

	return splitArr
end

function ActivityWarmUpGameModel:step2PickBasePos(buckets)
	local needCount = self._settings.blockCount
	local blockArr = {}

	for i = 1, needCount do
		local blockData = {}
		local bucketIndex = math.random(#buckets)

		blockData.startPos = buckets[bucketIndex] + self._settings.blockInterval

		table.remove(buckets, bucketIndex)

		blockData.endPos = blockData.startPos + self._settings.minBlock

		table.insert(blockArr, blockData)
	end

	table.sort(blockArr, ActivityWarmUpGameModel.sortBlockWithPos)

	return blockArr
end

function ActivityWarmUpGameModel:step3Grow(blocks)
	for i = #blocks, 1, -1 do
		local curBlock = blocks[i]

		self:growSingleBlock(curBlock, blocks, i)
	end
end

function ActivityWarmUpGameModel:growSingleBlock(curBlock, blocks, index)
	local next = blocks[index + 1]
	local randomSpace = ((next or nil) and next.startPos - self._settings.blockInterval) - curBlock.endPos
	local expandSpace = math.min(randomSpace, self._settings.randomLength)
	local expandValue = math.random() * expandSpace

	curBlock.endPos = curBlock.endPos + expandValue
	randomSpace = randomSpace - expandValue

	if randomSpace > 0 then
		local rnd = math.random()

		if rnd >= self._settings.stayProb then
			local offset = randomSpace * math.random()

			curBlock.startPos = curBlock.startPos + offset
			curBlock.endPos = curBlock.endPos + offset
		end
	end
end

function ActivityWarmUpGameModel.sortBlockWithPos(a, b)
	return a.startPos < b.startPos
end

function ActivityWarmUpGameModel:checkParamAvalid()
	local maxInterval = self._settings.minBlock + self._settings.blockInterval

	if maxInterval * self._settings.blockCount >= 1 then
		logError("generate param error, min interval too large!")

		return false
	end

	return true
end

ActivityWarmUpGameModel.instance = ActivityWarmUpGameModel.New()

return ActivityWarmUpGameModel
