-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/config/LioncultureConfig.lua

module("logic.extensions.lionculture.config.LioncultureConfig", package.seeall)

local LioncultureConfig = class("LioncultureConfig", BaseConfig)

function LioncultureConfig:onInit()
	LioncultureConfig.super.onInit(self)
end

function LioncultureConfig:getNames()
	return {
		"waking_lion_game",
		"waking_lion_game_shape",
		"waking_lion_game_shapepart",
		"waking_lion_game_intention",
		"waking_lion_game_monster",
		"waking_lion_game_creeps",
		"waking_lion_game_system_pet",
		"waking_lion_game_class",
		"waking_lion_fmt_introduce"
	}
end

function LioncultureConfig:handleConfig(name, content)
	if name == "waking_lion_game" then
		self._waking_lion_game = content
	elseif name == "waking_lion_game_shape" then
		self._waking_lion_game_shape = content
	elseif name == "waking_lion_game_shapepart" then
		self._waking_lion_game_shapepart = content
	elseif name == "waking_lion_game_intention" then
		self._waking_lion_game_intention = content
	elseif name == "waking_lion_game_monster" then
		self._waking_lion_game_monster = content
	elseif name == "waking_lion_game_creeps" then
		self._waking_lion_game_creeps = content
	elseif name == "waking_lion_game_system_pet" then
		self._waking_lion_game_system_pet = content
	elseif name == "waking_lion_game_class" then
		self._waking_lion_game_class = content
	elseif name == "waking_lion_fmt_introduce" then
		self._waking_lion_fmt_introduce = content
	end
end

function LioncultureConfig:getGamesCfg()
	return self._waking_lion_game.dataList
end

function LioncultureConfig:getGameData(activityId, gameId)
	return self._waking_lion_game[activityId][gameId]
end

function LioncultureConfig:getGameShapeCfg(index)
	return self._waking_lion_game_shape[1][index]
end

function LioncultureConfig:getGameShapeTotel()
	return #self._waking_lion_game_shape[1]
end

function LioncultureConfig:getGameShapePartCfg(index, partid)
	return self._waking_lion_game_shapepart[index][partid]
end

function LioncultureConfig:getGameShapePartCount(index)
	return #self._waking_lion_game_shapepart[index]
end

function LioncultureConfig:getGameIntentionCfg(index)
	return self._waking_lion_game_intention[1][index]
end

function LioncultureConfig:getGameIntentionNum()
	return #self._waking_lion_game_intention[1]
end

function LioncultureConfig:getGameMonsterData(activityId, gameId)
	local gameData = self:getGameData(activityId, gameId)

	return self._waking_lion_game_monster[gameData.creepsMasterId]
end

function LioncultureConfig:getGameCreepsCfg(activityId, gameId)
	local gameData = self:getGameData(activityId, gameId)

	return self._waking_lion_game_creeps[gameData.creepsMasterId]
end

function LioncultureConfig:getGameSystemPetCfg(activityId, gameId)
	local gameData = self:getGameData(activityId, gameId)

	return self._waking_lion_game_system_pet[gameData.petPlanId]
end

function LioncultureConfig:getGameClassCfgs()
	return self._waking_lion_game_class
end

function LioncultureConfig:getFmtIntroduceCfg()
	return self._waking_lion_fmt_introduce
end

LioncultureConfig.instance = LioncultureConfig.New()

return LioncultureConfig
