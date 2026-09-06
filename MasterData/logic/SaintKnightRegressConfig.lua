-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/config/SaintKnightRegressConfig.lua

module("logic.extensions.saintknightregress.SaintKnightRegressConfig", package.seeall)

local SaintKnightRegressConfig = class("SaintKnightRegressConfig", BaseConfig)

function SaintKnightRegressConfig:onInit()
	SaintKnightRegressConfig.super.onInit(self)
end

function SaintKnightRegressConfig:getNames()
	return {
		"saint_knight_regress_activity",
		"saint_knight_regress_invite_task",
		"saint_knight_regress_task",
		"saint_knight_regress_normal_lottery_prize",
		"saint_knight_regress_super_lottery_prize",
		"saint_knight_regress_effect_platform",
		"saint_knight_regress_task_count_prize"
	}
end

function SaintKnightRegressConfig:handleConfig(name, content)
	if name == "saint_knight_regress_activity" then
		self._saint_knight_regress_activity = content
	elseif name == "saint_knight_regress_invite_task" then
		self._saint_knight_regress_invite_task = content
	elseif name == "saint_knight_regress_task" then
		self._saint_knight_regress_task = content
	elseif name == "saint_knight_regress_normal_lottery_prize" then
		self._saint_knight_regress_normal_lottery_prize = content
	elseif name == "saint_knight_regress_super_lottery_prize" then
		self._saint_knight_regress_super_lottery_prize = content
	elseif name == "saint_knight_regress_effect_platform" then
		self._saint_knight_regress_effect_platform = content
	elseif name == "saint_knight_regress_task_count_prize" then
		self._saint_knight_regress_task_count_prize = content
	end
end

function SaintKnightRegressConfig:getActivityCfg(activityId)
	return self._saint_knight_regress_activity[activityId]
end

function SaintKnightRegressConfig:getNormalLotteryPrizeCfgs(activityId)
	return self._saint_knight_regress_normal_lottery_prize[activityId]
end

function SaintKnightRegressConfig:getNormalLotteryPrizeCfg(activityId, prizeId)
	if self._saint_knight_regress_normal_lottery_prize[activityId] then
		return self._saint_knight_regress_normal_lottery_prize[activityId][prizeId]
	end
end

function SaintKnightRegressConfig:getSuperLotteryPrizeCfgs(activityId)
	return self._saint_knight_regress_super_lottery_prize[activityId]
end

function SaintKnightRegressConfig:getSuperLotteryPrizeCfg(activityId, prizeId)
	if self._saint_knight_regress_super_lottery_prize[activityId] then
		return self._saint_knight_regress_super_lottery_prize[activityId][prizeId]
	end
end

function SaintKnightRegressConfig:getInviteTaskCfgs(activityId)
	return self._saint_knight_regress_invite_task[activityId]
end

function SaintKnightRegressConfig:getInviteTaskCfg(activityId, taskId)
	if self._saint_knight_regress_invite_task[activityId] then
		return self._saint_knight_regress_invite_task[activityId][taskId]
	end
end

function SaintKnightRegressConfig:getRegressTasks(activityId)
	return self._saint_knight_regress_task[activityId]
end

function SaintKnightRegressConfig:getRegressTaskCfg(activityId, taskId)
	if self._saint_knight_regress_task[activityId] then
		return self._saint_knight_regress_task[activityId][taskId]
	end
end

function SaintKnightRegressConfig:getPlatformSetting(activityId)
	return self._saint_knight_regress_effect_platform[activityId]
end

function SaintKnightRegressConfig:getTaskCountCfgs(activityId)
	return self._saint_knight_regress_task_count_prize[activityId]
end

SaintKnightRegressConfig.instance = SaintKnightRegressConfig.New()

return SaintKnightRegressConfig
