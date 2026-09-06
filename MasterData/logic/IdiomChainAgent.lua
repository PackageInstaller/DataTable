-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/agent/IdiomChainAgent.lua

module("logic.extensions.idiomchain.agent.IdiomChainAgent", package.seeall)

local IdiomChainAgent = class("IdiomChainAgent", BaseAgent)

function IdiomChainAgent:sendPM_IdiomChainInfoReq(activityId)
	local req = IdiomChainExtension_pb.PM_IdiomChainInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function IdiomChainAgent:handlePM_IdiomChainInfoRes(status, msg)
	if status == 0 then
		IdiomChainController.instance:handlePM_IdiomChainInfoRes(msg)
	end
end

function IdiomChainAgent:sendPM_IdiomChainGameStartReq(activityId, difficultId, clientKey)
	local req = IdiomChainExtension_pb.PM_IdiomChainGameStartReq()

	req.activityId = activityId
	req.difficultId = difficultId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function IdiomChainAgent:handlePM_IdiomChainGameStartRes(status, msg)
	IdiomChainController.instance:handlePM_IdiomChainGameStartRes(status, msg)
end

function IdiomChainAgent:sendPM_IdiomChainGameEndReq(activityId, difficultId, isPass, useSec, encryptedKey)
	local req = IdiomChainExtension_pb.PM_IdiomChainGameEndReq()

	req.activityId = activityId
	req.difficultId = difficultId
	req.isPass = isPass
	req.useSec = useSec
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function IdiomChainAgent:handlePM_IdiomChainGameEndRes(status, msg)
	if status == 0 then
		IdiomChainController.instance:handlePM_IdiomChainGameEndRes(msg)
	end
end

function IdiomChainAgent:sendPM_IdiomChainGainPrizeReq(activityId, prizeId)
	local req = IdiomChainExtension_pb.PM_IdiomChainGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function IdiomChainAgent:handlePM_IdiomChainGainPrizeRes(status, msg)
	if status == 0 then
		IdiomChainController.instance:handlePM_IdiomChainGainPrizeRes(msg)
	end
end

IdiomChainAgent.instance = IdiomChainAgent.New()

return IdiomChainAgent
