-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/agent/OriginDarkMoYanClgAgent.lua

module("logic.extensions.origindarkmoyanclg.agent.OriginDarkMoYanClgAgent", package.seeall)

local OriginDarkMoYanClgAgent = class("OriginDarkMoYanClgAgent", BaseAgent)

GlobalNotify.OriginDarkMoYanClgGetInfoRes = GlobalNotify.OriginDarkMoYanClgGetInfoRes or genId()
GlobalNotify.OriginDarkMoYanClgSelectBuffCellRes = GlobalNotify.OriginDarkMoYanClgSelectBuffCellRes or genId()
GlobalNotify.OriginDarkMoYanClgChallengeCellRes = GlobalNotify.OriginDarkMoYanClgChallengeCellRes or genId()
GlobalNotify.OriginDarkMoYanClgNotifyCellResultRes = GlobalNotify.OriginDarkMoYanClgNotifyCellResultRes or genId()
GlobalNotify.OriginDarkMoYanClgConfirmLockPetRes = GlobalNotify.OriginDarkMoYanClgConfirmLockPetRes or genId()
GlobalNotify.OriginDarkMoYanClgResetCurrentStageRes = GlobalNotify.OriginDarkMoYanClgResetCurrentStageRes or genId()

function OriginDarkMoYanClgAgent:sendPM_OriginDarkMoYanClgGetInfoReq(activityId)
	local req = OriginDarkMoYanClgExtension_pb.PM_OriginDarkMoYanClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginDarkMoYanClgAgent:handlePM_OriginDarkMoYanClgGetInfoRes(status, msg)
	if status == 0 then
		OrigindarkmoyanclgModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginDarkMoYanClgGetInfoRes)
	end
end

function OriginDarkMoYanClgAgent:sendPM_OriginDarkMoYanClgSelectBuffCellReq(activityId, stageId, x, y)
	local req = OriginDarkMoYanClgExtension_pb.PM_OriginDarkMoYanClgSelectBuffCellReq()

	req.activityId = activityId
	req.stageId = stageId
	req.x = x
	req.y = y

	self:sendMsg(req)
end

function OriginDarkMoYanClgAgent:handlePM_OriginDarkMoYanClgSelectBuffCellRes(status, msg)
	if status == 0 then
		OrigindarkmoyanclgModel.instance:onSelectBuff(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginDarkMoYanClgSelectBuffCellRes)
	end
end

function OriginDarkMoYanClgAgent:sendPM_OriginDarkMoYanClgChallengeCellReq(activityId, stageId, x, y, form)
	local req = OriginDarkMoYanClgExtension_pb.PM_OriginDarkMoYanClgChallengeCellReq()

	req.activityId = activityId
	req.stageId = stageId
	req.x = x
	req.y = y

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function OriginDarkMoYanClgAgent:handlePM_OriginDarkMoYanClgChallengeCellRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginDarkMoYanClgChallengeCellRes)
	end
end

function OriginDarkMoYanClgAgent:handlePM_OriginDarkMoYanClgNotifyCellResultRes(status, msg)
	if status == 0 then
		OrigindarkmoyanclgController.instance:onChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginDarkMoYanClgNotifyCellResultRes)
	end
end

function OriginDarkMoYanClgAgent:sendPM_OriginDarkMoYanClgConfirmLockPetReq(activityId, stageId, x, y, save, raceId)
	local req = OriginDarkMoYanClgExtension_pb.PM_OriginDarkMoYanClgConfirmLockPetReq()

	req.activityId = activityId
	req.stageId = stageId
	req.x = x
	req.y = y
	req.save = save
	req.raceId = raceId

	self:sendMsg(req)
end

function OriginDarkMoYanClgAgent:handlePM_OriginDarkMoYanClgConfirmLockPetRes(status, msg)
	if status == 0 then
		OrigindarkmoyanclgController.instance:onConfirmLockPetRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginDarkMoYanClgConfirmLockPetRes)
	end
end

function OriginDarkMoYanClgAgent:sendPM_OriginDarkMoYanClgResetCurrentStageReq(activityId, stageId)
	local req = OriginDarkMoYanClgExtension_pb.PM_OriginDarkMoYanClgResetCurrentStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginDarkMoYanClgAgent:handlePM_OriginDarkMoYanClgResetCurrentStageRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local stageId = msg.stageId

		OrigindarkmoyanclgModel.instance:onResetStage(activityId, stageId)
		GlobalDispatcher:dispatch(GlobalNotify.OriginDarkMoYanClgResetCurrentStageRes)
	end
end

OriginDarkMoYanClgAgent.instance = OriginDarkMoYanClgAgent.New()

return OriginDarkMoYanClgAgent
