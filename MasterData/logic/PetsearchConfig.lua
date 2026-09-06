-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/config/PetsearchConfig.lua

module("logic.extensions.petsearch.config.PetsearchConfig", package.seeall)

local PetsearchConfig = class("PetsearchConfig", BaseConfig)

function PetsearchConfig:onInit()
	PetsearchConfig.super.onInit(self)

	self._cycleCfgs = nil
	self._searchPetCfgs = nil
	self._searchPetCycleCfgs = nil
	self._creepsCfgs = nil
	self._teamCfgs = nil
	self._refreshTimesCfgs = nil
	self._baseParamsCfgs = nil
end

function PetsearchConfig:getNames()
	return {
		"seek_pet_cycle",
		"seek_pet",
		"seek_pet_team",
		"seek_pet_creeps",
		"seek_pet_refresh_times_define",
		"seek_pet_common_config"
	}
end

function PetsearchConfig:handleConfig(name, content)
	if name == "seek_pet_cycle" then
		self._cycleCfgs = content
	elseif name == "seek_pet" then
		self._searchPetCfgs = content
		self._searchPetCycleCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._searchPetCycleCfgs[v.cycleId] = self._searchPetCycleCfgs[v.cycleId] or {}

			table.insert(self._searchPetCycleCfgs[v.cycleId], v)
		end
	elseif name == "seek_pet_team" then
		self._teamCfgs = content
	elseif name == "seek_pet_creeps" then
		self._creepsCfgs = content
	elseif name == "seek_pet_refresh_times_define" then
		self._refreshTimesCfgs = content
	elseif name == "seek_pet_common_config" then
		self._baseParamsCfgs = content
	end
end

function PetsearchConfig:getTeamPets(creepsMasterId, creepsId)
	if not creepsId then
		return self._creepsCfgs[creepsMasterId]
	end

	return self._creepsCfgs[creepsMasterId][creepsId]
end

function PetsearchConfig:getTeamCfg(creepsMasterId)
	return self._teamCfgs[creepsMasterId]
end

function PetsearchConfig:getTeamCfgByBossId(bossId)
	local bossCfg = self:getSearchPetCfg(bossId)

	return self._teamCfgs[bossCfg.creepsMasterId]
end

function PetsearchConfig:getParamValueByKey(key)
	return self._baseParamsCfgs[key].value
end

function PetsearchConfig:getCycleStartTime(cycleId)
	if cycleId then
		local timeStr = self._cycleCfgs[cycleId].startTime

		if GameUtil.isEmptyString(timeStr) then
			printError("精灵寻觅周期配置缺失")

			return
		end

		return GameUtil.string2time(timeStr)
	end
end

function PetsearchConfig:getCurCycleIdAndEndTime()
	local curCycleId = 1
	local timeNow = ServerTime.now()
	local curCycleEndTime

	for i = 1, #self._cycleCfgs do
		curCycleEndTime = self:getCycleStartTime(i)

		if timeNow <= curCycleEndTime then
			return i - 1, curCycleEndTime
		end
	end

	printError("精灵寻觅周期配置未开始")

	return curCycleId, curCycleEndTime
end

function PetsearchConfig:getCurCycleIdAndEndTimeByBossId(bossId)
	if bossId and bossId > 0 then
		local cycleId = self:getSearchPetCfg(bossId).cycleId
		local endTime = self:getCycleStartTime(cycleId + 1)

		return cycleId, endTime
	else
		return self:getCurCycleIdAndEndTime()
	end
end

function PetsearchConfig:getSearchPetCfg(bossId)
	return self._searchPetCfgs[bossId]
end

function PetsearchConfig:getSearchPetCfgsPerCycle(cycleId)
	return self._searchPetCycleCfgs[cycleId]
end

function PetsearchConfig:getRefreshCostByTimes(times)
	local time = checkint(times)

	time = time >= #self._refreshTimesCfgs and #self._refreshTimesCfgs - 1 or time

	return self._refreshTimesCfgs[time].cost
end

PetsearchConfig.instance = PetsearchConfig.New()

return PetsearchConfig
