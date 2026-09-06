-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/agent/KindergartenAgent.lua

module("logic.extensions.kindergarten.agent.KindergartenAgent", package.seeall)

local KindergartenAgent = class("KindergartenAgent", BaseAgent)

function KindergartenAgent:sendPM_KindergartenGetInfoReq(activityId)
	local req = KindergartenExtension_pb.PM_KindergartenGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenGetInfoRes(status, msg)
	if status == 0 then
		KindergartenModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenGetInfoRes)
	end
end

function KindergartenAgent:sendPM_KindergartenOpenClassReq(activityId, classId, pointScheduleList)
	local req = KindergartenExtension_pb.PM_KindergartenOpenClassReq()

	req.activityId = activityId
	req.classId = classId

	for i, v in ipairs(pointScheduleList) do
		local item = req.pointScheduleList:add()

		item.pointType = v.pointType
		item.value = v.value
	end

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenOpenClassRes(status, msg)
	if status == 0 then
		KindergartenModel.instance:saveOpenClass(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenOpenClassRes)
	end
end

function KindergartenAgent:sendPM_KindergartenViewResultReq(activityId, classId)
	local req = KindergartenExtension_pb.PM_KindergartenViewResultReq()

	req.activityId = activityId
	req.classId = classId

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenViewResultRes(status, msg)
	if status == 0 then
		KindergartenModel.instance:setViewResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenViewResultRes)
	end
end

function KindergartenAgent:sendPM_KindergartenUnlockFacilityReq(activityId, classroomId)
	local req = KindergartenExtension_pb.PM_KindergartenUnlockFacilityReq()

	req.activityId = activityId
	req.classroomId = classroomId

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenUnlockFacilityRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("激活成功")
		KindergartenModel.instance:unlockFacilityRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenUnlockFacilityRes)
	end
end

function KindergartenAgent:sendPM_KindergartenUnlockAutoFunctionReq(activityId)
	local req = KindergartenExtension_pb.PM_KindergartenUnlockAutoFunctionReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenUnlockAutoFunctionRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("招募成功")
		KindergartenModel.instance:unlockAutoFunctionRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenUnlockAutoFunctionRes)
	end
end

function KindergartenAgent:sendPM_KindergartenSetAutoReq(activityId, pointScheduleList, isAuto)
	local req = KindergartenExtension_pb.PM_KindergartenSetAutoReq()

	req.activityId = activityId

	if pointScheduleList then
		for i, v in ipairs(pointScheduleList) do
			local pb = req.pointScheduleList:add()

			pb:ParseFromString(v:SerializeToString())
		end
	end

	req.isAuto = isAuto

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenSetAutoRes(status, msg)
	if status == 0 then
		KindergartenController.instance:handlePM_KindergartenSetAutoRes(msg)
	end
end

function KindergartenAgent:sendPM_KindergartenGetJobInfoReq(activityId)
	local req = KindergartenExtension_pb.PM_KindergartenGetJobInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenGetJobInfoRes(status, msg)
	if status == 0 then
		KindergartenModel.instance:setGetJobInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenGetJobInfoRes)
	end
end

function KindergartenAgent:sendPM_KindergartenAddStudentReq(activityId, enlistId, times)
	local req = KindergartenExtension_pb.PM_KindergartenAddStudentReq()

	req.activityId = activityId
	req.enlistId = enlistId
	req.times = times

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenAddStudentRes(status, msg)
	if status == 0 then
		KindergartenModel.instance:handlePM_KindergartenAddStudentRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenAddStudentRes)
	end
end

function KindergartenAgent:sendPM_KindergartenRankViewReq(activityId, rankType)
	local req = KindergartenExtension_pb.PM_KindergartenRankViewReq()

	req.activityId = activityId
	req.rankType = rankType

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenRankViewRes(status, msg)
	if status == 0 then
		KindergartenModel.instance:setRankInfos(msg)
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenRankViewRes)
	end
end

function KindergartenAgent:sendPM_KindergartenGainItemReq(activityId)
	local req = KindergartenExtension_pb.PM_KindergartenGainItemReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KindergartenAgent:handlePM_KindergartenGainItemRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.KindergartenGainItemRes)
	end
end

KindergartenAgent.instance = KindergartenAgent.New()

return KindergartenAgent
