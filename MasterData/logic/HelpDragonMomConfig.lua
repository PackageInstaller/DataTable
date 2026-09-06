-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/config/HelpDragonMomConfig.lua

module("logic.extensions.helpdragonmom.config.HelpDragonMomConfig", package.seeall)

local HelpDragonMomConfig = class("HelpDragonMomConfig", BaseConfig)

function HelpDragonMomConfig:onInit()
	HelpDragonMomConfig.super.onInit(self)

	self.help_dragon_mom_activity = nil
	self.help_dragon_mom_score = nil
	self.help_dragon_mom_reward_player = nil
	self.help_dragon_mom_reward_world = nil
	self.help_dragon_mom_rule = nil
end

function HelpDragonMomConfig:getNames()
	return {
		"help_dragon_mom_activity",
		"help_dragon_mom_score",
		"help_dragon_mom_reward_player",
		"help_dragon_mom_reward_world",
		"help_dragon_mom_rule"
	}
end

function HelpDragonMomConfig:handleConfig(name, content)
	if name == "help_dragon_mom_activity" then
		self.help_dragon_mom_activity = content
	elseif name == "help_dragon_mom_score" then
		self.help_dragon_mom_score = content
	elseif name == "help_dragon_mom_reward_player" then
		self.help_dragon_mom_reward_player = content
	elseif name == "help_dragon_mom_reward_world" then
		self.help_dragon_mom_reward_world = content
	elseif name == "help_dragon_mom_rule" then
		self.help_dragon_mom_rule = content
	end
end

function HelpDragonMomConfig:getActivityCfg(activityId)
	return self.help_dragon_mom_activity[activityId]
end

function HelpDragonMomConfig:getScoreCfgList(scoreAddPlanId)
	return self.help_dragon_mom_score[scoreAddPlanId]
end

function HelpDragonMomConfig:getRewardPlayerCfgList(playerRewardPlanId)
	return self.help_dragon_mom_reward_player[playerRewardPlanId]
end

function HelpDragonMomConfig:getRewardWorldCfgList(worldRewardPlanId)
	return self.help_dragon_mom_reward_world[worldRewardPlanId]
end

function HelpDragonMomConfig:getRuleCfgList()
	return self.help_dragon_mom_rule.dataList
end

function HelpDragonMomConfig:getRuleCfg(id)
	return self.help_dragon_mom_rule[id]
end

HelpDragonMomConfig.instance = HelpDragonMomConfig.New()

return HelpDragonMomConfig
