-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/config/KindergartenConfig.lua

module("logic.extensions.kindergarten.config.KindergartenConfig", package.seeall)

local KindergartenConfig = class("KindergartenConfig", BaseConfig)

function KindergartenConfig:onInit()
	return
end

function KindergartenConfig:getNames()
	return {
		"kindergarten_activity",
		"kindergarten_enlist",
		"kindergarten_student_plan",
		"kindergarten_growth_rate_plan",
		"kindergarten_classroom",
		"kindergarten_facility_plan",
		"kindergarten_level",
		"kindergarten_job",
		"kindergarten_rank_prize",
		"kindergarten_class",
		"kindergarten_common"
	}
end

function KindergartenConfig:handleConfig(name, content)
	if name == "kindergarten_activity" then
		self._kindergarten_activity = content
	elseif name == "kindergarten_enlist" then
		self._kindergarten_enlist = content
	elseif name == "kindergarten_student_plan" then
		self._kindergarten_student_plan = content
	elseif name == "kindergarten_growth_rate_plan" then
		self._kindergarten_growth_rate_plan = content
	elseif name == "kindergarten_classroom" then
		self._kindergarten_classroom = content
	elseif name == "kindergarten_facility_plan" then
		self._kindergarten_facility_plan = content
	elseif name == "kindergarten_level" then
		self._kindergarten_level = content
	elseif name == "kindergarten_job" then
		self._kindergarten_job = content
	elseif name == "kindergarten_rank_prize" then
		self._kindergarten_rank_prize = content
	elseif name == "kindergarten_class" then
		self._kindergarten_class = content
	elseif name == "kindergarten_common" then
		self._kindergarten_common = content
	end
end

function KindergartenConfig:getEnlistCfg(activityId)
	return self._kindergarten_enlist[activityId]
end

function KindergartenConfig:getEnlistData(activityId, enlistId)
	if self._kindergarten_enlist[activityId] then
		return self._kindergarten_enlist[activityId][enlistId]
	end
end

function KindergartenConfig:getStuPlanCfg(studentPlanId)
	return self._kindergarten_student_plan[studentPlanId]
end

function KindergartenConfig:getStuPlanData(studentPlanId, studentType)
	if self._kindergarten_student_plan[studentPlanId] then
		return self._kindergarten_student_plan[studentPlanId][studentType]
	end
end

function KindergartenConfig:getClassRoomCfgs(activityId)
	return self._kindergarten_classroom[activityId]
end

function KindergartenConfig:getClassRoomCfg(activityId, classRoomId)
	return self._kindergarten_classroom[activityId][classRoomId]
end

function KindergartenConfig:getFacilityPlanCfgs(facilityPlanId)
	return self._kindergarten_facility_plan[facilityPlanId]
end

function KindergartenConfig:getFacilityPlanCfg(facilityPlanId, facilityId)
	return self._kindergarten_facility_plan[facilityPlanId][facilityId]
end

function KindergartenConfig:getLevelCfgs(activityId)
	return self._kindergarten_level[activityId]
end

function KindergartenConfig:getLevelData(activityId, level)
	if self._kindergarten_level[activityId] then
		return self._kindergarten_level[activityId][level]
	end
end

function KindergartenConfig:getActCfg(activityId)
	return self._kindergarten_activity[activityId]
end

function KindergartenConfig:getRankPrizeCfgs(activityId)
	return self._kindergarten_rank_prize[activityId]
end

function KindergartenConfig:getRankPrizeCfg(activityId, index)
	return self._kindergarten_rank_prize[activityId][index]
end

function KindergartenConfig:getJobCfgs(activityId)
	return self._kindergarten_job[activityId]
end

function KindergartenConfig:getJobCfg(activityId, jobId)
	return self._kindergarten_job[activityId] and self._kindergarten_job[activityId][jobId]
end

function KindergartenConfig:getCommonValue(key)
	return self._kindergarten_common[key] and self._kindergarten_common[key].value
end

function KindergartenConfig:getClassCfgList(activityId)
	return self._kindergarten_class[activityId]
end

KindergartenConfig.instance = KindergartenConfig.New()

return KindergartenConfig
