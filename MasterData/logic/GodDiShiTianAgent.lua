-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/agent/GodDiShiTianAgent.lua

module("logic.extensions.goddishitian.agent.GodDiShiTianAgent", package.seeall)

local GodDiShiTianAgent = class("GodDiShiTianAgent", BaseAgent)

function GodDiShiTianAgent:sendPM_GodDiShiTianGetInfoReq()
	local req = GodDiShiTianExtension_pb.PM_GodDiShiTianGetInfoReq()

	self:sendMsg(req)
end

function GodDiShiTianAgent:handlePM_GodDiShiTianGetInfoRes(status, msg)
	if status == 0 then
		GodDiShiTianModel.instance:onGodDiShiTianGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GodDiShiTianGetInfoRes)
	end
end

function GodDiShiTianAgent:sendPM_GodDiShiTianSetFormReq(simpleForm)
	local req = GodDiShiTianExtension_pb.PM_GodDiShiTianSetFormReq()

	req.simpleForm = simpleForm

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function GodDiShiTianAgent:handlePM_GodDiShiTianSetFormRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.GodDiShiTianSetFormRes)
	end
end

function GodDiShiTianAgent:sendPM_GodDiShiTianChallengeReq(stageId, simpleForm)
	local req = GodDiShiTianExtension_pb.PM_GodDiShiTianChallengeReq()

	req.stageId = stageId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function GodDiShiTianAgent:handlePM_GodDiShiTianChallengeRes(status, msg)
	if status == 0 then
		GodDiShiTianModel.instance:onGodDiShiTianChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GodDiShiTianChallengeRes)
	end
end

function GodDiShiTianAgent:sendPM_GodDiShiTianSetScoreReq(stageId)
	local req = GodDiShiTianExtension_pb.PM_GodDiShiTianSetScoreReq()

	req.stageId = stageId

	self:sendMsg(req)
end

function GodDiShiTianAgent:handlePM_GodDiShiTianSetScoreRes(status, msg)
	if status == 0 then
		GodDiShiTianModel.instance:onGodDiShiTianSetScoreRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GodDiShiTianSetScoreRes)
	end
end

function GodDiShiTianAgent:sendPM_GodDiShiTianQuickPassReq()
	local req = GodDiShiTianExtension_pb.PM_GodDiShiTianQuickPassReq()

	self:sendMsg(req)
end

function GodDiShiTianAgent:handlePM_GodDiShiTianQuickPassRes(status, msg)
	if status == 0 then
		GodDiShiTianModel.instance:onGodDiShiTianQuickPassRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GodDiShiTianQuickPassRes, msg)
	end
end

function GodDiShiTianAgent:handlePM_GodDiShiTianStageOverRes(status, msg)
	if status == 0 then
		GodDiShiTianModel.instance:onGodDiShiTianStageOverRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.GodDiShiTianStageOverRes)
	end
end

GodDiShiTianAgent.instance = GodDiShiTianAgent.New()

return GodDiShiTianAgent
