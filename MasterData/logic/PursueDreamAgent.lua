-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/agent/PursueDreamAgent.lua

module("logic.extensions.mangtower.agent.PursueDreamAgent", package.seeall)

local PursueDreamAgent = class("PursueDreamAgent", BaseAgent)

PursueDreamAgent.PM_PursueDreamGetInfoRes = "PursueDreamAgent_PM_PursueDreamGetInfoRes"
PursueDreamAgent.PM_PursueDreamChallengeRes = "PursueDreamAgent_PM_PursueDreamChallengeRes"
PursueDreamAgent.PM_PursueDreamSetFormsRes = "PursueDreamAgent_PM_PursueDreamSetFormsRes"
PursueDreamAgent.PM_PursueDreamGetFormsRes = "PursueDreamAgent_PM_PursueDreamGetFormsRes"
PursueDreamAgent.PM_PursueDreamGetRanksRes = "PursueDreamAgent_PM_PursueDreamGetRanksRes"
PursueDreamAgent.PM_PursueDreamGainDailyBonusRes = "PursueDreamAgent_PM_PursueDreamGainDailyBonusRes"

function PursueDreamAgent:ctor()
	return
end

function PursueDreamAgent:setExtId(extId)
	PursueDreamAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PursueDreamAgent:sendPM_PursueDreamGetInfoReq(activityId, handler, handlerObj, errHandler)
	local req = PursueDreamExtension_pb.PM_PursueDreamGetInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PursueDreamAgent.PM_PursueDreamGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PursueDreamAgent:handlePM_PursueDreamGetInfoRes(status, msg)
	self:dispatch(PursueDreamAgent.PM_PursueDreamGetInfoRes, status, msg)
end

function PursueDreamAgent:sendPM_PursueDreamChallengeReq(activityId, type, phase, buffId, handler, handlerObj, errHandler)
	local req = PursueDreamExtension_pb.PM_PursueDreamChallengeReq()

	req.activityId = activityId
	req.type = type
	req.phase = phase
	req.buffId = buffId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PursueDreamAgent.PM_PursueDreamChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PursueDreamAgent:handlePM_PursueDreamChallengeRes(status, msg)
	self:dispatch(PursueDreamAgent.PM_PursueDreamChallengeRes, status, msg)
end

function PursueDreamAgent:sendPM_PursueDreamSetFormsReq(activityId, type, simpleForm_pb_Ary, handler, handlerObj, errHandler)
	local req = PursueDreamExtension_pb.PM_PursueDreamSetFormsReq()

	req.activityId = activityId
	req.type = type

	if simpleForm_pb_Ary ~= nil then
		for i, v1 in ipairs(simpleForm_pb_Ary) do
			local simpleForm = req.simpleForm:add()

			simpleForm:ParseFromString(v1:SerializeToString())
		end
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PursueDreamAgent.PM_PursueDreamSetFormsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PursueDreamAgent:handlePM_PursueDreamSetFormsRes(status, msg)
	self:dispatch(PursueDreamAgent.PM_PursueDreamSetFormsRes, status, msg)
end

function PursueDreamAgent:sendPM_PursueDreamGetFormsReq(activityId, type, handler, handlerObj, errHandler)
	local req = PursueDreamExtension_pb.PM_PursueDreamGetFormsReq()

	req.activityId = activityId
	req.type = type

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PursueDreamAgent.PM_PursueDreamGetFormsRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PursueDreamAgent:handlePM_PursueDreamGetFormsRes(status, msg)
	self:dispatch(PursueDreamAgent.PM_PursueDreamGetFormsRes, status, msg)
end

function PursueDreamAgent:sendPM_PursueDreamGetRanksReq(activityId, handler, handlerObj, errHandler)
	local req = PursueDreamExtension_pb.PM_PursueDreamGetRanksReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PursueDreamAgent.PM_PursueDreamGetRanksRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PursueDreamAgent:handlePM_PursueDreamGetRanksRes(status, msg)
	self:dispatch(PursueDreamAgent.PM_PursueDreamGetRanksRes, status, msg)
end

function PursueDreamAgent:sendPM_PursueDreamGainDailyBonusReq(activityId, handler, handlerObj, errHandler)
	local req = PursueDreamExtension_pb.PM_PursueDreamGainDailyBonusReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PursueDreamAgent.PM_PursueDreamGainDailyBonusRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PursueDreamAgent:handlePM_PursueDreamGainDailyBonusRes(status, msg)
	self:dispatch(PursueDreamAgent.PM_PursueDreamGainDailyBonusRes, status, msg)
end

PursueDreamAgent.instance = PursueDreamAgent.New()

return PursueDreamAgent
