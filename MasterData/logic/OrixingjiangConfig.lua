-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orixingjiang/config/OrixingjiangConfig.lua

module("logic.extensions.orixingjiang.config.OrixingjiangConfig", package.seeall)

local OrixingjiangConfig = class("OrixingjiangConfig", BaseConfig)

function OrixingjiangConfig:onInit()
	return
end

function OrixingjiangConfig:getNames()
	return {
		"origin_xingjiang_transmog_num_buff",
		"origin_xingjiang_master",
		"origin_xingjiang_transmog",
		"origin_xingjiang_stage",
		"origin_xingjiang_activity",
		"origin_xingjiang_creeps"
	}
end

function OrixingjiangConfig:handleConfig(name, content)
	if name == "origin_xingjiang_transmog_num_buff" then
		self._origin_xingjiang_transmog_num_buff = content
	elseif name == "origin_xingjiang_master" then
		self._origin_xingjiang_master = content
	elseif name == "origin_xingjiang_transmog" then
		self._origin_xingjiang_transmog = content
	elseif name == "origin_xingjiang_stage" then
		self._origin_xingjiang_stage = content
	elseif name == "origin_xingjiang_activity" then
		self._origin_xingjiang_activity = content
	elseif name == "origin_xingjiang_creeps" then
		self._origin_xingjiang_creeps = content
	end
end

function OrixingjiangConfig:getStageCfgs(activityId)
	return self._origin_xingjiang_stage[activityId]
end

function OrixingjiangConfig:getStageCfg(activityId, stageId)
	return self._origin_xingjiang_stage[activityId][stageId]
end

function OrixingjiangConfig:getActCfg(activityId)
	return self._origin_xingjiang_activity[activityId]
end

function OrixingjiangConfig:getCreepsCfgs(creepsMasterId)
	return self._origin_xingjiang_creeps[creepsMasterId]
end

function OrixingjiangConfig:getCreepsMasterCfg(creepsMasterId)
	return self._origin_xingjiang_master[creepsMasterId]
end

function OrixingjiangConfig:getBuffCfgs(activityId)
	return self._origin_xingjiang_transmog_num_buff[activityId]
end

function OrixingjiangConfig:getBuffDescByAliveTransmogNum(activityId, aliveTransmogNum)
	local cfgs = self:getBuffCfgs(activityId)
	local newCfgs = table.values(cfgs)

	table.sort(newCfgs, function(a, b)
		return a.aliveTransmogNum < b.aliveTransmogNum
	end)

	for i = #newCfgs, 1, -1 do
		local cfg = newCfgs[i]

		if aliveTransmogNum >= cfg.aliveTransmogNum then
			return cfg.desc
		end
	end

	return "暂未触发效果", -1
end

function OrixingjiangConfig:getTransmogCfg(activityId, transmogId)
	return self._origin_xingjiang_transmog[activityId][transmogId]
end

OrixingjiangConfig.instance = OrixingjiangConfig.New()

return OrixingjiangConfig
