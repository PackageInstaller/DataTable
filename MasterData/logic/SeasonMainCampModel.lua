-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonMainCampModel.lua

module("logic.extensions.season.model.SeasonMainCampModel", package.seeall)

local SeasonMainCampModel = class("SeasonMainCampModel", BaseModel)

function SeasonMainCampModel:ctor()
	return
end

function SeasonMainCampModel:onInit()
	self:onReset()
end

function SeasonMainCampModel:onReset()
	self._camplv = 0
	self._hangingStartTime = 0
	self._petGuardInfos = {}
	self._totemInfos = {}
	self._cacheTotemSelectTabId = 1
	self._bHasInitMainCampInfo = false
	self._msg_SMPVEGetMainCampInfoRes_Other = nil
end

function SeasonMainCampModel:isHasInitMainCampInfo()
	return self._bHasInitMainCampInfo
end

function SeasonMainCampModel:updateMainCampInfo(msg)
	self._camplv = msg.camplv
	self._hangingStartTime = checknumber(msg.hangingStartTime)
	self._petGuardInfos = {}

	for _, v in ipairs(msg.petGuardInfos or {}) do
		self._petGuardInfos[v.slotId] = v.raceId
	end

	self._bHasInitMainCampInfo = true
end

function SeasonMainCampModel:updateMainCampInfoOther(msg)
	self._msg_SMPVEGetMainCampInfoRes_Other = msg
end

function SeasonMainCampModel:handleGainHangingPrize(msg)
	self._hangingStartTime = checknumber(msg.hangingStartTime)
end

function SeasonMainCampModel:handleTriggerHangingStartTime(msg)
	self._hangingStartTime = ServerTime.nowMs()
end

function SeasonMainCampModel:handleChangePetGuardRes(msg)
	self._petGuardInfos = self._petGuardInfos or {}

	for _, v in ipairs(msg.infos or {}) do
		self._petGuardInfos[v.slotId] = v.raceId
	end
end

function SeasonMainCampModel:getPetGuardByPos(posId)
	return self._petGuardInfos[posId]
end

function SeasonMainCampModel:updateMainCampLevel(msg)
	self._camplv = msg.camplv
end

function SeasonMainCampModel:getCampLv()
	return self._camplv
end

function SeasonMainCampModel:getHangingStartTime()
	return self._hangingStartTime
end

function SeasonMainCampModel:hasTriggerHangingStartTime()
	return self._hangingStartTime ~= 0
end

function SeasonMainCampModel:getPetGuardUpRate(petMo)
	if petMo then
		local configInstance = SeasonMainCampConfig.instance
		local seasonId = SeasonModel.instance:getSeasonId()
		local mainCampConfig = configInstance:getMainCampConfig(seasonId)
		local config = configInstance:getPetGuardRecommendConfig(mainCampConfig.petGuardPlanId)
		local _, recommendMap = configInstance:getPetGuardRecommendRaceIds(mainCampConfig.petGuardPlanId)
		local _, normalMap = configInstance:getPetGuardNormalRaceIds(mainCampConfig.petGuardPlanId)

		if recommendMap[petMo.raceId] then
			return configInstance:getPetGuardAddition(config.recommendAdditionPlanId, checknumber(petMo.awakenLv)).addPercent
		elseif normalMap[petMo.raceId] then
			return configInstance:getPetGuardAddition(config.normalAdditionPlanId, checknumber(petMo.awakenLv)).addPercent
		end
	end

	return 0
end

function SeasonMainCampModel:hasSetPetAsGuard(raceId)
	for i, v in pairs(self._petGuardInfos) do
		if v == raceId then
			return true
		end
	end

	return false
end

function SeasonMainCampModel:getMainCampInfoResOfOther()
	return self._msg_SMPVEGetMainCampInfoRes_Other
end

function SeasonMainCampModel:getMainCampLevelOfOther()
	return (self._msg_SMPVEGetMainCampInfoRes_Other or nil) and self._msg_SMPVEGetMainCampInfoRes_Other.camplv
end

function SeasonMainCampModel:getPetGuardByPosOfOther(slotId)
	local raceId = 0

	if self._msg_SMPVEGetMainCampInfoRes_Other then
		for i, v in ipairs(self._msg_SMPVEGetMainCampInfoRes_Other.petGuardInfos) do
			if v.slotId == slotId then
				raceId = v.raceId

				break
			end
		end
	end

	return raceId
end

function SeasonMainCampModel:updateAllTotemPoleInfo(userId, msg)
	if self._totemInfos[userId] == nil then
		self._totemInfos[userId] = {}
	end

	for _, v in ipairs(msg.infos) do
		self:updateOneTotemPoleInfo(userId, v)
	end
end

function SeasonMainCampModel:updateOneTotemPoleInfo(userId, msg)
	local info = self._totemInfos[userId][msg.raceType]

	if not info then
		info = self:newOneTotemPoleInfo(msg)
		self._totemInfos[userId][msg.raceType] = info
	end

	info:update(msg)
end

function SeasonMainCampModel:newOneTotemPoleInfo(msg)
	local seasonId = SeasonModel.instance:getSeasonId()
	local totemPolConfig = SeasonMainCampConfig.instance:getTotemPoleConfig(seasonId)
	local totemPoleRaceTypePlanId = totemPolConfig.totemPoleRaceTypePlanId
	local raceTypeConfig = SeasonMainCampConfig.instance:getTotemPoleRaceTypeConfig(totemPoleRaceTypePlanId, msg.raceType)

	return (SeasonTotemMO.New(totemPolConfig.totemPoleRaceTypePlanId, raceTypeConfig.totemItemPlanId, raceTypeConfig.mainTotemPlanId))
end

function SeasonMainCampModel:getTotemPoleInfoByRaceType(userId, raceType)
	if self._totemInfos[userId] then
		return self._totemInfos[userId][raceType]
	end
end

function SeasonMainCampModel:getAllTotemAttrEntry(userId)
	local result = {}

	if self._totemInfos[userId] then
		for raceType, info in pairs(self._totemInfos) do
			local attr = info:getTotalEntry()

			AttrMo.addSameAttrs(attr, result)
		end
	end

	return result
end

function SeasonMainCampModel:getTotemAttrEntryByTabId(userId, tabId)
	local result = {}

	if self._totemInfos[userId] then
		local info = self._totemInfos[userId][tabId]

		if info then
			local attr = info:getTotalEntry()

			AttrMo.addSameAttrs(attr, result)
		end

		return result
	end
end

function SeasonMainCampModel:setCacheTotemSelectTabId(value)
	self._cacheTotemSelectTabId = value
end

function SeasonMainCampModel:getCacheTotemSelectTabId()
	return self._cacheTotemSelectTabId
end

SeasonMainCampModel.instance = SeasonMainCampModel.New()

return SeasonMainCampModel
