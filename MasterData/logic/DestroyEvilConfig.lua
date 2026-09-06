-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/config/DestroyEvilConfig.lua

module("logic.extensions.destroyevil.config.DestroyEvilConfig", package.seeall)

local DestroyEvilConfig = class("DestroyEvilConfig", BaseConfig)

function DestroyEvilConfig:onInit()
	DestroyEvilConfig.super.onInit(self)

	self.destroy_evil_activity = nil
	self.destroy_evil_discover_score = nil
	self.destroy_evil_ticket = nil
	self.destroy_evil_monster = nil
	self.destroy_evil_master = nil
	self.destroy_evil_creeps = nil
	self.destroy_evil_score = nil
	self.destroy_evil_ticket_buy = nil
	self.destroy_evil_strength_purchase = nil
	self.destroy_evil_buff = nil
end

function DestroyEvilConfig:getNames()
	return {
		"destroy_evil_activity",
		"destroy_evil_discover_score",
		"destroy_evil_ticket",
		"destroy_evil_monster",
		"destroy_evil_master",
		"destroy_evil_creeps",
		"destroy_evil_score",
		"destroy_evil_ticket_buy",
		"destroy_evil_strength_purchase",
		"destroy_evil_buff",
		"destroy_evil_reset_difficulty_cost",
		"destroy_evil_difficult_recommend"
	}
end

function DestroyEvilConfig:handleConfig(name, content)
	if name == "destroy_evil_activity" then
		self.destroy_evil_activity = content
	elseif name == "destroy_evil_discover_score" then
		self.destroy_evil_discover_score = content
	elseif name == "destroy_evil_ticket" then
		self.destroy_evil_ticket = content
	elseif name == "destroy_evil_monster" then
		self.destroy_evil_monster = content
	elseif name == "destroy_evil_master" then
		self.destroy_evil_master = content
	elseif name == "destroy_evil_creeps" then
		self.destroy_evil_creeps = content
	elseif name == "destroy_evil_score" then
		self.destroy_evil_score = content
	elseif name == "destroy_evil_ticket_buy" then
		self.destroy_evil_ticket_buy = content
	elseif name == "destroy_evil_strength_purchase" then
		self.destroy_evil_strength_purchase = content
	elseif name == "destroy_evil_buff" then
		self.destroy_evil_buff = content
	elseif name == "destroy_evil_reset_difficulty_cost" then
		self._destroy_evil_reset_difficulty_cost = content
	elseif name == "destroy_evil_difficult_recommend" then
		self._destroy_evil_difficult_recommend = content
	end
end

function DestroyEvilConfig:getActivityCfg(id)
	return self.destroy_evil_activity[id]
end

function DestroyEvilConfig:getBuffCfgs(buffPlanId)
	return self.destroy_evil_buff[buffPlanId]
end

function DestroyEvilConfig:getBuffCfg(buffPlanId, day)
	if self.destroy_evil_buff[buffPlanId] then
		return self.destroy_evil_buff[buffPlanId][day]
	end

	return nil
end

function DestroyEvilConfig:getBuyStrengthPlans(activityId)
	return self.destroy_evil_strength_purchase[activityId]
end

function DestroyEvilConfig:getMonsterCfg(activityId, monsterId)
	return self.destroy_evil_monster[activityId] and self.destroy_evil_monster[activityId][monsterId]
end

function DestroyEvilConfig:getMaster(creepsMasterId)
	return self.destroy_evil_master[creepsMasterId]
end

function DestroyEvilConfig:getCreeps(creepsMasterId)
	return self.destroy_evil_creeps[creepsMasterId]
end

function DestroyEvilConfig:getTicketsList(activityId)
	return self.destroy_evil_ticket[activityId] or {}
end

function DestroyEvilConfig:getTicket(activityId, ticketId)
	return self.destroy_evil_ticket[activityId] and self.destroy_evil_ticket[activityId][ticketId]
end

function DestroyEvilConfig:getScoreList(scorePlanId)
	return self.destroy_evil_score[scorePlanId] or {}
end

function DestroyEvilConfig:getScoreCfg(scorePlanId)
	if self.destroy_evil_score[scorePlanId] and self.destroy_evil_score[scorePlanId][1] then
		return self.destroy_evil_score[scorePlanId][1]
	end
end

function DestroyEvilConfig:getResetDiffitcultCostCfgs(resetDifficultyCostPlanId)
	return self._destroy_evil_reset_difficulty_cost[resetDifficultyCostPlanId]
end

function DestroyEvilConfig:getResetDiffitcultCostCfg(resetDifficultyCostPlanId, times)
	return self._destroy_evil_reset_difficulty_cost[resetDifficultyCostPlanId][times]
end

function DestroyEvilConfig:getDifficultRecommondCfgs(activityId)
	return self._destroy_evil_difficult_recommend[activityId]
end

function DestroyEvilConfig:getDifficultRecommondCfg(activityId, difficult)
	return self._destroy_evil_difficult_recommend[activityId][difficult]
end

DestroyEvilConfig.instance = DestroyEvilConfig.New()

return DestroyEvilConfig
