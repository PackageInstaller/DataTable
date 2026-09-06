-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/config/OriginDuoLaGameConfig.lua

module("logic.extensions.originduolagame.config.OriginDuoLaGameConfig", package.seeall)

local OriginDuoLaGameConfig = class("OriginDuoLaGameConfig", BaseConfig)

function OriginDuoLaGameConfig:onInit()
	OriginDuoLaGameConfig.super.onInit(self)
end

function OriginDuoLaGameConfig:getNames()
	return {
		"origin_duo_la_game_plan",
		"origin_duo_la_game_activity",
		"origin_duo_la_game_stage"
	}
end

function OriginDuoLaGameConfig:handleConfig(name, content)
	if name == "origin_duo_la_game_plan" then
		self._origin_duo_la_game_plan = content

		self:_handleGamePlanCfgs()
	elseif name == "origin_duo_la_game_activity" then
		self._origin_duo_la_game_activity = content
	elseif name == "origin_duo_la_game_stage" then
		self._origin_duo_la_game_stage = content
	end
end

function OriginDuoLaGameConfig:_safeGet(data, ...)
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

function OriginDuoLaGameConfig:getActivityCfg(activityId)
	return self:_safeGet(self._origin_duo_la_game_activity, activityId)
end

function OriginDuoLaGameConfig:getStageCfg(activityId, stageId)
	return self:_safeGet(self._origin_duo_la_game_stage, activityId, stageId)
end

function OriginDuoLaGameConfig:getStageCfgListByActivityId(activityId)
	return self:_safeGet(self._origin_duo_la_game_stage, activityId)
end

function OriginDuoLaGameConfig:getGamePlanCfg(planId)
	return self:_safeGet(self._origin_duo_la_game_plan, planId)
end

function OriginDuoLaGameConfig:_handleGamePlanCfgs()
	self._gamePlanSizeMap = {}

	for planId, cfg in ipairs(self._origin_duo_la_game_plan.dataList) do
		if not cfg.gameMap then
			local gameMap = {}
			local rowNum = #gameMap

			self._gamePlanSizeMap[planId] = {
				rowNum = rowNum,
				colNum = (rowNum > 0 or nil) and #gameMap[1]
			}
		end
	end
end

function OriginDuoLaGameConfig:getGamePlanSize(planId)
	return self:_safeGet(self._gamePlanSizeMap, planId)
end

OriginDuoLaGameConfig.instance = OriginDuoLaGameConfig.New()

return OriginDuoLaGameConfig
