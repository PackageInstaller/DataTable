-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/config/OriginKingOrderClgConfig.lua

module("logic.extensions.originkingorderclg.config.OriginKingOrderClgConfig", package.seeall)

local OriginKingOrderClgConfig = class("OriginKingOrderClgConfig", BaseConfig)

function OriginKingOrderClgConfig:getNames()
	return {
		"origin_king_order_clg",
		"origin_king_order_clg_creeps",
		"origin_king_order_clg_creeps_master",
		"origin_king_order_clg_stage"
	}
end

function OriginKingOrderClgConfig:handleConfig(name, content)
	if name == "origin_king_order_clg" then
		self._origin_king_order_clg = content
	elseif name == "origin_king_order_clg_creeps" then
		self._origin_king_order_clg_creeps = content
	elseif name == "origin_king_order_clg_creeps_master" then
		self._origin_king_order_clg_creeps_master = content
	elseif name == "origin_king_order_clg_stage" then
		self._origin_king_order_clg_stage = content
	end
end

function OriginKingOrderClgConfig:_safeGet(data, ...)
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

function OriginKingOrderClgConfig:getActivityData(activityId)
	return self:_safeGet(self._origin_king_order_clg, activityId)
end

function OriginKingOrderClgConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._origin_king_order_clg_creeps, creepsMasterId)
end

function OriginKingOrderClgConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._origin_king_order_clg_creeps, creepsMasterId, creepsId)
end

function OriginKingOrderClgConfig:getCreepsMasterData(creepsMasterId)
	return self:_safeGet(self._origin_king_order_clg_creeps_master, creepsMasterId)
end

function OriginKingOrderClgConfig:getStageDatas(activityId)
	return self:_safeGet(self._origin_king_order_clg_stage, activityId)
end

function OriginKingOrderClgConfig:getStageData(activityId, stageId)
	return self:_safeGet(self._origin_king_order_clg_stage, activityId, stageId)
end

OriginKingOrderClgConfig.instance = OriginKingOrderClgConfig.New()

return OriginKingOrderClgConfig
