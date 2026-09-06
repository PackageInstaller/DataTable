-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/config/FirePowerContestConfig.lua

module("logic.extensions.firepowercontest.config.FirePowerContestConfig", package.seeall)

local FirePowerContestConfig = class("FirePowerContestConfig", BaseConfig)

FirePowerContestConfig.tick = 0.02
FirePowerContestConfig.tickMs = FirePowerContestConfig.tick * 1000
FirePowerContestConfig.SpeedZoom = 200 / FirePowerContestConfig.tickMs
FirePowerContestConfig.BulletSpeed = 60
FirePowerContestConfig.debugClient = false
FirePowerContestConfig.enableDragAim = true
FirePowerContestConfig.ComboAnimUrls = {
	["5"] = "fx_ui_hyll_cb5",
	["15"] = "fx_ui_hyll_cb15"
}

function FirePowerContestConfig:onInit()
	FirePowerContestConfig.super.onInit(self)

	self._fire_power_contest_activity = nil
	self._fire_power_contest_prize = nil
	self._fire_power_contest_game_stage = nil
	self._fire_power_contest_item = nil
	self._fire_power_contest_client_common = nil
	self._fire_power_contest_game_interactive = nil
	self._fire_power_contest_progress = nil
end

function FirePowerContestConfig:getNames()
	return {
		"fire_power_contest_activity",
		"fire_power_contest_prize",
		"fire_power_contest_game_stage",
		"fire_power_contest_item",
		"fire_power_contest_client_common",
		"fire_power_contest_game_interactive",
		"fire_power_contest_progress"
	}
end

function FirePowerContestConfig:handleConfig(name, content)
	if name == "fire_power_contest_activity" then
		self._fire_power_contest_activity = content
	elseif name == "fire_power_contest_prize" then
		self._fire_power_contest_prize = content
	elseif name == "fire_power_contest_game_stage" then
		self._fire_power_contest_game_stage = content
	elseif name == "fire_power_contest_item" then
		self._fire_power_contest_item = content
	elseif name == "fire_power_contest_client_common" then
		self._fire_power_contest_client_common = content
	elseif name == "fire_power_contest_game_interactive" then
		self._fire_power_contest_game_interactive = content
	elseif name == "fire_power_contest_progress" then
		self._fire_power_contest_progress = content
	end
end

function FirePowerContestConfig:getCommonValue(key)
	local conf = self._fire_power_contest_client_common[key]

	if conf then
		return conf.value
	end

	return ""
end

function FirePowerContestConfig:getActCfg()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.FIRE_POWER_CONTEST)

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item
		end
	end

	return nil
end

function FirePowerContestConfig:getActId()
	local cfg = self:getActCfg()

	if cfg then
		return cfg.activityId
	end

	return -2
end

function FirePowerContestConfig:getGameActivityConf(activityId)
	activityId = activityId or self:getActId()

	if activityId > 0 then
		return self._fire_power_contest_activity[activityId]
	end

	return nil
end

function FirePowerContestConfig:getGamePrizeConfs(activityConf)
	activityConf = activityConf or self:getGameActivityConf()

	if activityConf then
		return self._fire_power_contest_prize[activityConf.prizePlanId]
	end

	return nil
end

function FirePowerContestConfig:getGameStageConf(stageId, id, stagePlanId)
	if not stagePlanId then
		local activityConf = self:getGameActivityConf()

		if activityConf then
			if not activityConf.stagePlanId then
				return nil
			end

			return self:getGameStageConf(stageId, id, activityConf.stagePlanId)
		end
	else
		local configs = self._fire_power_contest_game_stage[stagePlanId]

		if configs then
			configs = configs[stageId]

			if configs then
				return configs[id]
			end
		end
	end

	return nil
end

function FirePowerContestConfig:getMaxStage()
	local activityConf = self:getGameActivityConf()

	if activityConf then
		local configs = self._fire_power_contest_game_stage[activityConf.stagePlanId]

		if configs then
			local count = 1

			while configs[count] do
				count = count + 1
			end

			return count - 1
		end
	end

	return 0
end

function FirePowerContestConfig:getContinueHitScoreMap()
	local activityConf = self:getGameActivityConf()

	if not activityConf.scoreExtra then
		local result = {}

		for i, v in ipairs(activityConf.scoreExtra) do
			if not string.nilorempty(v) then
				local group = string.splitToNumber(v, ":")
				local hit = group[1]

				result[hit] = group[2]
			end
		end

		return result
	end
end

function FirePowerContestConfig:getContinueHitScore()
	local activityConf = self:getGameActivityConf()

	if not activityConf.scoreExtra then
		local result = {}

		for i, v in ipairs(activityConf.scoreExtra) do
			if not string.nilorempty(v) then
				local group = string.splitToNumber(v, ":")
				local hit = group[1]
				local score = group[2]

				table.insert(result, {
					hit = hit,
					score = score
				})
			end
		end

		return result
	end
end

function FirePowerContestConfig:getInteractiveConf(pathType)
	local data = self._fire_power_contest_game_interactive[pathType]

	return GameUtil.jsonToTable(data.data)
end

function FirePowerContestConfig:getInteractiveBg(pathType)
	return self._fire_power_contest_game_interactive[pathType].bg
end

function FirePowerContestConfig:getItemConf(itemId)
	return self._fire_power_contest_item[itemId]
end

function FirePowerContestConfig:getProgressByScore(value)
	local configs = self._fire_power_contest_progress

	for i = #configs, 1, -1 do
		local config = configs[i]

		if value >= config.scoreRange[1] then
			return config.progress
		end
	end

	return 0
end

local EffectUrlFormat = "20220602/huoyanliliang/%s.prefab"

function FirePowerContestConfig:getEffectUrl(name)
	return string.format(EffectUrlFormat, name)
end

FirePowerContestConfig.instance = FirePowerContestConfig.New()

return FirePowerContestConfig
