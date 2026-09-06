-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/config/SlackOffGameConfig.lua

module("logic.extensions.slackoffgame.config.SlackOffGameConfig", package.seeall)

local SlackOffGameConfig = class("SlackOffGameConfig", BaseConfig)

function SlackOffGameConfig:getNames()
	return {
		"slack_off_game_activity",
		"slack_off_game_student",
		"slack_off_game_prize",
		"slack_off_game_value_plan",
		"slack_off_game_rule"
	}
end

function SlackOffGameConfig:handleConfig(name, content)
	if name == "slack_off_game_activity" then
		self.slack_off_game_activity = content
	elseif name == "slack_off_game_student" then
		self.slack_off_game_student = content
	elseif name == "slack_off_game_prize" then
		self.slack_off_game_prize = content
	elseif name == "slack_off_game_value_plan" then
		self.slack_off_game_value_plan = content
	elseif name == "slack_off_game_rule" then
		self.slack_off_game_rule = content
	end
end

function SlackOffGameConfig:getActivityCfgByActId(activityId)
	return self.slack_off_game_activity[activityId]
end

function SlackOffGameConfig:getStudentCfgsByActId(activityId)
	return self.slack_off_game_student[activityId]
end

function SlackOffGameConfig:getProgressPrizeCfgByActId(activityId)
	return self.slack_off_game_prize[activityId]
end

function SlackOffGameConfig:getValuePlanCfgByPlanId(planId)
	return self.slack_off_game_value_plan[planId]
end

function SlackOffGameConfig:getImgRuleInfosByKey(ruleKey)
	return self.slack_off_game_rule[ruleKey]
end

function SlackOffGameConfig:getGameIntroContent(activityId)
	local cfg = self:getActivityCfgByActId(activityId)
	local targetPair = cfg and string.split(cfg.targets, "#")
	local moodTarget = tonumber(targetPair[1])
	local studyTarget = tonumber(targetPair[2])

	return (string.format("保持心情在%d+\n学习进度在%d+\n就可以提升此角色的\n1点学习/工作进度", moodTarget, studyTarget))
end

SlackOffGameConfig.instance = SlackOffGameConfig.New()

return SlackOffGameConfig
