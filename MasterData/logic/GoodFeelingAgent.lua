-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/agent/GoodFeelingAgent.lua

module("logic.extensions.goodfeeling.agent.GoodFeelingAgent", package.seeall)

local GoodFeelingAgent = class("GoodFeelingAgent", BaseAgent)

GoodFeelingAgent.PM_GFGetChatInfoRes = "GoodFeelingAgent_PM_GFGetChatInfoRes"
GoodFeelingAgent.PM_GFSelfChatRes = "GoodFeelingAgent_PM_GFSelfChatRes"
GoodFeelingAgent.PM_GFGetRaceBookInfoRes = "GoodFeelingAgent_PM_GFGetRaceBookInfoRes"
GoodFeelingAgent.PM_GFViewStoryRes = "GoodFeelingAgent_PM_GFViewStoryRes"
GoodFeelingAgent.PM_GFGetEventInfoRes = "GoodFeelingAgent_PM_GFGetEventInfoRes"
GoodFeelingAgent.PM_GFHandleEventRes = "GoodFeelingAgent_PM_GFHandleEventRes"
GoodFeelingAgent.PM_GFGainPrizeRes = "GoodFeelingAgent_PM_GFGainPrizeRes"
GoodFeelingAgent.PM_GFNotifyAfterHandleEventRes = "GoodFeelingAgent_PM_GFNotifyAfterHandleEventRes"
GoodFeelingAgent.GFOneKeyGainPrizeRes = "GoodFeelingAgent.GFOneKeyGainPrizeRes"

function GoodFeelingAgent:ctor()
	return
end

function GoodFeelingAgent:setExtId(extId)
	GoodFeelingAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function GoodFeelingAgent:sendPM_GFGetChatInfoReq(handler, handlerObj, errHandler)
	local req = GoodFeelingExtension_pb.PM_GFGetChatInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GoodFeelingAgent.PM_GFGetChatInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GoodFeelingAgent:handlePM_GFGetChatInfoRes(status, msg)
	self:dispatch(GoodFeelingAgent.PM_GFGetChatInfoRes, status, msg)
end

function GoodFeelingAgent:sendPM_GFSelfChatReq(chatId, handler, handlerObj, errHandler)
	local req = GoodFeelingExtension_pb.PM_GFSelfChatReq()

	req.chatId = chatId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GoodFeelingAgent.PM_GFSelfChatRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GoodFeelingAgent:handlePM_GFSelfChatRes(status, msg)
	self:dispatch(GoodFeelingAgent.PM_GFSelfChatRes, status, msg)
end

function GoodFeelingAgent:sendPM_GFGetRaceBookInfoReq(handler, handlerObj, errHandler)
	local req = GoodFeelingExtension_pb.PM_GFGetRaceBookInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GoodFeelingAgent.PM_GFGetRaceBookInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GoodFeelingAgent:handlePM_GFGetRaceBookInfoRes(status, msg)
	self:dispatch(GoodFeelingAgent.PM_GFGetRaceBookInfoRes, status, msg)
end

function GoodFeelingAgent:sendPM_GFViewStoryReq(raceId, storyId, handler, handlerObj, errHandler)
	local req = GoodFeelingExtension_pb.PM_GFViewStoryReq()

	req.raceId = raceId
	req.storyId = storyId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GoodFeelingAgent.PM_GFViewStoryRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GoodFeelingAgent:handlePM_GFViewStoryRes(status, msg)
	self:dispatch(GoodFeelingAgent.PM_GFViewStoryRes, status, msg)
end

function GoodFeelingAgent:sendPM_GFGetEventInfoReq(raceId, handler, handlerObj, errHandler)
	local req = GoodFeelingExtension_pb.PM_GFGetEventInfoReq()

	req.raceId = raceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GoodFeelingAgent.PM_GFGetEventInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GoodFeelingAgent:handlePM_GFGetEventInfoRes(status, msg)
	self:dispatch(GoodFeelingAgent.PM_GFGetEventInfoRes, status, msg)
end

function GoodFeelingAgent:sendPM_GFHandleEventReq(raceId, win, handler, handlerObj, errHandler)
	local req = GoodFeelingExtension_pb.PM_GFHandleEventReq()

	req.raceId = raceId

	if win ~= nil then
		req.win = win
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GoodFeelingAgent.PM_GFHandleEventRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GoodFeelingAgent:handlePM_GFHandleEventRes(status, msg)
	self:dispatch(GoodFeelingAgent.PM_GFHandleEventRes, status, msg)
end

function GoodFeelingAgent:sendPM_GFGainPrizeReq(raceId, level, handler, handlerObj, errHandler)
	local req = GoodFeelingExtension_pb.PM_GFGainPrizeReq()

	req.raceId = raceId
	req.level = level

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(GoodFeelingAgent.PM_GFGainPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function GoodFeelingAgent:handlePM_GFGainPrizeRes(status, msg)
	self:dispatch(GoodFeelingAgent.PM_GFGainPrizeRes, status, msg)
end

function GoodFeelingAgent:handlePM_GFNotifyAfterHandleEventRes(status, msg)
	self:dispatch(GoodFeelingAgent.PM_GFNotifyAfterHandleEventRes, status, msg)
end

function GoodFeelingAgent:sendPM_GFOneKeyGainPrizeReq()
	local req = GoodFeelingExtension_pb.PM_GFOneKeyGainPrizeReq()

	self:sendMsg(req)
end

function GoodFeelingAgent:handlePM_GFOneKeyGainPrizeRes(status, msg)
	if status == 0 then
		GoodFeelModel.instance:updateBookInfo(msg.infoList)
		GlobalDispatcher:dispatch(GoodFeelingAgent.GFOneKeyGainPrizeRes)
	end
end

GoodFeelingAgent.instance = GoodFeelingAgent.New()

return GoodFeelingAgent
