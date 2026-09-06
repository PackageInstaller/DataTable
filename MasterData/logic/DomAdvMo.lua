-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/model/DomAdvMo.lua

module("logic.extensions.domainadventure.model.DomAdvMo", package.seeall)

local DomAdvMo = class("DomAdvMo")

function DomAdvMo:ctor(activityId)
	self._activityId = activityId
	self._totalCostStrength = 0
	self._todayCostStrength = 0
	self._occupiedGlobalBlockNum = 1
	self._gainGlobalPrizeIds = {}
	self._curStrength = 0
	self._todayGameTimes = 0
	self._personBlockIds = {}
	self._bossInfo = nil
	self._disPetInfoDic = {}
	self._dispatchPetList = {}
	self._blockInfos = {}
	self._gridIdUpdateDic = {}

	local initBlockId = DomainAdventureConfig.instance:getInitBlockId(self._activityId)

	if initBlockId then
		self:_blockInfoUpdateToOccupied(initBlockId)
	end
end

function DomAdvMo:getActivityId()
	return self._activityId
end

function DomAdvMo:handlePM_DomainAdventureGetInfoRes(msg)
	self._totalCostStrength = msg.totalCostStrength
	self._todayCostStrength = checknumber(msg.todayCostStrength)
	self._occupiedGlobalBlockNum = msg.occupiedGlobalBlockNum
	self._curStrength = msg.curStrength
	self._todayGameTimes = msg.todayGameTimes
	self._bossInfo = msg.bossInfo
	self._personBlockIds = {}

	for i, v in ipairs(msg.personBlockIds) do
		self._personBlockIds[v] = true
	end

	for _, blockId in ipairs(msg.personBlockIds) do
		self:_blockInfoUpdateToOccupied(blockId)
	end

	self._gainGlobalPrizeIds = {}

	for _, v in ipairs(msg.gainGlobalPrizeIds) do
		table.insert(self._gainGlobalPrizeIds, v)
	end

	self._dispatchPetList = msg.dispatchPetList
end

function DomAdvMo:handlePM_DomainAdventureLoadMapRes(msg)
	for _, v in ipairs(msg.blockList) do
		self:_blockInfoUpdateData(v.blockId, v)
	end
end

function DomAdvMo:handlePM_DomainAdventureActionRes(msg)
	return
end

function DomAdvMo:handlePM_DomainAdventureGainGlobalPrizeRes(msg)
	table.insert(self._gainGlobalPrizeIds, msg.prizeId)
end

function DomAdvMo:handlePM_DomainAdventureRankViewRes(msg)
	return
end

function DomAdvMo:handlePM_DomainAdventureNotifyActionRes(msg)
	self._curStrength = msg.curStrength
	self._totalCostStrength = msg.totalCostStrength
	self._todayCostStrength = checknumber(msg.todayCostStrength)

	if msg:HasField("bossInfo") then
		self._bossInfo = msg.bossInfo
	end

	local activityId = msg.actionParam.activityId
	local blockId = msg.actionParam.blockId
	local eventType = DomainAdventureConfig.instance:getEventType(activityId, blockId)

	if eventType == DomAdvEnum.EventType_Dispatch then
		self._dispatchPetList = msg.dispatchPetList
	end

	if eventType == DomAdvEnum.EventType_SolveForm then
		self._personBlockIds = {}

		for _, blockId in ipairs(msg.personBlockIds) do
			self._personBlockIds[blockId] = true

			self:_blockInfoUpdateToOccupied(blockId)
		end
	end

	if eventType == DomAdvEnum.EventType_Game and msg:HasField("todayGameTimes") then
		self._todayGameTimes = msg.todayGameTimes
	end

	if msg:HasField("block") then
		self:_blockInfoUpdateData(msg.block.blockId, msg.block)
	end
end

function DomAdvMo:handlePM_DomainAdventureOccupiedChangesRes(msg)
	self._occupiedGlobalBlockNum = msg.occupiedGlobalBlockNum
end

function DomAdvMo:isCanSweetInFight(blockId)
	return self:getMaxDamageInFightInBlock(blockId) > 0
end

function DomAdvMo:_getBlockInfo(blockId)
	if self._blockInfos[blockId] == nil then
		local info = DomAdvGridInfo.New()

		info:onReset(self._activityId, blockId)

		self._blockInfos[blockId] = info
	end

	return self._blockInfos[blockId]
end

function DomAdvMo:getCurPercentageInBlock(blockId)
	local blockInfo = self:_getBlockInfo(blockId)

	return blockInfo:getCurPercentage()
end

function DomAdvMo:getProgressInBlock(blockId)
	local blockInfo = self:_getBlockInfo(blockId)

	return blockInfo:getCurProgress()
end

function DomAdvMo:isOccupiedInBlock(blockId)
	if self._personBlockIds[blockId] then
		return checkbool(self._personBlockIds[blockId])
	end

	local blockInfo = self:_getBlockInfo(blockId)

	return blockInfo:isOccupied()
end

function DomAdvMo:getMaxDamageInFightInBlock(blockId)
	local blockInfo = self:_getBlockInfo(blockId)

	return blockInfo:getMaxDamageInFight()
end

function DomAdvMo:_blockInfoUpdateData(blockId, data)
	local info = self:_getBlockInfo(blockId)

	info:updateData(data)
	self:addGridIdToUpdateDic(blockId)
end

function DomAdvMo:_blockInfoUpdateToOccupied(blockId)
	local info = self:_getBlockInfo(blockId)

	info:updateToOccupied()
	self:addGridIdToUpdateDic(blockId)
end

function DomAdvMo:addGridIdToUpdateDic(blockId)
	self._gridIdUpdateDic[blockId] = true
end

function DomAdvMo:getGridIdUpdateDic()
	return self._gridIdUpdateDic
end

function DomAdvMo:clearGridIdUpdateDic()
	table.clear(self._gridIdUpdateDic)
end

function DomAdvMo:getTotalCostStrength()
	return self._totalCostStrength
end

function DomAdvMo:getTodayCostStrength()
	return self._todayCostStrength
end

function DomAdvMo:getOccupiedGlobalBlockNum()
	return self._occupiedGlobalBlockNum
end

function DomAdvMo:getGainGlobalPrizeIds()
	return self._gainGlobalPrizeIds
end

function DomAdvMo:isGainGlobalPrize(prizeId)
	return table.indexof(self._gainGlobalPrizeIds, prizeId)
end

function DomAdvMo:getCurStrength()
	return self._curStrength
end

function DomAdvMo:getTodayGameTimes()
	return self._todayGameTimes
end

function DomAdvMo:isBossUnlock(gridId)
	local need = self:getMaxBossUnlockCount(gridId)
	local cur = self:getOccupiedGlobalBlockNum()

	return need <= cur
end

function DomAdvMo:isBossEnoughTimes(gridId)
	local cur = self:getDailyFightBossTimesInBoss()
	local max = self:getMaxBossFightTimes(gridId)

	return cur < max
end

function DomAdvMo:getBossInfo()
	return self._bossInfo
end

function DomAdvMo:getDailyFightBossTimesInBoss()
	return (self._bossInfo or nil) and (self._bossInfo.dailyFightBossTimes or 0)
end

function DomAdvMo:getLockPetIdsInBoss()
	return (self._bossInfo or nil) and (self._bossInfo.lockPetIds or {})
end

function DomAdvMo:getHistoryMaxDamageInBoss()
	return (self._bossInfo or nil) and (self._bossInfo.historyMaxDamage or {})
end

function DomAdvMo:getMaxBossUnlockCount(gridId)
	return DomainAdventureConfig.instance:getUnlockBlockCount(self._activityId, gridId)
end

function DomAdvMo:getMaxBossFightTimes(gridId)
	local eventId = DomainAdventureConfig.instance:getEventId(self._activityId, gridId)
	local eventData = DomainAdventureConfig.instance:getBossEventData(self._activityId, eventId)

	return (eventData or nil) and (eventData.dailyTimes or 0)
end

function DomAdvMo:getDsipatchInfo(petId)
	return self._disPetInfoDic[petId]
end

function DomAdvMo:getAllDsipatchInfo()
	return self._disPetInfoDic
end

function DomAdvMo:getDispatchPetList()
	return self._dispatchPetList
end

return DomAdvMo
