-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/musicgame/config/MusicGameConfig.lua

module("logic.extensions.musicgame.config.MusicGameConfig", package.seeall)

local MusicGameConfig = class("MusicGameConfig", BaseConfig)

function MusicGameConfig:onInit()
	MusicGameConfig.super.onInit(self)
end

function MusicGameConfig:getNames()
	return {
		"music_game_activity",
		"music_game_prize",
		"music_game_plan",
		"music_game_stage",
		"music_game_map"
	}
end

function MusicGameConfig:handleConfig(name, content)
	if name == "music_game_activity" then
		self.music_game_activity = content
	elseif name == "music_game_prize" then
		self.music_game_prize = content
	elseif name == "music_game_plan" then
		self.music_game_plan = content
	elseif name == "music_game_stage" then
		self.music_game_stage = content
	elseif name == "music_game_map" then
		self.music_game_map = content
	end
end

function MusicGameConfig:getActData(activityId)
	return self.music_game_activity[activityId]
end

function MusicGameConfig:getPrizeCfg(activityId)
	return self.music_game_prize[activityId]
end

function MusicGameConfig:getPrizeData(activityId, prizeId)
	if self.music_game_prize[activityId] then
		return self.music_game_prize[activityId][prizeId]
	end
end

function MusicGameConfig:getPlanCfg(gamePlanId)
	return self.music_game_plan[gamePlanId]
end

function MusicGameConfig:getPlanData(gamePlanId, gameTypeId)
	if self.music_game_plan[gamePlanId] then
		return self.music_game_plan[gamePlanId][gameTypeId]
	end
end

function MusicGameConfig:getStageData(stageId)
	return self.music_game_stage[stageId]
end

function MusicGameConfig:getMapData(stageId)
	local data = self:getStageData(stageId)

	if data then
		if data then
			if not data.mapId then
				local mapId = 0

				return self.music_game_map[mapId]
			end
		end
	end
end

MusicGameConfig.instance = MusicGameConfig.New()

return MusicGameConfig
