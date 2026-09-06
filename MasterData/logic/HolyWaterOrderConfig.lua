-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/config/HolyWaterOrderConfig.lua

module("logic.extensions.holywaterorder.config.HolyWaterOrderConfig", package.seeall)

local HolyWaterOrderConfig = class("HolyWaterOrderConfig", BaseConfig)

function HolyWaterOrderConfig:onInit()
	HolyWaterOrderConfig.super.onInit(self)

	self.holy_water_order_challenge = nil
	self.holy_water_order_stage = nil
	self.holy_water_order_buff = nil
	self.holy_water_order_monster = nil
	self.holy_water_order_creeps = nil
end

function HolyWaterOrderConfig:getNames()
	return {
		"holy_water_order_challenge",
		"holy_water_order_stage",
		"holy_water_order_buff",
		"holy_water_order_monster",
		"holy_water_order_creeps"
	}
end

function HolyWaterOrderConfig:handleConfig(name, content)
	if name == "holy_water_order_challenge" then
		self.holy_water_order_challenge = content
	elseif name == "holy_water_order_stage" then
		self.holy_water_order_stage = content
	elseif name == "holy_water_order_buff" then
		self.holy_water_order_buff = content
	elseif name == "holy_water_order_monster" then
		self.holy_water_order_monster = content
	elseif name == "holy_water_order_creeps" then
		self.holy_water_order_creeps = content
	end
end

function HolyWaterOrderConfig:getActivityCfg(activityId)
	return self.holy_water_order_challenge[activityId]
end

function HolyWaterOrderConfig:getStageCfgList(activityId)
	return self.holy_water_order_stage[activityId]
end

function HolyWaterOrderConfig:getStageCfg(activityId, stageId)
	return self.holy_water_order_stage[activityId] and self.holy_water_order_stage[activityId][stageId]
end

function HolyWaterOrderConfig:getBuffCfgList(buffPlanId)
	return self.holy_water_order_buff[buffPlanId]
end

function HolyWaterOrderConfig:getBuffCfg(buffPlanId, difficulty)
	return self.holy_water_order_buff[buffPlanId] and self.holy_water_order_buff[buffPlanId][difficulty]
end

function HolyWaterOrderConfig:getMonsterCfg(creepsMasterId)
	return self.holy_water_order_monster[creepsMasterId]
end

function HolyWaterOrderConfig:getCreepsCfgList(creepsMasterId)
	return self.holy_water_order_creeps[creepsMasterId]
end

HolyWaterOrderConfig.instance = HolyWaterOrderConfig.New()

return HolyWaterOrderConfig
