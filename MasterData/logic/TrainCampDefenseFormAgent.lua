-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampdefense/agent/TrainCampDefenseFormAgent.lua

module("logic.extensions.traincampdefenseform.agent.TrainCampDefenseFormAgent", package.seeall)

local TrainCampDefenseFormAgent = class("TrainCampDefenseFormAgent", BaseAgent)

TrainCampDefenseFormAgent.DF_GetMyFormRes = "TrainCampDefenseFormAgent.DF_GetMyFormRes"
TrainCampDefenseFormAgent.DF_SaveFormRes = "TrainCampDefenseFormAgent.DF_SaveFormRes"
TrainCampDefenseFormAgent.DF_GetOtherFormRes = "TrainCampDefenseFormAgent.DF_GetOtherFormRes"
TrainCampDefenseFormAgent.DF_ChallengeRes = "TrainCampDefenseFormAgent.DF_ChallengeRes"
TrainCampDefenseFormAgent.DF_RefreshFormListRes = "TrainCampDefenseFormAgent.DF_RefreshFormListRes"
TrainCampDefenseFormAgent.DF_NotifyChallengeResultRes = "TrainCampDefenseFormAgent.DF_NotifyChallengeResultRes"

function TrainCampDefenseFormAgent:sendPM_DF_GetMyFormReq()
	local req = TrainCampDefenseFormExtension_pb.PM_DF_GetMyFormReq()

	self:sendMsg(req)
end

function TrainCampDefenseFormAgent:handlePM_DF_GetMyFormRes(status, msg)
	if status == 0 then
		TraincampdefenseController.instance:onGetFormRes(msg.defenseForm)
		GlobalDispatcher:dispatch(TrainCampDefenseFormAgent.DF_GetMyFormRes)
	end
end

function TrainCampDefenseFormAgent:sendPM_DF_SaveFormReq(defenseForm)
	local req = TrainCampDefenseFormExtension_pb.PM_DF_SaveFormReq()

	req.defenseForm:ParseFromString(defenseForm:SerializeToString())
	self:sendMsg(req)
end

function TrainCampDefenseFormAgent:handlePM_DF_SaveFormRes(status, msg)
	if status == 0 then
		TraincampdefenseController.instance:saveFormRes()
		GlobalDispatcher:dispatch(TrainCampDefenseFormAgent.DF_SaveFormRes)
	else
		TraincampdefenseModel.instance:resetFormDefenseForm()
	end
end

function TrainCampDefenseFormAgent:sendPM_DF_GetOtherFormReq(otherPlayerId)
	local req = TrainCampDefenseFormExtension_pb.PM_DF_GetOtherFormReq()

	req.otherPlayerId = otherPlayerId

	self:sendMsg(req)
end

function TrainCampDefenseFormAgent:handlePM_DF_GetOtherFormRes(status, msg)
	if status == 0 then
		TraincampdefenseController.instance:onGetOtherFormRes(msg.otherPlayerView)
		GlobalDispatcher:dispatch(TrainCampDefenseFormAgent.DF_GetOtherFormRes)
	end
end

function TrainCampDefenseFormAgent:sendPM_DF_ChallengeReq(targetUserId, myForm, otherForm, defenseFormZdl)
	local req = TrainCampDefenseFormExtension_pb.PM_DF_ChallengeReq()

	req.targetUserId = targetUserId

	req.myForm:ParseFromString(myForm:SerializeToString())
	req.otherForm:ParseFromString(otherForm:SerializeToString())

	req.defenseFormZdl = defenseFormZdl

	self:sendMsg(req)
end

function TrainCampDefenseFormAgent:handlePM_DF_ChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampDefenseFormAgent.DF_ChallengeRes)
	end
end

function TrainCampDefenseFormAgent:sendPM_DF_RefreshFormListReq()
	local req = TrainCampDefenseFormExtension_pb.PM_DF_RefreshFormListReq()

	self:sendMsg(req)
end

function TrainCampDefenseFormAgent:handlePM_DF_RefreshFormListRes(status, msg)
	if status == 0 then
		TraincampdefenseController.instance:setDefensePlayerlistList(msg.playerList)
		GlobalDispatcher:dispatch(TrainCampDefenseFormAgent.DF_RefreshFormListRes)
	end
end

function TrainCampDefenseFormAgent:handlePM_DF_NotifyChallengeResultRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TrainCampDefenseFormAgent.DF_NotifyChallengeResultRes)
	end
end

TrainCampDefenseFormAgent.instance = TrainCampDefenseFormAgent.New()

return TrainCampDefenseFormAgent
