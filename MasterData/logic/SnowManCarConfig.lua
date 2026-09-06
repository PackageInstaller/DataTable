-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/config/SnowManCarConfig.lua

module("logic.extensions.snowmancar.config.SnowManCarConfig", package.seeall)

local SnowManCarConfig = class("SnowManCarConfig", BaseConfig)

function SnowManCarConfig:getNames()
	return {
		"snowman_car_activity",
		"snowman_car_progress_prize",
		"snowman_car_icon",
		"snowman_car_game",
		"snowman_car_game_rule"
	}
end

function SnowManCarConfig:handleConfig(name, content)
	if name == "snowman_car_activity" then
		self.snowman_car_activity = content
	elseif name == "snowman_car_progress_prize" then
		self.snowman_car_progress_prize = content
	elseif name == "snowman_car_icon" then
		self.snowman_car_icon = content
	elseif name == "snowman_car_game" then
		self.snowman_car_game = content
	elseif name == "snowman_car_game_rule" then
		self.snowman_car_game_rule = content
	end
end

function SnowManCarConfig:getActivityCfgByActId(activityId)
	return self.snowman_car_activity[activityId]
end

function SnowManCarConfig:getProgressPrizeCfgByActId(activityId)
	return self.snowman_car_progress_prize[activityId]
end

function SnowManCarConfig:getCarIconCfg()
	return self.snowman_car_icon.dataList
end

function SnowManCarConfig:getCarIconById(activityId)
	return self.snowman_car_icon[activityId]
end

function SnowManCarConfig:getGameCfgByActId(activityId)
	local actCfg = self:getActivityCfgByActId(activityId)

	return self.snowman_car_game[actCfg.planId]
end

function SnowManCarConfig:getImgRuleInfosByKey(ruleKey)
	local ruleInfos = {}
	local ruleCfg = self.snowman_car_game_rule[ruleKey]

	if not ruleCfg then
		return nil
	end

	table.sort(ruleCfg, function(a, b)
		return a.index < b.index
	end)

	for i, v in ipairs(ruleCfg) do
		local info = {
			url = "ui/bigbg/views/snowmancar/" .. v.picturePath .. ".png",
			desc = v.desc
		}

		table.insert(ruleInfos, info)
	end

	return ruleInfos
end

SnowManCarConfig.instance = SnowManCarConfig.New()

return SnowManCarConfig
