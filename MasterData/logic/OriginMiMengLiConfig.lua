-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/config/OriginMiMengLiConfig.lua

module("logic.extensions.originmimengli.config.OriginMiMengLiConfig", package.seeall)

local OriginMiMengLiConfig = class("OriginMiMengLiConfig", BaseConfig)

function OriginMiMengLiConfig:onInit()
	OriginMiMengLiConfig.super.onInit(self)
end

function OriginMiMengLiConfig:getNames()
	return {
		"origin_mi_meng_li_activity",
		"origin_mi_meng_li_creeps",
		"origin_mi_meng_li_master",
		"origin_mi_meng_li_stage"
	}
end

function OriginMiMengLiConfig:handleConfig(name, content)
	if name == "origin_mi_meng_li_activity" then
		self._origin_mi_meng_li_activity = content
	elseif name == "origin_mi_meng_li_creeps" then
		self._origin_mi_meng_li_creeps = content
	elseif name == "origin_mi_meng_li_master" then
		self._origin_mi_meng_li_master = content
	elseif name == "origin_mi_meng_li_stage" then
		self._origin_mi_meng_li_stage = content
	end
end

function OriginMiMengLiConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function OriginMiMengLiConfig:getActCfgByActId(activityId)
	return self:_safeGet(self._origin_mi_meng_li_activity, activityId)
end

function OriginMiMengLiConfig:getAllStageCfgs(activityId)
	return self:_safeGet(self._origin_mi_meng_li_stage, activityId)
end

function OriginMiMengLiConfig:getSingleStageCfgById(activityId, stageId)
	return self:_safeGet(self._origin_mi_meng_li_stage, activityId, stageId)
end

function OriginMiMengLiConfig:getCreepCfgs(creepsMasterId)
	return self:_safeGet(self._origin_mi_meng_li_creeps, creepsMasterId)
end

function OriginMiMengLiConfig:getTeamCfg(creepsMasterId)
	return self:_safeGet(self._origin_mi_meng_li_master, creepsMasterId)
end

OriginMiMengLiConfig.instance = OriginMiMengLiConfig.New()

return OriginMiMengLiConfig
