-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/agent/FengBaoBaoChallengeAgent.lua

module("logic.extensions.fengbaobaochallenge.agent.FengBaoBaoChallengeAgent", package.seeall)

local FengBaoBaoChallengeAgent = class("FengBaoBaoChallengeAgent", BaseAgent)

FengBaoBaoChallengeAgent.PM_FengBaoBaoClgGetInfoRes = "FengBaoBaoChallengeAgent_PM_FengBaoBaoClgGetInfoRes"
FengBaoBaoChallengeAgent.PM_FengBaoBaoChallengeSetFormRes = "FengBaoBaoChallengeAgent_PM_FengBaoBaoChallengeSetFormRes"
FengBaoBaoChallengeAgent.PM_FengBaoBaoChallengeGetFormRes = "FengBaoBaoChallengeAgent_PM_FengBaoBaoChallengeGetFormRes"
FengBaoBaoChallengeAgent.PM_FengBaoBaoClgStartGameRes = "FengBaoBaoChallengeAgent_PM_FengBaoBaoClgStartGameRes"
FengBaoBaoChallengeAgent.PM_FengBaoBaoClgEndGameRes = "FengBaoBaoChallengeAgent_PM_FengBaoBaoClgEndGameRes"
FengBaoBaoChallengeAgent.PM_FengBaoBaoClgBuyTimesRes = "FengBaoBaoChallengeAgent_PM_FengBaoBaoClgBuyTimesRes"
FengBaoBaoChallengeAgent.PM_FengBaoBaoClgFightRes = "FengBaoBaoChallengeAgent_PM_FengBaoBaoClgFightRes"

function FengBaoBaoChallengeAgent:ctor()
	return
end

function FengBaoBaoChallengeAgent:setExtId(extId)
	FengBaoBaoChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function FengBaoBaoChallengeAgent:sendPM_FengBaoBaoClgGetInfoReq(handler, handlerObj, errHandler)
	local req = FengBaoBaoChallengeExtension_pb.PM_FengBaoBaoClgGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FengBaoBaoChallengeAgent:handlePM_FengBaoBaoClgGetInfoRes(status, msg)
	self:dispatch(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgGetInfoRes, status, msg)
end

function FengBaoBaoChallengeAgent:sendPM_FengBaoBaoChallengeSetFormReq(simpleForm_pb, handler, handlerObj, errHandler)
	local req = FengBaoBaoChallengeExtension_pb.PM_FengBaoBaoChallengeSetFormReq()

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FengBaoBaoChallengeAgent.PM_FengBaoBaoChallengeSetFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FengBaoBaoChallengeAgent:handlePM_FengBaoBaoChallengeSetFormRes(status, msg)
	self:dispatch(FengBaoBaoChallengeAgent.PM_FengBaoBaoChallengeSetFormRes, status, msg)
end

function FengBaoBaoChallengeAgent:sendPM_FengBaoBaoChallengeGetFormReq(handler, handlerObj, errHandler)
	local req = FengBaoBaoChallengeExtension_pb.PM_FengBaoBaoChallengeGetFormReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FengBaoBaoChallengeAgent.PM_FengBaoBaoChallengeGetFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FengBaoBaoChallengeAgent:handlePM_FengBaoBaoChallengeGetFormRes(status, msg)
	self:dispatch(FengBaoBaoChallengeAgent.PM_FengBaoBaoChallengeGetFormRes, status, msg)
end

function FengBaoBaoChallengeAgent:sendPM_FengBaoBaoClgStartGameReq(clientKey, handler, handlerObj, errHandler)
	local req = FengBaoBaoChallengeExtension_pb.PM_FengBaoBaoClgStartGameReq()

	req.clientKey = clientKey

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgStartGameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FengBaoBaoChallengeAgent:handlePM_FengBaoBaoClgStartGameRes(status, msg)
	self:dispatch(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgStartGameRes, status, msg)
end

function FengBaoBaoChallengeAgent:sendPM_FengBaoBaoClgEndGameReq(shovelNums, encryptedKey, handler, handlerObj, errHandler)
	local req = FengBaoBaoChallengeExtension_pb.PM_FengBaoBaoClgEndGameReq()

	req.shovelNums = shovelNums
	req.encryptedKey = encryptedKey

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgEndGameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FengBaoBaoChallengeAgent:handlePM_FengBaoBaoClgEndGameRes(status, msg)
	self:dispatch(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgEndGameRes, status, msg)
end

function FengBaoBaoChallengeAgent:sendPM_FengBaoBaoClgBuyTimesReq(handler, handlerObj, errHandler)
	local req = FengBaoBaoChallengeExtension_pb.PM_FengBaoBaoClgBuyTimesReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgBuyTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FengBaoBaoChallengeAgent:handlePM_FengBaoBaoClgBuyTimesRes(status, msg)
	self:dispatch(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgBuyTimesRes, status, msg)
end

function FengBaoBaoChallengeAgent:sendPM_FengBaoBaoClgFightReq(handler, handlerObj, errHandler)
	local req = FengBaoBaoChallengeExtension_pb.PM_FengBaoBaoClgFightReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgFightRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FengBaoBaoChallengeAgent:handlePM_FengBaoBaoClgFightRes(status, msg)
	self:dispatch(FengBaoBaoChallengeAgent.PM_FengBaoBaoClgFightRes, status, msg)
end

FengBaoBaoChallengeAgent.instance = FengBaoBaoChallengeAgent.New()

return FengBaoBaoChallengeAgent
