-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/config/IceQibuGameConfig.lua

module("logic.extensions.iceqibugame.config.IceQibuGameConfig", package.seeall)

local IceQibuGameConfig = class("IceQibuGameConfig", BaseConfig)

function IceQibuGameConfig:getNames()
	return {
		"ice_qibu_game_activity",
		"ice_qibu_game_prize",
		"ice_qibu_game_stage",
		"ice_qibu_game_map"
	}
end

function IceQibuGameConfig:handleConfig(name, content)
	if name == "ice_qibu_game_activity" then
		self._ice_qibu_game_activity = content
	elseif name == "ice_qibu_game_prize" then
		self._ice_qibu_game_prize = content
	elseif name == "ice_qibu_game_stage" then
		self._ice_qibu_game_stage = content
	elseif name == "ice_qibu_game_map" then
		self._ice_qibu_game_map = content
	end
end

function IceQibuGameConfig:getActivityData(activityId)
	return self:_safeGet(self._ice_qibu_game_activity, activityId)
end

function IceQibuGameConfig:getMapData(mapId)
	return self:_safeGet(self._ice_qibu_game_map, mapId)
end

function IceQibuGameConfig:getStageDatas(activityId)
	return self:_safeGet(self._ice_qibu_game_stage, activityId)
end

function IceQibuGameConfig:getStageData(activityId, stageId)
	return self:_safeGet(self._ice_qibu_game_stage, activityId, stageId)
end

function IceQibuGameConfig:getPrizeDatas(activityId)
	return self:_safeGet(self._ice_qibu_game_prize, activityId)
end

function IceQibuGameConfig:getPrizeData(activityId, prizeId)
	return self:_safeGet(self._ice_qibu_game_prize, activityId, prizeId)
end

function IceQibuGameConfig:getPrizeDataByTime(activityId, costTime)
	local datas = self:getPrizeDatas(activityId)

	return MmUtil.binarySearchInArrayKey(datas, "timeRange", costTime)
end

function IceQibuGameConfig:_safeGet(data, ...)
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

IceQibuGameConfig.instance = IceQibuGameConfig.New()

return IceQibuGameConfig
