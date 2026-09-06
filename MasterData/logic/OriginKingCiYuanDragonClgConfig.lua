-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/config/OriginKingCiYuanDragonClgConfig.lua

module("logic.extensions.originkingciyuandragonclg.config.OriginKingCiYuanDragonClgConfig", package.seeall)

local OriginKingCiYuanDragonClgConfig = class("OriginKingCiYuanDragonClgConfig", BaseConfig)

function OriginKingCiYuanDragonClgConfig:getNames()
	return {
		"origin_king_ci_yuan_dragon_clg_activity",
		"origin_king_ci_yuan_dragon_clg_creeps",
		"origin_king_ci_yuan_dragon_clg_monster",
		"origin_king_ci_yuan_dragon_clg_stage"
	}
end

function OriginKingCiYuanDragonClgConfig:handleConfig(name, content)
	if name == "origin_king_ci_yuan_dragon_clg_activity" then
		self._origin_king_ci_yuan_dragon_clg_activity = content
	elseif name == "origin_king_ci_yuan_dragon_clg_creeps" then
		self._origin_king_ci_yuan_dragon_clg_creeps = content
	elseif name == "origin_king_ci_yuan_dragon_clg_monster" then
		self._origin_king_ci_yuan_dragon_clg_monster = content
	elseif name == "origin_king_ci_yuan_dragon_clg_stage" then
		self._origin_king_ci_yuan_dragon_clg_stage = content

		self:_initStageDataByBlock(content.dataList)
	end
end

function OriginKingCiYuanDragonClgConfig:_safeGet(data, ...)
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

function OriginKingCiYuanDragonClgConfig:getActivityData(activityId, passPrize)
	return self:_safeGet(self._origin_king_ci_yuan_dragon_clg_activity, activityId, passPrize)
end

function OriginKingCiYuanDragonClgConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._origin_king_ci_yuan_dragon_clg_creeps, creepsMasterId)
end

function OriginKingCiYuanDragonClgConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._origin_king_ci_yuan_dragon_clg_creeps, creepsMasterId, creepsId)
end

function OriginKingCiYuanDragonClgConfig:getMonsterData(creepsMasterId)
	return self:_safeGet(self._origin_king_ci_yuan_dragon_clg_monster, creepsMasterId)
end

function OriginKingCiYuanDragonClgConfig:getStageDatas(activityId)
	return self:_safeGet(self._origin_king_ci_yuan_dragon_clg_stage, activityId)
end

function OriginKingCiYuanDragonClgConfig:getStageData(activityId, stageId)
	return self:_safeGet(self._origin_king_ci_yuan_dragon_clg_stage, activityId, stageId)
end

function OriginKingCiYuanDragonClgConfig:getStageBlockCfg(activityId)
	return self._stageDataByBlock[activityId]
end

function OriginKingCiYuanDragonClgConfig:getStageDatasByBlock(activityId, blockId)
	if self._stageDataByBlock[activityId] then
		return self._stageDataByBlock[activityId][blockId]
	end
end

function OriginKingCiYuanDragonClgConfig:getStageDataByBlock(activityId, blockId, blockStageId)
	if self._stageDataByBlock[activityId] and self._stageDataByBlock[activityId][blockId] then
		return self._stageDataByBlock[activityId][blockId][blockStageId]
	end
end

function OriginKingCiYuanDragonClgConfig:_initStageDataByBlock(dataList)
	self._stageDataByBlock = {}

	for _, v in ipairs(dataList) do
		self._stageDataByBlock = MmUtil.checkTable(self._stageDataByBlock, v.activityId, v.blockId)
		self._stageDataByBlock[v.activityId][v.blockId][v.blockStageId] = v
	end
end

OriginKingCiYuanDragonClgConfig.instance = OriginKingCiYuanDragonClgConfig.New()

return OriginKingCiYuanDragonClgConfig
