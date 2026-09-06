-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/model/KindergartenModel.lua

module("logic.extensions.kindergarten.view.KindergartenModel", package.seeall)

local KindergartenModel = class("KindergartenModel", BaseModel)

KindergartenModel.STRENGTH = 0
KindergartenModel.ART = 1
KindergartenModel.INTELLECT = 2
KindergartenModel.NormalStudent = 1
KindergartenModel.TalentStudent = 2
KindergartenModel.BeforeCourse = 1
KindergartenModel.DoingCourse = 2
KindergartenModel.AfterCourse = 3
KindergartenModel.ReadFlag = "KindergartenModel.ReadFlag"

function KindergartenModel:ctor()
	return
end

function KindergartenModel:onInit()
	self:onReset()
end

function KindergartenModel:onReset()
	self._activityId = 0
	self._msgInfos = {}
	self._rankInfos = {}
	self._myRank = -1
	self._addStudentResMsg = nil
	self._courseResultStudentList = nil
	self._jobResultList = nil
end

function KindergartenModel:setActivityId(activityId)
	self._activityId = activityId
end

function KindergartenModel:getActivityId()
	return self._activityId
end

function KindergartenModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function KindergartenModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function KindergartenModel:unlockFacilityRes(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		info.curStudentCount = msg.curStudentCount

		for _, iv in ipairs(info.classroomList) do
			if iv.classroomId == msg.classroomInfo.classroomId then
				iv.unlockFacilityId = msg.classroomInfo.unlockFacilityId

				break
			end
		end

		local newAddClassList = {}

		for _, vm in ipairs(msg.classList) do
			local isAddSuccess = false

			for i, vi in ipairs(info.classList) do
				if vi.classId == vm.classId then
					info.classList[i] = GameUtil.pbToTable(vm)
					isAddSuccess = true

					break
				end
			end

			if not isAddSuccess then
				table.insert(newAddClassList, GameUtil.pbToTable(vm) or {})
			end
		end

		table.insertto(info.classList, newAddClassList)
		table.sort(info.classList, function(a, b)
			return a.classId < b.classId
		end)
	end

	info.isAuto = msg.isAuto
end

function KindergartenModel:isUnlockAutoFunction(activityId)
	local info = self:getInfo(activityId)

	if info then
		return info.unlockAutoFunction
	end
end

function KindergartenModel:unlockAutoFunctionRes(msg)
	local info = self:getInfo(msg.activityId)

	if info then
		info.unlockAutoFunction = true
	end
end

function KindergartenModel:setAutoRes(msg, isSetAuto)
	local info = self:getInfo(msg.activityId)

	if info then
		info.isAuto = msg.isAuto

		if isSetAuto == true then
			info.schedulePlanList = GameUtil.pbToTable(msg.pointScheduleList)
		end

		for _, vm in ipairs(msg.classList) do
			for i, vi in ipairs(info.classList) do
				if vi.classId == vm.classId then
					info.classList[i] = GameUtil.pbToTable(vm)

					break
				end
			end
		end

		info.curStudentCount = msg.curStudentCount
	end
end

function KindergartenModel:handlePM_KindergartenAddStudentRes(msg)
	self._addStudentResMsg = msg
end

function KindergartenModel:setRankInfos(msg)
	self._myRank = msg.myRank

	if msg.rankInfoList then
		self._rankInfos = msg.rankInfoList
	end
end

function KindergartenModel:setViewResultRes(msg)
	local info = self:getInfo(msg.activityId)

	for i, v in ipairs(info.classList) do
		if v.classId == msg.classInfo.classId then
			info.classList[i] = GameUtil.pbToTable(msg.classInfo) or {}

			break
		end
	end

	self._courseResultStudentList = GameUtil.pbToTable(msg.studentList) or {}
end

function KindergartenModel:setGetJobInfoRes(msg)
	self._jobResultList = GameUtil.pbToTable(msg.jobResultList) or {}
end

function KindergartenModel:getRankInfos()
	return self._rankInfos
end

function KindergartenModel:getMyRank()
	return self._myRank
end

function KindergartenModel:getAddStudentResMsg()
	return self._addStudentResMsg
end

function KindergartenModel:getCourseResultStudents()
	return self._courseResultStudentList
end

function KindergartenModel:getJobResultList()
	return self._jobResultList
end

function KindergartenModel:getUsedQualityPointToday(activityId, qualityPointType)
	local info = self:getInfo(activityId)

	for i, qualityPoint in ipairs(info.todayUseQualityPointList or {}) do
		if qualityPoint.pointType == qualityPointType then
			return qualityPoint.value
		end
	end

	return 0
end

function KindergartenModel:getMaxQualityPointToday(activityId)
	local actCfg = KindergartenConfig.instance:getActCfg(activityId)
	local maxPointDic = {}

	maxPointDic[KindergartenModel.STRENGTH] = actCfg.strengthPoint
	maxPointDic[KindergartenModel.ART] = actCfg.artPoint
	maxPointDic[KindergartenModel.INTELLECT] = actCfg.intellectPoint

	local info = self:getInfo(activityId)

	for i, classroom in ipairs(info.classroomList) do
		if classroom.unlockFacilityId > 0 then
			local cfgClassroom = KindergartenConfig.instance:getClassRoomCfg(activityId, classroom.classroomId)

			if cfgClassroom then
				local cfgPlans = KindergartenConfig.instance:getFacilityPlanCfgs(cfgClassroom.facilityPlanId)

				for j, cfgPlan in ipairs(cfgPlans or {}) do
					if cfgPlan.facilityId <= classroom.unlockFacilityId then
						maxPointDic[KindergartenModel.STRENGTH] = maxPointDic[KindergartenModel.STRENGTH] + cfgPlan.strengthPoint
						maxPointDic[KindergartenModel.ART] = maxPointDic[KindergartenModel.ART] + cfgPlan.artPoint
						maxPointDic[KindergartenModel.INTELLECT] = maxPointDic[KindergartenModel.INTELLECT] + cfgPlan.intellectPoint
					end
				end
			end
		end
	end

	return maxPointDic
end

function KindergartenModel:getLeftQualityPointToday(activityId)
	local maxPointDic = self:getMaxQualityPointToday(activityId)
	local leftPointDic = {}

	leftPointDic[KindergartenModel.STRENGTH] = maxPointDic[KindergartenModel.STRENGTH] - self:getUsedQualityPointToday(activityId, KindergartenModel.STRENGTH)
	leftPointDic[KindergartenModel.ART] = maxPointDic[KindergartenModel.ART] - self:getUsedQualityPointToday(activityId, KindergartenModel.ART)
	leftPointDic[KindergartenModel.INTELLECT] = maxPointDic[KindergartenModel.INTELLECT] - self:getUsedQualityPointToday(activityId, KindergartenModel.INTELLECT)

	return leftPointDic
end

function KindergartenModel:getLeftSumQualityPointToday(activityId)
	local leftPointDic = self:getLeftQualityPointToday(activityId)

	return leftPointDic[KindergartenModel.STRENGTH] + leftPointDic[KindergartenModel.ART] + leftPointDic[KindergartenModel.INTELLECT]
end

function KindergartenModel:getTotalStudentNum(activityId)
	local info = self:getInfo(activityId)

	for i, classInfo in ipairs(info.classList) do
		if classInfo.classId == classId then
			for j, studentInfo in ipairs(classInfo.studentList or {}) do
				if studentInfo.studentType == KindergartenModel.TalentStudent then
					talentNum = talentNum + 1
				else
					normalNum = normalNum + 1
				end
			end
		end
	end
end

function KindergartenModel:getStudentNum(activityId, classId)
	local normalNum = 0
	local talentNum = 0
	local info = self:getInfo(activityId)

	for i, classInfo in ipairs(info.classList) do
		if classInfo.classId == classId then
			for j, studentInfo in ipairs(classInfo.studentList or {}) do
				if studentInfo.studentType == KindergartenModel.TalentStudent then
					talentNum = talentNum + 1
				else
					normalNum = normalNum + 1
				end
			end
		end
	end

	return normalNum, talentNum
end

function KindergartenModel:getClassCourseState(activityId, classId)
	local info = self:getInfo(activityId)

	for i, classInfo in ipairs(info.classList) do
		if classInfo.classId == classId then
			local time = checknumber(classInfo.classFinishTime)

			if time < 0 then
				return KindergartenModel.BeforeCourse
			else
				local curTime = ServerTime.now()
				local finishTime = time / 1000

				if curTime < finishTime then
					return KindergartenModel.DoingCourse
				else
					return KindergartenModel.AfterCourse
				end
			end
		end
	end

	return KindergartenModel.BeforeCourse
end

function KindergartenModel:getClassCourseFinshTime(activityId, classId)
	local info = self:getInfo(activityId)

	for i, classInfo in ipairs(info.classList) do
		if classInfo.classId == classId then
			return checknumber(classInfo.classFinishTime) / 1000
		end
	end

	return 0
end

function KindergartenModel:getTodayClassTimes(activityId, classId)
	local info = self:getInfo(activityId)

	for i, classInfo in ipairs(info.classList) do
		if classInfo.classId == classId then
			return classInfo.todayClassTimes
		end
	end
end

function KindergartenModel:saveOpenClass(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self:getInfo(data.activityId)

	info.todayUseQualityPointList = data.todayUseQualityPointList

	for i, v in ipairs(info.classList) do
		if v.classId == data.classInfo.classId then
			info.classList[i] = data.classInfo

			break
		end
	end
end

function KindergartenModel:getClassPoint(activityId, classId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.classList) do
		if v.classId == classId then
			local list = {}

			for j, data in ipairs(v.pointScheduleList) do
				list[data.pointType + 1] = data.value
			end

			return list
		end
	end

	return {
		0,
		0,
		0
	}
end

function KindergartenModel:getFirstIntoMain(activityId)
	return GameUtil.getUserData("KindergartenModel.ReadFlag#firstMain#" .. activityId)
end

function KindergartenModel:saveFirstIntoMain(activityId)
	GameUtil.saveUserData("KindergartenModel.ReadFlag#firstMain#" .. activityId, true)
end

function KindergartenModel:getFirstIntoManage(activityId)
	return GameUtil.getUserData("KindergartenModel.ReadFlag#firstManage#" .. activityId)
end

function KindergartenModel:saveFirstIntoManage(activityId)
	GameUtil.saveUserData("KindergartenModel.ReadFlag#firstManage#" .. activityId, true)
end

function KindergartenModel:getFirstIntoCourse(activityId)
	return GameUtil.getUserData("KindergartenModel.ReadFlag#firstCourse#" .. activityId)
end

function KindergartenModel:saveFirstIntoCourse(activityId)
	GameUtil.saveUserData("KindergartenModel.ReadFlag#firstCourse#" .. activityId, true)
end

KindergartenModel.instance = KindergartenModel.New()

return KindergartenModel
