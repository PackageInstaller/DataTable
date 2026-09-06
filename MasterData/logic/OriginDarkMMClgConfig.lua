-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/config/OriginDarkMMClgConfig.lua

module("logic.extensions.origindarkmmclg.config.OriginDarkMMClgConfig", package.seeall)

local OriginDarkMMClgConfig = class("OriginDarkMMClgConfig", BaseConfig)

function OriginDarkMMClgConfig:getNames()
	return {
		"origin_dark_mm_challenge_activity",
		"origin_dark_mm_challenge_buff",
		"origin_dark_mm_challenge_stage",
		"origin_dark_mm_challenge_master",
		"origin_dark_mm_challenge_creeps",
		"origin_dark_mm_challenge_behaviour"
	}
end

function OriginDarkMMClgConfig:handleConfig(name, content)
	if name == "origin_dark_mm_challenge_activity" then
		self._origin_dark_mm_challenge_activity = content
	elseif name == "origin_dark_mm_challenge_buff" then
		self._origin_dark_mm_challenge_buff = content
	elseif name == "origin_dark_mm_challenge_stage" then
		self._origin_dark_mm_challenge_stage = content
	elseif name == "origin_dark_mm_challenge_master" then
		self._origin_dark_mm_challenge_master = content
	elseif name == "origin_dark_mm_challenge_creeps" then
		self._origin_dark_mm_challenge_creeps = content
	elseif name == "origin_dark_mm_challenge_behaviour" then
		self._origin_dark_mm_challenge_behaviour = content
	end
end

function OriginDarkMMClgConfig:getActivity(activityId)
	return self._origin_dark_mm_challenge_activity[activityId]
end

function OriginDarkMMClgConfig:getBuff(activityId, num)
	local cfg = self._origin_dark_mm_challenge_buff[activityId]

	if not cfg then
		return nil
	end

	for index = num, 0, -1 do
		local data = cfg[index]

		if data then
			return data
		end
	end

	return nil
end

function OriginDarkMMClgConfig:getStages(activityId)
	return self._origin_dark_mm_challenge_stage[activityId]
end

function OriginDarkMMClgConfig:getStage(activityId, stageId)
	if self._origin_dark_mm_challenge_stage[activityId] then
		return self._origin_dark_mm_challenge_stage[activityId][stageId]
	end
end

function OriginDarkMMClgConfig:getMaster(creepsMasterId)
	return self._origin_dark_mm_challenge_master[creepsMasterId]
end

function OriginDarkMMClgConfig:getCreeps(creepsMasterId)
	return self._origin_dark_mm_challenge_creeps[creepsMasterId]
end

function OriginDarkMMClgConfig:getBehaviour(costPlanId)
	return self._origin_dark_mm_challenge_behaviour[costPlanId]
end

function OriginDarkMMClgConfig:getActionPoints(activityId, stageId)
	local stageInfo = self:getStage(activityId, stageId)

	return (stageInfo or nil) and (stageInfo.actionPoints or 0)
end

OriginDarkMMClgConfig.instance = OriginDarkMMClgConfig.New()

return OriginDarkMMClgConfig
