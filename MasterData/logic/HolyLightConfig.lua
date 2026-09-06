-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/config/HolyLightConfig.lua

module("logic.extensions.holylight.config.HolyLightConfig", package.seeall)

local HolyLightConfig = class("HolyLightConfig", BaseConfig)

function HolyLightConfig:onInit()
	HolyLightConfig.super.onInit(self)
end

function HolyLightConfig:getNames()
	return {
		"holy_light_base",
		"holy_light_common",
		"holy_light_grid",
		"holy_light_piece",
		"holy_light_event",
		"holy_light_finish",
		"holy_light_refresh",
		"holy_light_dice",
		"holy_light_pet",
		"holy_light_master",
		"holy_light_creeps",
		"holy_light_buff"
	}
end

function HolyLightConfig:handleConfig(name, content)
	if name == "holy_light_base" then
		self._hlBaseCfg = content
	elseif name == "holy_light_common" then
		self._hlCommonCfg = content
	elseif name == "holy_light_grid" then
		self._hlGridCfgs = content
	elseif name == "holy_light_piece" then
		self._hlPieceCfg = content
	elseif name == "holy_light_event" then
		self._hlEventCfg = content
	elseif name == "holy_light_finish" then
		self._hlFinishCfgs = content
	elseif name == "holy_light_refresh" then
		self._hlRefreshCfgs = content
	elseif name == "holy_light_dice" then
		self._hlDiceCfgs = content
	elseif name == "holy_light_pet" then
		self._hlPetCfgss = content
	elseif name == "holy_light_master" then
		self._hlMasterCfg = content
	elseif name == "holy_light_creeps" then
		self._hlCreepsCfgs = content
	elseif name == "holy_light_buff" then
		self._hlBuffCfgs = content
	end
end

function HolyLightConfig:getHlBaseData(activityId)
	return self._hlBaseCfg[activityId]
end

function HolyLightConfig:getHlCommonValue(key, isToNumber)
	local data = self._hlCommonCfg[key]
	local value = data and data.value

	return isToNumber and checknumber(value) or value
end

function HolyLightConfig:getHlGridCfg(activityId)
	local gridPlanId = self:getHlBaseData(activityId).gridPlanId

	return self._hlGridCfgs[gridPlanId]
end

function HolyLightConfig:getHlGridData(activityId, gridId)
	return self:getHlGridCfg(activityId)[gridId]
end

function HolyLightConfig:getHlPieceData(pieceId)
	return self._hlPieceCfg[pieceId]
end

function HolyLightConfig:getHlPieceDataById(activityId, gridId)
	local pieceId = self:getHlGridData(activityId, gridId).pieceId

	return self._hlPieceCfg[pieceId]
end

function HolyLightConfig:getHlEventData(eventId)
	return self._hlEventCfg[eventId]
end

function HolyLightConfig:getHlEventDataById(activityId, gridId)
	local gridData = self:getHlGridData(activityId, gridId)

	return self:getHlEventData(gridData.eventId)
end

function HolyLightConfig:getHlFinishCfg(activityId)
	local finishPlanId = self:getHlBaseData(activityId).finishPlanId

	return self._hlFinishCfgs[finishPlanId]
end

function HolyLightConfig:getHlFinishData(activityId, finishId)
	return self:getHlFinishCfg(activityId)[finishId]
end

function HolyLightConfig:getHlFinishIdWithTimes(activityId, times)
	local finishId = 0
	local cfg = self:getHlFinishCfg(activityId)

	for _, data in ipairs(cfg) do
		if times >= data.times then
			finishId = data.finishId
		else
			break
		end
	end

	return finishId
end

function HolyLightConfig:getHlRefreshCfg(activityId)
	local refreshPlanId = self:getHlBaseData(activityId).refreshPlanId

	return self._hlRefreshCfgs[refreshPlanId]
end

function HolyLightConfig:getHlRefreshData(activityId, refreshId)
	return self:getHlRefreshCfg(activityId)[refreshId]
end

function HolyLightConfig:getHlRefreshDataByTimes(activityId, times)
	local res
	local cfg = self:getHlRefreshCfg(activityId)

	for _, data in ipairs(cfg) do
		if times >= data.times then
			res = data
		else
			break
		end
	end

	return res
end

function HolyLightConfig:getHlDiceCfg(activityId)
	local dicePlanId = self:getHlBaseData(activityId).dicePlanId

	return self._hlDiceCfgs[dicePlanId]
end

function HolyLightConfig:getHlDiceData(activityId, diceId)
	return self:getHlDiceCfg(activityId)[diceId]
end

function HolyLightConfig:getHlDiceNum(activityId)
	local cfg = self:getHlDiceCfg(activityId)

	return #cfg
end

function HolyLightConfig:getHlPetCfgs(activityId)
	local petPlanId = self:getHlBaseData(activityId).petPlanId

	return self._hlPetCfgss[petPlanId]
end

function HolyLightConfig:getHlPetCfg(activityId, creepsId)
	return self:getHlPetCfgs(activityId)[creepsId]
end

function HolyLightConfig:getHlPetData(activityId, creepsId, level)
	return self:getHlPetCfg(activityId, creepsId)[level]
end

function HolyLightConfig:getHlPetMaxLevel(activityId, creepsId)
	local cfg = self:getHlPetCfg(activityId, creepsId)

	return #cfg
end

function HolyLightConfig:getHlMasterCfg(activityId)
	local masterPlanId = self:getHlBaseData(activityId).masterPlanId

	return self._hlMasterCfg[masterPlanId]
end

function HolyLightConfig:getHlMasterData(activityId, masterId)
	return self:getHlMasterCfg(activityId)[masterId]
end

function HolyLightConfig:getHlMasterMaxId(activityId)
	local maxData = self:getHlMasterData(activityId, #self:getHlMasterCfg(activityId))

	return maxData.masterId
end

function HolyLightConfig:getHlCreepsCfg(creepsMasterId)
	return self._hlCreepsCfgs[creepsMasterId]
end

function HolyLightConfig:getHlCreepsData(creepsMasterId, creepsId)
	return self._hlCreepsCfgs[creepsMasterId][creepsId]
end

function HolyLightConfig:getHlCreepsDataById(activityId, times, creepsId)
	local masterData = self:getHlMasterData(activityId, times)

	return self:getHlCreepsData(masterData.creepsMasterId, creepsId)
end

function HolyLightConfig:getHlBuffCfgs()
	return self._hlBuffCfgs
end

function HolyLightConfig:getHlBuffCfg(buffId)
	return self._hlBuffCfgs[buffId]
end

function HolyLightConfig:getHlBuffData(buffId, index)
	return self._hlBuffCfgs[buffId][index]
end

function HolyLightConfig:getHlBuffDataByLv(buffId, level)
	level = checknumber(level)

	local cfg = self:getHlBuffCfg(buffId)
	local res = cfg[1]

	for _, data in ipairs(cfg) do
		if level < data.level then
			break
		else
			res = data
		end
	end

	return res
end

function HolyLightConfig:getHlBuffMaxLevel(buffId)
	local cfg = self:getHlBuffCfg(buffId)

	return #cfg
end

HolyLightConfig.instance = HolyLightConfig.New()

return HolyLightConfig
