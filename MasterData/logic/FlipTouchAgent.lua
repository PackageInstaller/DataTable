-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/agent/FlipTouchAgent.lua

module("logic.extensions.dreamteam.agent.FlipTouchAgent", package.seeall)

local FlipTouchAgent = class("FlipTouchAgent", BaseAgent)

FlipTouchAgent.PM_FlipTouchGetInfoRes = "FlipTouchAgent_PM_FlipTouchGetInfoRes"
FlipTouchAgent.PM_FlipTouchGainOutPrizeRes = "FlipTouchAgent_PM_FlipTouchGainOutPrizeRes"
FlipTouchAgent.PM_FlipTouchStartGameRes = "FlipTouchAgent_PM_FlipTouchStartGameRes"
FlipTouchAgent.PM_FlipTouchIntoNextStageRes = "FlipTouchAgent_PM_FlipTouchIntoNextStageRes"
FlipTouchAgent.PM_FlipTouchIncreaseStageTimeRes = "FlipTouchAgent_PM_FlipTouchIncreaseStageTimeRes"
FlipTouchAgent.PM_FlipTouchEndGameRes = "FlipTouchAgent_PM_FlipTouchEndGameRes"
FlipTouchAgent.PM_FlipTouchGainGlobalPrizeRes = "FlipTouchAgent_PM_FlipTouchGainGlobalPrizeRes"

function FlipTouchAgent:ctor()
	return
end

function FlipTouchAgent:setExtId(extId)
	FlipTouchAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function FlipTouchAgent:sendPM_FlipTouchGetInfoReq(activityId, handler, handlerObj, errHandler)
	local req = FlipTouchExtension_pb.PM_FlipTouchGetInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FlipTouchAgent.PM_FlipTouchGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FlipTouchAgent:handlePM_FlipTouchGetInfoRes(status, msg)
	self:dispatch(FlipTouchAgent.PM_FlipTouchGetInfoRes, status, msg)
end

function FlipTouchAgent:sendPM_FlipTouchGainOutPrizeReq(activityId, id, handler, handlerObj, errHandler)
	local req = FlipTouchExtension_pb.PM_FlipTouchGainOutPrizeReq()

	req.activityId = activityId
	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FlipTouchAgent.PM_FlipTouchGainOutPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FlipTouchAgent:handlePM_FlipTouchGainOutPrizeRes(status, msg)
	self:dispatch(FlipTouchAgent.PM_FlipTouchGainOutPrizeRes, status, msg)
end

function FlipTouchAgent:sendPM_FlipTouchStartGameReq(activityId, clientKey, handler, handlerObj, errHandler)
	local req = FlipTouchExtension_pb.PM_FlipTouchStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FlipTouchAgent.PM_FlipTouchStartGameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FlipTouchAgent:handlePM_FlipTouchStartGameRes(status, msg)
	self:dispatch(FlipTouchAgent.PM_FlipTouchStartGameRes, status, msg)
end

function FlipTouchAgent:sendPM_FlipTouchIntoNextStageReq(activityId, touchNum, nextStageId, clientEncryptedKey, handler, handlerObj, errHandler)
	local req = FlipTouchExtension_pb.PM_FlipTouchIntoNextStageReq()

	req.activityId = activityId
	req.touchNum = touchNum
	req.nextStageId = nextStageId
	req.clientEncryptedKey = clientEncryptedKey

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FlipTouchAgent.PM_FlipTouchIntoNextStageRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FlipTouchAgent:handlePM_FlipTouchIntoNextStageRes(status, msg)
	self:dispatch(FlipTouchAgent.PM_FlipTouchIntoNextStageRes, status, msg)
end

function FlipTouchAgent:sendPM_FlipTouchIncreaseStageTimeReq(activityId, curStageId, handler, handlerObj, errHandler)
	local req = FlipTouchExtension_pb.PM_FlipTouchIncreaseStageTimeReq()

	req.activityId = activityId
	req.curStageId = curStageId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FlipTouchAgent.PM_FlipTouchIncreaseStageTimeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FlipTouchAgent:handlePM_FlipTouchIncreaseStageTimeRes(status, msg)
	self:dispatch(FlipTouchAgent.PM_FlipTouchIncreaseStageTimeRes, status, msg)
end

function FlipTouchAgent:sendPM_FlipTouchEndGameReq(activityId, touchNum, clientEncryptedKey, handler, handlerObj, errHandler)
	local req = FlipTouchExtension_pb.PM_FlipTouchEndGameReq()

	req.activityId = activityId
	req.touchNum = touchNum
	req.clientEncryptedKey = clientEncryptedKey

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FlipTouchAgent.PM_FlipTouchEndGameRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FlipTouchAgent:handlePM_FlipTouchEndGameRes(status, msg)
	self:dispatch(FlipTouchAgent.PM_FlipTouchEndGameRes, status, msg)
end

function FlipTouchAgent:sendPM_FlipTouchGainGlobalPrizeReq(activityId, id, handler, handlerObj, errHandler)
	local req = FlipTouchExtension_pb.PM_FlipTouchGainGlobalPrizeReq()

	req.activityId = activityId
	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FlipTouchAgent.PM_FlipTouchGainGlobalPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FlipTouchAgent:handlePM_FlipTouchGainGlobalPrizeRes(status, msg)
	self:dispatch(FlipTouchAgent.PM_FlipTouchGainGlobalPrizeRes, status, msg)
end

FlipTouchAgent.instance = FlipTouchAgent.New()

return FlipTouchAgent
