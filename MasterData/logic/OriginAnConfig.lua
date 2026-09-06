-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/config/OriginAnConfig.lua

module("logic.extensions.originan.config.OriginAnConfig", package.seeall)

local OriginAnConfig = class("OriginAnConfig", BaseConfig)

function OriginAnConfig:getNames()
	return {
		"origin_an_activity",
		"origin_an_creeps",
		"origin_an_extreme_buff",
		"origin_an_extreme_stage",
		"origin_an_master",
		"origin_an_normal_stage",
		"origin_an_progress"
	}
end

function OriginAnConfig:handleConfig(name, content)
	if name == "origin_an_activity" then
		self._origin_an_activity = content
	elseif name == "origin_an_creeps" then
		self._origin_an_creeps = content
	elseif name == "origin_an_extreme_buff" then
		self._origin_an_extreme_buff = content
	elseif name == "origin_an_extreme_stage" then
		self._origin_an_extreme_stage = content
	elseif name == "origin_an_master" then
		self._origin_an_master = content
	elseif name == "origin_an_normal_stage" then
		self._origin_an_normal_stage = content
	elseif name == "origin_an_progress" then
		self._origin_an_progress = content
	end
end

function OriginAnConfig:_safeGet(data, ...)
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

function OriginAnConfig:getActivityData(activityId)
	return self:_safeGet(self._origin_an_activity, activityId)
end

function OriginAnConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._origin_an_creeps, creepsMasterId)
end

function OriginAnConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._origin_an_creeps, creepsMasterId, creepsId)
end

function OriginAnConfig:getExtremeBuffDatas(activityId)
	return self:_safeGet(self._origin_an_extreme_buff, activityId)
end

function OriginAnConfig:getExtremeBuffData(activityId, buffId)
	return self:_safeGet(self._origin_an_extreme_buff, activityId, buffId)
end

function OriginAnConfig:getExtremeBuffDataByTimes(activityId, blockHealTimes)
	local tb = self:getExtremeBuffDatas(activityId)

	return MmUtil.binarySearchInSingleKey(tb, "blockHealTimes", blockHealTimes)
end

function OriginAnConfig:getExtremeStageDatas(activityId)
	return self:_safeGet(self._origin_an_extreme_stage, activityId)
end

function OriginAnConfig:getExtremeStageData(activityId, stageId)
	return self:_safeGet(self._origin_an_extreme_stage, activityId, stageId)
end

function OriginAnConfig:getMasterData(creepsMasterId)
	return self:_safeGet(self._origin_an_master, creepsMasterId)
end

function OriginAnConfig:getNormalStageDatass(activityId)
	return self:_safeGet(self._origin_an_normal_stage, activityId)
end

function OriginAnConfig:getNormalStageDatas(activityId, groupId)
	return self:_safeGet(self._origin_an_normal_stage, activityId, groupId)
end

function OriginAnConfig:getNormalStageData(activityId, groupId, stageId)
	return self:_safeGet(self._origin_an_normal_stage, activityId, groupId, stageId)
end

function OriginAnConfig:getProgressDatas(activityId)
	return self:_safeGet(self._origin_an_progress, activityId)
end

function OriginAnConfig:getProgressData(activityId, progressId)
	return self:_safeGet(self._origin_an_progress, activityId, progressId)
end

OriginAnConfig.instance = OriginAnConfig.New()

return OriginAnConfig
