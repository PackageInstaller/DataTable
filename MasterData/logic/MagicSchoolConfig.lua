-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/config/MagicSchoolConfig.lua

module("logic.extensions.magicschool.config.MagicSchoolConfig", package.seeall)

local MagicSchoolConfig = class("MagicSchoolConfig", BaseConfig)

function MagicSchoolConfig:getNames()
	return {
		"magic_school_activity",
		"magic_school_visit_prize",
		"magic_school_stage",
		"magic_school_system_pet",
		"magic_school_buff",
		"magic_school_level_prize",
		"magic_school_question",
		"magic_school_select",
		"magic_school_answer",
		"magic_school_monster",
		"magic_school_creeps",
		"magic_school_list_prize_preview"
	}
end

function MagicSchoolConfig:handleConfig(name, content)
	if name == "magic_school_activity" then
		self._magic_school_activity = content
	elseif name == "magic_school_visit_prize" then
		self._magic_school_visit_prize = content
	elseif name == "magic_school_stage" then
		self._magic_school_stage = content
	elseif name == "magic_school_system_pet" then
		self._magic_school_system_pet = content

		self:_sortSystemPetByPlanId(self._magic_school_system_pet.dataList)
	elseif name == "magic_school_buff" then
		self._magic_school_buff = content
	elseif name == "magic_school_level_prize" then
		self._magic_school_level_prize = content
	elseif name == "magic_school_question" then
		self._magic_school_question = content
	elseif name == "magic_school_select" then
		self._magic_school_select = content
	elseif name == "magic_school_answer" then
		self._magic_school_answer = content
	elseif name == "magic_school_monster" then
		self._magic_school_monster = content
	elseif name == "magic_school_creeps" then
		self._magic_school_creeps = content
	elseif name == "magic_school_list_prize_preview" then
		self._magic_school_list_prize_preview = content
	end
end

function MagicSchoolConfig:getActCfg(activityId)
	return self._magic_school_activity[activityId]
end

function MagicSchoolConfig:getPrizeCfg(activityId)
	return self._magic_school_visit_prize[activityId]
end

function MagicSchoolConfig:getStageCfgs(activityId)
	return self._magic_school_stage[activityId]
end

function MagicSchoolConfig:getStageCfgsByCampId(activityId, campId)
	return self._magic_school_stage[activityId] and self._magic_school_stage[activityId][campId]
end

function MagicSchoolConfig:getStageCfgByStageId(activityId, campId, stageId)
	local curStageCfgs = self:getStageCfgsByCampId(activityId, campId)

	return curStageCfgs and curStageCfgs[stageId]
end

function MagicSchoolConfig:getSystemPetCfg(creepsMasterId)
	return self._magic_school_system_pet[creepsMasterId]
end

function MagicSchoolConfig:getSystemPetCfgsByStageId(activityId, campId, stageId)
	local stageCfg = self:getStageCfgByStageId(activityId, campId, stageId)

	return self._systemPetMap[stageCfg.systemPetPlanId]
end

function MagicSchoolConfig:_sortSystemPetByPlanId(dataList)
	self._systemPetMap = {}

	for i, data in ipairs(dataList) do
		self._systemPetMap[data.planId] = self._systemPetMap[data.planId] or {}

		local petList = self._systemPetMap[data.planId]

		table.insert(petList, data)
	end
end

function MagicSchoolConfig:getBuffCfgsByCampId(activityId, campId)
	return self._magic_school_buff[activityId] and self._magic_school_buff[activityId][campId]
end

function MagicSchoolConfig:getBuffCfgData(activityId, campId, buffId)
	local cfg = self:getBuffCfgsByCampId(activityId, campId)

	return cfg and cfg[buffId]
end

function MagicSchoolConfig:getLevelPrizeCfgs(activityId, campId)
	return self._magic_school_level_prize[activityId] and self._magic_school_level_prize[activityId][campId]
end

function MagicSchoolConfig:getQuestionCfgs(activityId, campId)
	return self._magic_school_question[activityId] and self._magic_school_question[activityId][campId]
end

function MagicSchoolConfig:getSelectCfgs(activityId, campId)
	return self._magic_school_select[activityId] and self._magic_school_select[activityId][campId]
end

function MagicSchoolConfig:getSelectCfgsById(activityId, campId, questionId)
	local curSelectCfgs = self:getSelectCfgs(activityId, campId)

	return curSelectCfgs and curSelectCfgs[questionId]
end

function MagicSchoolConfig:getAnswerCfgByAnswer(activityId, campId, answer)
	if self._magic_school_answer[activityId] then
		return self._magic_school_answer[activityId][answer]
	end
end

function MagicSchoolConfig:getMonsterCfgs(creepsMasterId)
	return self._magic_school_monster[creepsMasterId]
end

function MagicSchoolConfig:getCreepsCfgs(creepsMasterId)
	return self._magic_school_creeps[creepsMasterId]
end

function MagicSchoolConfig:getCreepMasterId(activityId, campId, stageId)
	local stageCfg = self:getStageCfgByStageId(activityId, campId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

function MagicSchoolConfig:getListPrizePreviewCfgs(activityId)
	return self._magic_school_list_prize_preview[activityId]
end

MagicSchoolConfig.instance = MagicSchoolConfig.New()

return MagicSchoolConfig
