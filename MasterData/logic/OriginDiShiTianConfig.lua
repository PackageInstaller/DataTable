-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindishitian/config/OriginDiShiTianConfig.lua

module("logic.extensions.originpowersclg.config.OriginDiShiTianConfig", package.seeall)

local OriginDiShiTianConfig = class("OriginDiShiTianConfig", BaseConfig)

function OriginDiShiTianConfig:onInit()
	OriginDiShiTianConfig.super.onInit(self)
end

function OriginDiShiTianConfig:getNames()
	return {
		"origin_dishitian_clg_stage",
		"origin_dishitian_clg_team",
		"origin_dishitian_clg_creeps",
		"origin_dishitian_clg_activity",
		"origin_dishitian_clg_buff"
	}
end

function OriginDiShiTianConfig:handleConfig(name, content)
	if name == "origin_dishitian_clg_stage" then
		self._origin_dishitian_clg_stage = content
	elseif name == "origin_dishitian_clg_team" then
		self._origin_dishitian_clg_team = content
	elseif name == "origin_dishitian_clg_creeps" then
		self._origin_dishitian_clg_creeps = content
	elseif name == "origin_dishitian_clg_activity" then
		self._origin_dishitian_clg_activity = content
	elseif name == "origin_dishitian_clg_buff" then
		self._origin_dishitian_clg_buff = content

		self:handlerBuffCfgs(content)
	end
end

function OriginDiShiTianConfig:handlerBuffCfgs(content)
	self._buffCfgs = {}

	for i, v in ipairs(content.dataList) do
		self._buffCfgs[v.buffPlanId] = self._buffCfgs[v.buffPlanId] or {}
		self._buffCfgs[v.buffPlanId][v.buffType] = self._buffCfgs[v.buffPlanId][v.buffType] or {}

		local plan = self._buffCfgs[v.buffPlanId][v.buffType]

		table.insert(plan, {
			pos = v.pos,
			count = v.count
		})
	end
end

function OriginDiShiTianConfig:getActivityCfg(activityId)
	return self._origin_dishitian_clg_activity[activityId]
end

function OriginDiShiTianConfig:getTeamCfg(creepsMasterId)
	return self._origin_dishitian_clg_team[creepsMasterId]
end

function OriginDiShiTianConfig:getCreepsCfg(creepsMasterId)
	return self._origin_dishitian_clg_creeps[creepsMasterId]
end

function OriginDiShiTianConfig:getStageCfgs(activityId)
	return self._origin_dishitian_clg_stage[activityId]
end

function OriginDiShiTianConfig:getStageCfg(activityId, stageId)
	if self._origin_dishitian_clg_stage[activityId] then
		return self._origin_dishitian_clg_stage[activityId][stageId]
	end
end

function OriginDiShiTianConfig:getBuffPlan(buffPlanId, buffType)
	return self._buffCfgs[buffPlanId][buffType]
end

OriginDiShiTianConfig.instance = OriginDiShiTianConfig.New()

return OriginDiShiTianConfig
