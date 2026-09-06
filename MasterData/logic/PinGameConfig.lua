-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/config/PinGameConfig.lua

module("logic.extensions.pingame.config.PinGameConfig", package.seeall)

local PinGameConfig = class("PinGameConfig", BaseConfig)

function PinGameConfig:onInit()
	PinGameConfig.super.onInit(self)

	self.pin_game_activity = nil
	self.pin_game_mode = nil
	self.pin_game_score_prize = nil
	self.pin_game_stage = nil
	self.pin_game_recover_cost = nil
	self.pin_game_common = nil
end

function PinGameConfig:getNames()
	return {
		"pin_game_activity",
		"pin_game_mode",
		"pin_game_score_prize",
		"pin_game_stage",
		"pin_game_recover_cost",
		"pin_game_common"
	}
end

function PinGameConfig:handleConfig(name, content)
	if name == "pin_game_activity" then
		self.pin_game_activity = content
	elseif name == "pin_game_mode" then
		self.pin_game_mode = content
	elseif name == "pin_game_score_prize" then
		self.pin_game_score_prize = content
	elseif name == "pin_game_stage" then
		self.pin_game_stage = content
	elseif name == "pin_game_recover_cost" then
		self.pin_game_recover_cost = content
	elseif name == "pin_game_common" then
		self.pin_game_common = content
	end
end

function PinGameConfig:getActivityCfg(id)
	return self.pin_game_activity[id]
end

function PinGameConfig:getCommonValue(key)
	if self.pin_game_common[key] then
		return self.pin_game_common[key].value
	end
end

function PinGameConfig:getStageCfg(stagePlanId)
	return self.pin_game_stage[stagePlanId]
end

function PinGameConfig:getStageParam(stagePlanId, stageId)
	if self.pin_game_stage[stagePlanId] then
		local paramList = {}

		if self.pin_game_stage[stagePlanId] and #self.pin_game_stage[stagePlanId] > 0 then
			for i, v in ipairs(self.pin_game_stage[stagePlanId]) do
				local paramInfo = TableUtil.deepcopy(v)

				paramInfo.rotateSpeed = v.rotateSpeed
				paramInfo.rootRadius = v.rootRadius
				paramInfo.lineLength = v.lineLength
				paramInfo.lineRadius = v.lineRadius
				paramInfo.obstacleRadius = v.obstacleRadius
				paramInfo.shootDuration = v.shootDuration
				paramInfo.winCount = v.winCount
				paramInfo.shootDir = v.shootDir or {}
				paramInfo.obstacleList = v.obstacleList or {}

				table.insert(paramList, paramInfo)
			end
		end

		return paramList
	end
end

function PinGameConfig:getGameMode(actId, mode)
	return self.pin_game_mode[actId] and self.pin_game_mode[actId][mode]
end

function PinGameConfig:getScorePrizeList(actId)
	return self.pin_game_score_prize[actId]
end

function PinGameConfig:getRecoverCost(actId)
	return self.pin_game_recover_cost[actId]
end

function PinGameConfig:getRecoverCostCfg(actId, times)
	return self.pin_game_recover_cost[actId] and self.pin_game_recover_cost[actId][times]
end

PinGameConfig.instance = PinGameConfig.New()

return PinGameConfig
