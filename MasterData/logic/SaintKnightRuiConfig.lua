-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/config/SaintKnightRuiConfig.lua

module("logic.extensions.saintknightrui.config.SaintKnightRuiConfig", package.seeall)

local SaintKnightRuiConfig = class("SaintKnightRuiConfig", BaseConfig)

function SaintKnightRuiConfig:onInit()
	SaintKnightRuiConfig.super.onInit(self)

	self.saintknight_rui_activity = nil
	self.saintknight_rui_info = nil
	self.saintknight_rui_challenge_plan = nil
	self.saintknight_rui_stage = nil
	self.saintknight_rui_creeps = nil
	self.saintknight_rui_helper_pet = nil
	self.saintknight_rui_buff = nil
	self.saintknight_rui_const = nil
end

function SaintKnightRuiConfig:getNames()
	return {
		"saintknight_rui_activity",
		"saintknight_rui_info",
		"saintknight_rui_challenge_plan",
		"saintknight_rui_stage",
		"saintknight_rui_creeps",
		"saintknight_rui_helper_pet",
		"saintknight_rui_buff",
		"saintknight_rui_const"
	}
end

function SaintKnightRuiConfig:handleConfig(name, content)
	if name == "saintknight_rui_activity" then
		self.saintknight_rui_activity = content
	elseif name == "saintknight_rui_info" then
		self.saintknight_rui_info = content
	elseif name == "saintknight_rui_challenge_plan" then
		self.saintknight_rui_challenge_plan = content
	elseif name == "saintknight_rui_stage" then
		self.saintknight_rui_stage = content
	elseif name == "saintknight_rui_creeps" then
		self.saintknight_rui_creeps = content
	elseif name == "saintknight_rui_helper_pet" then
		self.saintknight_rui_helper_pet = content
	elseif name == "saintknight_rui_buff" then
		self.saintknight_rui_buff = content
	elseif name == "saintknight_rui_const" then
		self.saintknight_rui_const = content
	end
end

function SaintKnightRuiConfig:getActivityCfg(activityId)
	return self.saintknight_rui_activity[activityId]
end

function SaintKnightRuiConfig:getStageInfoCfgList(challengePlanId)
	return self.saintknight_rui_info[challengePlanId]
end

function SaintKnightRuiConfig:getStateInfoCfg(challengePlanId, stageId)
	if self.saintknight_rui_info[challengePlanId] then
		return self.saintknight_rui_info[challengePlanId][stageId]
	end
end

function SaintKnightRuiConfig:getSortStageCfgs(challengePlanId, stageId)
	local dataList = self.saintknight_rui_challenge_plan.dataList
	local list = {}

	for i, v in ipairs(dataList) do
		if v.challengePlanId == challengePlanId and v.stageId == stageId then
			table.insert(list, v)
		end
	end

	return list
end

function SaintKnightRuiConfig:getFmtById(creepsMasterId)
	return self.saintknight_rui_stage[creepsMasterId]
end

function SaintKnightRuiConfig:getFmtPetsList(creepsMasterId)
	return self.saintknight_rui_creeps[creepsMasterId]
end

function SaintKnightRuiConfig:getSupportPetCfg(creepsId)
	return self.saintknight_rui_helper_pet[creepsId]
end

function SaintKnightRuiConfig:getBuffCfgList(activityId)
	return self.saintknight_rui_buff[activityId]
end

function SaintKnightRuiConfig:getBuffCfg(activityId, id)
	if self.saintknight_rui_buff[activityId] then
		return self.saintknight_rui_buff[activityId][id]
	end
end

function SaintKnightRuiConfig:getConstValue(key)
	if self.saintknight_rui_const[key] then
		return self.saintknight_rui_const[key].value
	end

	return ""
end

SaintKnightRuiConfig.instance = SaintKnightRuiConfig.New()

return SaintKnightRuiConfig
