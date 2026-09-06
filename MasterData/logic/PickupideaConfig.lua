-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/config/PickupideaConfig.lua

module("logic.extensions.pickupidea.config.PickupideaConfig", package.seeall)

local PickupideaConfig = class("PickupideaConfig", BaseConfig)

function PickupideaConfig:onInit()
	return
end

function PickupideaConfig:getNames()
	return {
		"pick_up_idea_activity",
		"pick_up_idea_role",
		"pick_up_idea_progress_prize",
		"pick_up_idea_rank_prize",
		"pick_up_idea_block_plan",
		"pick_up_idea_bubble",
		"pick_up_idea_game_plan",
		"pick_up_idea_main_view_param",
		"pick_up_idea_story"
	}
end

function PickupideaConfig:handleConfig(name, content)
	if name == "pick_up_idea_activity" then
		self._pick_up_idea_activity = content
	elseif name == "pick_up_idea_role" then
		self._pick_up_idea_role = content
	elseif name == "pick_up_idea_progress_prize" then
		self._pick_up_idea_progress_prize = content
	elseif name == "pick_up_idea_rank_prize" then
		self._pick_up_idea_rank_prize = content
	elseif name == "pick_up_idea_block_plan" then
		self._pick_up_idea_block_plan = content
		self._pick_up_idea_block_planIds = {}

		for id, v in pairs(content) do
			if type(id) == "number" then
				table.insert(self._pick_up_idea_block_planIds, id)
			end
		end
	elseif name == "pick_up_idea_bubble" then
		self._pick_up_idea_bubble = content
	elseif name == "pick_up_idea_game_plan" then
		self._pick_up_idea_game_plan = content
		self._gamePlanIds = {}

		for i, v in ipairs(content) do
			table.insert(self._gamePlanIds, i)
		end
	elseif name == "pick_up_idea_main_view_param" then
		self._pick_up_idea_main_view_param = content
	elseif name == "pick_up_idea_story" then
		self._pick_up_idea_story = content
	end
end

function PickupideaConfig:getSize(activityId)
	return self._pick_up_idea_activity[activityId].size
end

function PickupideaConfig:getActivityCfg(activityId)
	return self._pick_up_idea_activity[activityId]
end

function PickupideaConfig:getGamePlanIds()
	return self._gamePlanIds
end

function PickupideaConfig:getGamePlanCfgs(planId)
	return self._pick_up_idea_game_plan[planId]
end

function PickupideaConfig:getBubbleCfg(id)
	return self._pick_up_idea_bubble[id]
end

function PickupideaConfig:getRoleCfgs(activityId)
	return self._pick_up_idea_role[activityId]
end

function PickupideaConfig:getRoleCfg(activityId, id)
	return self._pick_up_idea_role[activityId][id]
end

function PickupideaConfig:getStoryCfgs(activityId, id)
	return self._pick_up_idea_story[activityId][id]
end

function PickupideaConfig:getRankPrizeCfg(rank)
	for i, v in ipairs(self._pick_up_idea_rank_prize.dataList) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			return v
		end
	end
end

function PickupideaConfig:getRandomBlockPlanId()
	local cnt = #self._pick_up_idea_block_planIds
	local idx = math.random(1, cnt)

	return self._pick_up_idea_block_planIds[idx]
end

function PickupideaConfig:getBlockCfgs(planId)
	return self._pick_up_idea_block_plan[planId]
end

function PickupideaConfig:getProgressPrizeCfgs(activityId)
	return self._pick_up_idea_progress_prize[activityId]
end

function PickupideaConfig:getProgressPrizeCfg(activityId, prizeId)
	return self._pick_up_idea_progress_prize[activityId][prizeId]
end

PickupideaConfig.instance = PickupideaConfig.New()

return PickupideaConfig
