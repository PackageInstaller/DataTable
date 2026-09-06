-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankverify/config/RankVerifyConfig.lua

module("logic.extensions.rankverify.config.RankVerifyConfig", package.seeall)

local RankVerifyConfig = class("RankVerifyConfig", BaseConfig)

function RankVerifyConfig:onInit()
	RankVerifyConfig.super.onInit(self)

	self._commonCfgs = nil
	self._taskCfgs = nil
	self._prizeCfgs = nil
end

function RankVerifyConfig:getNames()
	return {
		"verification_task_prize_task",
		"verification_task_prize",
		"verification_task_prize_prize"
	}
end

function RankVerifyConfig:handleConfig(name, content)
	if name == "verification_task_prize" then
		self._commonCfgs = content
	elseif name == "verification_task_prize_task" then
		self._taskCfgs = content
	elseif name == "verification_task_prize_prize" then
		self._prizeCfgs = content
	end
end

function RankVerifyConfig:getCommonCfgByActId(actId)
	return self._commonCfgs[actId]
end

function RankVerifyConfig:getTaskCfgs(actId)
	local commonCfg = self:getCommonCfgByActId(actId)
	local taskPlanId = commonCfg and commonCfg.taskPlanId

	if taskPlanId then
		return self._taskCfgs[taskPlanId]
	end
end

function RankVerifyConfig:getPrizeCfgs(actId)
	local commonCfg = self:getCommonCfgByActId(actId)
	local prizePlanId = commonCfg and commonCfg.prizePlanId

	if prizePlanId then
		return self._prizeCfgs[prizePlanId]
	end
end

RankVerifyConfig.instance = RankVerifyConfig.New()

return RankVerifyConfig
