-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/config/FunCampConfig.lua

module("logic.extensions.funcamp.config.FunCampConfig", package.seeall)

local FunCampConfig = class("FunCampConfig", BaseConfig)

function FunCampConfig:onInit()
	FunCampConfig.super.onInit(self)

	self.camp_battle_activity = nil
	self.camp_battle_prize_view = nil
	self.camp_battle_flip_touch_interaction = nil
	self.camp_battle_progress = nil
	self.camp_battle_game_buy_cost = nil
	self.camp_battle_stagedes = nil
	self.camp_battle_group = nil
	self.camp_battle_coin_mode = nil
	self.camp_battle_donate_buy_cost = nil
	self.camp_battle_buff = nil
	self.camp_battle_coin_effect = nil
end

function FunCampConfig:getNames()
	return {
		"camp_battle_activity",
		"camp_battle_prize_view",
		"camp_battle_flip_touch_interaction",
		"camp_battle_progress",
		"camp_battle_game_buy_cost",
		"camp_battle_stagedes",
		"camp_battle_group",
		"camp_battle_coin_mode",
		"camp_battle_task",
		"camp_battle_donate_buy_cost",
		"camp_battle_buff",
		"camp_battle_coin_effect"
	}
end

function FunCampConfig:handleConfig(name, content)
	if name == "camp_battle_activity" then
		self.camp_battle_activity = content
	elseif name == "camp_battle_prize_view" then
		self.camp_battle_prize_view = content
	elseif name == "camp_battle_flip_touch_interaction" then
		self.camp_battle_flip_touch_interaction = content
	elseif name == "camp_battle_progress" then
		self.camp_battle_progress = content
	elseif name == "camp_battle_game_buy_cost" then
		self.camp_battle_game_buy_cost = content
	elseif name == "camp_battle_stagedes" then
		self.camp_battle_stagedes = content
	elseif name == "camp_battle_group" then
		self.camp_battle_group = content
	elseif name == "camp_battle_task" then
		self.camp_battle_task = content
	elseif name == "camp_battle_coin_mode" then
		self.camp_battle_coin_mode = content
	elseif name == "camp_battle_donate_buy_cost" then
		self.camp_battle_donate_buy_cost = content
	elseif name == "camp_battle_buff" then
		self.camp_battle_buff = content
	elseif name == "camp_battle_coin_effect" then
		self.camp_battle_coin_effect = content
	end
end

function FunCampConfig:getActivityCfg(id)
	return self.camp_battle_activity[id]
end

function FunCampConfig:getPrizeStr(prizeViewPlanId, param)
	if self.camp_battle_prize_view[prizeViewPlanId] then
		local cfg = self.camp_battle_prize_view[prizeViewPlanId][param]

		if cfg then
			return cfg.prizeView
		else
			return ""
		end
	end

	return ""
end

function FunCampConfig:getInteractionCfg(planId, stageId)
	if self.camp_battle_flip_touch_interaction[planId] then
		return self.camp_battle_flip_touch_interaction[planId][stageId]
	end
end

function FunCampConfig:getInteractionCfgs(planId)
	return self.camp_battle_flip_touch_interaction[planId]
end

function FunCampConfig:getGameBuyCost(gameBuyPlanId, buyTimes)
	local buyTimes = buyTimes + 1
	local list = self.camp_battle_game_buy_cost[gameBuyPlanId]

	if list and #list > 0 then
		local cfg = list[#list]

		for i, v in ipairs(list) do
			if v.buyTimes == buyTimes then
				cfg = v
			end
		end

		return cfg
	else
		return nil
	end
end

function FunCampConfig:getDonateBuyCost(donateBuyPlanId, type, buyTimes)
	local buyTimes = buyTimes + 1
	local list

	if self.camp_battle_donate_buy_cost[donateBuyPlanId] then
		list = self.camp_battle_donate_buy_cost[donateBuyPlanId][type]
	end

	if list and #list > 0 then
		local cfg = list[#list]

		for i, v in ipairs(list) do
			if v.buyTimes == buyTimes then
				cfg = v
			end
		end

		return cfg
	else
		return nil
	end
end

function FunCampConfig:getTimeProgressList()
	return self.camp_battle_progress.dataList
end

function FunCampConfig:getStageDesCfg(id)
	return self.camp_battle_stagedes[id]
end

function FunCampConfig:getCampGroupList(groupId)
	return self.camp_battle_group[groupId]
end

function FunCampConfig:getCampGroupCfg(groupId, campId)
	if self.camp_battle_group[groupId] then
		return self.camp_battle_group[groupId][campId]
	end
end

function FunCampConfig:getCoinMode(activityId, type)
	if self.camp_battle_coin_mode[activityId] then
		return self.camp_battle_coin_mode[activityId][type]
	end
end

function FunCampConfig:getCoinModeCfg(activityId, type, id)
	if self.camp_battle_coin_mode[activityId] and self.camp_battle_coin_mode[activityId][type] then
		return self.camp_battle_coin_mode[activityId][type][id]
	end
end

function FunCampConfig:getTaskInfo(actId)
	return self.camp_battle_task[actId]
end

function FunCampConfig:getBuffList(buffPlanId)
	return self.camp_battle_buff[buffPlanId]
end

function FunCampConfig:getBuffCfg(buffPlanId, inspireScore)
	local list = self:getBuffList(buffPlanId)

	if list then
		local count = #list

		for i = count, 1, -1 do
			if inspireScore >= list[i].inspireScore then
				return list[i]
			end
		end
	end
end

function FunCampConfig:getCoinEffectCfgList(activityId, type)
	if self.camp_battle_coin_effect[activityId] then
		return self.camp_battle_coin_effect[activityId][type]
	end
end

FunCampConfig.instance = FunCampConfig.New()

return FunCampConfig
