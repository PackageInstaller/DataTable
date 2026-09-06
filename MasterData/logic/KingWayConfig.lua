-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/config/KingWayConfig.lua

module("logic.extensions.kingway.config.KingWayConfig", package.seeall)

local KingWayConfig = class("KingWayConfig", BaseConfig)

function KingWayConfig:onInit()
	KingWayConfig.super.onInit(self)

	self.wayBaseCfg = nil
	self.wayStageCfg = nil
	self.wayCreepsCfg = nil
end

function KingWayConfig:getNames()
	return {
		"king_road_challenge",
		"king_road_stage",
		"king_road_creeps",
		"king_road_verify_buff",
		"king_road_verify_plan"
	}
end

function KingWayConfig:handleConfig(name, content)
	if name == "king_road_challenge" then
		self.wayBaseCfg = content
	elseif name == "king_road_stage" then
		self.wayStageCfg = content
	elseif name == "king_road_creeps" then
		self.wayCreepsCfg = content
	elseif name == "king_road_verify_buff" then
		self._kingWayVerifyBuff = content
	elseif name == "king_road_verify_plan" then
		self._kingWayVerifyPlan = content
	end
end

function KingWayConfig:GetWayBaseCfg(battleId)
	if self.wayBaseCfg == nil then
		return
	end

	if checknumber(battleId) <= 0 then
		return self.wayBaseCfg
	end

	return self.wayBaseCfg[battleId]
end

function KingWayConfig:GetWayStageCfg(battleId, stageId)
	if checknumber(battleId) <= 0 or self.wayStageCfg == nil then
		return
	end

	if checknumber(stageId) <= 0 then
		return self.wayStageCfg[battleId]
	end

	return self.wayStageCfg[battleId][stageId]
end

function KingWayConfig:GetWayStagesCfg(battleId)
	if checknumber(battleId) <= 0 or self.wayStageCfg == nil then
		return
	end

	return self.wayStageCfg[battleId]
end

function KingWayConfig:GetWayCreepsCfg(masterId, creepsId)
	if self.wayCreepsCfg == nil then
		return
	end

	if checknumber(masterId) <= 0 or self.wayCreepsCfg == nil then
		return
	end

	if checknumber(creepsId) <= 0 then
		return self.wayCreepsCfg[masterId]
	end

	return self.wayCreepsCfg[masterId][creepsId]
end

function KingWayConfig:getVerifyPlan(planId)
	return self._kingWayVerifyPlan[planId]
end

function KingWayConfig:getVerifyBuffs(planId)
	local buffPlanId = self._kingWayVerifyPlan[planId].buffPlanId
	local data = self._kingWayVerifyBuff[buffPlanId]
	local ret = {}

	for k, v in pairs(data) do
		table.insert(ret, v)
	end

	return ret
end

KingWayConfig.instance = KingWayConfig.New()

return KingWayConfig
