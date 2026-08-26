-- chunkname: @modules/logic/versionactivity3_2/cruise/config/Activity218Config.lua

module("modules.logic.versionactivity3_2.cruise.config.Activity218Config", package.seeall)

local Activity218Config = class("Activity218Config", BaseConfig)

function Activity218Config:ctor()
	self._controlConfig = nil
	self._dailyDiffConfig = nil
	self._bonusConfig = nil
end

function Activity218Config:reqConfigNames()
	return {
		"activity218_control",
		"activity218_dailydifficultly",
		"activity218_milestone_bonus"
	}
end

function Activity218Config:onConfigLoaded(configName, configTable)
	if configName == "activity218_control" then
		self._controlConfig = configTable
	elseif configName == "activity218_dailydifficultly" then
		self._dailyDiffConfig = configTable
	elseif configName == "activity218_milestone_bonus" then
		self._bonusConfig = configTable
	end
end

function Activity218Config:getCfg_activity218_control(activityId)
	local id = activityId or Activity218Model.instance.activityId

	return lua_activity218_control.configDict[id]
end

function Activity218Config:getGamePoint(resultType, activityId)
	local id = activityId or Activity218Model.instance.activityId
	local cfg = self:getCfg_activity218_control(id)

	if resultType == Activity218Enum.GameResultType.Victory then
		return cfg.winPoint
	elseif resultType == Activity218Enum.GameResultType.Defeat then
		return cfg.losePoint
	elseif resultType == Activity218Enum.GameResultType.Draw then
		return cfg.drawPoint
	end
end

function Activity218Config:getBonusCfgs(activityId)
	local id = activityId or Activity218Model.instance.activityId

	if self.bonusCfgs == nil then
		self.bonusCfgs = {}
	end

	if self.bonusCfgs[id] == nil then
		self.bonusCfgs[id] = {}

		for i, cfg in ipairs(lua_activity218_milestone_bonus.configList) do
			if cfg.activityId == id then
				table.insert(self.bonusCfgs[id], cfg)
			end
		end
	end

	return self.bonusCfgs[id]
end

function Activity218Config:getMilestoneBonusCfg(activityId, rewardId)
	local id = activityId or Activity218Model.instance.activityId

	return lua_activity218_milestone_bonus.configDict[id][rewardId]
end

function Activity218Config:getBonus(activityId, rewardId)
	local id = activityId or Activity218Model.instance.activityId
	local cfg = lua_activity218_milestone_bonus.configDict[id][rewardId]

	return (GameUtil.splitString2(cfg.bonus, true))
end

function Activity218Config:getMaxCoin(activityId)
	local id = activityId or Activity218Model.instance.activityId
	local bounsCfgs = self:getBonusCfgs(id)

	return bounsCfgs[#bounsCfgs].coinNum
end

function Activity218Config:getDifficultly(day)
	local list = lua_activity218_dailydifficultly.configList
	local maxDay = #list
	local curDay = (day - 1) % maxDay + 1

	return tonumber(lua_activity218_dailydifficultly.configDict[curDay].difficulty)
end

Activity218Config.instance = Activity218Config.New()

return Activity218Config
