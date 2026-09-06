-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/config/MirrorTrialConfig.lua

module("logic.extensions.mirrortrial.config.MirrorTrialConfig", package.seeall)

local MirrorTrialConfig = class("MirrorTrialConfig", BaseConfig)

function MirrorTrialConfig:onInit()
	MirrorTrialConfig.super.onInit(self)

	self._baseCfgs = nil
	self._chapterCfgs = nil
	self._stageCfgs = nil
	self._stageCfgsByChapter = nil
	self._creepCfgs = nil
	self._prizePlanCfgs = nil
	self._propertyPlanCfgs = nil
end

function MirrorTrialConfig:getNames()
	return {
		"mirror_trial_activity",
		"mirror_trial_chapter",
		"mirror_trial_stage",
		"mirror_trial_creeps",
		"mirror_trial_prize_plan",
		"mirror_trial_property_plan"
	}
end

function MirrorTrialConfig:handleConfig(name, content)
	if name == "mirror_trial_activity" then
		self._baseCfg = content
	elseif name == "mirror_trial_chapter" then
		self._chapterCfgs = content
	elseif name == "mirror_trial_stage" then
		self._stageCfgs = content
		self._stageCfgsByChapter = {}

		for k, v in pairs(content.dataList) do
			self._stageCfgsByChapter[v.activityId] = self._stageCfgsByChapter[v.activityId] or {}
			self._stageCfgsByChapter[v.activityId][v.chapterId] = self._stageCfgsByChapter[v.activityId][v.chapterId] or {}
			self._stageCfgsByChapter[v.activityId][v.chapterId][v.stageId] = v
		end
	elseif name == "mirror_trial_creeps" then
		self._creepCfgs = content
	elseif name == "mirror_trial_prize_plan" then
		self._prizePlanCfgs = {}

		for k, v in pairs(content.dataList) do
			self._prizePlanCfgs[v.planId] = self._prizePlanCfgs[v.planId] or {}

			table.insert(self._prizePlanCfgs[v.planId], v)
		end
	elseif name == "mirror_trial_property_plan" then
		self._propertyPlanCfgs = {}

		for k, v in pairs(content.dataList) do
			self._propertyPlanCfgs[v.planId] = v
		end
	end
end

function MirrorTrialConfig:getActBaseCfgById(actId)
	return self._baseCfg[checkint(actId)]
end

function MirrorTrialConfig:getChapterCfgsById(actId, chapterId)
	local id = checkint(chapterId)

	if id > 0 then
		return self._chapterCfgs[checkint(actId)][id]
	end

	return self._chapterCfgs[checkint(actId)]
end

function MirrorTrialConfig:getStageCfgsByChapterId(actId, chapterId)
	return self._stageCfgsByChapter[actId][chapterId]
end

function MirrorTrialConfig:getStageCfgsById(actId, stageId)
	local id = checkint(stageId)

	if id > 0 then
		return self._stageCfgs[checkint(actId)][id]
	end

	return self._stageCfgs[checkint(actId)]
end

function MirrorTrialConfig:getCreepCfgsById(creepId)
	return self._creepCfgs[checkint(creepId)]
end

function MirrorTrialConfig:getPrizePlanCfgsById(actId)
	return self._prizePlanCfgs[self._baseCfg[checkint(actId)].prizePlanId]
end

function MirrorTrialConfig:getPropertyIcon(planId)
	return self._propertyPlanCfgs[planId] and self._propertyPlanCfgs[planId].icon
end

MirrorTrialConfig.instance = MirrorTrialConfig.New()

return MirrorTrialConfig
