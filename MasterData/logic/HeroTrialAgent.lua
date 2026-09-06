-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/agent/HeroTrialAgent.lua

module("logic.extensions.herotrial.agent.HeroTrialAgent", package.seeall)

local HeroTrialAgent = class("HeroTrialAgent", BaseAgent)

HeroTrialAgent.PM_HTGetInfoRes = "HeroTrialAgent_PM_HTGetInfoRes"
HeroTrialAgent.PM_HTUpdateVerifiedZdlRes = "HeroTrialAgent_PM_HTUpdateVerifiedZdlRes"
HeroTrialAgent.PM_HTChallengeBossRes = "HeroTrialAgent_PM_HTChallengeBossRes"
HeroTrialAgent.PM_HTSaveFormRes = "HeroTrialAgent_PM_HTSaveFormRes"
HeroTrialAgent.PM_HTChallengeEndRes = "HeroTrialAgent_PM_HTChallengeEndRes"

function HeroTrialAgent:ctor()
	return
end

function HeroTrialAgent:setExtId(extId)
	HeroTrialAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function HeroTrialAgent:sendPM_HTGetInfoReq(activityId, handler, handlerObj, errHandler)
	local req = HeroTrialExtension_pb.PM_HTGetInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HeroTrialAgent.PM_HTGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HeroTrialAgent:handlePM_HTGetInfoRes(status, msg)
	self:dispatch(HeroTrialAgent.PM_HTGetInfoRes, status, msg)
end

function HeroTrialAgent:sendPM_HTUpdateVerifiedZdlReq(activityId, verifyPetId, handler, handlerObj, errHandler)
	local req = HeroTrialExtension_pb.PM_HTUpdateVerifiedZdlReq()

	req.activityId = activityId
	req.verifyPetId = verifyPetId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HeroTrialAgent.PM_HTUpdateVerifiedZdlRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HeroTrialAgent:handlePM_HTUpdateVerifiedZdlRes(status, msg)
	self:dispatch(HeroTrialAgent.PM_HTUpdateVerifiedZdlRes, status, msg)
end

function HeroTrialAgent:sendPM_HTChallengeBossReq(activityId, handler, handlerObj, errHandler)
	local req = HeroTrialExtension_pb.PM_HTChallengeBossReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HeroTrialAgent.PM_HTChallengeBossRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HeroTrialAgent:handlePM_HTChallengeBossRes(status, msg)
	self:dispatch(HeroTrialAgent.PM_HTChallengeBossRes, status, msg)
end

function HeroTrialAgent:sendPM_HTSaveFormReq(activityId, form_pb, handler, handlerObj, errHandler)
	local req = HeroTrialExtension_pb.PM_HTSaveFormReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HeroTrialAgent.PM_HTSaveFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function HeroTrialAgent:handlePM_HTSaveFormRes(status, msg)
	self:dispatch(HeroTrialAgent.PM_HTSaveFormRes, status, msg)
end

function HeroTrialAgent:handlePM_HTChallengeEndRes(status, msg)
	self:dispatch(HeroTrialAgent.PM_HTChallengeEndRes, status, msg)
end

HeroTrialAgent.instance = HeroTrialAgent.New()

return HeroTrialAgent
