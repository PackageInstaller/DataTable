-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/config/ScenariocopyConfig.lua

module("logic.extensions.scenariocopy.config.ScenariocopyConfig", package.seeall)

local ScenariocopyConfig = class("ScenariocopyConfig", BaseConfig)

function ScenariocopyConfig:onInit()
	ScenariocopyConfig.super.onInit(self)

	self._activityDefineCfg = nil
end

function ScenariocopyConfig:getNames()
	return {
		"operation_plot_activity",
		"operation_plot_story",
		"operation_plot_chapter",
		"operation_plot_stage",
		"operation_plot_creeps",
		"operation_plot_support_pet",
		"operation_plot_extra_prize",
		"operation_plot_trial",
		"operation_plot_trial_page",
		"operation_plot_buff",
		"operation_plot_npc"
	}
end

function ScenariocopyConfig:handleConfig(name, content)
	if name == "operation_plot_activity" then
		self._act_cfg = content
	elseif name == "operation_plot_story" then
		self._story_cfg = content
	elseif name == "operation_plot_chapter" then
		self._chapter_cfg = content
	elseif name == "operation_plot_stage" then
		self._stage_cfg = content
	elseif name == "operation_plot_creeps" then
		self._creeps_cfg = content
	elseif name == "operation_plot_support_pet" then
		self._support_cfg = content
	elseif name == "operation_plot_extra_prize" then
		self._prize_cfg = content
	elseif name == "operation_plot_trial" then
		self._trial_cfg = content
	elseif name == "operation_plot_trial_page" then
		self._trialPage_cfg = content
	elseif name == "operation_plot_buff" then
		self._buff_cfg = content
	elseif name == "operation_plot_npc" then
		self._npc_cfg = content
	end
end

function ScenariocopyConfig:getActCfg(activityId)
	return self._act_cfg[activityId]
end

function ScenariocopyConfig:getSignInCfgById(roundSid)
	return self._sign_in_Cfg[roundSid]
end

function ScenariocopyConfig:getStoryCfgs(planId)
	return self._story_cfg[planId]
end

function ScenariocopyConfig:getStoryCfg(planId, storyId)
	return self._story_cfg[planId][storyId]
end

function ScenariocopyConfig:getChapterCfg(storyId, chapterId)
	return self._chapter_cfg[storyId][chapterId]
end

function ScenariocopyConfig:getChapterCfgs(storyId)
	return self._chapter_cfg[storyId]
end

function ScenariocopyConfig:getStageCfg(chapterId, stageId)
	return self._stage_cfg[chapterId][stageId]
end

function ScenariocopyConfig:getSupportCfgs(supportId)
	return self._support_cfg[supportId]
end

function ScenariocopyConfig:getSupportCfg(supportId, creepId)
	return self._support_cfg[supportId][creepId]
end

function ScenariocopyConfig:getCreepsById(creepsMasterId)
	return self._creeps_cfg[creepsMasterId]
end

function ScenariocopyConfig:getPrizeCfg(extPrizetId)
	return self._prize_cfg[extPrizetId]
end

function ScenariocopyConfig:getTrialCfg(trialId)
	return self._trial_cfg[trialId]
end

function ScenariocopyConfig:getTrialCfgs()
	return self._trial_cfg
end

function ScenariocopyConfig:getTrialPageCfgs(trialId)
	return self._trialPage_cfg[trialId]
end

function ScenariocopyConfig:getBuffCfg(planId)
	return self._buff_cfg[planId]
end

function ScenariocopyConfig:getNpcCfg(chapterId)
	return self._npc_cfg[chapterId]
end

ScenariocopyConfig.instance = ScenariocopyConfig.New()

return ScenariocopyConfig
