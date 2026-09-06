-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/config/OriginFightConfig.lua

module("logic.extensions.originfight.config.OriginFightConfig", package.seeall)

local OriginFightConfig = class("OriginFightConfig", BaseConfig)

function OriginFightConfig:onInit()
	OriginFightConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function OriginFightConfig:getNames()
	return {
		"origin_fight_activity",
		"origin_fight_god_favor",
		"origin_fight_titan",
		"origin_fight_creeps_master",
		"origin_fight_creeps",
		"origin_fight_dungeon_role",
		"origin_fight_dungeon_stage",
		"origin_fight_dungeon_event",
		"origin_fight_pick_up",
		"origin_fight_pick_up_idea_game_plan",
		"origin_fight_pick_up_idea_bubble",
		"origin_fight_pick_up_idea_block_plan",
		"origin_fight_planetarium_game_activity",
		"origin_fight_planetarium_game_rule",
		"origin_fight_planetarium_game"
	}
end

function OriginFightConfig:handleConfig(name, content)
	if name == "origin_fight_activity" then
		self._origin_fight_activity = content
	elseif name == "origin_fight_god_favor" then
		self._origin_fight_god_favor = content
	elseif name == "origin_fight_titan" then
		self._origin_fight_titan = content
	elseif name == "origin_fight_creeps_master" then
		self._origin_fight_creeps_master = content
	elseif name == "origin_fight_creeps" then
		self._origin_fight_creeps = content
	elseif name == "origin_fight_dungeon_role" then
		self._origin_fight_dungeon_role = content
	elseif name == "origin_fight_dungeon_stage" then
		self._origin_fight_dungeon_stage = content
	elseif name == "origin_fight_dungeon_event" then
		self._origin_fight_dungeon_event = content
	elseif name == "origin_fight_pick_up" then
		self._origin_fight_pick_up = content
	elseif name == "origin_fight_pick_up_idea_game_plan" then
		self._origin_fight_pick_up_idea_game_plan = content
		self._gamePlanIds = {}

		for i, v in ipairs(content) do
			table.insert(self._gamePlanIds, i)
		end
	elseif name == "origin_fight_pick_up_idea_bubble" then
		self._origin_fight_pick_up_idea_bubble = content
	elseif name == "origin_fight_pick_up_idea_block_plan" then
		self._origin_fight_pick_up_idea_block_plan = content
		self._origin_fight_pick_up_idea_block_planIds = {}

		for id, v in pairs(content) do
			if type(id) == "number" then
				table.insert(self._origin_fight_pick_up_idea_block_planIds, id)
			end
		end
	elseif name == "origin_fight_planetarium_game_activity" then
		self._origin_fight_planetarium_game_activity = content
	elseif name == "origin_fight_planetarium_game_rule" then
		self._origin_fight_planetarium_game_rule = content
	elseif name == "origin_fight_planetarium_game" then
		self._origin_fight_planetarium_game = content
	end
end

function OriginFightConfig:getActCfg(activityId)
	return self._origin_fight_activity[activityId]
end

function OriginFightConfig:getGodFavorCfgs(activityId)
	return self._origin_fight_god_favor[activityId]
end

function OriginFightConfig:getGodFavorCfgById(activityId, godFavorId)
	return self._origin_fight_god_favor[activityId] and self._origin_fight_god_favor[activityId][godFavorId]
end

function OriginFightConfig:getTiTanCfgs(activityId)
	return self._origin_fight_titan[activityId]
end

function OriginFightConfig:getTiTanCfgById(activityId, titanId)
	return self._origin_fight_titan[activityId] and self._origin_fight_titan[activityId][titanId]
end

function OriginFightConfig:getCreepMasterCfg(creepMasterId)
	return self._origin_fight_creeps_master[creepMasterId]
end

function OriginFightConfig:getCreepsCfg(creepMasterId)
	return self._origin_fight_creeps[creepMasterId]
end

function OriginFightConfig:getStoryIdById(activityId, godFavorId)
	local godFavorCfg = self:getGodFavorCfgById(activityId, godFavorId)

	return godFavorCfg.storyId
end

function OriginFightConfig:getDungeonRoleCfgs(activityId)
	return self._origin_fight_dungeon_role[activityId]
end

function OriginFightConfig:getDungeonRoleCfgById(activityId, roleId)
	return self._origin_fight_dungeon_role[activityId] and self._origin_fight_dungeon_role[activityId][roleId]
end

function OriginFightConfig:getDungeonStageCfg(stageId)
	return self._origin_fight_dungeon_stage[stageId]
end

function OriginFightConfig:getDungeonEventCfgs(stageId)
	local stageCfg = self:getDungeonStageCfg(stageId)
	local eventPlanId = stageCfg.eventPlanId

	return self._origin_fight_dungeon_event[eventPlanId]
end

function OriginFightConfig:getDungeonEventCfgById(stageId, eventId)
	local eventCfgs = self:getDungeonEventCfgs(stageId)

	return eventCfgs and eventCfgs[eventId]
end

function OriginFightConfig:getPickUpActCfg(activityId)
	return self._origin_fight_pick_up[activityId]
end

function OriginFightConfig:getPickUpGamePlanCfgs(gamePlanId)
	return self._origin_fight_pick_up_idea_game_plan[gamePlanId]
end

function OriginFightConfig:getGamePlanIds()
	return self._gamePlanIds
end

function OriginFightConfig:getPickUpBubbleCfg(id)
	return self._origin_fight_pick_up_idea_bubble[id]
end

function OriginFightConfig:getPickUpRandomBlockPlanId()
	local cnt = #self._origin_fight_pick_up_idea_block_planIds
	local idx = math.random(1, cnt)

	return self._origin_fight_pick_up_idea_block_planIds[idx]
end

function OriginFightConfig:getPickUpBlockCfgs(planId)
	return self._origin_fight_pick_up_idea_block_plan[planId]
end

function OriginFightConfig:getPlaneAriumActCfg(activityId)
	return self._origin_fight_planetarium_game_activity[activityId]
end

function OriginFightConfig:getPlaneAriumRulePlanId(activityId)
	return self._origin_fight_planetarium_game_activity[activityId].rulePlanId
end

function OriginFightConfig:getPlaneAriumRuleCfg(rulePlanId)
	return self._origin_fight_planetarium_game_rule[rulePlanId]
end

function OriginFightConfig:getPlaneAriumGameRingCfgById(stageId, ringId)
	return self._origin_fight_planetarium_game[stageId][ringId]
end

OriginFightConfig.instance = OriginFightConfig.New()

return OriginFightConfig
