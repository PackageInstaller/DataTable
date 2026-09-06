-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/agent/TutorSystemAgent.lua

module("logic.extensions.tutorsystem.agent.TutorSystemAgent", package.seeall)

local TutorSystemAgent = class("TutorSystemAgent", BaseAgent)

function TutorSystemAgent:sendPM_TutorMainInfoReq()
	forcePrint("===== RoleDataRequestor: loadTutorSystem -> sendPM_TutorMainInfoReq ===")

	local req = TutorSystemExtension_pb.PM_TutorMainInfoReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorMainInfoRes(status, msg)
	forcePrint("===== RoleDataRequestor: loadTutorSystem -> handlePM_TutorMainInfoRes ===")

	if status == 0 then
		TutorSystemController.instance:handleTutorMainInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorRecommendReq(identity)
	local req = TutorSystemExtension_pb.PM_TutorRecommendReq()

	req.identity = identity

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorRecommendRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorRecommendRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorSearchReq(identity, searchInfo, searchUserId)
	local req = TutorSystemExtension_pb.PM_TutorSearchReq()

	req.identity = identity

	if not string.nilorempty(searchInfo) then
		req.searchInfo = searchInfo
	end

	if not string.nilorempty(searchUserId) then
		req.searchInfo = searchUserId
	end

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorSearchRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorSearchRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorSendRequestReq(identity, userId)
	local req = TutorSystemExtension_pb.PM_TutorSendRequestReq()

	req.identity = identity
	req.userId = userId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorSendRequestRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorSendRequestRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorReceivedRequestReq(identity)
	local req = TutorSystemExtension_pb.PM_TutorReceivedRequestReq()

	req.identity = identity

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorReceivedRequestRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorReceivedRequestRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorHandleRequestReq(identity, requestUserId, action)
	local req = TutorSystemExtension_pb.PM_TutorHandleRequestReq()

	req.identity = identity
	req.requestUserId = requestUserId
	req.action = action

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorHandleRequestRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorHandleRequestRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorRelieveReq(identity, targetUserId)
	local req = TutorSystemExtension_pb.PM_TutorRelieveReq()

	req.identity = identity
	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorRelieveRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorRelieveRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherTaskInfoReq(studentUserId)
	local req = TutorSystemExtension_pb.PM_TutorTeacherTaskInfoReq()

	req.studentUserId = studentUserId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherTaskInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorTeacherTaskInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherSwitchAutoPublishGrowUpTaskReq(switch)
	local req = TutorSystemExtension_pb.PM_TutorTeacherSwitchAutoPublishGrowUpTaskReq()

	req.switch = switch or false

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherSwitchAutoPublishGrowUpTaskRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorTeacherSwitchAutoPublishGrowUpTaskRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherPublishGrowUpTaskReq(studentUserId, taskIds)
	local req = TutorSystemExtension_pb.PM_TutorTeacherPublishGrowUpTaskReq()

	req.studentUserId = studentUserId

	for _, taskId in ipairs(taskIds) do
		req.taskIds:append(taskId)
	end

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherPublishGrowUpTaskRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorTeacherPublishGrowUpTaskRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorGainFinishPublishPrizeReq(studentUserId, taskId)
	local req = TutorSystemExtension_pb.PM_TutorGainFinishPublishPrizeReq()

	req.studentUserId = studentUserId
	req.taskId = taskId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorGainFinishPublishPrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorGainFinishPublishPrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentTaskInfoReq()
	local req = TutorSystemExtension_pb.PM_TutorStudentTaskInfoReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentTaskInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorStudentTaskInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentGainBaseTaskPrizeReq(taskId)
	local req = TutorSystemExtension_pb.PM_TutorStudentGainBaseTaskPrizeReq()

	req.taskId = taskId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentGainBaseTaskPrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorStudentGainBaseTaskPrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentGainGrowthTaskPrizeReq(taskId)
	local req = TutorSystemExtension_pb.PM_TutorStudentGainGrowthTaskPrizeReq()

	req.taskId = taskId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentGainGrowthTaskPrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorStudentGainGrowthTaskPrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentGainProgressPrizeReq(prizeId)
	local req = TutorSystemExtension_pb.PM_TutorStudentGainProgressPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentGainProgressPrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorStudentGainProgressPrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorPuzzleInfoReq(identity, targetUserId)
	local req = TutorSystemExtension_pb.PM_TutorPuzzleInfoReq()

	req.identity = identity
	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorPuzzleInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorPuzzleInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorActivePuzzleReq(identity, targetUserId, x, y)
	local req = TutorSystemExtension_pb.PM_TutorActivePuzzleReq()

	req.identity = identity
	req.targetUserId = targetUserId
	req.pos.x = x
	req.pos.y = y

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorActivePuzzleRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorActivePuzzleRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorGainPuzzlePrizeReq(identity, targetUserId, prizeId)
	local req = TutorSystemExtension_pb.PM_TutorGainPuzzlePrizeReq()

	req.identity = identity
	req.targetUserId = targetUserId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorGainPuzzlePrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorGainPuzzlePrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherPetHireInfoReq(studentUserId)
	local req = TutorSystemExtension_pb.PM_TutorTeacherPetHireInfoReq()

	req.studentUserId = studentUserId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherPetHireInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorTeacherPetHireInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherSetHirePetReq(studentUserId, slotId, petId)
	local req = TutorSystemExtension_pb.PM_TutorTeacherSetHirePetReq()

	req.studentUserId = studentUserId
	req.slotId = slotId
	req.petId = petId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherSetHirePetRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorTeacherSetHirePetRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorGainTeacherHirePetPrizeReq(studentUserId)
	local req = TutorSystemExtension_pb.PM_TutorGainTeacherHirePetPrizeReq()

	req.studentUserId = studentUserId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorGainTeacherHirePetPrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorGainTeacherHirePetPrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentPetHireInfoReq()
	local req = TutorSystemExtension_pb.PM_TutorStudentPetHireInfoReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentPetHireInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorStudentPetHireInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentHirePetReq(slotId)
	local req = TutorSystemExtension_pb.PM_TutorStudentHirePetReq()

	req.slotId = slotId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentHirePetRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorStudentHirePetRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherProgressPrizeInfoReq()
	local req = TutorSystemExtension_pb.PM_TutorTeacherProgressPrizeInfoReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherProgressPrizeInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorTeacherProgressPrizeInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorGainTeacherProgressPrizeReq(prizeId)
	local req = TutorSystemExtension_pb.PM_TutorGainTeacherProgressPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorGainTeacherProgressPrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorGainTeacherProgressPrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherGainStudentBaseTaskInfoReq(studentUserId)
	local req = TutorSystemExtension_pb.PM_TutorTeacherGainStudentBaseTaskInfoReq()

	req.studentUserId = studentUserId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherGainStudentBaseTaskInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorTeacherGainStudentBaseTaskInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherGainStudentGrowthTaskInfoReq(studentUserId)
	local req = TutorSystemExtension_pb.PM_TutorTeacherGainStudentGrowthTaskInfoReq()

	req.studentUserId = studentUserId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherGainStudentGrowthTaskInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleTutorTeacherGainStudentGrowthTaskInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorLoadRedPointReq()
	forcePrint("===== RoleDataRequestor: loadTutorSystem -> sendPM_TutorLoadRedPointReq ===")

	local req = TutorSystemExtension_pb.PM_TutorLoadRedPointReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorLoadRedPointRes(status, msg)
	forcePrint("===== RoleDataRequestor: loadTutorSystem -> handlePM_TutorLoadRedPointRes ===")

	if status == 0 then
		TutorSystemController.instance:handleTutorLoadRedPointRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentZdlPrizeInfoReq()
	local req = TutorSystemExtension_pb.PM_TutorStudentZdlPrizeInfoReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentZdlPrizeInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handlePM_TutorStudentZdlPrizeInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentGainZdlPrizeReq(prizeId)
	local req = TutorSystemExtension_pb.PM_TutorStudentGainZdlPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentGainZdlPrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handlePM_TutorStudentGainZdlPrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentNewPuzzleInfoReq()
	local req = TutorSystemExtension_pb.PM_TutorStudentNewPuzzleInfoReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentNewPuzzleInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handlePM_TutorStudentNewPuzzleInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentNewPuzzleActiveReq(x, y)
	local req = TutorSystemExtension_pb.PM_TutorStudentNewPuzzleActiveReq()

	req.pos.x = x
	req.pos.y = y

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentNewPuzzleActiveRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handlePM_TutorStudentNewPuzzleActiveRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorStudentNewPuzzleGainPrizeReq(prizeId)
	local req = TutorSystemExtension_pb.PM_TutorStudentNewPuzzleGainPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorStudentNewPuzzleGainPrizeRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handlePM_TutorStudentNewPuzzleGainPrizeRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherMonthlyRankInfoReq()
	local req = TutorSystemExtension_pb.PM_TutorTeacherMonthlyRankInfoReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherMonthlyRankInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handlePM_TutorTeacherMonthlyRankInfoRes(msg)
	end
end

function TutorSystemAgent:sendPM_TutorTeacherRankInfoReq()
	local req = TutorSystemExtension_pb.PM_TutorTeacherRankInfoReq()

	self:sendMsg(req)
end

function TutorSystemAgent:handlePM_TutorTeacherRankInfoRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handlePM_TutorTeacherRankInfoRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyTutorRedPointChangedRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handlePNotifyTutorRedPointChangedRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyEstablishTutorRelationRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleNotifyEstablishTutorRelationRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyTutorRelieveRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleNotifyTutorRelieveRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyTutorReceivedTeacherRequestRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleNotifyTutorReceivedTeacherRequestRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyTutorReceivedStudentRequestRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleNotifyTutorReceivedStudentRequestRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyTutorStudentFinishTutorRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleNotifyTutorStudentFinishTutorRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyTutorClassmateEstablishRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleNotifyTutorClassmateEstablishRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyTutorClassmateRelieveRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleNotifyTutorClassmateRelieveRes(msg)
	end
end

function TutorSystemAgent:handlePM_NotifyTutorClassmateFinishRes(status, msg)
	if status == 0 then
		TutorSystemController.instance:handleNotifyTutorClassmateFinishRes(msg)
	end
end

TutorSystemAgent.instance = TutorSystemAgent.New()

return TutorSystemAgent
