-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/agent/NaiLongHotSearchAgent.lua

module("logic.extensions.nailonghotsearch.agent.NaiLongHotSearchAgent", package.seeall)

local NaiLongHotSearchAgent = class("NaiLongHotSearchAgent", BaseAgent)

function NaiLongHotSearchAgent:sendPM_HotSearchGetInfoReq(activityId)
	local req = HotSearchExtension_pb.PM_HotSearchGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NaiLongHotSearchAgent:handlePM_HotSearchGetInfoRes(status, msg)
	if status == 0 then
		NaiLongHotSearchController.instance:handlePM_HotSearchGetInfoRes(msg)
	end
end

function NaiLongHotSearchAgent:sendPM_HotSearchGainPrizeReq(activityId, prizeIds)
	local req = HotSearchExtension_pb.PM_HotSearchGainPrizeReq()

	req.activityId = activityId

	for _, v in ipairs(prizeIds) do
		req.prizeIds:append(v)
	end

	self:sendMsg(req)
end

function NaiLongHotSearchAgent:handlePM_HotSearchGainPrizeRes(status, msg)
	if status == 0 then
		NaiLongHotSearchController.instance:handlePM_HotSearchGainPrizeRes(msg)
	end
end

function NaiLongHotSearchAgent:sendPM_HotSearchReplyReq(activityId, replyId)
	local req = HotSearchExtension_pb.PM_HotSearchReplyReq()

	req.activityId = activityId
	req.replyId = replyId

	self:sendMsg(req)
end

function NaiLongHotSearchAgent:handlePM_HotSearchReplyRes(status, msg)
	if status == 0 then
		NaiLongHotSearchController.instance:handlePM_HotSearchReplyRes(msg)
	end
end

function NaiLongHotSearchAgent:sendPM_HotSearchKudosReq(activityId)
	local req = HotSearchExtension_pb.PM_HotSearchKudosReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NaiLongHotSearchAgent:handlePM_HotSearchKudosRes(status, msg)
	if status == 0 then
		NaiLongHotSearchController.instance:handlePM_HotSearchKudosRes(msg)
	end
end

function NaiLongHotSearchAgent:sendPM_HotSearchPresentReq(activityId)
	local req = HotSearchExtension_pb.PM_HotSearchPresentReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NaiLongHotSearchAgent:handlePM_HotSearchPresentRes(status, msg)
	if status == 0 then
		NaiLongHotSearchController.instance:handlePM_HotSearchPresentRes(msg)
	end
end

NaiLongHotSearchAgent.instance = NaiLongHotSearchAgent.New()

return NaiLongHotSearchAgent
