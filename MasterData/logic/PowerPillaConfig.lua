-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/config/PowerPillaConfig.lua

module("logic.extensions.maintainpowerpilla.config.PowerPillaConfig", package.seeall)

local PowerPillaConfig = class("PowerPillaConfig", BaseConfig)

function PowerPillaConfig:onInit()
	PowerPillaConfig.super.onInit(self)

	self.maintain_power_pillar_activity = nil
	self.maintain_power_pillar_stage = nil
	self.maintain_power_pillar_grid = nil
	self.maintain_power_pillar_box = nil
	self.maintain_power_pillar_monster = nil
	self.maintain_power_pillar_creeps = nil
	self.maintain_power_pillar_buff = nil
	self.maintain_power_pillar_pet = nil
	self.maintain_power_pillar_const = nil
	self.maintain_power_pillar_buy_times = nil
end

function PowerPillaConfig:getNames()
	return {
		"maintain_power_pillar_activity",
		"maintain_power_pillar_stage",
		"maintain_power_pillar_grid",
		"maintain_power_pillar_box",
		"maintain_power_pillar_npc",
		"maintain_power_pillar_bubble",
		"maintain_power_pillar_game",
		"maintain_power_pillar_boss",
		"maintain_power_pillar_boss_prize",
		"maintain_power_pillar_branch",
		"maintain_power_pillar_monster",
		"maintain_power_pillar_creeps",
		"maintain_power_pillar_buff",
		"maintain_power_pillar_buff_tree",
		"maintain_power_pillar_pet",
		"maintain_power_pillar_const",
		"maintain_power_pillar_buy_times",
		"maintain_power_pillar_story"
	}
end

function PowerPillaConfig:handleConfig(name, content)
	if name == "maintain_power_pillar_activity" then
		self.maintain_power_pillar_activity = content
	elseif name == "maintain_power_pillar_stage" then
		self.maintain_power_pillar_stage = content
	elseif name == "maintain_power_pillar_grid" then
		self.maintain_power_pillar_grid = content
	elseif name == "maintain_power_pillar_box" then
		self.maintain_power_pillar_box = content
	elseif name == "maintain_power_pillar_npc" then
		self.maintain_power_pillar_npc = content
	elseif name == "maintain_power_pillar_bubble" then
		self.maintain_power_pillar_bubble = content
	elseif name == "maintain_power_pillar_game" then
		self.maintain_power_pillar_game = content
	elseif name == "maintain_power_pillar_boss" then
		self.maintain_power_pillar_boss = content
	elseif name == "maintain_power_pillar_boss_prize" then
		self.maintain_power_pillar_boss_prize = content
	elseif name == "maintain_power_pillar_branch" then
		self.maintain_power_pillar_branch = content
	elseif name == "maintain_power_pillar_monster" then
		self.maintain_power_pillar_monster = content
	elseif name == "maintain_power_pillar_creeps" then
		self.maintain_power_pillar_creeps = content
	elseif name == "maintain_power_pillar_buff" then
		self.maintain_power_pillar_buff = content
	elseif name == "maintain_power_pillar_buff_tree" then
		self.maintain_power_pillar_buff_tree = content

		self:_setBuffTreeDataList(content.dataList)
	elseif name == "maintain_power_pillar_pet" then
		self.maintain_power_pillar_pet = content
	elseif name == "maintain_power_pillar_const" then
		self.maintain_power_pillar_const = content
	elseif name == "maintain_power_pillar_buy_times" then
		self.maintain_power_pillar_buy_times = content
	elseif name == "maintain_power_pillar_story" then
		self.maintain_power_pillar_story = content
	end
end

function PowerPillaConfig:getActivityCfg(id)
	return self.maintain_power_pillar_activity[id]
end

function PowerPillaConfig:getStageCfg(stagePlanId, stage)
	if self.maintain_power_pillar_stage[stagePlanId] then
		return self.maintain_power_pillar_stage[stagePlanId][stage]
	end
end

function PowerPillaConfig:getStageCfgById(activityId, stage)
	local stagePlanId = self:getActivityCfg(activityId).stagePlanId

	return self:getStageCfg(stagePlanId, stage)
end

function PowerPillaConfig:getStageList(stagePlanId)
	return self.maintain_power_pillar_stage[stagePlanId]
end

function PowerPillaConfig:getStageListById(activityId)
	local stagePlanId = self:getActivityCfg(activityId).stagePlanId

	return self.maintain_power_pillar_stage[stagePlanId]
end

function PowerPillaConfig:getBranchStageData(activityId, mainStageId)
	local stageDataList = self:getStageListOfBranch(activityId)

	for _, data in ipairs(stageDataList) do
		if data.mainStageId == mainStageId then
			return data
		end
	end
end

function PowerPillaConfig:getStageListOfMain(activityId)
	local resList = {}
	local list = self:getStageListById(activityId)

	for _, data in ipairs(list) do
		if data.mainStageId <= 0 then
			table.insert(resList, data)
		end
	end

	return resList
end

function PowerPillaConfig:getStageListOfBranch(activityId)
	local resList = {}
	local list = self:getStageListById(activityId)

	for _, data in ipairs(list) do
		if data.mainStageId > 0 then
			table.insert(resList, data)
		end
	end

	return resList
end

function PowerPillaConfig:getStageNumOfMain(activityId)
	return #self:getStageListOfMain(activityId)
end

function PowerPillaConfig:getGridList(mapId)
	return self.maintain_power_pillar_grid[mapId]
end

function PowerPillaConfig:getGridCfg(mapId, gridId)
	if self.maintain_power_pillar_grid[mapId] then
		return self.maintain_power_pillar_grid[mapId][gridId]
	end
end

function PowerPillaConfig:getGridDataListByStage(activityId, stage)
	local stageData = self:getStageCfgById(activityId, stage)

	return self:getGridList(stageData.mapId)
end

function PowerPillaConfig:getGridDataByStage(activityId, stage, gridId)
	return self:getGridDataListByStage(activityId, stage)[gridId]
end

function PowerPillaConfig:getBoxCfg(eventId)
	return self.maintain_power_pillar_box[eventId]
end

function PowerPillaConfig:getNpcData(npcId)
	return self.maintain_power_pillar_npc[npcId]
end

function PowerPillaConfig:getNpcDataByGrid(mapId, gridId)
	local npcId = self:getGridCfg(mapId, gridId).npcId

	return self.maintain_power_pillar_npc[npcId]
end

function PowerPillaConfig:getBubbleData(bubbleId)
	return self.maintain_power_pillar_bubble[bubbleId]
end

function PowerPillaConfig:getGameData(eventId)
	return self.maintain_power_pillar_game[eventId]
end

function PowerPillaConfig:getBossData(eventId)
	return self.maintain_power_pillar_boss[eventId]
end

function PowerPillaConfig:getCreepsMasterIdOfBossData(eventId)
	return self.maintain_power_pillar_boss[eventId].creepsMasterId
end

function PowerPillaConfig:getMonsterCfg(creepsMasterId)
	return self.maintain_power_pillar_monster[creepsMasterId]
end

function PowerPillaConfig:getMonsterCfgByEventId(eventId)
	local dataList = self.maintain_power_pillar_monster.dataList

	for i, v in ipairs(dataList) do
		if checknumber(v.eventId) == eventId then
			return v
		end
	end

	return nil
end

function PowerPillaConfig:getCreepsList(creepsMasterId)
	return self.maintain_power_pillar_creeps[creepsMasterId]
end

function PowerPillaConfig:getCreepsCfg(creepsMasterId, creepsId)
	if self.maintain_power_pillar_creeps[creepsMasterId] then
		return self.maintain_power_pillar_creeps[creepsMasterId][creepsId]
	end
end

function PowerPillaConfig:getBuffTypeList(buffPlanId)
	return self.maintain_power_pillar_buff[buffPlanId]
end

function PowerPillaConfig:getBuffLevelList(buffPlanId, type)
	if self.maintain_power_pillar_buff[buffPlanId] then
		return self.maintain_power_pillar_buff[buffPlanId][type]
	end
end

function PowerPillaConfig:getBuffCfgs(activityId)
	local buffPlanId = self:getActivityCfg(activityId).buffPlanId

	return self.maintain_power_pillar_buff[buffPlanId]
end

function PowerPillaConfig:getBuffCfg(activityId, type)
	return self:getBuffCfgs(activityId)[type]
end

function PowerPillaConfig:getBuffData(activityId, type, level)
	local lv = Mathf.Clamp(level, 0, self:getMaxLevelOfBuff(activityId, type))

	return self:getBuffCfg(activityId, type)[lv]
end

function PowerPillaConfig:getMaxLevelOfBuff(activityId, type)
	local cfg = self:getBuffCfg(activityId, type)
	local data = cfg[#cfg]

	return (data or nil) and (data.level or 0)
end

function PowerPillaConfig:getBuffTreeCfgs(activityId)
	local buffPlanId = self:getActivityCfg(activityId).buffPlanId

	return self.maintain_power_pillar_buff_tree[buffPlanId]
end

function PowerPillaConfig:getBuffTreeDataList(activityId, listId)
	return self:getBuffTreeCfgs(activityId)[listId]
end

function PowerPillaConfig:getBuffTreeData(activityId, listId, index)
	return self:getBuffTreeDataList(activityId, listId)[index]
end

function PowerPillaConfig:getBuffTreeDataById(activityId, onlyId)
	local buffPlanId = self:getActivityCfg(activityId).buffPlanId

	return self._buffTreeDataPool[buffPlanId][onlyId]
end

function PowerPillaConfig:_setBuffTreeDataList(dataList)
	self._buffTreeDataPool = {}

	for _, data in ipairs(dataList) do
		if self._buffTreeDataPool[data.buffPlanId] == nil then
			self._buffTreeDataPool[data.buffPlanId] = {}
		end

		self._buffTreeDataPool[data.buffPlanId][data.onlyId] = data
	end
end

function PowerPillaConfig:getSupportPetList(petPlanId)
	return self.maintain_power_pillar_pet[petPlanId]
end

function PowerPillaConfig:getSupportPetCfg(petPlanId, creepsId)
	if self.maintain_power_pillar_pet[petPlanId] then
		return self.maintain_power_pillar_pet[petPlanId][creepsId]
	end
end

function PowerPillaConfig:isLimitBuyBuff(buffType)
	local count = self:getBuffBuyTimes(buffType)

	return count ~= 0
end

function PowerPillaConfig:getBuffBuyTimes(buffType)
	if self.maintain_power_pillar_buy_times[buffType] then
		return self.maintain_power_pillar_buy_times[buffType].cost
	end

	return 0
end

function PowerPillaConfig:getConstValue(key, isToNumber)
	local data = self.maintain_power_pillar_const[key]
	local value = data and data.value

	return isToNumber and checknumber(value) or value
end

function PowerPillaConfig:getStoryCfgs(activityId)
	return self.maintain_power_pillar_story[activityId]
end

PowerPillaConfig.instance = PowerPillaConfig.New()

return PowerPillaConfig
