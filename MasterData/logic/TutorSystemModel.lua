-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/model/TutorSystemModel.lua

module("logic.extensions.tutorsystem.model.TutorSystemModel", package.seeall)

local TutorSystemModel = class("TutorSystemModel", BaseModel)

function TutorSystemModel:ctor()
	return
end

function TutorSystemModel:onInit()
	self:onReset()
end

function TutorSystemModel:onReset()
	self._myUserTutorState = {}
	self._myTutorStudentInfo = nil
	self._myTutorTeacherInfo = nil
	self._newPuzzleFinishTutorFlag = false

	self:resetGraduateInfoStack()

	self._recommendList = {}
	self._requestList = {}
	self._searchList = {}
	self._hasGraduatedStuNum = 0
	self._prizeIdListInTeaTask = {}
	self._growthTaskInfoInTeaPlanGrowthTask = {}
	self._stuTaskInfo = {
		progressScore = 0,
		baseTaskInfoList = {},
		growUpTaskInfoList = {},
		publishedGrowthTaskIdList = {},
		gainedScorePrizeIdList = {}
	}
	self._baseTaskMoPool = {}
	self._growthTaskMoPool = {}
	self._tutorPuzzlePos = {}
	self._leftCanOpTimes = 0
	self._puzzleGainPrizeId = {}
	self._dtDailyScore = 0
	self._teaLeaseInfosPool = {}
	self._stuHirePetInfoList = {}
	self._myTotalHireTimesWhenStu = 0
	self._stuCurHirePetInfo = nil
	self._redInfoGroupPool = {}
	self._gainedPrizeIdsInZdlPrize = {}
	self._myIdentityType = 0
	self._myIdentityState = 0
end

function TutorSystemModel:handleTutorMainInfoRes(msg)
	self._newPuzzleFinishTutorFlag = msg.newPuzzleFinishTutorFlag
	self._myTutorFinishPrizeNotify = msg.finishNotifys

	self:_handleIdentityInfo(msg.identityInfo)
	self:pushGraduateInfoListStack(msg.finishNotifys)
end

function TutorSystemModel:_handleIdentityInfo(identityInfo)
	self._myUserTutorState = identityInfo.state
	self._myTutorStudentInfo = identityInfo.studentInfo
	self._myTutorTeacherInfo = identityInfo.teacherInfo

	self:_updateMyUserTutorState()
end

function TutorSystemModel:handleTutorRecommendRes(msg)
	self._recommendList = msg.recommendList
end

function TutorSystemModel:handleTutorSearchRes(msg)
	self._searchList = msg.searchList
end

function TutorSystemModel:handleTutorSendRequestRes(msg)
	return
end

function TutorSystemModel:handleTutorReceivedRequestRes(msg)
	self._requestList = msg.requestList
	self._recommendList = msg.recommendList
end

function TutorSystemModel:handleTutorHandleRequestRes(msg)
	return
end

function TutorSystemModel:_updateMyUserTutorState()
	local studyState = self._myUserTutorState.studyState
	local maxZdl = self._myUserTutorState.maxZdl
	local teaZdlLimit = TutorSystemConfig.instance:getTsTeacherZdlLimit()
	local stuZdlLimit = TutorSystemConfig.instance:getTsStudentZdlLimit()
	local identityType = 0
	local identityState = 0

	if studyState == 0 then
		local stuCount = self:getCurStuCountAsTea()

		identityType = stuCount > 0 and GameEnum.IdentityType.Teacher or GameEnum.IdentityType.FreeMan
	elseif studyState == 1 then
		identityType = GameEnum.IdentityType.Student
	elseif studyState == 2 then
		local stuCount = self:getCurStuCountAsTea()

		identityType = stuCount > 0 and GameEnum.IdentityType.Teacher or GameEnum.IdentityType.FreeMan
	end

	if identityType == GameEnum.IdentityType.Student then
		identityState = GameEnum.IdentityState.IsStudying
	elseif identityType == GameEnum.IdentityType.Teacher then
		identityState = self:isHasFullStuCountAsTea() and GameEnum.IdentityState.NotRecruiting or GameEnum.IdentityState.Recruiting
	elseif identityType == GameEnum.IdentityType.FreeMan then
		if maxZdl <= stuZdlLimit then
			identityState = studyState == 2 and GameEnum.IdentityState.StuHasFinish or GameEnum.IdentityState.StuQuals
		elseif stuZdlLimit < maxZdl and maxZdl < teaZdlLimit then
			identityState = GameEnum.IdentityState.NoStuTeaQuals
		elseif teaZdlLimit <= maxZdl then
			identityState = GameEnum.IdentityState.TeaQuals
		end
	end

	self._myIdentityType = identityType
	self._myIdentityState = identityState
end

function TutorSystemModel:handleTutorRelieveRes(msg)
	return
end

function TutorSystemModel:handleNotifyEstablishTutorRelationRes(msg)
	self:_handleIdentityInfo(msg.identityInfo)
end

function TutorSystemModel:handleNotifyTutorRelieveRes(msg)
	self:_handleIdentityInfo(msg.identityInfo)
end

function TutorSystemModel:handleNotifyTutorReceivedTeacherRequestRes(msg)
	return
end

function TutorSystemModel:handleNotifyTutorReceivedStudentRequestRes(msg)
	return
end

function TutorSystemModel:handleNotifyTutorStudentFinishTutorRes(msg)
	self:_handleIdentityInfo(msg.identityInfo)
end

function TutorSystemModel:handleNotifyTutorClassmateEstablishRes(msg)
	return
end

function TutorSystemModel:handleNotifyTutorClassmateRelieveRes(msg)
	return
end

function TutorSystemModel:handleNotifyTutorClassmateFinishRes(msg)
	return
end

function TutorSystemModel:handleTutorTeacherTaskInfoRes(msg)
	self._growthTaskInfoInTeaPlanGrowthTask[msg.studentUserId] = {
		studentUserId = msg.studentUserId,
		randomGrowthTask = msg.randomGrowthTask,
		publishedGrowthTask = msg.publishedGrowthTask,
		studentFinishGrowthTaskIds = msg.studentFinishGrowthTaskIds,
		gainedFinishPrizeTaskIds = msg.gainedFinishPrizeTaskIds,
		autoPublishGrowUpTaskSwitch = msg.autoPublishGrowUpTaskSwitch
	}
end

function TutorSystemModel:handleTutorTeacherSwitchAutoPublishGrowUpTaskRes(msg)
	for i, v in pairs(self._growthTaskInfoInTeaPlanGrowthTask) do
		v.autoPublishGrowUpTaskSwitch = msg.switch
	end
end

function TutorSystemModel:handleTutorTeacherPublishGrowUpTaskRes(msg)
	return
end

function TutorSystemModel:handleTutorGainFinishPublishPrizeRes(msg)
	return
end

function TutorSystemModel:handleTutorTeacherProgressPrizeInfoRes(msg)
	self._hasGraduatedStuNum = msg.num
	self._prizeIdListInTeaTask = msg.prizeId
end

function TutorSystemModel:handleTutorGainTeacherProgressPrizeRes(msg)
	return
end

function TutorSystemModel:handleTutorTeacherGainStudentBaseTaskInfoRes(msg)
	self:handleMoAsBaseTask(msg.studentUserId, msg.baseTask)
end

function TutorSystemModel:handleTutorTeacherGainStudentGrowthTaskInfoRes(msg)
	self:handleMoAsGrowthTask(msg.studentUserId, msg.growUpTask, msg.publishedGrowthTask)
end

function TutorSystemModel:handleTutorStudentTaskInfoRes(msg)
	self._stuTaskInfo = {
		baseTaskInfoList = msg.baseTask,
		growUpTaskInfoList = msg.growUpTask,
		publishedGrowthTaskIdList = msg.publishedGrowthTask,
		progressScore = msg.score,
		gainedScorePrizeIdList = msg.gainedScorePrizes
	}
end

function TutorSystemModel:handleTutorStudentGainBaseTaskPrizeRes(msg)
	return
end

function TutorSystemModel:handleTutorStudentGainGrowthTaskPrizeRes(msg)
	return
end

function TutorSystemModel:handleTutorStudentGainProgressPrizeRes(msg)
	return
end

function TutorSystemModel:handleTutorPuzzleInfoRes(msg)
	self._tutorPuzzlePos = msg.activePos
	self._leftCanOpTimes = checknumber(msg.times)
	self._puzzleGainPrizeId = msg.gainPrizeId
end

function TutorSystemModel:handleTutorActivePuzzleRes(msg)
	self._tutorPuzzlePos = msg.activePos
	self._leftCanOpTimes = Mathf.Max(self._leftCanOpTimes - 1, 0)
end

function TutorSystemModel:handleTutorGainPuzzlePrizeRes(msg)
	return
end

function TutorSystemModel:handlePM_TutorStudentZdlPrizeInfoRes(msg)
	self._gainedPrizeIdsInZdlPrize = msg.gainedPrizeIds
end

function TutorSystemModel:handlePM_TutorStudentGainZdlPrizeRes(msg)
	return
end

function TutorSystemModel:handlePM_TutorStudentNewPuzzleInfoRes(msg)
	self._tutorPuzzlePos = msg.activePos
	self._leftCanOpTimes = checknumber(msg.times)
	self._puzzleGainPrizeId = msg.gainPrizeId
	self._dtDailyScore = msg.dtDailyScore
end

function TutorSystemModel:handlePM_TutorStudentNewPuzzleActiveRes(msg)
	self._tutorPuzzlePos = msg.activePos
	self._leftCanOpTimes = Mathf.Max(self._leftCanOpTimes - 1, 0)
end

function TutorSystemModel:handlePM_TutorStudentNewPuzzleGainPrizeRes(msg)
	return
end

function TutorSystemModel:handlePM_TutorTeacherMonthlyRankInfoRes(msg)
	return
end

function TutorSystemModel:handlePM_TutorTeacherRankInfoRes(msg)
	return
end

function TutorSystemModel:handleTutorTeacherPetHireInfoRes(msg)
	self._teaLeaseInfosPool[msg.studentUserId] = {
		hirePets = msg.hirePets,
		gainHirePetPrize = msg.gainHirePetPrize,
		studentUserId = msg.studentUserId,
		curHirePetId = msg.curHirePetId
	}
end

function TutorSystemModel:handleTutorTeacherSetHirePetRes(msg)
	return
end

function TutorSystemModel:handleTutorGainTeacherHirePetPrizeRes(msg)
	if self._teaLeaseInfosPool[msg.studentUserId] == nil then
		printError("无法设置,对象为nil")

		return
	end

	self._teaLeaseInfosPool[msg.studentUserId].gainHirePetPrize = true
end

function TutorSystemModel:handleTutorStudentPetHireInfoRes(msg)
	self._stuHirePetInfoList = msg.hirePets
	self._myTotalHireTimesWhenStu = msg.totalHireTimes
	self._stuCurHirePetInfo = msg.curHirePet
end

function TutorSystemModel:handleTutorStudentHirePetRes(msg)
	return
end

function TutorSystemModel:getMyUserTutorState()
	return self._myUserTutorState
end

function TutorSystemModel:getMyTutorFinishPrizeNotify()
	return self._myTutorFinishPrizeNotify
end

function TutorSystemModel:getNewPuzzleFinishTutorFlag()
	return self._newPuzzleFinishTutorFlag
end

function TutorSystemModel:getMyIdentityType()
	return self._myIdentityType
end

function TutorSystemModel:getMyIdentityState()
	return self._myIdentityState
end

function TutorSystemModel:accessTutorSystem(isEnter)
	self._isInTutorSystem = isEnter
end

function TutorSystemModel:isInTutorSystem()
	return self._isInTutorSystem == true
end

function TutorSystemModel:getMyInfoAsStu()
	return self._myTutorStudentInfo
end

function TutorSystemModel:getMyStartTimesAsStu()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.startTimes or nil)
end

function TutorSystemModel:getMyTeaShowInfoAsStu()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.headInfo or nil)
end

function TutorSystemModel:getMyTeaHeadInfoAsStu()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.headInfo.headInfo or nil)
end

function TutorSystemModel:getMyTeaUserIdAsStu()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.headInfo.headInfo.userId or nil)
end

function TutorSystemModel:getMyTeaUserNameAsStu()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.headInfo.headInfo.userName or nil)
end

function TutorSystemModel:getMyTeaMaxZdl()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.headInfo.maxZdl or nil)
end

function TutorSystemModel:getMyTeaGenderAsStu()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.headInfo.gender or nil)
end

function TutorSystemModel:getMyTeaClothesAsStu()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.headInfo.clothes or nil)
end

function TutorSystemModel:getMyBrotherHeadInfoAsStu()
	local info = self:getMyInfoAsStu()

	return (info or nil) and (info.brotherHeadInfo or nil)
end

function TutorSystemModel:getMyInfoAsTea()
	return self._myTutorTeacherInfo
end

function TutorSystemModel:getStuInfoListAsTea()
	if self._myTutorTeacherInfo == nil then
		printError("试图获取目标为空的数据,请检查逻辑")

		return
	end

	return self._myTutorTeacherInfo.student
end

function TutorSystemModel:getStuInfoAsTea(stuUserId)
	local targetInfo
	local stuInfoList = self:getStuInfoListAsTea()

	for _, info in ipairs(stuInfoList) do
		if info.headInfo.headInfo.userId == stuUserId then
			targetInfo = info

			break
		end
	end

	return targetInfo
end

function TutorSystemModel:getMyStudentStartTimesAsTea(stuUserId)
	local stuInfo = self:getStuInfoAsTea(stuUserId)

	return (stuInfo or nil) and (stuInfo.startTimes or nil)
end

function TutorSystemModel:getMyStudentTaskProgressAsTea(stuUserId)
	local stuInfo = self:getStuInfoAsTea(stuUserId)

	return (stuInfo or nil) and (stuInfo.taskProgress or 0)
end

function TutorSystemModel:getPuzzleTimesforMyStudentAsTea(stuUserId)
	local stuInfo = self:getStuInfoAsTea(stuUserId)

	return (stuInfo or nil) and (stuInfo.puzzleTimes or 0)
end

function TutorSystemModel:getCurStuCountAsTea()
	local info = self:getMyInfoAsTea()

	return (info or nil) and (#info.student or 0)
end

function TutorSystemModel:getFinishStuCountAsTea()
	local info = self:getMyInfoAsTea()

	return info and checknumber(info.finishStudentNum) or 0
end

function TutorSystemModel:isHasFullStuCountAsTea()
	local stuLimit = TutorSystemConfig.instance:getTsTeachStudentLimit()
	local myCurStuCount = self:getCurStuCountAsTea()

	return stuLimit <= myCurStuCount
end

function TutorSystemModel:isGraduateInfoStackHaveContent()
	return #self._graduateInfoStack > 0
end

function TutorSystemModel:pushGraduateInfoListStack(infoList)
	for _, info in ipairs(infoList) do
		self:pushGraduateInfoStack(info)
	end
end

function TutorSystemModel:pushGraduateInfoStack(info)
	table.insert(self._graduateInfoStack, info)
end

function TutorSystemModel:popGraduateInfoStack()
	return table.remove(self._graduateInfoStack)
end

function TutorSystemModel:resetGraduateInfoStack()
	self._graduateInfoStack = {}
end

function TutorSystemModel:getRecommendList()
	return self._recommendList
end

function TutorSystemModel:getRequestList()
	return self._requestList
end

function TutorSystemModel:getSearchList()
	return self._searchList
end

function TutorSystemModel:getHasGraduatedStuNumInTeaTask()
	return self._hasGraduatedStuNum
end

function TutorSystemModel:isPrizeHasGainInTeaTask(targetPrizeId)
	local isHasGain = false
	local prizeList = self:_getPrizeIdListInTeaTask()

	for _, prizeId in ipairs(prizeList) do
		if targetPrizeId == prizeId then
			isHasGain = true

			break
		end
	end

	return isHasGain
end

function TutorSystemModel:_getPrizeIdListInTeaTask()
	return self._prizeIdListInTeaTask
end

function TutorSystemModel:getProgressScoreInStuTask()
	return self._stuTaskInfo.progressScore
end

function TutorSystemModel:getGainedScorePrizeIdListInStuTask()
	return self._stuTaskInfo.gainedScorePrizeIdList
end

function TutorSystemModel:isHasGainScorePrizeInStuTask(targetPrizeId)
	local isHasGain = false
	local prizeList = self:getGainedScorePrizeIdListInStuTask()

	for _, prizeId in ipairs(prizeList) do
		if targetPrizeId == prizeId then
			isHasGain = true

			break
		end
	end

	return isHasGain
end

function TutorSystemModel:getBaseTaskInfoListInStuTask()
	return self._stuTaskInfo.baseTaskInfoList
end

function TutorSystemModel:getBaseTaskInfoInStuTask(taskId)
	local targetInfo
	local taskInfoList = self:getBaseTaskInfoListInStuTask()

	for _, info in ipairs(taskInfoList) do
		if info.taskId == taskId then
			targetInfo = info

			break
		end
	end

	return targetInfo
end

function TutorSystemModel:getBaseTaskCurProgressInStuTask(taskId)
	local info = self:getBaseTaskInfoInStuTask(taskId)

	return (info or nil) and (info.curProgress or 0)
end

function TutorSystemModel:isHasGainBaseTaskPrizeInStuTask(taskId)
	local info = self:getBaseTaskInfoInStuTask(taskId)

	return (info or nil) and (info.hasGainPrize or false)
end

function TutorSystemModel:getGrowUpTaskInfoListInStuTask()
	return self._stuTaskInfo.growUpTaskInfoList
end

function TutorSystemModel:getGrowUpTaskInfoInStuTask(taskId)
	local targetInfo
	local taskInfoList = self:getGrowUpTaskInfoListInStuTask()

	for _, info in ipairs(taskInfoList) do
		if info.taskId == taskId then
			targetInfo = info

			break
		end
	end

	return targetInfo
end

function TutorSystemModel:getGrowUpTaskCurProgressInStuTask(taskId)
	local info = self:getGrowUpTaskInfoInStuTask(taskId)

	return (info or nil) and (info.curProgress or 0)
end

function TutorSystemModel:isHasGainGrowUpTaskPrizeInStuTask(taskId)
	local info = self:getGrowUpTaskInfoInStuTask(taskId)

	return (info or nil) and (info.hasGainPrize or false)
end

function TutorSystemModel:getPublishedGrowthTaskIdListInStuTask()
	return self._stuTaskInfo.publishedGrowthTaskIdList
end

function TutorSystemModel:getPublishedTaskCountInTeaPlanGrowTask(stuUserId)
	local taskIdList = self:getPublishedGrowthTaskIdListInTeaPlanGrowTask(stuUserId)

	return (taskIdList or nil) and (#taskIdList or 0)
end

function TutorSystemModel:getFinishedTaskCountInTeaPlanGrowTask(stuUserId)
	local taskIdList = self:getStudentFinishGrowthTaskIdListInTeaPlanGrowTask(stuUserId)

	return (taskIdList or nil) and (#taskIdList or 0)
end

function TutorSystemModel:isHasPublishedTaskInTeaPlanGrowTask(stuUserId, targetTaskId)
	local isHasPublished = false
	local taskIdList = self:getPublishedGrowthTaskIdListInTeaPlanGrowTask(stuUserId)

	for _, taskId in ipairs(taskIdList) do
		if targetTaskId == taskId then
			isHasPublished = true

			break
		end
	end

	return isHasPublished
end

function TutorSystemModel:isHasFinishedTaskInTeaPlanGrowTask(stuUserId, targetTaskId)
	local isHasFinished = false
	local taskIdList = self:getStudentFinishGrowthTaskIdListInTeaPlanGrowTask(stuUserId)

	for _, taskId in ipairs(taskIdList) do
		if targetTaskId == taskId then
			isHasFinished = true

			break
		end
	end

	return isHasFinished
end

function TutorSystemModel:isHasGainTaskPrizeInTeaPlanGrowTask(stuUserId, targetTaskId)
	local isHasGain = false
	local taskIdList = self:getGainedFinishPrizeTaskIdsListInTeaPlanGrowTask(stuUserId)

	for _, taskId in ipairs(taskIdList) do
		if targetTaskId == taskId then
			isHasGain = true

			break
		end
	end

	return isHasGain
end

function TutorSystemModel:getGrowthTaskInfoInTeaPlanGrowTask(stuUserId)
	return self._growthTaskInfoInTeaPlanGrowthTask[stuUserId]
end

function TutorSystemModel:getRandomGrowthTaskIdListInTeaPlanGrowTask(stuUserId)
	local info = self:getGrowthTaskInfoInTeaPlanGrowTask(stuUserId)

	return (info or nil) and (info.randomGrowthTask or nil)
end

function TutorSystemModel:getPublishedGrowthTaskIdListInTeaPlanGrowTask(stuUserId)
	local info = self:getGrowthTaskInfoInTeaPlanGrowTask(stuUserId)

	return (info or nil) and (info.publishedGrowthTask or nil)
end

function TutorSystemModel:getStudentFinishGrowthTaskIdListInTeaPlanGrowTask(stuUserId)
	local info = self:getGrowthTaskInfoInTeaPlanGrowTask(stuUserId)

	return (info or nil) and (info.studentFinishGrowthTaskIds or nil)
end

function TutorSystemModel:getGainedFinishPrizeTaskIdsListInTeaPlanGrowTask(stuUserId)
	local info = self:getGrowthTaskInfoInTeaPlanGrowTask(stuUserId)

	return (info or nil) and (info.gainedFinishPrizeTaskIds or nil)
end

function TutorSystemModel:handleMoAsBaseTask(userId, baseTaskInfoList)
	self._baseTaskMoPool[userId] = {
		userId = userId,
		baseTaskInfoList = baseTaskInfoList
	}
end

function TutorSystemModel:_getMoAsBaseTask(userId)
	return self._baseTaskMoPool[userId]
end

function TutorSystemModel:getInfoListAsBaseTask(userId)
	local mo = self:_getMoAsBaseTask(userId)

	return (mo or nil) and (mo.baseTaskInfoList or {})
end

function TutorSystemModel:getInfoAsBaseTask(userId, taskId)
	local resultInfo
	local infoList = self:getInfoListAsBaseTask(userId)

	for _, info in ipairs(infoList) do
		if info.taskId == taskId then
			resultInfo = info

			break
		end
	end

	return resultInfo
end

function TutorSystemModel:getCurProgressAsBaseTask(userId, taskId)
	local info = self:getInfoAsBaseTask(userId, taskId)

	return (info or nil) and (info.curProgress or 0)
end

function TutorSystemModel:isHasGainPrizeAsBaseTask(userId, taskId)
	local info = self:getInfoAsBaseTask(userId, taskId)

	return (info or nil) and (info.hasGainPrize or false)
end

function TutorSystemModel:handleMoAsGrowthTask(userId, growthTaskInfoList, publishedGrowthTaskIdList)
	self._growthTaskMoPool[userId] = {
		userId = userId,
		growthTaskInfoList = growthTaskInfoList,
		publishedGrowthTaskIdList = publishedGrowthTaskIdList
	}
end

function TutorSystemModel:_getMoAsGrowthTask(userId)
	return self._growthTaskMoPool[userId]
end

function TutorSystemModel:getInfoListAsGrowthTask(userId)
	local mo = self:_getMoAsGrowthTask(userId)

	return (mo or nil) and (mo.growthTaskInfoList or {})
end

function TutorSystemModel:getInfoAsGrowthTask(userId, taskId)
	local resultInfo
	local infoList = self:getInfoListAsGrowthTask(userId)

	for _, info in ipairs(infoList) do
		if info.taskId == taskId then
			resultInfo = info

			break
		end
	end

	return resultInfo
end

function TutorSystemModel:getCurProgressAsGrowthTask(userId, taskId)
	local info = self:getInfoAsGrowthTask(userId, taskId)

	return (info or nil) and (info.curProgress or 0)
end

function TutorSystemModel:isHasGainPrizeAsGrowthTask(userId, taskId)
	local info = self:getInfoAsGrowthTask(userId, taskId)

	return (info or nil) and (info.hasGainPrize or false)
end

function TutorSystemModel:getPublishedGrowthTaskIdList(userId)
	local mo = self:_getMoAsGrowthTask(userId)

	return (mo or nil) and (mo.publishedGrowthTaskIdList or {})
end

function TutorSystemModel:getPublishedGrowthTaskCount(userId)
	local taskIdList = self:getPublishedGrowthTaskIdList(userId)

	return #taskIdList
end

function TutorSystemModel:isTaskHasPublishedAsGrowthTask(userId, taskId)
	local taskIdList = self:getPublishedGrowthTaskIdList(userId)

	return table.indexof(taskIdList, taskId) ~= false
end

function TutorSystemModel:isTutorPuzzlePosActive(posX, posY)
	local isActive = false

	for _, pos in ipairs(self._tutorPuzzlePos) do
		if pos.x == posX and pos.y == posY then
			isActive = true

			break
		end
	end

	return isActive
end

function TutorSystemModel:getLeftCanOpTimes()
	return self._leftCanOpTimes
end

function TutorSystemModel:isHasGainTutorPuzzlePrize(targetPrizeId)
	local isHasGain = false
	local prizeList = self:_getPuzzleGainPrizeIdList()

	for _, prizeId in ipairs(prizeList) do
		if targetPrizeId == prizeId then
			isHasGain = true

			break
		end
	end

	return isHasGain
end

function TutorSystemModel:_getPuzzleGainPrizeIdList()
	return self._puzzleGainPrizeId
end

function TutorSystemModel:getDtDailyScore()
	return self._dtDailyScore
end

function TutorSystemModel:_getTeaLeaseInfoInTeaLease(stuUserId)
	return self._teaLeaseInfosPool[stuUserId]
end

function TutorSystemModel:getHirePetInfoListInTeaLease(stuUserId)
	local info = self:_getTeaLeaseInfoInTeaLease(stuUserId)

	return (info or nil) and (info.hirePets or {})
end

function TutorSystemModel:getHirePetInfoInTeaLease(stuUserId, slotId)
	local targetInfo
	local infoList = self:getHirePetInfoListInTeaLease(stuUserId)

	for _, info in ipairs(infoList) do
		if info.slotId == slotId then
			targetInfo = info

			break
		end
	end

	return targetInfo
end

function TutorSystemModel:getHirePetViewInSlotInTeaLease(stuUserId, slotId)
	local info = self:getHirePetInfoInTeaLease(stuUserId, slotId)

	return (info or nil) and (info.petView or nil)
end

function TutorSystemModel:getCurHirePetIdInTeaLease(stuUserId)
	local info = self:_getTeaLeaseInfoInTeaLease(stuUserId)

	return (info or nil) and (info.curHirePetId or -1)
end

function TutorSystemModel:isHaveHirePetInSlotInTeaLease(stuUserId, slotId)
	local petView = self:getHirePetViewInSlotInTeaLease(stuUserId, slotId)

	return petView ~= nil
end

function TutorSystemModel:isHasGainHirePetPrizeInTeaLease(stuUserId)
	local info = self:_getTeaLeaseInfoInTeaLease(stuUserId)

	return (info or nil) and (info.gainHirePetPrize or false)
end

function TutorSystemModel:isHasLeaseTheSlotByStuInTeaLease(stuUserId, slotId)
	local petView = self:getHirePetViewInSlotInTeaLease(stuUserId, slotId)

	if petView == nil then
		return false
	end

	local petId = petView.petId
	local curHirePetId = self:getCurHirePetIdInTeaLease(stuUserId)

	return petId == curHirePetId
end

function TutorSystemModel:getHirePetInfoListInStuLease()
	return self._stuHirePetInfoList
end

function TutorSystemModel:getHirePetInfoInStuLease(slotId)
	local info
	local infoList = self:getHirePetInfoListInStuLease()

	for _, v in ipairs(infoList) do
		if v.slotId == slotId then
			info = v

			break
		end
	end

	return info
end

function TutorSystemModel:getHirePetViewInStuLease(slotId)
	local info = self:getHirePetInfoInStuLease(slotId)

	return (info or nil) and (info.petView or nil)
end

function TutorSystemModel:getHirePetZdlInStuLease(slotId)
	local info = self:getHirePetInfoInStuLease(slotId)

	return (info or nil) and (info.zdl or 0)
end

function TutorSystemModel:getHirePetTimesInSlotInStuLease(slotId)
	local info = self:getHirePetInfoInStuLease(slotId)

	return (info or nil) and (info.times or -1)
end

function TutorSystemModel:getTotalHireTimesInStuLease()
	return self._myTotalHireTimesWhenStu
end

function TutorSystemModel:getCurHirePetInfoInStuLease()
	return self._stuCurHirePetInfo
end

function TutorSystemModel:getCurHirePetLeftTimesInStuLease()
	local info = self:getCurHirePetInfoInStuLease()

	return (info or nil) and (info.leftTimes or 0)
end

function TutorSystemModel:isHasHirePetInStuLease()
	local info = self:getCurHirePetInfoInStuLease()
	local tb = GameUtil.pbToTable(info)

	return not not tb
end

function TutorSystemModel:isHasPushPetToSlotInStuLease(slotId)
	local info
	local infoList = self:getHirePetInfoListInStuLease()

	for _, v in ipairs(infoList) do
		if v.slotId == slotId then
			info = v

			break
		end
	end

	return info ~= nil
end

function TutorSystemModel:isHiringThePetInSlotInStuLease(slotId)
	local petView = self:getHirePetViewInStuLease(slotId)

	if petView == nil then
		return false
	end

	local hirePetInfo = self:getCurHirePetInfoInStuLease()

	if hirePetInfo == nil then
		return false
	end

	return hirePetInfo.petId == petView.petId
end

function TutorSystemModel:isHiringThePetInStuLease(petId)
	local hirePetInfo = self:getCurHirePetInfoInStuLease()

	if hirePetInfo == nil then
		return false
	end

	return hirePetInfo.petId == petId
end

function TutorSystemModel:_saveTutorRedInfo(redType, userId, isActivated, showTime, endTime)
	if self._redInfoGroupPool[redType] == nil then
		self._redInfoGroupPool[redType] = {}
	end

	if self._redInfoGroupPool[redType][userId] == nil then
		self._redInfoGroupPool[redType][userId] = {}
	end

	self._redInfoGroupPool[redType][userId] = {
		redType = redType,
		userId = userId,
		isActivated = isActivated,
		showTime = showTime,
		endTime = endTime
	}
end

function TutorSystemModel:getTutorRedInfoGroup(redType)
	return self._redInfoGroupPool[redType] or {}
end

function TutorSystemModel:getTutorRedInfo(redType, userId)
	return self:getTutorRedInfoGroup(redType)[userId]
end

function TutorSystemModel:getTutorServantRedId(redType, userId)
	return string.format("tsRed_%s_%s", redType, userId)
end

function TutorSystemModel:isCanGetPrizeInZdlPrize(prizeId)
	return not self:isHasGainPrizeInZdlPrize(prizeId) and self:isEnoughPrizeInZdlPrize(prizeId)
end

function TutorSystemModel:isHasGainPrizeInZdlPrize(prizeId)
	return table.indexof(self._gainedPrizeIdsInZdlPrize, prizeId) ~= false
end

function TutorSystemModel:isEnoughPrizeInZdlPrize(prizeId)
	local data = TutorSystemConfig.instance:getZdlPrizeData(prizeId)

	if data then
		if not data.zdl then
			local need = 0
			local cur = RoleModel.instance:getMaxPower()

			return need <= cur
		end
	end
end

TutorSystemModel.instance = TutorSystemModel.New()

return TutorSystemModel
