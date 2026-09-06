-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/agent/DivineChenClgAgent.lua

module("logic.extensions.divinechenclg.agent.DivineChenClgAgent", package.seeall)

local DivineChenClgAgent = class("DivineChenClgAgent", BaseAgent)

function DivineChenClgAgent:sendPM_DivineChenClgExtremeInfoReq(activityId)
	local req = DivineChenClgExtension_pb.PM_DivineChenClgExtremeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineChenClgAgent:handlePM_DivineChenClgExtremeInfoRes(status, msg)
	if status == 0 then
		DivineChenClgController.instance:handleGetExtremeInfo(msg)
	end
end

function DivineChenClgAgent:sendPM_DivineChenClgExtremeClgReq(activityId, stageId, form_pb)
	local req = DivineChenClgExtension_pb.PM_DivineChenClgExtremeClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineChenClgAgent:handlePM_DivineChenClgExtremeClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineChenClgAgent:sendPM_DivineChenClgExtremeResetStageReq(activityId, stageId)
	local req = DivineChenClgExtension_pb.PM_DivineChenClgExtremeResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineChenClgAgent:handlePM_DivineChenClgExtremeResetStageRes(status, msg)
	if status == 0 then
		DivineChenClgController.instance:handleExtremeResetStage(msg)
	end
end

function DivineChenClgAgent:sendPM_DivineChenClgNormalInfoReq(activityId)
	local req = DivineChenClgExtension_pb.PM_DivineChenClgNormalInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineChenClgAgent:handlePM_DivineChenClgNormalInfoRes(status, msg)
	if status == 0 then
		DivineChenClgController.instance:handleGetNormalInfo(msg)
	end
end

function DivineChenClgAgent:sendPM_DivineChenClgNormalClgReq(activityId, stageId, form_pb)
	local req = DivineChenClgExtension_pb.PM_DivineChenClgNormalClgReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineChenClgAgent:handlePM_DivineChenClgNormalClgRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineChenClgAgent:sendPM_DivineChenClgNormalResetStageReq(activityId, stageId)
	local req = DivineChenClgExtension_pb.PM_DivineChenClgNormalResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineChenClgAgent:handlePM_DivineChenClgNormalResetStageRes(status, msg)
	if status == 0 then
		DivineChenClgController.instance:handleNormalResetStage(msg)
	end
end

function DivineChenClgAgent:sendPM_DivineChenClgNormalGainPrizeReq(activityId, prizeId)
	local req = DivineChenClgExtension_pb.PM_DivineChenClgNormalGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineChenClgAgent:handlePM_DivineChenClgNormalGainPrizeRes(status, msg)
	if status == 0 then
		DivineChenClgController.instance:handleNormalGainPrize(msg)
	end
end

function DivineChenClgAgent:handlePM_NotifyDivineChenClgExtremeClgEndRes(status, msg)
	if status == 0 then
		DivineChenClgController.instance:handleNotifyExtremeClgEnd(msg)
	end
end

function DivineChenClgAgent:handlePM_NotifyDivineChenClgNormalClgEndRes(status, msg)
	if status == 0 then
		DivineChenClgController.instance:handleNotifyNormalClgEnd(msg)
	end
end

DivineChenClgAgent.instance = DivineChenClgAgent.New()

return DivineChenClgAgent
