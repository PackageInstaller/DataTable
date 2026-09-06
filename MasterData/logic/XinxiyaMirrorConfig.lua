-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/config/XinxiyaMirrorConfig.lua

module("logic.extensions.xinxiyamirror.config.XinxiyaMirrorConfig", package.seeall)

local XinxiyaMirrorConfig = class("XinxiyaMirrorConfig", BaseConfig)

function XinxiyaMirrorConfig:onInit()
	XinxiyaMirrorConfig.super.onInit(self)

	self._openTimeCfgs = nil
	self._allStageCfgs = nil
	self._masterTeamCfgs = nil
	self._masterCreepsCfgs = nil
end

function XinxiyaMirrorConfig:getNames()
	return {
		"mirror_challenge",
		"mirror_challenge_stage",
		"mirror_challenge_team",
		"mirror_challenge_creeps"
	}
end

function XinxiyaMirrorConfig:handleConfig(name, content)
	if name == "mirror_challenge" then
		self._openTimeCfgs = content
	elseif name == "mirror_challenge_stage" then
		self._allStageCfgs = content
	elseif name == "mirror_challenge_team" then
		self._masterTeamCfgs = content
	elseif name == "mirror_challenge_creeps" then
		self._masterCreepsCfgs = content
	end
end

function XinxiyaMirrorConfig:getOpenActivityId()
	if self._openTimeCfgs == nil then
		return -1
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(XinxiyaMirrorModel.instance.activityType)

	if cfgs == nil then
		return -2
	end

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			XinxiyaMirrorModel.instance.lastActivityId = item.activityId

			return item.activityId
		end
	end

	return -3
end

function XinxiyaMirrorConfig:getOpenTimeCfg(actId)
	if self._openTimeCfgs == nil or self._openTimeCfgs[actId] == nil then
		return nil
	end

	return self._openTimeCfgs[actId]
end

function XinxiyaMirrorConfig:getBattleStageCfg(planId, stageId)
	if self._allStageCfgs == nil or self._allStageCfgs[planId] == nil then
		return
	end

	local list = self._allStageCfgs[planId]

	if checknumber(stageId) <= 0 or list[stageId] == nil then
		return list
	end

	return list[stageId]
end

function XinxiyaMirrorConfig:getMasterTeamCfg(masterId)
	if self._masterTeamCfgs == nil or self._masterTeamCfgs[masterId] == nil then
		return
	end

	return self._masterTeamCfgs[masterId]
end

function XinxiyaMirrorConfig:getMasterCreepsCfg(masterId, creepsId)
	if self._masterCreepsCfgs == nil or self._masterCreepsCfgs[masterId] == nil then
		return
	end

	local list = self._masterCreepsCfgs[masterId]

	if list[creepsId] == nil then
		return list
	end

	return list[creepsId]
end

function XinxiyaMirrorConfig:getMirrorShopsCfg(actId)
	if checknumber(actId) <= 0 then
		return
	end

	local allCfgs = ActivityshopConfig.instance:getActivityShopCfgWithPage(XinxiyaMirrorModel.instance.activityType, actId)

	if allCfgs == nil or allCfgs[1] == nil then
		return
	end

	local name = ActivityshopConfig.instance:getActShopTitleName(XinxiyaMirrorModel.instance.activityType, actId)
	local cfg = ActivityshopConfig.instance:getActivityShopPageCfg(XinxiyaMirrorModel.instance.activityType, actId, 1)

	return allCfgs[1], cfg, name
end

XinxiyaMirrorConfig.instance = XinxiyaMirrorConfig.New()

return XinxiyaMirrorConfig
