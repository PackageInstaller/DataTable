-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/agent/SignInAgent.lua

module("logic.extensions.sevendays.agent.SignInAgent", package.seeall)

local SignInAgent = class("SignInAgent", BaseAgent)

SignInAgent.SignInInfoRes = "SignInAgent_SignInInfoRes"
SignInAgent.SignInGainPrizeRes = "SignInAgent_SignInGainPrizeRes"

function SignInAgent:ctor()
	return
end

function SignInAgent:setExtId(extId)
	SignInAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function SignInAgent:sendSignInInfoReq(handler, handlerObj, errHandler)
	local req = SignInExtension_pb.SignInInfoReq()

	self:sendMsg(req)
	self:addEventOnce(SignInAgent.SignInInfoRes, handler, handlerObj, errHandler)
end

function SignInAgent:handleSignInInfoRes(status, msg)
	self:dispatch(SignInAgent.SignInInfoRes, status, msg)
end

function SignInAgent:sendSignInGainPrizeReq(prizeReq_pb, day, handler, handlerObj, errHandler)
	local req = SignInExtension_pb.SignInGainPrizeReq()

	req.prizeReq:ParseFromString(prizeReq_pb:SerializeToString())

	req.day = day

	self:sendMsg(req)
	self:addEventOnce(SignInAgent.SignInGainPrizeRes, handler, handlerObj, errHandler)
end

function SignInAgent:handleSignInGainPrizeRes(status, msg)
	self:dispatch(SignInAgent.SignInGainPrizeRes, status, msg)
end

SignInAgent.instance = SignInAgent.New()

return SignInAgent
