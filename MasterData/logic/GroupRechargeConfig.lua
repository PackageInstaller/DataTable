-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/config/GroupRechargeConfig.lua

module("logic.extensions.grouprecharge.config.GroupRechargeConfig", package.seeall)

local GroupRechargeConfig = class("GroupRechargeConfig", BaseConfig)

GroupRechargeConfig.Agree = 1
GroupRechargeConfig.Disagree = 2
GroupRechargeConfig.Personal = 1
GroupRechargeConfig.Team = 2
GroupRechargeConfig.LT_Captain = 1
GroupRechargeConfig.LT_Friend = 2
GroupRechargeConfig.LT_Match = 3

function GroupRechargeConfig:onInit()
	GroupRechargeConfig.super.onInit(self)

	self._group_recharge_activity = nil
	self._group_recharge_position = nil
	self._group_recharge_personal_prize = nil
	self._group_recharge_team_prize = nil
	self._group_recharge_tab = nil
end

function GroupRechargeConfig:getNames()
	return {
		"group_recharge_activity",
		"group_recharge_position",
		"group_recharge_personal_prize",
		"group_recharge_team_prize",
		"group_recharge_tab"
	}
end

function GroupRechargeConfig:handleConfig(name, content)
	if name == "group_recharge_activity" then
		self._group_recharge_activity = content
	elseif name == "group_recharge_position" then
		self._group_recharge_position = content
	elseif name == "group_recharge_personal_prize" then
		self._group_recharge_personal_prize = content
	elseif name == "group_recharge_team_prize" then
		self._group_recharge_team_prize = content
	elseif name == "group_recharge_tab" then
		self._group_recharge_tab = content
	end
end

function GroupRechargeConfig:getTabConfigs()
	return self._group_recharge_tab
end

function GroupRechargeConfig:getRechargePrizeConfigs(type, planId)
	if type == GroupRechargeConfig.Personal then
		return self._group_recharge_personal_prize[planId]
	else
		return self._group_recharge_team_prize[planId]
	end
end

function GroupRechargeConfig:getActivityConfig(activityId)
	return self._group_recharge_activity[activityId]
end

function GroupRechargeConfig:getPositionConfigs()
	return self._group_recharge_position
end

GroupRechargeConfig.instance = GroupRechargeConfig.New()

return GroupRechargeConfig
