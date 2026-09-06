-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/agent/PlotChallengeAgent.lua

module("logic.extensions.plotchallenge.agent.PlotChallengeAgent", package.seeall)

local PlotChallengeAgent = class("PlotChallengeAgent", BaseAgent)

PlotChallengeAgent.GetChapterProgressRes = "PlotChallengeAgent_GetChapterProgressRes"
PlotChallengeAgent.ChallengeRes = "PlotChallengeAgent_ChallengeRes"
PlotChallengeAgent.GainChapterPrizeRes = "PlotChallengeAgent_GainChapterPrizeRes"
PlotChallengeAgent.NotifyAfterChallengeRes = "PlotChallengeAgent_NotifyAfterChallengeRes"
PlotChallengeAgent.GetChapterStageInfosRes = "PlotChallengeAgent_GetChapterStageInfosRes"
PlotChallengeAgent.PCLG_SweepsByTimesRes = "PlotChallengeAgent_PCLG_SweepsByTimesRes"
PlotChallengeAgent.PCLG_SweepAutoRes = "PlotChallengeAgent_PCLG_SweepAutoRes"
PlotChallengeAgent.GainPreciousBoxPrizeRes = "PlotChallengeAgent_GainPreciousBoxPrizeRes"

function PlotChallengeAgent:ctor()
	return
end

function PlotChallengeAgent:setExtId(extId)
	PlotChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PlotChallengeAgent:sendGetChapterProgressReq(handler, handlerObj, errHandler)
	local req = PlotChallengeExtension_pb.GetChapterProgressReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlotChallengeAgent.GetChapterProgressRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlotChallengeAgent:handleGetChapterProgressRes(status, msg)
	forcePrint("PlotChallengeAgent:handleGetChapterProgressRes===", status)
	self:dispatch(PlotChallengeAgent.GetChapterProgressRes, status, msg)
end

function PlotChallengeAgent:sendChallengeReq(chapterId, stageId, handler, handlerObj, errHandler)
	local req = PlotChallengeExtension_pb.ChallengeReq()

	req.chapterId = chapterId
	req.stageId = stageId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlotChallengeAgent.ChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlotChallengeAgent:handleChallengeRes(status, msg)
	self:dispatch(PlotChallengeAgent.ChallengeRes, status, msg)
end

function PlotChallengeAgent:sendGainChapterPrizeReq(chapterId, index, handler, handlerObj, errHandler)
	local req = PlotChallengeExtension_pb.GainChapterPrizeReq()

	req.chapterId = chapterId
	req.index = index

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlotChallengeAgent.GainChapterPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlotChallengeAgent:handleGainChapterPrizeRes(status, msg)
	self:dispatch(PlotChallengeAgent.GainChapterPrizeRes, status, msg)
end

function PlotChallengeAgent:handleNotifyAfterChallengeRes(status, msg)
	self:dispatch(PlotChallengeAgent.NotifyAfterChallengeRes, status, msg)
end

function PlotChallengeAgent:sendGetChapterStageInfosReq(chapterId, handler, handlerObj, errHandler)
	local req = PlotChallengeExtension_pb.GetChapterStageInfosReq()

	req.chapterId = chapterId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlotChallengeAgent.GetChapterStageInfosRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlotChallengeAgent:handleGetChapterStageInfosRes(status, msg)
	self:dispatch(PlotChallengeAgent.GetChapterStageInfosRes, status, msg)
end

function PlotChallengeAgent:sendPCLG_SweepsByTimesReq(chapterId, stageId, times, useTicket, handler, handlerObj, errHandler)
	local req = PlotChallengeExtension_pb.PCLG_SweepsByTimesReq()

	req.chapterId = chapterId
	req.stageId = stageId
	req.times = times
	req.useTicket = useTicket

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlotChallengeAgent.PCLG_SweepsByTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlotChallengeAgent:handlePCLG_SweepsByTimesRes(status, msg)
	self:dispatch(PlotChallengeAgent.PCLG_SweepsByTimesRes, status, msg)
end

function PlotChallengeAgent:sendPCLG_SweepAutoReq(chapterId, stageId, materialType, materialId, num, useTicket, handler, handlerObj, errHandler)
	local req = PlotChallengeExtension_pb.PCLG_SweepAutoReq()

	req.chapterId = chapterId
	req.stageId = stageId
	req.materialType = materialType
	req.materialId = materialId
	req.num = num
	req.useTicket = useTicket

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlotChallengeAgent.PCLG_SweepAutoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlotChallengeAgent:handlePCLG_SweepAutoRes(status, msg)
	self:dispatch(PlotChallengeAgent.PCLG_SweepAutoRes, status, msg)
end

function PlotChallengeAgent:sendGainPreciousBoxPrizeReq(chapterId, handler, handlerObj, errHandler)
	local req = PlotChallengeExtension_pb.GainPreciousBoxPrizeReq()

	req.chapterId = chapterId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PlotChallengeAgent.GainPreciousBoxPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PlotChallengeAgent:handleGainPreciousBoxPrizeRes(status, msg)
	self:dispatch(PlotChallengeAgent.GainPreciousBoxPrizeRes, status, msg)
end

function PlotChallengeAgent:sendZdlSecKillReq(chapterId, stageId)
	local req = PlotChallengeExtension_pb.ZdlSecKillReq()

	req.chapterId = chapterId
	req.stageId = stageId

	self:sendMsg(req)
end

function PlotChallengeAgent:handleZdlSecKillRes(status, msg)
	if status == 0 then
		MaterialFacade.instance:popAndShowChangeSetItems(msg.rewardChangeSetId)
		PlotCopyModel.instance:onCopyZdlSecKillRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.CopyZdlSecKillRes)
	end
end

function PlotChallengeAgent:sendPCLG_GetRewardMultiplyTimesReq()
	local req = PlotChallengeExtension_pb.PCLG_GetRewardMultiplyTimesReq()

	self:sendMsg(req)
end

function PlotChallengeAgent:handlePCLG_GetRewardMultiplyTimesRes(status, msg)
	if status == 0 then
		PlotCopyModel.instance:setRewardMultiplyTime(msg)
	else
		PlotCopyModel.instance:setRewardMultiplyTime()
	end

	GlobalDispatcher:dispatch(GlobalNotify.GetRewardMultiplyTimesReq)
end

PlotChallengeAgent.instance = PlotChallengeAgent.New()

return PlotChallengeAgent
