-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/config/DragonDishitianConfig.lua

module("logic.extensions.dragondishitian.config.DragonDishitianConfig", package.seeall)

local DragonDishitianConfig = class("DragonDishitianConfig", BaseConfig)

function DragonDishitianConfig:onInit()
	DragonDishitianConfig.super.onInit(self)

	self.dragon_dishitian_actiivty = nil
	self.dragon_dishitian_chapter = nil
	self.dragon_dishitian_stage = nil
	self.dragon_dishitian_pass_condition = nil
	self.dragon_dishitian_master = nil
	self.dragon_dishitian_creeps = nil
	self.dragon_dishitian_common = nil
end

function DragonDishitianConfig:getNames()
	return {
		"dragon_dishitian_actiivty",
		"dragon_dishitian_chapter",
		"dragon_dishitian_stage",
		"dragon_dishitian_pass_condition",
		"dragon_dishitian_master",
		"dragon_dishitian_creeps",
		"dragon_dishitian_common",
		"dragon_dishitian_buff",
		"dragon_dishitian_buff_type"
	}
end

function DragonDishitianConfig:handleConfig(name, content)
	if name == "dragon_dishitian_actiivty" then
		self.dragon_dishitian_actiivty = content
	elseif name == "dragon_dishitian_chapter" then
		self.dragon_dishitian_chapter = content
	elseif name == "dragon_dishitian_stage" then
		self.dragon_dishitian_stage = content
	elseif name == "dragon_dishitian_pass_condition" then
		self.dragon_dishitian_pass_condition = content
	elseif name == "dragon_dishitian_master" then
		self.dragon_dishitian_master = content
	elseif name == "dragon_dishitian_creeps" then
		self.dragon_dishitian_creeps = content
	elseif name == "dragon_dishitian_common" then
		self.dragon_dishitian_common = content
	elseif name == "dragon_dishitian_buff" then
		self.dragon_dishitian_buff = content
	elseif name == "dragon_dishitian_buff_type" then
		self.dragon_dishitian_buff_type = content
	end
end

function DragonDishitianConfig:getActivityCfg(activityId)
	return self.dragon_dishitian_actiivty[activityId]
end

function DragonDishitianConfig:getChapterCfgList(activityId)
	return self.dragon_dishitian_chapter[activityId]
end

function DragonDishitianConfig:getChapterCfg(activityId, chapterId)
	return self.dragon_dishitian_chapter[activityId] and self.dragon_dishitian_chapter[activityId][chapterId]
end

function DragonDishitianConfig:getStageCfgList(activityId, chapterId)
	return self.dragon_dishitian_stage[activityId] and self.dragon_dishitian_stage[activityId][chapterId]
end

function DragonDishitianConfig:getStageCfg(activityId, chapterId, stageId)
	return self.dragon_dishitian_stage[activityId] and self.dragon_dishitian_stage[activityId][chapterId] and self.dragon_dishitian_stage[activityId][chapterId][stageId]
end

function DragonDishitianConfig:getPassConditionCfg(conditionId)
	return self.dragon_dishitian_pass_condition[conditionId]
end

function DragonDishitianConfig:getMonsterCfg(creepsMasterId)
	return self.dragon_dishitian_master[creepsMasterId]
end

function DragonDishitianConfig:getCreeps(creepsMasterId)
	return self.dragon_dishitian_creeps[creepsMasterId]
end

function DragonDishitianConfig:getCommonValue(key)
	return self.dragon_dishitian_common[key] and self.dragon_dishitian_common[key].value
end

function DragonDishitianConfig:getBuffTypeCfgs(activityId)
	return self.dragon_dishitian_buff_type[activityId]
end

function DragonDishitianConfig:getBuffTypeCfg(activityId, buffType)
	if self.dragon_dishitian_buff_type[activityId] then
		return self.dragon_dishitian_buff_type[activityId][buffType]
	end
end

function DragonDishitianConfig:getBuffCfg(activityId, buffType, level)
	if self.dragon_dishitian_buff[activityId] and self.dragon_dishitian_buff[activityId][buffType] then
		return self.dragon_dishitian_buff[activityId][buffType][level]
	end
end

function DragonDishitianConfig:getBuffCfgByprogress(activityId, buffType, progress)
	if self.dragon_dishitian_buff[activityId] and self.dragon_dishitian_buff[activityId][buffType] then
		local cfgs = self.dragon_dishitian_buff[activityId][buffType]
		local matchCfg

		for i, cfg in ipairs(cfgs) do
			if progress < cfg.progress then
				break
			else
				matchCfg = cfg
			end
		end

		return matchCfg
	end
end

DragonDishitianConfig.instance = DragonDishitianConfig.New()

return DragonDishitianConfig
