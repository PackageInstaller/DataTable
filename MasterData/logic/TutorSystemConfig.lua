-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/config/TutorSystemConfig.lua

module("logic.extensions.tutorsystem.config.TutorSystemConfig", package.seeall)

local TutorSystemConfig = class("TutorSystemConfig", BaseConfig)

function TutorSystemConfig:onInit()
	TutorSystemConfig.super.onInit(self)

	self._tutorActCfg = nil
end

function TutorSystemConfig:getNames()
	return {
		"tutor_system_common",
		"tutor_system_red",
		"tutor_system_tips_library",
		"tutor_system_teacher_prize",
		"tutor_system_base_task",
		"tutor_system_growth_task",
		"tutor_system_student_prize",
		"tutor_system_new_puzzle_prize",
		"tutor_system_new_puzzle_map",
		"tutor_system_new_puzzle_task",
		"tutor_activity_common",
		"tutor_system_zdl_prize",
		"tutor_system_rank_prize"
	}
end

function TutorSystemConfig:handleConfig(name, content)
	if name == "tutor_system_common" then
		self._tsCommonCfg = content
	elseif name == "tutor_system_red" then
		self._tsRedCfg = content

		self:_handleTsRedCfgToIdPool(content)
	elseif name == "tutor_system_tips_library" then
		self._tsTipsLibraryCfg = content
	elseif name == "tutor_system_teacher_prize" then
		self._tsTeacherPrizeCfg = content
	elseif name == "tutor_system_base_task" then
		self._tsBaseTaskCfg = content
	elseif name == "tutor_system_growth_task" then
		self._tsGrowthTaskCfg = content
	elseif name == "tutor_system_student_prize" then
		self._tsStuPrizeCfg = content
		self._tsStuPrizeDataList = content.dataList
	elseif name == "tutor_system_new_puzzle_prize" then
		self._tsPuzzlePrizeCfg = content
	elseif name == "tutor_system_new_puzzle_map" then
		self._tsPuzzleMapCfg = content
	elseif name == "tutor_system_new_puzzle_task" then
		self._tutor_system_new_puzzle_task = content
	elseif name == "tutor_activity_common" then
		self._tutorActCfg = content
	elseif name == "tutor_system_zdl_prize" then
		self._tutor_system_zdl_prize = content
	elseif name == "tutor_system_rank_prize" then
		self._tutor_system_rank_prize = content
	end
end

function TutorSystemConfig:getTsBaseTaskCfg()
	return self._tsBaseTaskCfg
end

function TutorSystemConfig:getTsBaseTaskData(taskId)
	return self._tsBaseTaskCfg[taskId]
end

function TutorSystemConfig:getTsGrowthTaskCfg()
	return self._tsGrowthTaskCfg
end

function TutorSystemConfig:getTsGrowthTaskData(taskId)
	return self._tsGrowthTaskCfg[taskId]
end

function TutorSystemConfig:getTsStuPrizeCfg()
	return self._tsStuPrizeCfg
end

function TutorSystemConfig:getTsStuPrizeData(prizeId)
	return self._tsStuPrizeCfg[prizeId]
end

function TutorSystemConfig:getTsStuPrizeMaxProgress()
	local data = self._tsStuPrizeDataList[#self._tsStuPrizeDataList]

	return (data or nil) and (data.scoreLimit or 0)
end

function TutorSystemConfig:getTsPuzzlePrizeCfg()
	return self._tsPuzzlePrizeCfg
end

function TutorSystemConfig:getTsPuzzlePrizeData(prizeId)
	return self._tsPuzzlePrizeCfg[prizeId]
end

function TutorSystemConfig:getTsPuzzleMapCfg()
	return self._tsPuzzleMapCfg
end

function TutorSystemConfig:getTsPuzzleMapData(pointId)
	return self._tsPuzzleMapCfg[pointId]
end

function TutorSystemConfig:getTsPuzzleTaskCfg()
	return self._tutor_system_new_puzzle_task
end

function TutorSystemConfig:getTsPuzzleTaskData(key)
	return self._tutor_system_new_puzzle_task[key]
end

function TutorSystemConfig:getTsTipsData(key)
	key = key .. ""

	if self._tsTipsLibraryCfg[key] == nil then
		return nil
	end

	return self._tsTipsLibraryCfg[key]
end

function TutorSystemConfig:getTsTipsValue(key)
	local tipsData = self:getTsTipsData(key)

	return (tipsData or nil) and (tipsData.value or "")
end

function TutorSystemConfig:getTsTipsSceneType(key)
	local tipsData = self:getTsTipsData(key)

	return (tipsData or nil) and (tipsData.sceneType or nil)
end

function TutorSystemConfig:_handleTsRedCfgToIdPool(content)
	self._redPoolById = {}

	for _, data in ipairs(content.dataList) do
		if not string.nilorempty(data.totalRedId) then
			self._redPoolById[data.totalRedId] = data
		end
	end
end

function TutorSystemConfig:getTsRedDataByType(redType)
	return self._tsRedCfg[redType]
end

function TutorSystemConfig:getTsRedDataById(redId)
	return self._redPoolById[redId]
end

function TutorSystemConfig:getTsRedDataList()
	return self._tsRedCfg.dataList
end

function TutorSystemConfig:getTsCommonValue(key)
	if self._tsCommonCfg[key] == nil then
		return nil
	end

	if not string.nilorempty(self._tsCommonCfg[key].value2) then
		return self._tsCommonCfg[key].value2
	end

	return self._tsCommonCfg[key].value
end

function TutorSystemConfig:getTsTeacherZdlLimit()
	return checknumber(self:getTsCommonValue("TEACHER_ZDL_LIMIT"))
end

function TutorSystemConfig:getTsStudentZdlLimit()
	return checknumber(self:getTsCommonValue("STUDENT_ZDL_LIMIT"))
end

function TutorSystemConfig:getTsTeachStudentLimit()
	return checknumber(self:getTsCommonValue("TEACH_STUDENT_LIMIT"))
end

function TutorSystemConfig:getTsTeacherRequestNum()
	return checknumber(self:getTsCommonValue("TEACHER_REQUEST_NUM"))
end

function TutorSystemConfig:getTsStudentRequestNum()
	return checknumber(self:getTsCommonValue("STUDENT_REQUEST_NUM"))
end

function TutorSystemConfig:getTsRelieveCd()
	return checknumber(self:getTsCommonValue("RELIEVE_CD"))
end

function TutorSystemConfig:getTsAutoRelieveDay()
	return checknumber(self:getTsCommonValue("AUTO_RELIEVE_DAY"))
end

function TutorSystemConfig:getTsRecommendRefreshTime()
	return checknumber(self:getTsCommonValue("RECOMMEND_REFRESH_TIME"))
end

function TutorSystemConfig:getTsWeeklyGrowthTaskNum()
	return checknumber(self:getTsCommonValue("WEEKLY_GROWTH_TASK_NUM"))
end

function TutorSystemConfig:getTsWeeklyGrowthRandomTaskNum()
	return checknumber(self:getTsCommonValue("WEEKLY_GROWTH_RANDOM_TASK_NUM"))
end

function TutorSystemConfig:getTsTeacherAchTaskActivityType()
	return checknumber(self:getTsCommonValue("TEACHER_ACHIEVEMENT_TASK_ACTIVITY_TYPE"))
end

function TutorSystemConfig:getTsTeacherGradAwardTaskActivityType()
	return checknumber(self:getTsCommonValue("TEACHER_GRAD_AWARD_TASK_ACTIVITY_TYPE"))
end

function TutorSystemConfig:getTsPuzzleUserActiveMaxTimes()
	return checknumber(self:getTsCommonValue("PUZZLE_USER_ACTIVE_MAX_TIMES"))
end

function TutorSystemConfig:getTsPuzzleX()
	return checknumber(self:getTsCommonValue("NEW_PUZZLE_X"))
end

function TutorSystemConfig:getTsPuzzleY()
	return checknumber(self:getTsCommonValue("NEW_PUZZLE_Y"))
end

function TutorSystemConfig:getTsPuzzleMaxActivePos()
	return checknumber(self:getTsCommonValue("PUZZLE_MAX_ACTIVE_POS"))
end

function TutorSystemConfig:getTsPuzzleActivePrize()
	return checknumber(self:getTsCommonValue("PUZZLE_ACTIVE_PRIZE"))
end

function TutorSystemConfig:getTsPuzzleActivePrize()
	return self:getTsCommonValue("PUZZLE_ACTIVE_PRIZE")
end

function TutorSystemConfig:getTsPuzzleDailyAddTimes()
	return checknumber(self:getTsCommonValue("PUZZLE_DAILY_ADD_TIMES"))
end

function TutorSystemConfig:getTsTeacherHirePetMax()
	return checknumber(self:getTsCommonValue("TEACHER_HIRE_PET_MAX"))
end

function TutorSystemConfig:getTsHirePetUseTimes()
	return checknumber(self:getTsCommonValue("HIRE_PET_USE_TIMES"))
end

function TutorSystemConfig:getSinglePetCanHireTimes()
	return checknumber(self:getTsCommonValue("SINGLE_PET_CAN_HIRE_TIMES"))
end

function TutorSystemConfig:getStudentTotalCanHireTimes()
	return checknumber(self:getTsCommonValue("STUDENT_TOTAL_CAN_HIRE_TIMES"))
end

function TutorSystemConfig:getTeacherSetHirePetPrize()
	return self:getTsCommonValue("TEACHER_SET_HIRE_PET_PRIZE")
end

function TutorSystemConfig:getFinishTutorPrize()
	return self:getTsCommonValue("FINISH_TUTOR_PRIZE")
end

function TutorSystemConfig:getFinishTutorTextContent()
	return self:getTsCommonValue("FINISH_TUTOR_TEXT_CONTENT")
end

function TutorSystemConfig:getTutorSystemRuleKey()
	return self:getTsCommonValue("TUTOR_SYSTEM_RULE")
end

function TutorSystemConfig:getTutorSystemGradScoreItem()
	return self:getTsCommonValue("TUTOR_SYSTEM_GRAD_SCORE_ITEM")
end

function TutorSystemConfig:getTutorSystemGradScoreItemStr(num)
	local item = self:getTutorSystemGradScoreItem()
	local scoreItem = item

	if not string.nilorempty(item) then
		local matType, matId, matNum = MaterialMgr.getMatParams(item)

		scoreItem = string.format("%s:%s:%s", matType, matId, num)
	end

	return scoreItem
end

function TutorSystemConfig:getRedStuBaseTask()
	return checknumber(self:getTsCommonValue("RED_STU_BASE_TASK"))
end

function TutorSystemConfig:getRedRequestFromTea()
	return checknumber(self:getTsCommonValue("RED_REQUEST_FROM_TEA"))
end

function TutorSystemConfig:getRedRequestFromStu()
	return checknumber(self:getTsCommonValue("RED_REQUEST_FROM_STU"))
end

function TutorSystemConfig:getRedPuzzleTimes()
	return checknumber(self:getTsCommonValue("RED_PUZZLETIMES"))
end

function TutorSystemConfig:getRedStudentZdlTask()
	return checknumber(self:getTsCommonValue("RED_SUTDENT_ZDL_TASK"))
end

function TutorSystemConfig:getTutorActivityCommon(str)
	if self._tutorActCfg == nil or self._tutorActCfg[str] == nil then
		return
	end

	return self._tutorActCfg[str].value
end

function TutorSystemConfig:getZdlPrizeCfg()
	return self._tutor_system_zdl_prize
end

function TutorSystemConfig:getZdlPrizeData(prizeId)
	return self._tutor_system_zdl_prize[prizeId]
end

function TutorSystemConfig:getMaxZdlInPrize()
	local zdl = 0
	local cfg = self:getZdlPrizeCfg()

	if cfg then
		local data = cfg[#cfg]

		zdl = data and data.zdl or 0
	end

	return zdl
end

function TutorSystemConfig:getRankPrizeDataByRank(rank)
	local data
	local cfg = self._tutor_system_rank_prize.dataList

	if cfg then
		for i, v in pairs(cfg) do
			if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
				data = v

				break
			end
		end
	end

	return data
end

TutorSystemConfig.instance = TutorSystemConfig.New()

return TutorSystemConfig
