-- chunkname: @modules/logic/rouge/model/RougeGameRecordInfoMO.lua

module("modules.logic.rouge.model.RougeGameRecordInfoMO", package.seeall)

local RougeGameRecordInfoMO = pureTable("RougeGameRecordInfoMO")

function RougeGameRecordInfoMO:init(info)
	self.maxDifficulty = info.maxDifficulty
	self.passEndIdMap = self:_listToMap(info.passEndId)
	self.passLayerIdMap = self:_listToMap(info.passLayerId)
	self.passEventIdMap = self:_listToMap(info.passEventId)
	self.passEndIdMap = self:_listToMap(info.passEndId)
	self.passEntrustMap = self:_listToMap(info.passEntrustId)
	self.lastGameTime = math.ceil((tonumber(info.lastGameTime) or 0) / 1000)
	self.passCollections = self:_listToMap(info.passCollections)
	self.unlockStoryIds = self:_listToMap(info.unlockStoryIds)

	self:_updateVersionIds(info.dlcVersionIds)

	self.unlockSkillMap = GameUtil.rpcInfosToMap(info.unlockSkills, RougeUnlockSkillMO, "type")
end

function RougeGameRecordInfoMO:_listToMap(list)
	if not list then
		return {}
	end

	local map = {}

	for _, v in ipairs(list) do
		map[v] = v
	end

	return map
end

function RougeGameRecordInfoMO:collectionIsPass(id)
	return self.passCollections[id]
end

function RougeGameRecordInfoMO:storyIsPass(id)
	return self.unlockStoryIds[id]
end

function RougeGameRecordInfoMO:passedLayerId(layerId)
	return self.passLayerIdMap and self.passLayerIdMap[layerId]
end

function RougeGameRecordInfoMO:passedEventId(eventId)
	return self.passEventIdMap and self.passEventIdMap[eventId]
end

function RougeGameRecordInfoMO:passAnyOneEnd()
	return tabletool.len(self.passEndIdMap) > 0
end

function RougeGameRecordInfoMO:passEndId(endId)
	return self.passEndIdMap and self.passEndIdMap[endId]
end

function RougeGameRecordInfoMO:passEntrustId(entrustId)
	return self.passEntrustMap and self.passEntrustMap[entrustId]
end

function RougeGameRecordInfoMO:passLayerId(layerId)
	return self.passLayerIdMap and self.passLayerIdMap[layerId]
end

function RougeGameRecordInfoMO:lastGameEndTimestamp()
	return self.lastGameTime
end

function RougeGameRecordInfoMO:isSelectDLC(dlcVersionId)
	return self.versionIdMap and self.versionIdMap[dlcVersionId] ~= nil
end

function RougeGameRecordInfoMO:_updateVersionIds(versionIds)
	self.versionIds = {}
	self.versionIdMap = {}

	if versionIds then
		for _, versionId in ipairs(versionIds) do
			table.insert(self.versionIds, versionId)

			self.versionIdMap[versionId] = versionId
		end
	end
end

function RougeGameRecordInfoMO:getVersionIds()
	local versions = {}

	for _, version in ipairs(self.versionIds) do
		table.insert(versions, version)
	end

	return versions
end

function RougeGameRecordInfoMO:isSkillUnlock(skillType, skillId)
	if self.unlockSkillMap then
		return self.unlockSkillMap and self.unlockSkillMap:isSkillUnlock(skillId)
	end
end

function RougeGameRecordInfoMO:updateSkillUnlockInfo(skillType, skillId)
	if not skillType and skillId then
		return
	end

	if self.unlockSkillMap then
		local unlockSkillMo = self.unlockSkillMap[skillType]

		if not unlockSkillMo then
			unlockSkillMo = RougeUnlockSkillMO.New()

			unlockSkillMo:init({
				type = skillType,
				ids = {}
			})

			self.unlockSkillMap[skillType] = unlockSkillMo
		end

		unlockSkillMo:onNewSkillUnlock(skillId)
	end
end

return RougeGameRecordInfoMO
