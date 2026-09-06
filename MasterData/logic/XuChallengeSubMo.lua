-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/data/XuChallengeSubMo.lua

module("logic.extensions.xuchallenge.data.XuChallengeSubMo", package.seeall)

local XuChallengeSubMo = class("XuChallengeSubMo")

function XuChallengeSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function XuChallengeSubMo:_resetData()
	self:_resetEverPassStageData()
	self:_resetChallengeData()
	self:_resetBindDraftData()
end

function XuChallengeSubMo:_resetChallengeData()
	self._maxPassStage = 0
	self._stageIds = {}
	self._bindRaceIds = {}
	self._sacrificeRaceIds = {}
	self._serverStageToPetIds = {}
	self._serverStageToPetIdMap = {}
	self._previewChallengeStageId = 0
	self._previewStageToRaceIds = {}
	self._previewStageToRaceIdMap = {}
end

function XuChallengeSubMo:_resetBindDraftData()
	self._bindDraftStageToRaceIds = {}
	self._bindDraftStageToRaceIdMap = {}
end

function XuChallengeSubMo:_resetEverPassStageData()
	self._everPassStageIds = {}
	self._everPassStageIdMap = {}
end

function XuChallengeSubMo:dispose()
	self:_resetData()
end

function XuChallengeSubMo:handlePM_XuChallengeInfoRes(msg)
	self:_resetChallengeData()
	self:_resetEverPassStageData()

	self._activityId = msg.activityId
	self._maxPassStage = msg.maxPassStage

	for _, stageId in ipairs(msg.everPassStageIds or {}) do
		self:_appendEverPassStageId(stageId)
	end

	for _, stageInfo in ipairs(msg.stageInfos) do
		local stageId = stageInfo.stageId

		table.insert(self._stageIds, stageId)

		self._bindRaceIds[stageId] = stageInfo.bindRaceId
		self._sacrificeRaceIds[stageId] = {}

		for _, raceId in ipairs(stageInfo.sacrificeRaceIds) do
			table.insert(self._sacrificeRaceIds[stageId], raceId)
		end
	end

	if self:_isAllServerStageBound() then
		self:_resetBindDraftData()
	end
end

function XuChallengeSubMo:handlePM_XuChallengeNotifyClgRes(msg)
	if checkbool(msg.isWin) then
		self:_appendSacrificeRaceIdsByServerDiff(msg.stageToPetId)
		self:_setServerStageToPetIdState(msg.stageToPetId)
		self:_clearPreviewStageToRaceIdState()

		self._maxPassStage = math.max(self._maxPassStage, msg.stageId)

		self:_appendEverPassStageId(msg.stageId)
	end
end

function XuChallengeSubMo:handlePM_XuChallengeResetRes(msg)
	self._activityId = msg.activityId

	self:_resetChallengeData()
	self:_resetBindDraftData()
end

function XuChallengeSubMo:handlePM_XuChallengeReplacePetRes(msg)
	self._activityId = msg.activityId

	self:_setServerStageToPetIdState(msg.stageToPetId)
	self:_clearPreviewStageToRaceIdState()
	self:_resetBindDraftData()
end

function XuChallengeSubMo:_setServerStageToPetIdState(stageToPetId)
	local list, map = self:_buildStageToPetIdState(stageToPetId)

	self._serverStageToPetIds = list
	self._serverStageToPetIdMap = map

	self:_syncStageIdsByStageToPetIdState(list)
	self:_syncBindRaceIdsByStageToPetIdState(list)
end

function XuChallengeSubMo:_setPreviewStageToRaceIdState(challengeStageId, stageToRaceId)
	local list, map = self:_buildStageToRaceIdState(stageToRaceId)

	self._previewChallengeStageId = checknumber(challengeStageId)
	self._previewStageToRaceIds = list
	self._previewStageToRaceIdMap = map
end

function XuChallengeSubMo:_clearPreviewStageToRaceIdState()
	self._previewChallengeStageId = 0
	self._previewStageToRaceIds = {}
	self._previewStageToRaceIdMap = {}
end

function XuChallengeSubMo:_appendEverPassStageId(stageId)
	stageId = checknumber(stageId)

	if stageId <= 0 or self._everPassStageIdMap[stageId] then
		return
	end

	table.insert(self._everPassStageIds, stageId)

	self._everPassStageIdMap[stageId] = true
end

function XuChallengeSubMo:_buildStageToPetIdState(stageToPetId)
	local list = {}
	local map = {}

	for _, v in ipairs(stageToPetId or {}) do
		local stageId = checknumber((not v.stageId or nil) and v.left)
		local petId = checknumber((not v.petId or nil) and v.right)
		local data = {
			stageId = stageId,
			petId = petId
		}

		if stageId > 0 then
			table.insert(list, data)

			map[stageId] = petId
		end
	end

	return list, map
end

function XuChallengeSubMo:_buildStageToPetIdListFromMap(map)
	local result = {}
	local addedStageIds = {}

	for _, stageId in ipairs(self._stageIds or {}) do
		local petId = map[stageId]

		if petId ~= nil then
			table.insert(result, {
				stageId = stageId,
				petId = petId
			})

			addedStageIds[stageId] = true
		end
	end

	for stageId, petId in pairs(map or {}) do
		if not addedStageIds[stageId] then
			table.insert(result, {
				stageId = stageId,
				petId = petId
			})
		end
	end

	return result
end

function XuChallengeSubMo:_buildStageToRaceIdState(stageToRaceId)
	local list = {}
	local map = {}

	for _, v in ipairs(stageToRaceId or {}) do
		local stageId = checknumber((not v.stageId or nil) and v.left)
		local raceId = checknumber((not v.raceId or nil) and v.right)

		if stageId > 0 and raceId > 0 then
			table.insert(list, {
				stageId = stageId,
				raceId = raceId
			})

			map[stageId] = raceId
		end
	end

	return list, map
end

function XuChallengeSubMo:_copyStageToPetIdList(list)
	local result = {}

	for _, data in ipairs(list or {}) do
		table.insert(result, {
			stageId = data.stageId,
			petId = data.petId
		})
	end

	return result
end

function XuChallengeSubMo:_copyStageToRaceIdList(list)
	local result = {}

	for _, data in ipairs(list or {}) do
		table.insert(result, {
			stageId = data.stageId,
			raceId = data.raceId
		})
	end

	return result
end

function XuChallengeSubMo:_buildStageToRaceIdListFromMap(map)
	local result = {}
	local addedStageIds = {}

	for _, stageId in ipairs(self._stageIds or {}) do
		local raceId = map[stageId]

		if raceId ~= nil then
			table.insert(result, {
				stageId = stageId,
				raceId = raceId
			})

			addedStageIds[stageId] = true
		end
	end

	for stageId, raceId in pairs(map or {}) do
		if not addedStageIds[stageId] then
			table.insert(result, {
				stageId = stageId,
				raceId = raceId
			})
		end
	end

	return result
end

function XuChallengeSubMo:_syncStageIdsByStageToPetIdState(list)
	local stageIdMap = {}

	self._stageIds = self._stageIds or {}
	self._sacrificeRaceIds = self._sacrificeRaceIds or {}

	for _, stageId in ipairs(self._stageIds or {}) do
		stageIdMap[checknumber(stageId)] = true
	end

	for _, data in ipairs(list or {}) do
		local stageId = checknumber(data.stageId)

		if stageId > 0 then
			if not stageIdMap[stageId] then
				table.insert(self._stageIds, stageId)

				stageIdMap[stageId] = true
			end

			self._sacrificeRaceIds[stageId] = self._sacrificeRaceIds[stageId] or {}
		end
	end
end

function XuChallengeSubMo:_syncBindRaceIdsByStageToPetIdState(list)
	for _, data in ipairs(list or {}) do
		local stageId = checknumber(data.stageId)
		local petId = checknumber(data.petId)

		if stageId > 0 then
			self._bindRaceIds[stageId] = self:_getRaceIdByPetId(petId)
		end
	end
end

function XuChallengeSubMo:_appendSacrificeRaceIdsByServerDiff(stageToPetId)
	local _, newMap = self:_buildStageToPetIdState(stageToPetId)

	for stageId, newPetId in pairs(newMap) do
		local oldRaceId = self:_getServerRaceIdByStageId(stageId)
		local newRaceId = self:_getRaceIdByPetId(newPetId)
		local isChanged = oldRaceId > 0 and oldRaceId ~= newRaceId

		if isChanged then
			self:_appendSacrificeRaceId(stageId, oldRaceId)
		end
	end
end

function XuChallengeSubMo:_appendSacrificeRaceId(stageId, raceId)
	stageId = checknumber(stageId)
	raceId = checknumber(raceId)

	if stageId <= 0 or raceId <= 0 then
		return
	end

	self._sacrificeRaceIds[stageId] = self._sacrificeRaceIds[stageId] or {}

	for _, existRaceId in ipairs(self._sacrificeRaceIds[stageId]) do
		if checknumber(existRaceId) == raceId then
			return
		end
	end

	table.insert(self._sacrificeRaceIds[stageId], raceId)
end

function XuChallengeSubMo:_getRaceIdByPetId(petId)
	petId = checknumber(petId)

	if petId <= 0 then
		return 0
	end

	local petMo = BagPetsController.instance:getPet(petId)

	if petMo == nil then
		return 0
	end

	return checknumber(petMo.raceId)
end

function XuChallengeSubMo:_getServerRaceIdByStageId(stageId)
	stageId = checknumber(stageId)

	if stageId <= 0 then
		return 0
	end

	local raceId = self:_getRaceIdByPetId(self._serverStageToPetIdMap[stageId])

	if raceId > 0 then
		return raceId
	end

	return checknumber(self._bindRaceIds[stageId])
end

function XuChallengeSubMo:_isAllServerStageBound()
	if self._stageIds == nil or #self._stageIds <= 0 then
		return false
	end

	for _, stageId in ipairs(self._stageIds) do
		if checknumber(self._bindRaceIds[stageId]) <= 0 then
			return false
		end
	end

	return true
end

function XuChallengeSubMo:getActivityId()
	return self._activityId
end

function XuChallengeSubMo:getMaxPassStage()
	return self._maxPassStage
end

function XuChallengeSubMo:getCurrentChallengeStageId()
	return self._maxPassStage + 1
end

function XuChallengeSubMo:getStageIds()
	return self._stageIds
end

function XuChallengeSubMo:getEverPassStageIds()
	local result = {}

	for _, stageId in ipairs(self._everPassStageIds or {}) do
		table.insert(result, stageId)
	end

	return result
end

function XuChallengeSubMo:isEverPassStage(stageId)
	return self._everPassStageIdMap[checknumber(stageId)] == true
end

function XuChallengeSubMo:isAllStageEverPass(stageIds)
	if stageIds == nil or #stageIds <= 0 then
		return false
	end

	for _, stageId in ipairs(stageIds) do
		if not self:isEverPassStage(stageId) then
			return false
		end
	end

	return true
end

function XuChallengeSubMo:getBindRaceId(stageId)
	return self._bindRaceIds[stageId] or 0
end

function XuChallengeSubMo:isHasBindRaceId(stageId)
	return self:getBindRaceId(stageId) > 0
end

function XuChallengeSubMo:getSacrificeRaceIds(stageId)
	return self._sacrificeRaceIds[stageId] or {}
end

function XuChallengeSubMo:getTotalSacrificeRaceIdCount()
	local count = 0

	for _, raceIds in pairs(self._sacrificeRaceIds) do
		count = count + #(raceIds or {})
	end

	return count
end

function XuChallengeSubMo:getServerStageToPetIds()
	return self:_copyStageToPetIdList(self._serverStageToPetIds)
end

function XuChallengeSubMo:getServerPetIdByStageId(stageId)
	return self._serverStageToPetIdMap[stageId]
end

function XuChallengeSubMo:getBindDraftStageToRaceIds()
	return self:_copyStageToRaceIdList(self._bindDraftStageToRaceIds)
end

function XuChallengeSubMo:getBindDraftRaceIdByStageId(stageId)
	return self._bindDraftStageToRaceIdMap[stageId]
end

function XuChallengeSubMo:getBindDraftStageIdByRaceId(raceId)
	raceId = checknumber(raceId)

	if raceId <= 0 then
		return 0
	end

	for _, data in ipairs(self._bindDraftStageToRaceIds or {}) do
		if checknumber(data.raceId) == raceId then
			return checknumber(data.stageId)
		end
	end

	return 0
end

function XuChallengeSubMo:setBindDraftRaceIdByStageId(stageId, raceId)
	stageId = checknumber(stageId)
	raceId = checknumber(raceId)

	if stageId <= 0 then
		return
	end

	if raceId > 0 then
		for oldStageId, oldRaceId in pairs(self._bindDraftStageToRaceIdMap) do
			if oldStageId ~= stageId and checknumber(oldRaceId) == raceId then
				self._bindDraftStageToRaceIdMap[oldStageId] = nil
			end
		end

		self._bindDraftStageToRaceIdMap[stageId] = raceId
	else
		self._bindDraftStageToRaceIdMap[stageId] = nil
	end

	self._bindDraftStageToRaceIds = self:_buildStageToRaceIdListFromMap(self._bindDraftStageToRaceIdMap)
end

function XuChallengeSubMo:removeBindDraftRaceIdByStageId(stageId)
	self:setBindDraftRaceIdByStageId(stageId, 0)
end

function XuChallengeSubMo:clearBindDraftStageToRaceIds()
	self:_resetBindDraftData()
end

function XuChallengeSubMo:setPreviewStageToRaceIds(challengeStageId, stageToRaceId)
	self:_setPreviewStageToRaceIdState(challengeStageId, stageToRaceId)
end

function XuChallengeSubMo:setPreviewRaceIdByStageId(challengeStageId, stageId, raceId)
	stageId = checknumber(stageId)
	raceId = checknumber(raceId)

	if stageId <= 0 then
		return
	end

	self:ensurePreviewStageToRaceIds(challengeStageId)

	self._previewStageToRaceIdMap[stageId] = raceId > 0 and raceId or nil
	self._previewStageToRaceIds = self:_buildStageToRaceIdListFromMap(self._previewStageToRaceIdMap)
end

function XuChallengeSubMo:setPreviewPetIdByStageId(challengeStageId, stageId, petId)
	self:setPreviewRaceIdByStageId(challengeStageId, stageId, self:_getRaceIdByPetId(petId))
end

function XuChallengeSubMo:ensurePreviewStageToRaceIds(challengeStageId)
	challengeStageId = checknumber(challengeStageId)

	if self._previewChallengeStageId ~= challengeStageId then
		self._previewChallengeStageId = challengeStageId
		self._previewStageToRaceIds = {}
		self._previewStageToRaceIdMap = {}
	end
end

function XuChallengeSubMo:clearPreviewStageToRaceIds()
	self:_clearPreviewStageToRaceIdState()
end

function XuChallengeSubMo:getPreviewChallengeStageId()
	return self._previewChallengeStageId
end

function XuChallengeSubMo:getPreviewStageToRaceIds()
	return self:_copyStageToRaceIdList(self._previewStageToRaceIds)
end

function XuChallengeSubMo:getPreviewRaceIdByStageId(stageId)
	return self._previewStageToRaceIdMap[stageId]
end

function XuChallengeSubMo:getEffectiveRaceIdByStageId(stageId)
	local previewRaceId = checknumber(self:getPreviewRaceIdByStageId(stageId))

	if previewRaceId > 0 then
		return previewRaceId
	end

	return self:_getServerRaceIdByStageId(stageId)
end

function XuChallengeSubMo:_getPreviewDiffStageCount()
	local count = 0

	for stageId, _ in pairs(self._previewStageToRaceIdMap) do
		if self:_isPreviewStageRaceIdChanged(stageId) then
			count = count + 1
		end
	end

	return count
end

function XuChallengeSubMo:_isPreviewStageRaceIdChanged(stageId)
	local oldRaceId = self:_getServerRaceIdByStageId(stageId)
	local newRaceId = checknumber(self._previewStageToRaceIdMap[stageId])

	return oldRaceId ~= newRaceId
end

function XuChallengeSubMo:getPreviewSacrificeCount()
	return self:_getPreviewDiffStageCount()
end

function XuChallengeSubMo:isPreviewSacrificeCountInLimit(maxCount)
	return self:getPreviewSacrificeCount() <= checknumber(maxCount)
end

function XuChallengeSubMo:isPreviewDirty()
	return self:_getPreviewDiffStageCount() > 0
end

return XuChallengeSubMo
