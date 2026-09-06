-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/agent/PlotReviewAgent.lua

module("logic.extensions.plotreview.agent.PlotReviewAgent", package.seeall)

local PlotReviewAgent = class("PlotReviewAgent", BaseAgent)

function PlotReviewAgent:sendPM_PlotReviewGetInfoReq()
	local req = PlotReviewExtension_pb.PM_PlotReviewGetInfoReq()

	self:sendMsg(req)
end

function PlotReviewAgent:handlePM_PlotReviewGetInfoRes(status, msg)
	if status == 0 then
		PlotmamoriesController.instance:handlePM_PlotReviewGetInfoRes(msg)
	end
end

function PlotReviewAgent:sendPM_PlotReviewGainPrizeReq(prizeId)
	local req = PlotReviewExtension_pb.PM_PlotReviewGainPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function PlotReviewAgent:handlePM_PlotReviewGainPrizeRes(status, msg)
	if status == 0 then
		PlotmamoriesController.instance:handlePM_PlotReviewGainPrizeRes(msg)
	end
end

PlotReviewAgent.instance = PlotReviewAgent.New()

return PlotReviewAgent
