-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/config/DivineShiKongLongZunConfig.lua

module("logic.extensions.divineshikonglongzunmainview.config.DivineShiKongLongZunConfig", package.seeall)

local DivineShiKongLongZunConfig = class("DivineShiKongLongZunConfig", BaseConfig)

function DivineShiKongLongZunConfig:onInit()
	DivineShiKongLongZunConfig.super.onInit(self)
end

function DivineShiKongLongZunConfig:getNames()
	return {
		"divine_ts_dragon_loard_clg_activity",
		"divine_ts_dragon_loard_clg_stage",
		"divine_ts_dragon_loard_clg_monster",
		"divine_ts_dragon_loard_clg_creeps",
		"divine_ts_dragon_loard_clg_common"
	}
end

function DivineShiKongLongZunConfig:handleConfig(name, content)
	if name == "divine_ts_dragon_loard_clg_activity" then
		self.divine_ts_dragon_loard_clg_activity = content
	elseif name == "divine_ts_dragon_loard_clg_stage" then
		self.divine_ts_dragon_loard_clg_stage = content
	elseif name == "divine_ts_dragon_loard_clg_monster" then
		self.divine_ts_dragon_loard_clg_monster = content
	elseif name == "divine_ts_dragon_loard_clg_creeps" then
		self.divine_ts_dragon_loard_clg_creeps = content
	elseif name == "divine_ts_dragon_loard_clg_common" then
		self.divine_ts_dragon_loard_clg_common = content
	end
end

function DivineShiKongLongZunConfig:getDivineTsDragonLoardClgData(activityId)
	return self.divine_ts_dragon_loard_clg_activity[activityId]
end

function DivineShiKongLongZunConfig:getDivineTsDragonLoardClgStageData(activityId)
	return self.divine_ts_dragon_loard_clg_stage[activityId]
end

function DivineShiKongLongZunConfig:getStageData(activityId, stageId)
	if self.divine_ts_dragon_loard_clg_stage[activityId] then
		return self.divine_ts_dragon_loard_clg_stage[activityId][stageId] or {}
	end
end

function DivineShiKongLongZunConfig:getDivineTsDragonLoardClgMonsterData(masterId)
	return self.divine_ts_dragon_loard_clg_monster[masterId]
end

function DivineShiKongLongZunConfig:getDivineTsDragonLoardClgCreepsData(masterId)
	return self.divine_ts_dragon_loard_clg_creeps[masterId]
end

function DivineShiKongLongZunConfig:getCommonData(activityId)
	local comPlanId = self.divine_ts_dragon_loard_clg_activity[activityId].comPlanId

	return self.divine_ts_dragon_loard_clg_common[comPlanId]
end

function DivineShiKongLongZunConfig:getCommonValue(activityId, key)
	local comPlanId = self.divine_ts_dragon_loard_clg_activity[activityId].comPlanId

	return self.divine_ts_dragon_loard_clg_common[comPlanId] and self.divine_ts_dragon_loard_clg_common[comPlanId][key]
end

function DivineShiKongLongZunConfig:getTeamTotalNum(activityId, stageId)
	if self.divine_ts_dragon_loard_clg_stage[activityId] and self.divine_ts_dragon_loard_clg_stage[activityId][stageId] then
		return #self.divine_ts_dragon_loard_clg_stage[activityId][stageId].teams
	end
end

function DivineShiKongLongZunConfig:getStageTotalNum(activityId)
	if self.divine_ts_dragon_loard_clg_stage[activityId] then
		return #self.divine_ts_dragon_loard_clg_stage[activityId]
	end
end

function DivineShiKongLongZunConfig:getPassExpression(activityId, stageId)
	if self.divine_ts_dragon_loard_clg_stage[activityId] then
		return self.divine_ts_dragon_loard_clg_stage[activityId][stageId].passExpression
	end
end

DivineShiKongLongZunConfig.instance = DivineShiKongLongZunConfig.New()

return DivineShiKongLongZunConfig
