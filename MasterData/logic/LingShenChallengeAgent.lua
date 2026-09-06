-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenchallenge/agent/LingShenChallengeAgent.lua

module("logic.extensions.lingshenchallenge.agent.LingShenChallengeAgent", package.seeall)

local LingShenChallengeAgent = class("LingShenChallengeAgent", BaseAgent)

function LingShenChallengeAgent:sendPM_LingShenClgGetInfoReq(activityId)
	local req = LingShenChallengeExtension_pb.PM_LingShenClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LingShenChallengeAgent:handlePM_LingShenClgGetInfoRes(status, msg)
	if status == 0 then
		LingShenChallengeController.instance:handlePM_LingShenClgGetInfoRes(msg)
	end
end

function LingShenChallengeAgent:sendPM_LingShenClgGainDamagePrizeReq(activityId, prizeId)
	local req = LingShenChallengeExtension_pb.PM_LingShenClgGainDamagePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function LingShenChallengeAgent:handlePM_LingShenClgGainDamagePrizeRes(status, msg)
	if status == 0 then
		LingShenChallengeController.instance:handlePM_LingShenClgGainDamagePrizeRes(msg)
	end
end

function LingShenChallengeAgent:sendPM_LingShenClgSetPreFormReq(activityId, form)
	local req = LingShenChallengeExtension_pb.PM_LingShenClgSetPreFormReq()

	req.activityId = activityId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function LingShenChallengeAgent:handlePM_LingShenClgSetPreFormRes(status, msg)
	if status == 0 then
		LingShenChallengeController.instance:handlePM_LingShenClgSetPreFormRes(msg)
	end
end

function LingShenChallengeAgent:sendPM_LingShenClgSetFormReq(form)
	local req = LingShenChallengeExtension_pb.PM_LingShenClgSetFormReq()

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function LingShenChallengeAgent:handlePM_LingShenClgSetFormRes(status, msg)
	if status == 0 then
		LingShenChallengeController.instance:handlePM_LingShenClgSetFormRes(msg)
	end
end

function LingShenChallengeAgent:sendPM_LingShenClgReadyReq(form)
	local req = LingShenChallengeExtension_pb.PM_LingShenClgReadyReq()

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function LingShenChallengeAgent:handlePM_LingShenClgReadyRes(status, msg)
	if status == 0 then
		LingShenChallengeController.instance:handlePM_LingShenClgReadyRes(msg)
	end
end

function LingShenChallengeAgent:handlePM_LingShenClgNotifyStartRes(status, msg)
	if status == 0 then
		LingShenChallengeController.instance:handlePM_LingShenClgNotifyStartRes(msg)
	end
end

function LingShenChallengeAgent:handlePM_LingShenClgNotifyFormChangeRes(status, msg)
	if status == 0 then
		LingShenChallengeController.instance:handlePM_LingShenClgNotifyFormChangeRes(msg)
	end
end

function LingShenChallengeAgent:handlePM_LingShenClgNotifyReadyRes(status, msg)
	if status == 0 then
		LingShenChallengeController.instance:handlePM_LingShenClgNotifyReadyRes(msg)
	end
end

function LingShenChallengeAgent:handlePM_LingShenClgNotifyResultRes(status, msg)
	LingShenChallengeController.instance:handlePM_LingShenClgNotifyResultRes(status, msg)
end

LingShenChallengeAgent.instance = LingShenChallengeAgent.New()

return LingShenChallengeAgent
