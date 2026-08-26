-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_GameRecordInfoMO.lua

module("modules.logic.rouge2.outside.model.Rouge2_GameRecordInfoMO", package.seeall)

local Rouge2_GameRecordInfoMO = pureTable("Rouge2_GameRecordInfoMO")

function Rouge2_GameRecordInfoMO:init(info)
	self.maxDifficulty = info.maxDifficulty
	self.passLayerId = info.passLayerId
	self.passEventId = info.passEventId
	self.passEndIdMap = self:_listToMap(info.passEndId)
	self.passLayerIdMap = self:_listToMap(info.passLayerId)
	self.passEventIdMap = self:_listToMap(info.passEventId)
	self.passEndIdMap = self:_listToMap(info.passEndId)
	self.passEntrustMap = self:_listToMap(info.passEntrustId)
	self.lastGameTime = math.ceil((tonumber(info.lastGameTime) or 0) / 1000)
	self.passCollections = self:_listToMap(info.passCollections)
	self.unlockStoryIds = self:_listToMap(info.unlockStoryIds)
	self.unlockIllustrationMap = self:_listToMap(info.unlockIllustrationIds)
end

function Rouge2_GameRecordInfoMO:_listToMap(list)
	if not list then
		return {}
	end

	local map = {}

	for _, v in ipairs(list) do
		map[v] = v
	end

	return map
end

function Rouge2_GameRecordInfoMO:collectionIsPass(id)
	return self.passCollections[id]
end

function Rouge2_GameRecordInfoMO:storyIsPass(id)
	return StoryModel.instance:isStoryHasPlayed(id)
end

function Rouge2_GameRecordInfoMO:passedLayerId(layerId)
	return self.passLayerIdMap and self.passLayerIdMap[layerId]
end

function Rouge2_GameRecordInfoMO:passedEventId(eventId)
	return self.passEventIdMap and self.passEventIdMap[eventId]
end

function Rouge2_GameRecordInfoMO:passAnyOneEnd()
	return tabletool.len(self.passEndIdMap) > 0
end

function Rouge2_GameRecordInfoMO:passEndId(endId)
	return self.passEndIdMap and self.passEndIdMap[endId]
end

function Rouge2_GameRecordInfoMO:passEntrustId(entrustId)
	return self.passEntrustMap and self.passEntrustMap[entrustId]
end

function Rouge2_GameRecordInfoMO:passLayerId(layerId)
	return self.passLayerIdMap and self.passLayerIdMap[layerId]
end

function Rouge2_GameRecordInfoMO:lastGameEndTimestamp()
	return self.lastGameTime
end

return Rouge2_GameRecordInfoMO
