-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonsoulvote/config/DragonSoulVoteConfig.lua

module("logic.extensions.dragonsoulvote.config.DragonSoulVoteConfig", package.seeall)

local DragonSoulVoteConfig = class("DragonSoulVoteConfig", BaseConfig)

function DragonSoulVoteConfig:getNames()
	return {
		"dsoul_predict_activity",
		"dsoul_predict",
		"dsoul_predict_progress_prize",
		"dsoul_predict_msg"
	}
end

function DragonSoulVoteConfig:handleConfig(name, content)
	if name == "dsoul_predict_activity" then
		self._dsoul_predict_activity = content
	elseif name == "dsoul_predict" then
		self._dsoul_predict = content
	elseif name == "dsoul_predict_progress_prize" then
		self._dsoul_predict_progress_prize = content
	elseif name == "dsoul_predict_msg" then
		self._dsoul_predict_msg = content
	end
end

function DragonSoulVoteConfig:getActivityCfgById(id)
	return self._dsoul_predict_activity[id]
end

function DragonSoulVoteConfig:getPredictCfgMap(activityId)
	return self._dsoul_predict[activityId]
end

function DragonSoulVoteConfig:getPredictGroupCfg(activityId, groupId)
	if self._dsoul_predict[activityId] then
		return self._dsoul_predict[activityId][groupId]
	end
end

function DragonSoulVoteConfig:getPredictCfgById(activityId, groupId, itemId)
	if self._dsoul_predict[activityId] and self._dsoul_predict[activityId][groupId] then
		return self._dsoul_predict[activityId][groupId][itemId]
	end
end

function DragonSoulVoteConfig:getProgressCfgListById(activityId)
	return self._dsoul_predict_progress_prize[activityId]
end

function DragonSoulVoteConfig:getMsgCfgListById(activityId)
	return self._dsoul_predict_msg[activityId]
end

DragonSoulVoteConfig.instance = DragonSoulVoteConfig.New()

return DragonSoulVoteConfig
