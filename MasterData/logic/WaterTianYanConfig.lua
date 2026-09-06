-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/config/WaterTianYanConfig.lua

module("logic.extensions.watertianyan.config.WaterTianYanConfig", package.seeall)

local WaterTianYanConfig = class("WaterTianYanConfig", BaseConfig)

function WaterTianYanConfig:onInit()
	WaterTianYanConfig.super.onInit(self)

	self.water_tian_yan_challenge_activity = nil
	self.water_tian_yan_buiding_type = nil
	self.water_tian_yan_buiding_stage = nil
	self.water_tian_yan_main_stage = nil
	self.water_tian_yan_buff_item = nil
	self.water_tian_yan_buff_item_level = nil
	self.water_tian_yan_buff = nil
	self.water_tian_yan_monster = nil
	self.water_tian_yan_creeps = nil
end

function WaterTianYanConfig:getNames()
	return {
		"water_tian_yan_challenge_activity",
		"water_tian_yan_buiding_type",
		"water_tian_yan_buiding_stage",
		"water_tian_yan_main_stage",
		"water_tian_yan_buff_item",
		"water_tian_yan_buff_item_level",
		"water_tian_yan_buff",
		"water_tian_yan_monster",
		"water_tian_yan_creeps"
	}
end

function WaterTianYanConfig:handleConfig(name, content)
	if name == "water_tian_yan_challenge_activity" then
		self.water_tian_yan_challenge_activity = content
	elseif name == "water_tian_yan_buiding_type" then
		self.water_tian_yan_buiding_type = content
	elseif name == "water_tian_yan_buiding_stage" then
		self.water_tian_yan_buiding_stage = content
	elseif name == "water_tian_yan_main_stage" then
		self.water_tian_yan_main_stage = content
	elseif name == "water_tian_yan_buff_item" then
		self.water_tian_yan_buff_item = content
	elseif name == "water_tian_yan_buff_item_level" then
		self.water_tian_yan_buff_item_level = content
	elseif name == "water_tian_yan_buff" then
		self.water_tian_yan_buff = content
	elseif name == "water_tian_yan_monster" then
		self.water_tian_yan_monster = content
	elseif name == "water_tian_yan_creeps" then
		self.water_tian_yan_creeps = content
	end
end

function WaterTianYanConfig:getActivityCfg(activityId)
	return self.water_tian_yan_challenge_activity[activityId]
end

function WaterTianYanConfig:getBuildingTypeCfgList(activityId)
	return self.water_tian_yan_buiding_type[activityId]
end

function WaterTianYanConfig:getBuildingTypeCfg(activityId, typeId)
	return self.water_tian_yan_buiding_type[activityId] and self.water_tian_yan_buiding_type[activityId][typeId]
end

function WaterTianYanConfig:getBuildingStageCfgList(activityId)
	return self.water_tian_yan_buiding_stage[activityId]
end

function WaterTianYanConfig:getBuildingStageCfg(activityId, stageId)
	return self.water_tian_yan_buiding_stage[activityId] and self.water_tian_yan_buiding_stage[activityId][stageId]
end

function WaterTianYanConfig:getMainStageCfgList(activityId)
	return self.water_tian_yan_main_stage[activityId]
end

function WaterTianYanConfig:getMainStageCfg(activityId, stageId)
	return self.water_tian_yan_main_stage[activityId] and self.water_tian_yan_main_stage[activityId][stageId]
end

function WaterTianYanConfig:getBuffItemCfgList(activityId)
	return self.water_tian_yan_buff_item[activityId]
end

function WaterTianYanConfig:getBuffItemCfg(activityId, buffItemId)
	return self.water_tian_yan_buff_item[activityId] and self.water_tian_yan_buff_item[activityId][buffItemId]
end

function WaterTianYanConfig:getBuffItemCfgs(activityId, typeId)
	local list = {}

	for i, v in ipairs(self.water_tian_yan_buff_item.dataList) do
		if v.activityId == activityId and v.type == typeId then
			table.insert(list, v)
		end
	end

	return list
end

function WaterTianYanConfig:getBuffItemLevelCfgList(activityId, buffItemId)
	return self.water_tian_yan_buff_item_level[activityId] and self.water_tian_yan_buff_item_level[activityId][buffItemId]
end

function WaterTianYanConfig:getBuffItemLevelCfg(activityId, buffItemId, level)
	return self.water_tian_yan_buff_item_level[activityId] and self.water_tian_yan_buff_item_level[activityId][buffItemId] and self.water_tian_yan_buff_item_level[activityId][buffItemId][level]
end

function WaterTianYanConfig:getBuffCfgByBuffItemId(activityId, buffItemId, level)
	local list = self:getBuffItemLevelCfgList(activityId, buffItemId)

	if list and level and level > 0 then
		for i, v in ipairs(list) do
			if v.level == level then
				return self:getBuffCfg(v.buffId)
			end
		end
	end
end

function WaterTianYanConfig:getBuffCfg(buffId)
	return self.water_tian_yan_buff[buffId]
end

function WaterTianYanConfig:getMonsterCfg(creepsMasterId)
	return self.water_tian_yan_monster[creepsMasterId]
end

function WaterTianYanConfig:getCreepsCfgs(creepsMasterId)
	return self.water_tian_yan_creeps[creepsMasterId]
end

WaterTianYanConfig.instance = WaterTianYanConfig.New()

return WaterTianYanConfig
