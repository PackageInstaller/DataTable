-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/controller/TutorSystemController.lua

module("logic.extensions.tutorsystem.controller.TutorSystemController", package.seeall)

local TutorSystemController = class("TutorSystemController", BaseController)

function TutorSystemController:ctor()
	return
end

function TutorSystemController:onInit()
	self:onReset()
end

function TutorSystemController:onReset()
	GlobalDispatcher:addListener("tutoropensearchview", self.openSearchViewByNotify, self)
end

function TutorSystemController:loadTutorSystem()
	TutorSystemController.instance:sendTutorMainInfoReq()
	TutorSystemController.instance:sendTutorLoadRedPointReq()
end

function TutorSystemController:sendTutorMainInfoReq()
	TutorSystemAgent.instance:sendPM_TutorMainInfoReq()
end

function TutorSystemController:handleTutorMainInfoRes(msg)
	TutorSystemModel.instance:handleTutorMainInfoRes(msg)

	for _, info in ipairs(msg.finishNotifys) do
		MaterialController.instance:saveChangeSetToTemp(info.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.TutorMainInfoRes)
end

function TutorSystemController:sendTutorRecommendReq(identity)
	TutorSystemAgent.instance:sendPM_TutorRecommendReq(identity)
end

function TutorSystemController:handleTutorRecommendRes(msg)
	TutorSystemModel.instance:handleTutorRecommendRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorRecommendRes)
end

function TutorSystemController:sendTutorSearchReq(identity, searchInfo, searchUserId)
	TutorSystemAgent.instance:sendPM_TutorSearchReq(identity, searchInfo, searchUserId)
end

function TutorSystemController:handleTutorSearchRes(msg)
	TutorSystemModel.instance:handleTutorSearchRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorSearchRes)
end

function TutorSystemController:sendTutorSendRequestReq(identity, userId)
	TutorSystemAgent.instance:sendPM_TutorSendRequestReq(identity, userId)
end

function TutorSystemController:handleTutorSendRequestRes(msg)
	TutorSystemModel.instance:handleTutorSendRequestRes(msg)
	self:popTipByKey(msg.result)
	GlobalDispatcher:dispatch(GlobalNotify.TutorSendRequestRes, msg)
end

function TutorSystemController:sendTutorReceivedRequestReq(identity)
	TutorSystemAgent.instance:sendPM_TutorReceivedRequestReq(identity)
end

function TutorSystemController:handleTutorReceivedRequestRes(msg)
	TutorSystemModel.instance:handleTutorReceivedRequestRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorReceivedRequestRes)
end

function TutorSystemController:sendTutorHandleRequestReq(identity, requestUserId, action)
	TutorSystemAgent.instance:sendPM_TutorHandleRequestReq(identity, requestUserId, action)
end

function TutorSystemController:handleTutorHandleRequestRes(msg)
	TutorSystemModel.instance:handleTutorHandleRequestRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorHandleRequestRes, msg)

	if msg.result == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorRelationShipChange)
	end
end

function TutorSystemController:sendTutorRelieveReq(identity, targetUserId)
	TutorSystemAgent.instance:sendPM_TutorRelieveReq(identity, targetUserId)
end

function TutorSystemController:handleTutorRelieveRes(msg)
	TutorSystemModel.instance:handleTutorRelieveRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorRelieveRes)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorRelationShipChange)
end

function TutorSystemController:sendTutorTeacherTaskInfoReq(studentUserId)
	TutorSystemAgent.instance:sendPM_TutorTeacherTaskInfoReq(studentUserId)
end

function TutorSystemController:handleTutorTeacherTaskInfoRes(msg)
	TutorSystemModel.instance:handleTutorTeacherTaskInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorTeacherTaskInfoRes)
end

function TutorSystemController:sendTutorTeacherSwitchAutoPublishGrowUpTaskReq(switch)
	TutorSystemAgent.instance:sendPM_TutorTeacherSwitchAutoPublishGrowUpTaskReq(switch)
end

function TutorSystemController:handleTutorTeacherSwitchAutoPublishGrowUpTaskRes(msg)
	TutorSystemModel.instance:handleTutorTeacherSwitchAutoPublishGrowUpTaskRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorTeacherSwitchAutoRes)
end

function TutorSystemController:sendTutorTeacherPublishGrowUpTaskReq(studentUserId, taskIds)
	TutorSystemAgent.instance:sendPM_TutorTeacherPublishGrowUpTaskReq(studentUserId, taskIds)
end

function TutorSystemController:handleTutorTeacherPublishGrowUpTaskRes(msg)
	TutorSystemModel.instance:handleTutorTeacherPublishGrowUpTaskRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorTeacherPublishGrowUpTaskRes)
end

function TutorSystemController:sendTutorGainFinishPublishPrizeReq(studentUserId, taskId)
	TutorSystemAgent.instance:sendPM_TutorGainFinishPublishPrizeReq(studentUserId, taskId)
end

function TutorSystemController:handleTutorGainFinishPublishPrizeRes(msg)
	TutorSystemModel.instance:handleTutorGainFinishPublishPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorGainFinishPublishPrizeRes)
end

function TutorSystemController:sendTutorStudentTaskInfoReq()
	TutorSystemAgent.instance:sendPM_TutorStudentTaskInfoReq()
end

function TutorSystemController:handleTutorStudentTaskInfoRes(msg)
	TutorSystemModel.instance:handleTutorStudentTaskInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorStudentTaskInfoRes)
end

function TutorSystemController:sendTutorStudentGainBaseTaskPrizeReq(taskId)
	TutorSystemAgent.instance:sendPM_TutorStudentGainBaseTaskPrizeReq(taskId)

	self._basePrizeTaskId = taskId
end

function TutorSystemController:handleTutorStudentGainBaseTaskPrizeRes(msg)
	TutorSystemModel.instance:handleTutorStudentGainBaseTaskPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorStudentGainBaseTaskPrizeRes, msg, self._basePrizeTaskId)
end

function TutorSystemController:sendPM_TutorStudentGainGrowthTaskPrizeReq(taskId)
	TutorSystemAgent.instance:sendPM_TutorStudentGainGrowthTaskPrizeReq(taskId)
end

function TutorSystemController:handleTutorStudentGainGrowthTaskPrizeRes(msg)
	TutorSystemModel.instance:handleTutorStudentGainGrowthTaskPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorStudentGainGrowthTaskPrizeRes)
end

function TutorSystemController:sendTutorStudentGainProgressPrizeReq(prizeId)
	TutorSystemAgent.instance:sendPM_TutorStudentGainProgressPrizeReq(prizeId)
end

function TutorSystemController:handleTutorStudentGainProgressPrizeRes(msg)
	TutorSystemModel.instance:handleTutorStudentGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorStudentGainProgressPrizeRes, msg)
end

function TutorSystemController:sendTutorPuzzleInfoReq(identity, targetUserId)
	TutorSystemAgent.instance:sendPM_TutorPuzzleInfoReq(identity, targetUserId)
end

function TutorSystemController:handleTutorPuzzleInfoRes(msg)
	TutorSystemModel.instance:handleTutorPuzzleInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorPuzzleInfoRes)
end

function TutorSystemController:sendTutorActivePuzzleReq(identity, targetUserId, pointId)
	local x, y = self:getPosByPointId(pointId)

	TutorSystemAgent.instance:sendPM_TutorActivePuzzleReq(identity, targetUserId, x, y)
end

function TutorSystemController:handleTutorActivePuzzleRes(msg)
	TutorSystemModel.instance:handleTutorActivePuzzleRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorActivePuzzleRes, msg)
end

function TutorSystemController:sendTutorGainPuzzlePrizeReq(identity, targetUserId, prizeId)
	TutorSystemAgent.instance:sendPM_TutorGainPuzzlePrizeReq(identity, targetUserId, prizeId)
end

function TutorSystemController:handleTutorGainPuzzlePrizeRes(msg)
	TutorSystemModel.instance:handleTutorGainPuzzlePrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorGainPuzzlePrizeRes)
end

function TutorSystemController:sendTutorTeacherPetHireInfoReq(studentUserId)
	TutorSystemAgent.instance:sendPM_TutorTeacherPetHireInfoReq(studentUserId)
end

function TutorSystemController:handleTutorTeacherPetHireInfoRes(msg)
	TutorSystemModel.instance:handleTutorTeacherPetHireInfoRes(msg)
	self:_updateRedPrizeInTeacherLease()
	GlobalDispatcher:dispatch(GlobalNotify.TutorTeacherPetHireInfoRes)
end

function TutorSystemController:sendTutorTeacherSetHirePetReq(studentUserId, slotId, petId)
	TutorSystemAgent.instance:sendPM_TutorTeacherSetHirePetReq(studentUserId, slotId, petId)
end

function TutorSystemController:handleTutorTeacherSetHirePetRes(msg)
	TutorSystemModel.instance:handleTutorTeacherSetHirePetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorTeacherSetHirePetRes)
end

function TutorSystemController:sendTutorGainTeacherHirePetPrizeReq(studentUserId)
	TutorSystemAgent.instance:sendPM_TutorGainTeacherHirePetPrizeReq(studentUserId)
end

function TutorSystemController:handleTutorGainTeacherHirePetPrizeRes(msg)
	TutorSystemModel.instance:handleTutorGainTeacherHirePetPrizeRes(msg)
	self:_updateRedPrizeInTeacherLease()
	GlobalDispatcher:dispatch(GlobalNotify.TutorGainTeacherHirePetPrizeRes)
end

function TutorSystemController:sendTutorStudentPetHireInfoReq()
	TutorSystemAgent.instance:sendPM_TutorStudentPetHireInfoReq()
end

function TutorSystemController:handleTutorStudentPetHireInfoRes(msg)
	TutorSystemModel.instance:handleTutorStudentPetHireInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorStudentPetHireInfoRes)
end

function TutorSystemController:sendTutorStudentHirePetReq(slotId)
	TutorSystemAgent.instance:sendPM_TutorStudentHirePetReq(slotId)
end

function TutorSystemController:handleTutorStudentHirePetRes(msg)
	TutorSystemModel.instance:handleTutorStudentHirePetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorStudentHirePetRes)
end

function TutorSystemController:sendTutorTeacherProgressPrizeInfoReq()
	TutorSystemAgent.instance:sendPM_TutorTeacherProgressPrizeInfoReq()
end

function TutorSystemController:handleTutorTeacherProgressPrizeInfoRes(msg)
	TutorSystemModel.instance:handleTutorTeacherProgressPrizeInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorTeacherProgressPrizeInfoRes)
end

function TutorSystemController:sendTutorGainTeacherProgressPrizeReq(prizeId)
	TutorSystemAgent.instance:sendPM_TutorGainTeacherProgressPrizeReq(prizeId)
end

function TutorSystemController:handleTutorGainTeacherProgressPrizeRes(msg)
	TutorSystemModel.instance:handleTutorGainTeacherProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorGainTeacherProgressPrizeRes)
end

function TutorSystemController:sendTutorTeacherGainStudentBaseTaskInfoReq(userId)
	TutorSystemAgent.instance:sendPM_TutorTeacherGainStudentBaseTaskInfoReq(userId)
end

function TutorSystemController:handleTutorTeacherGainStudentBaseTaskInfoRes(msg)
	TutorSystemModel.instance:handleTutorTeacherGainStudentBaseTaskInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorGainBaseTaskInfo)
end

function TutorSystemController:sendTutorTeacherGainStudentGrowthTaskInfoReq(userId)
	TutorSystemAgent.instance:sendPM_TutorTeacherGainStudentGrowthTaskInfoReq(userId)
end

function TutorSystemController:handleTutorTeacherGainStudentGrowthTaskInfoRes(msg)
	TutorSystemModel.instance:handleTutorTeacherGainStudentGrowthTaskInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TutorGainGrowthTaskInfo)
end

function TutorSystemController:sendTutorLoadRedPointReq()
	TutorSystemAgent.instance:sendPM_TutorLoadRedPointReq()
end

function TutorSystemController:handleTutorLoadRedPointRes(msg)
	local redTypeList = {}

	for _, info in ipairs(msg.point) do
		TutorSystemModel.instance:_saveTutorRedInfo(info.type, info.userId, info.isActivated, info.showTime, info.endTime)
		table.insert(redTypeList, info.type)
	end

	self:_updateTutorServantRed(redTypeList)
	GlobalDispatcher:dispatch(GlobalNotify.TutorRedPointChanged)
end

function TutorSystemController:sendPM_TutorStudentZdlPrizeInfoReq()
	TutorSystemAgent.instance:sendPM_TutorStudentZdlPrizeInfoReq()
end

function TutorSystemController:handlePM_TutorStudentZdlPrizeInfoRes(msg)
	TutorSystemModel.instance:handlePM_TutorStudentZdlPrizeInfoRes(msg)

	local isNeedRed = false
	local cfg = TutorSystemConfig.instance:getZdlPrizeCfg()

	if cfg then
		for _, data in ipairs(cfg) do
			if TutorSystemModel.instance:isCanGetPrizeInZdlPrize(data.prizeId) then
				isNeedRed = true

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TUTORSYSTEM_ZDLTASKRED, isNeedRed)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_TutorStudentZdlPrizeInfoRes)
end

function TutorSystemController:sendPM_TutorStudentGainZdlPrizeReq(prizeId)
	TutorSystemAgent.instance:sendPM_TutorStudentGainZdlPrizeReq(prizeId)
end

function TutorSystemController:handlePM_TutorStudentGainZdlPrizeRes(msg)
	TutorSystemModel.instance:handlePM_TutorStudentGainZdlPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_TutorStudentGainZdlPrizeRes, msg)
end

function TutorSystemController:sendPM_TutorStudentNewPuzzleInfoReq()
	TutorSystemAgent.instance:sendPM_TutorStudentNewPuzzleInfoReq()
end

function TutorSystemController:handlePM_TutorStudentNewPuzzleInfoRes(msg)
	TutorSystemModel.instance:handlePM_TutorStudentNewPuzzleInfoRes(msg)

	local isNeedRed = TutorSystemModel.instance:getLeftCanOpTimes() > 0

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TUTORSYSTEM_STUDENT_PUZZLE_TIMES, isNeedRed)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_TutorStudentNewPuzzleInfoRes)
end

function TutorSystemController:sendPM_TutorStudentNewPuzzleActiveReq(pointId)
	local x, y = self:getPosByPointId(pointId)

	TutorSystemAgent.instance:sendPM_TutorStudentNewPuzzleActiveReq(x, y)
end

function TutorSystemController:handlePM_TutorStudentNewPuzzleActiveRes(msg)
	TutorSystemModel.instance:handlePM_TutorStudentNewPuzzleActiveRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_TutorStudentNewPuzzleActiveRes, msg)
end

function TutorSystemController:sendPM_TutorStudentNewPuzzleGainPrizeReq(prizeId)
	TutorSystemAgent.instance:sendPM_TutorStudentNewPuzzleGainPrizeReq(prizeId)
end

function TutorSystemController:handlePM_TutorStudentNewPuzzleGainPrizeRes(msg)
	TutorSystemModel.instance:handlePM_TutorStudentNewPuzzleGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_TutorStudentNewPuzzleGainPrizeRes)
end

function TutorSystemController:sendPM_TutorTeacherMonthlyRankInfoReq()
	TutorSystemAgent.instance:sendPM_TutorTeacherMonthlyRankInfoReq()
end

function TutorSystemController:handlePM_TutorTeacherMonthlyRankInfoRes(msg)
	TutorSystemModel.instance:handlePM_TutorTeacherMonthlyRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_TutorTeacherMonthlyRankInfoRes, msg)
end

function TutorSystemController:sendPM_TutorTeacherRankInfoReq()
	TutorSystemAgent.instance:sendPM_TutorTeacherRankInfoReq()
end

function TutorSystemController:handlePM_TutorTeacherRankInfoRes(msg)
	TutorSystemModel.instance:handlePM_TutorTeacherRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_TutorTeacherRankInfoRes, msg)
end

function TutorSystemController:handlePNotifyTutorRedPointChangedRes(msg)
	local redTypeList = {}

	for _, info in ipairs(msg.changedPoint) do
		TutorSystemModel.instance:_saveTutorRedInfo(info.type, info.userId, info.isActivated, info.showTime, info.endTime)
		table.insert(redTypeList, info.type)
	end

	self:_updateTutorServantRed(redTypeList)
	GlobalDispatcher:dispatch(GlobalNotify.TutorRedPointChanged)
end

function TutorSystemController:handleNotifyEstablishTutorRelationRes(msg)
	TutorSystemModel.instance:handleNotifyEstablishTutorRelationRes(msg)

	if msg.identity == 1 then
		self:popTipByKey(GameEnum.TsNotifyKey.RecruitTea)
	elseif msg.identity == 2 then
		self:popTipByKey(GameEnum.TsNotifyKey.RecruitStu)
	end

	GlobalDispatcher:dispatch(GlobalNotify.NotifyEstablishTutorRelationRes, msg)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorRelationShipChange)
end

function TutorSystemController:handleNotifyTutorRelieveRes(msg)
	TutorSystemModel.instance:handleNotifyTutorRelieveRes(msg)

	if msg.identity == 1 then
		self:popTipByKey(GameEnum.TsNotifyKey.RelieveByMyTea)
	elseif msg.identity == 2 then
		self:popTipByKey(GameEnum.TsNotifyKey.RelieveByMyStu)
	end

	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorRelieveRes, msg)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorRelationShipChange)
end

function TutorSystemController:handleNotifyTutorReceivedTeacherRequestRes(msg)
	TutorSystemModel.instance:handleNotifyTutorReceivedTeacherRequestRes(msg)
	self:popTipByKey(GameEnum.TsNotifyKey.InvitationToBecomeTea)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorReceivedTeacherRequestRes)
end

function TutorSystemController:handleNotifyTutorReceivedStudentRequestRes(msg)
	TutorSystemModel.instance:handleNotifyTutorReceivedStudentRequestRes(msg)
	self:popTipByKey(GameEnum.TsNotifyKey.InvitationToBecomeStu)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorReceivedStudentRequestRes)
end

function TutorSystemController:handleNotifyTutorStudentFinishTutorRes(msg)
	TutorSystemModel.instance:handleNotifyTutorStudentFinishTutorRes(msg)

	if msg.identity == 1 then
		if msg.otherUserId == RoleModel.instance:getUserId() then
			TutorSystemController.instance:popTipByKey(GameEnum.TsNotifyKey.GraduatedOfMySelf)
		end
	elseif msg.identity == 2 then
		local userName = ""

		for _, stuInfo in ipairs(msg.identityInfo.teacherInfo.student) do
			if stuInfo.headInfo.headInfo.userId == msg.studentUserId then
				userName = stuInfo.headInfo.headInfo.userName
			end
		end

		self:popTipByKey(GameEnum.TsNotifyKey.GraduatedOfMyStu)
	end

	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorStudentFinishTutorRes, msg)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorRelationShipChange)
end

function TutorSystemController:handleNotifyTutorClassmateEstablishRes(msg)
	TutorSystemModel.instance:handleNotifyTutorClassmateEstablishRes(msg)
	self:popTipByKey(GameEnum.TsNotifyKey.RecruitClassMate)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorClassmateEstablishRes, msg)
end

function TutorSystemController:handleNotifyTutorClassmateRelieveRes(msg)
	TutorSystemModel.instance:handleNotifyTutorClassmateRelieveRes(msg)
	self:popTipByKey(GameEnum.TsNotifyKey.RelieveByMyClassMate)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorClassmateRelieveRes, msg)
end

function TutorSystemController:handleNotifyTutorClassmateFinishRes(msg)
	TutorSystemModel.instance:handleNotifyTutorClassmateFinishRes(msg)
	self:popTipByKey(GameEnum.TsNotifyKey.GraduatedOfMyClassMate)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyTutorClassmateFinishRes, msg)
end

function TutorSystemController:dailyRefresh()
	return
end

function TutorSystemController:popTipByKey(key, ...)
	local sceneType = TutorSystemConfig.instance:getTsTipsSceneType(key)

	if sceneType == nil then
		return
	end

	local isInTutorSystem = TutorSystemModel.instance:isInTutorSystem()

	if sceneType == 0 then
		return
	elseif sceneType == 1 and isInTutorSystem ~= true then
		return
	elseif sceneType == 2 then
		-- block empty
	end

	local params = {
		...
	}

	if key == GameEnum.TsNotifyKey.InvitationToBecomeStu then
		self:popTipWinWhenReceivedStuRequest(key)
	elseif key == GameEnum.TsNotifyKey.InvitationToBecomeTea then
		self:popTipWinWhenReceivedTeaRequest(key)
	elseif key == GameEnum.TsNotifyKey.GraduatedOfMyStu then
		if #params > 0 then
			self:popTipWinWhenStudentFinish(key, unpack(params))
		else
			self:popTipWinWhenStudentFinish(key)
		end
	else
		local tips = TutorSystemConfig.instance:getTsTipsValue(key)

		if string.nilorempty(tips) then
			return
		end

		if isInTutorSystem and key ~= GameEnum.TsNotifyKey.InvitationToBecomeStu and key ~= GameEnum.TsNotifyKey.InvitationToBecomeTea then
			TutorSystemController.instance:sendTutorMainInfoReq()
		end

		self:popFloatTip(key, params)
	end
end

function TutorSystemController:popFloatTip(key, params)
	local tipsValue = TutorSystemConfig.instance:getTsTipsValue(key)

	if string.nilorempty(tipsValue) then
		return
	end

	if #params > 0 then
		FloatWordMgr.instance:show(string.format(tipsValue, unpack(params)))
	else
		FloatWordMgr.instance:show(tipsValue)
	end
end

function TutorSystemController:popTipWinWhenStudentFinish(key, userName)
	local text = TutorSystemConfig.instance:getTsTipsValue(key)
	local btnText = "确定"
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	local function func()
		UIStateManager.instance:clear()
		UIStateManager.instance:push(ViewName.TutorSystemMainView)
	end

	TipsFacade.instance:openTipWindow("通知", text, func, btnText, alignment)
end

function TutorSystemController:popTipWinWhenReceivedTeaRequest(key)
	local text = TutorSystemConfig.instance:getTsTipsValue(key)

	local function okFunc()
		UIStateManager.instance:clear()
		UIStateManager.instance:push(ViewName.TutorSystemMainView)
		UIStateManager.instance:push(ViewName.TutorSystemSearchView)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("通知", text, okFunc, cencelFunc, "确定", "取消")
end

function TutorSystemController:popTipWinWhenReceivedStuRequest(key)
	local text = TutorSystemConfig.instance:getTsTipsValue(key)

	local function okFunc()
		UIStateManager.instance:clear()
		UIStateManager.instance:push(ViewName.TutorSystemMainView)
		UIStateManager.instance:push(ViewName.TutorSystemSearchView)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("通知", text, okFunc, cencelFunc, "确定", "取消")
end

function TutorSystemController:isEnoughRelieveCd(startTimes)
	local nowTimes = ServerTime.now()
	local leftTimes = nowTimes - startTimes / 1000
	local hour = leftTimes / 60 / 60

	hour = Mathf.Max(hour, 0)

	local relieveCd = TutorSystemConfig.instance:getTsRelieveCd()

	return relieveCd <= hour
end

function TutorSystemController:ifHaveLetterThenOpenIt()
	if not TutorSystemModel.instance:isGraduateInfoStackHaveContent() then
		return
	end

	UIStateManager.instance:push(ViewName.TutorSystemLetterView)
end

function TutorSystemController:openSearchViewByNotify(params)
	self:openSearchView(params and checkbool(params[1]) or false)
end

function TutorSystemController:openSearchView(isHasMainInfo)
	if not isHasMainInfo then
		self:sendTutorMainInfoReq()
	end

	UIStateManager.instance:push(ViewName.TutorSystemSearchView)
end

function TutorSystemController:goToRemoveRelationship(userId)
	local startTimes = 0
	local myIdentityType = TutorSystemModel.instance:getMyIdentityType()

	if myIdentityType == GameEnum.IdentityType.Student then
		startTimes = TutorSystemModel.instance:getMyStartTimesAsStu()
	elseif myIdentityType == GameEnum.IdentityType.Teacher then
		startTimes = TutorSystemModel.instance:getMyStudentStartTimesAsTea(userId)
	else
		return
	end

	if not TutorSystemController.instance:isEnoughRelieveCd(startTimes) then
		FloatWordMgr.instance:show(TutorSystemConfig.instance:getTsTipsValue(-29913))

		return
	end

	local tipsContent = "解除关系后，双方将不再是师徒关系"

	local function okFunc()
		local myIdentityType = TutorSystemModel.instance:getMyIdentityType()

		if myIdentityType > GameEnum.IdentityType.Teacher then
			return
		end

		TutorSystemController.instance:sendTutorRelieveReq(myIdentityType, userId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function TutorSystemController:popChangSetItemList(itemlist)
	if #itemlist > 0 then
		local clientChangeSetId = MaterialController.instance:getClientChangeSetId(true)

		MaterialController.instance:showChangeSetItemMo(itemlist, clientChangeSetId)
	end
end

function TutorSystemController:isCanGetScorePrizeInStuTask(prizeId)
	local isHasGain = self:isHasGainScorePrizeInStuTask(prizeId)
	local isEnough = self:isEnouthGetScorePrizeInStuTask(prizeId)

	return not isHasGain and isEnough
end

function TutorSystemController:isEnouthGetScorePrizeInStuTask(prizeId)
	local data = TutorSystemConfig.instance:getTsStuPrizeData(prizeId)
	local curProgress = TutorSystemModel.instance:getProgressScoreInStuTask()

	return curProgress >= data.scoreLimit
end

function TutorSystemController:isHasGainScorePrizeInStuTask(prizeId)
	return TutorSystemModel.instance:isHasGainScorePrizeInStuTask(prizeId)
end

function TutorSystemController:isHasGainPreScorePrizesInStuTask(prizeId)
	local isHasGainPrePrizes = true

	if prizeId == 1 then
		return isHasGainPrePrizes
	end

	for i = 1, prizeId - 1 do
		if not self:isHasGainScorePrizeInStuTask(i) then
			isHasGainPrePrizes = false

			break
		end
	end

	return isHasGainPrePrizes
end

function TutorSystemController:isCanGetBaseTaskPrizeInStuTask(taskId)
	local isHasGain = self:isHasGainBaseTaskPrizeInStuTask(taskId)
	local isEnough = self:isEnoughGetBaseTaskPrizeInStuTask(taskId)

	return not isHasGain and isEnough
end

function TutorSystemController:isEnoughGetBaseTaskPrizeInStuTask(taskId)
	local data = TutorSystemConfig.instance:getTsBaseTaskData(taskId)
	local curProgress = TutorSystemModel.instance:getBaseTaskCurProgressInStuTask(taskId)

	return curProgress >= data.maxProgress
end

function TutorSystemController:isHasGainBaseTaskPrizeInStuTask(taskId)
	return TutorSystemModel.instance:isHasGainBaseTaskPrizeInStuTask(taskId)
end

function TutorSystemController:isAllEnoughBaseTaskInStuTask()
	local isAllEnough = true
	local taskCfg = TutorSystemConfig.instance:getTsBaseTaskCfg()

	for _, data in ipairs(taskCfg) do
		if not self:isEnoughGetBaseTaskPrizeInStuTask(data.taskId) and not self:isHasGainBaseTaskPrizeInStuTask(data.taskId) then
			isAllEnough = false

			break
		end
	end

	return isAllEnough
end

function TutorSystemController:isExceedTotalPlanTimesInTeaGrowthTask(stuUserId)
	local totalCanPublicTimes = TutorSystemConfig.instance:getTsWeeklyGrowthTaskNum()
	local totalHasPublicTimes = TutorSystemModel.instance:getPublishedTaskCountInTeaPlanGrowTask(stuUserId)

	return totalCanPublicTimes <= totalHasPublicTimes
end

function TutorSystemController:getLeftCanPlanTimesInTeaGrowthTask(stuUserId)
	local totalCanPublicTimes = TutorSystemConfig.instance:getTsWeeklyGrowthTaskNum()
	local totalHasPublicTimes = TutorSystemModel.instance:getPublishedTaskCountInTeaPlanGrowTask(stuUserId)

	return totalCanPublicTimes - totalHasPublicTimes
end

function TutorSystemController:isCanGetGrowUpTaskPrizeInStuTask(taskId)
	local isHasGain = self:isHasGainGrowUpTaskPrizeInStuTask(taskId)
	local isEnough = self:isEnouthGetGrowUpTaskPrizeInStuTask(taskId)

	return not isHasGain and isEnough
end

function TutorSystemController:isEnouthGetGrowUpTaskPrizeInStuTask(taskId)
	local data = TutorSystemConfig.instance:getTsGrowthTaskData(taskId)
	local curProgress = TutorSystemModel.instance:getGrowUpTaskCurProgressInStuTask(taskId)

	return curProgress >= data.maxProgress
end

function TutorSystemController:isHasGainGrowUpTaskPrizeInStuTask(taskId)
	return TutorSystemModel.instance:isHasGainGrowUpTaskPrizeInStuTask(taskId)
end

function TutorSystemController:isCanGetTaskPrizeAsBaseTask(userId, taskId)
	return self:isEnoughGetPrizeAsBaseTask(userId, taskId) and not self:isHasGainPrizeAsBaseTask(userId, taskId)
end

function TutorSystemController:isEnoughGetPrizeAsBaseTask(userId, taskId)
	local data = TutorSystemConfig.instance:getTsBaseTaskData(taskId)
	local curProgress = TutorSystemModel.instance:getCurProgressAsBaseTask(userId, taskId)

	return curProgress >= data.maxProgress
end

function TutorSystemController:isHasGainPrizeAsBaseTask(userId, taskId)
	return TutorSystemModel.instance:isHasGainPrizeAsBaseTask(userId, taskId)
end

function TutorSystemController:isAllEnoughGetPrizeAsBaseTask(userId)
	local isAllEnough = true
	local taskCfg = TutorSystemConfig.instance:getTsBaseTaskCfg()

	for _, data in ipairs(taskCfg) do
		if not self:isEnoughGetPrizeAsBaseTask(userId, data.taskId) then
			isAllEnough = false

			break
		end
	end

	return isAllEnough
end

function TutorSystemController:isCanGetPrizeAsGrowthTask(userId, taskId)
	return self:isEnouthGetPrizeAsGrowthTask(userId, taskId) and not self:isHasGainPrizeAsGrowthTask(userId, taskId)
end

function TutorSystemController:isEnouthGetPrizeAsGrowthTask(userId, taskId)
	local data = TutorSystemConfig.instance:getTsGrowthTaskData(taskId)
	local curProgress = TutorSystemModel.instance:getCurProgressAsGrowthTask(userId, taskId)

	return curProgress >= data.maxProgress
end

function TutorSystemController:isHasGainPrizeAsGrowthTask(userId, taskId)
	return TutorSystemModel.instance:isHasGainPrizeAsGrowthTask(userId, taskId)
end

function TutorSystemController:getPosByPointId(pointId)
	local width = TutorSystemConfig.instance:getTsPuzzleX()
	local height = TutorSystemConfig.instance:getTsPuzzleY()
	local x = pointId % width + 1
	local y = (pointId - pointId % width) / width + 1

	return x, y
end

function TutorSystemController:getTutorPuzzleActiveCount()
	return #self:getTutorPuzzlePosActiveList()
end

function TutorSystemController:getTutorPuzzlePosActiveList()
	local activePointIdList = {}
	local puzzleMapCfg = TutorSystemConfig.instance:getTsPuzzleMapCfg()

	for pointId = 0, #puzzleMapCfg do
		if self:isTutorPuzzlePosActive(pointId) then
			table.insert(activePointIdList, pointId)
		end
	end

	return activePointIdList
end

function TutorSystemController:isTutorPuzzlePosActive(pointId)
	return TutorSystemModel.instance:isTutorPuzzlePosActive(self:getPosByPointId(pointId))
end

function TutorSystemController:isPlayerHaveLeftTimesInPuzzle()
	local leftTimes = TutorSystemModel.instance:getLeftCanOpTimes()

	return leftTimes > 0
end

function TutorSystemController:isTutorPuzzlePrizeCanGet(prizeId)
	local isHasGain = self:isTutorPuzzlePrizeHasGain(prizeId)
	local isEnough = self:isTutorPuzzlePrizeEnough(prizeId)

	return not isHasGain and isEnough
end

function TutorSystemController:isTutorPuzzlePrizeEnough(prizeId)
	local activePointIdList = self:getTutorPuzzlePosActiveList()
	local puzzlePrizeData = TutorSystemConfig.instance:getTsPuzzlePrizeData(prizeId)
	local isEnough = true

	for idx, needPointId in ipairs(puzzlePrizeData.needPointIds) do
		local isHave = table.indexof(activePointIdList, needPointId) ~= false

		isEnough = isEnough and isHave
	end

	return isEnough
end

function TutorSystemController:isTutorPuzzlePrizeHasGain(prizeId)
	return TutorSystemModel.instance:isHasGainTutorPuzzlePrize(prizeId)
end

function TutorSystemController:isReachInPuzzleTask(key)
	local cur = self:getCurProgressInPuzzleTask(key)
	local max = self:getMaxProgressInPuzzleTask(key)

	return max <= cur
end

function TutorSystemController:getCurProgressInPuzzleTask(key)
	local progress = 0
	local data = TutorSystemConfig.instance:getTsPuzzleTaskData(key)
	local cur = data and data.cur

	if cur == "DaySign" then
		progress = 1
	elseif cur == "Activation" then
		progress = TutorSystemModel.instance:getDtDailyScore()
	end

	return progress
end

function TutorSystemController:getMaxProgressInPuzzleTask(key)
	local data = TutorSystemConfig.instance:getTsPuzzleTaskData(key)

	return (data or nil) and (data.max or 0)
end

function TutorSystemController:_updateRedPrizeInTeacherLease()
	local isNeedRed = false
	local stuInfoList = TutorSystemModel.instance:getStuInfoListAsTea() or {}

	for _, info in ipairs(stuInfoList) do
		local userId = info.headInfo.headInfo.userId

		if TutorSystemController.instance:isCanGetPrizeInTeacherLease(userId) then
			isNeedRed = true

			break
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_TUTORSYSTEM_TEACHER_LEASE, isNeedRed)
end

function TutorSystemController:isCanGetPrizeInTeacherLease(studentUserId)
	local isHasGain = self:isHasGainPrizeInTeacherLease(studentUserId)
	local isEnough = self:isEnouthPrizeInTeacherLease(studentUserId)

	return not isHasGain and isEnough
end

function TutorSystemController:isEnouthPrizeInTeacherLease(studentUserId)
	local totalPetCount = TutorSystemConfig.instance:getTsTeacherHirePetMax()
	local curPetCount = 0

	for slotId = 1, totalPetCount do
		if TutorSystemModel.instance:isHaveHirePetInSlotInTeaLease(studentUserId, slotId) then
			curPetCount = curPetCount + 1
		else
			break
		end
	end

	return totalPetCount <= curPetCount
end

function TutorSystemController:isHasGainPrizeInTeacherLease(studentUserId)
	return TutorSystemModel.instance:isHasGainHirePetPrizeInTeaLease(studentUserId)
end

function TutorSystemController:isExceedTotalLeaseTimesInStuLease()
	local totalCanHireTimes = TutorSystemConfig.instance:getStudentTotalCanHireTimes()
	local totalHasHireTimes = TutorSystemModel.instance:getTotalHireTimesInStuLease()

	return totalCanHireTimes <= totalHasHireTimes
end

function TutorSystemController:isExceedThisPetLeaseTimesInStuLease(slotId)
	local singlePetCanHireTimes = TutorSystemConfig.instance:getSinglePetCanHireTimes()
	local petHasHireTimes = TutorSystemModel.instance:getHirePetTimesInSlotInStuLease(slotId)

	return singlePetCanHireTimes <= petHasHireTimes
end

function TutorSystemController:isExceedCanLeaseTimesInStuLease()
	local isHasHirePet = TutorSystemModel.instance:isHasHirePetInStuLease()

	return not not isHasHirePet
end

function TutorSystemController:_updateTutorServantRed(redTypeList)
	for _, redType in ipairs(redTypeList) do
		local servantRedIdList = {}
		local redInfoGroup = TutorSystemModel.instance:getTutorRedInfoGroup(redType)

		for _, redInfo in pairs(redInfoGroup) do
			local servantRedId = TutorSystemModel.instance:getTutorServantRedId(redInfo.redType, redInfo.userId)

			table.insert(servantRedIdList, servantRedId)
			RedPointController.instance:setRedPointInfo(servantRedId, redInfo.isActivated, false, redInfo.showTime / 1000, redInfo.endTime / 1000)
		end

		local redData = TutorSystemConfig.instance:getTsRedDataByType(redType)
		local masterRedId = redData and redData.masterRedId

		if not string.nilorempty(masterRedId) then
			RedPointController.instance:regMasterServantRed(masterRedId, false, unpack(servantRedIdList))
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.RedPointUpdate)
end

function TutorSystemController:isActivatedServantRed(redType, userId)
	return RedPointModel.instance:isActive(TutorSystemModel.instance:getTutorServantRedId(redType, userId))
end

function TutorSystemController:isActivatedMasterRed(redType)
	local redData = TutorSystemConfig.instance:getTsRedDataByType(redType)
	local masterRedId = redData and redData.masterRedId

	if not string.nilorempty(masterRedId) then
		return RedPointModel.instance:isActive(masterRedId)
	else
		return false
	end
end

function TutorSystemController:getRedIdList()
	local list = {}
	local gaActivityType = TutorSystemConfig.instance:getTsTeacherGradAwardTaskActivityType()
	local achActivityType = TutorSystemConfig.instance:getTsTeacherAchTaskActivityType()

	table.insert(list, EventTaskSummaryController.instance:getCurRedIdByActivityType(gaActivityType))
	table.insert(list, EventTaskSummaryController.instance:getCurRedIdByActivityType(achActivityType))
	table.insert(list, TutorSystemConfig.instance:getRedRequestFromTea())
	table.insert(list, TutorSystemConfig.instance:getRedRequestFromStu())
	table.insert(list, TutorSystemConfig.instance:getRedStudentZdlTask())

	local redDataList = TutorSystemConfig.instance:getTsRedDataList() or {}

	for _, data in ipairs(redDataList) do
		if data.isUse then
			table.insert(list, data.masterRedId)
		end
	end

	local dic = {}

	for _, redId in ipairs(list) do
		redId = tostring(redId)

		if not string.nilorempty(redId) then
			dic[redId] = redId
		end
	end

	return TableUtil.toList(dic)
end

TutorSystemController.instance = TutorSystemController.New()

return TutorSystemController
