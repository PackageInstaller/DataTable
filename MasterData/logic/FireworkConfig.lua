-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firework/config/FireworkConfig.lua

module("logic.extensions.firework.config.FireworkConfig", package.seeall)

local FireworkConfig = class("FireworkConfig", BaseConfig)

FireworkConfig.randomTips = {
	"战力暴涨、欧皇降临…快来许下心愿吧~",
	"十载同心，一起再出发",
	"放烟花，领满级装备经验宝箱与钻石好礼"
}

function FireworkConfig:onInit()
	FireworkConfig.super.onInit(self)
end

function FireworkConfig:getNames()
	return {
		"fire_works_display_activity",
		"fire_works_display_scene_time",
		"fire_works_display_scene",
		"fire_works_display_position",
		"fire_works_display_normal_prize",
		"fire_works_display_world_progress",
		"fire_works_display_progress_prize"
	}
end

function FireworkConfig:handleConfig(name, content)
	if name == "fire_works_display_activity" then
		self._planCfg = content
	elseif name == "fire_works_display_scene_time" then
		self._sceneTimeCfg = content
	elseif name == "fire_works_display_scene" then
		self._scenePosCfg = content
	elseif name == "fire_works_display_position" then
		self._sceneNPCCfg = content
	elseif name == "fire_works_display_normal_prize" then
		self._normalPrizeCfg = content
	elseif name == "fire_works_display_world_progress" then
		self._worldProgressCfg = content
	elseif name == "fire_works_display_progress_prize" then
		self._worldPrizeCfg = content
	end
end

function FireworkConfig:getPlanCfg(actid)
	return self._planCfg[actid]
end

function FireworkConfig:getSceneTimeCfgs(actid, id)
	local plan = self._planCfg[actid].sceneTimePlanId

	if id then
		return self._sceneTimeCfg[plan][id]
	end

	return self._sceneTimeCfg[plan]
end

function FireworkConfig:getScenePosCfg(actid, sceneId)
	local plan = self._planCfg[actid].scenePlanId

	return self._scenePosCfg[plan][sceneId]
end

function FireworkConfig:getSceneNPCCfgs(scenePositionPlanId)
	return self._sceneNPCCfg[scenePositionPlanId]
end

function FireworkConfig:getSceneNPCCfgsByTimeId(actid, timeId)
	local sceneId = self:getSceneTimeCfgs(actid, timeId).sceneId
	local scenePositionPlanId = self:getScenePosCfg(actid, sceneId).scenePositionPlanId

	return self._sceneNPCCfg[scenePositionPlanId]
end

function FireworkConfig:getIdByNpcId(actid, timeId, npcId)
	local cfgs = self:getSceneNPCCfgsByTimeId(actid, timeId)

	for k, v in pairs(cfgs) do
		if v.npcId == npcId then
			return v.id
		end
	end
end

function FireworkConfig:getPrizeCfgs(actid, planId)
	return self._normalPrizeCfg[planId]
end

function FireworkConfig:getWorldProgressCfgs(actid)
	local plan = self._planCfg[actid].worldProgressPlanId

	return self._worldProgressCfg[plan]
end

function FireworkConfig:getWorldPrizeCfgs(actid)
	local plan = self._planCfg[actid].worldProgressPrizePlanId

	return self._worldPrizeCfg[plan]
end

FireworkConfig.instance = FireworkConfig.New()

return FireworkConfig
