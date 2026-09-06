-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/config/LuYinJiaDeConfig.lua

module("logic.extensions.luyinjiade.config.LuYinJiaDeConfig", package.seeall)

local LuYinJiaDeConfig = class("LuYinJiaDeConfig", BaseConfig)

function LuYinJiaDeConfig:onInit()
	LuYinJiaDeConfig.super.onInit(self)
end

function LuYinJiaDeConfig:getNames()
	return {
		"luyinjiade_clg_activity",
		"luyinjiade_clg_stage",
		"luyinjiade_clg_monster",
		"luyinjiade_clg_creeps",
		"luyinjiade_clg_score"
	}
end

function LuYinJiaDeConfig:handleConfig(name, content)
	if name == "luyinjiade_clg_activity" then
		self._luyinjiade_clg_activity = content
	elseif name == "luyinjiade_clg_stage" then
		self._luyinjiade_clg_stage = content
	elseif name == "luyinjiade_clg_monster" then
		self._luyinjiade_clg_monster = content
	elseif name == "luyinjiade_clg_creeps" then
		self._luyinjiade_clg_creeps = content
	elseif name == "luyinjiade_clg_score" then
		self._luyinjiade_clg_score = content
	end
end

function LuYinJiaDeConfig:getActData(activityId)
	return self._luyinjiade_clg_activity[activityId]
end

function LuYinJiaDeConfig:getStageData(activityId)
	return self._luyinjiade_clg_stage[activityId]
end

function LuYinJiaDeConfig:getStageDataById(activityId, stageId)
	if self._luyinjiade_clg_stage[activityId] then
		return self._luyinjiade_clg_stage[activityId][stageId]
	end
end

function LuYinJiaDeConfig:getMonsterData(creepsMasterId)
	return self._luyinjiade_clg_monster[creepsMasterId]
end

function LuYinJiaDeConfig:getCreepsData(creepsMasterId)
	return self._luyinjiade_clg_creeps[creepsMasterId]
end

function LuYinJiaDeConfig:getScoreData(activityId)
	return self._luyinjiade_clg_score[activityId]
end

function LuYinJiaDeConfig:getSkinId(activityId)
	return self._luyinjiade_clg_activity[activityId] and self._luyinjiade_clg_activity[activityId].skinId
end

function LuYinJiaDeConfig:getCreepsMasterId(activityId, stageId)
	if self._luyinjiade_clg_stage[activityId] then
		return self._luyinjiade_clg_stage[activityId][stageId] and self._luyinjiade_clg_stage[activityId][stageId].creepsMasterId
	end
end

function LuYinJiaDeConfig:getRankLimitNums(activityId)
	local arr = {}

	table.insert(arr, self._luyinjiade_clg_activity[activityId].godRankLimit)
	table.insert(arr, self._luyinjiade_clg_activity[activityId].dailyRankLimit)

	return arr
end

LuYinJiaDeConfig.instance = LuYinJiaDeConfig.New()

return LuYinJiaDeConfig
