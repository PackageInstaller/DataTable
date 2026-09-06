-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/config/HeartOfAoJiuClgConfig.lua

module("logic.extensions.heartofaojiuclg.config.HeartOfAoJiuClgConfig", package.seeall)

local HeartOfAoJiuClgConfig = class("HeartOfAoJiuClgConfig", BaseConfig)

function HeartOfAoJiuClgConfig:getNames()
	return {
		"heart_of_ao_jiu_clg_activity",
		"heart_of_ao_jiu_clg_creeps",
		"heart_of_ao_jiu_clg_daily_balance",
		"heart_of_ao_jiu_clg_monster",
		"heart_of_ao_jiu_clg_stage"
	}
end

function HeartOfAoJiuClgConfig:handleConfig(name, content)
	if name == "heart_of_ao_jiu_clg_activity" then
		self._heart_of_ao_jiu_clg_activity = content
	elseif name == "heart_of_ao_jiu_clg_creeps" then
		self._heart_of_ao_jiu_clg_creeps = content
	elseif name == "heart_of_ao_jiu_clg_daily_balance" then
		self._heart_of_ao_jiu_clg_daily_balance = content
	elseif name == "heart_of_ao_jiu_clg_monster" then
		self._heart_of_ao_jiu_clg_monster = content
	elseif name == "heart_of_ao_jiu_clg_stage" then
		self._heart_of_ao_jiu_clg_stage = content
	end
end

function HeartOfAoJiuClgConfig:getActivityData(activityId)
	return self:_safeGet(self._heart_of_ao_jiu_clg_activity, activityId)
end

function HeartOfAoJiuClgConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._heart_of_ao_jiu_clg_creeps, creepsMasterId)
end

function HeartOfAoJiuClgConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._heart_of_ao_jiu_clg_creeps, creepsMasterId, creepsId)
end

function HeartOfAoJiuClgConfig:getDailyBalanceDatas(activityId)
	return self:_safeGet(self._heart_of_ao_jiu_clg_daily_balance, activityId)
end

function HeartOfAoJiuClgConfig:getDailyBalanceData(activityId, id)
	return self:_safeGet(self._heart_of_ao_jiu_clg_daily_balance, activityId, id)
end

function HeartOfAoJiuClgConfig:getMonsterData(creepsMasterId)
	return self:_safeGet(self._heart_of_ao_jiu_clg_monster, creepsMasterId)
end

function HeartOfAoJiuClgConfig:getStageDatas(activityId)
	return self:_safeGet(self._heart_of_ao_jiu_clg_stage, activityId)
end

function HeartOfAoJiuClgConfig:getStageData(activityId, stageId)
	return self:_safeGet(self._heart_of_ao_jiu_clg_stage, activityId, stageId)
end

function HeartOfAoJiuClgConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

HeartOfAoJiuClgConfig.instance = HeartOfAoJiuClgConfig.New()

return HeartOfAoJiuClgConfig
