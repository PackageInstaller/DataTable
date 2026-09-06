-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/agent/JieShenEventAgent.lua

module("logic.extensions.jieshenevent.agent.JieShenEventAgent", package.seeall)

local JieShenEventAgent = class("JieShenEventAgent", BaseAgent)

function JieShenEventAgent:sendPM_JieShenEventGetInfoReq(activityId)
	local req = JieShenEventExtension_pb.PM_JieShenEventGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JieShenEventAgent:handlePM_JieShenEventGetInfoRes(status, msg)
	if status == 0 then
		JieShenEventController.instance:_handlePM_JieShenEventGetInfoRes(msg)
	end
end

function JieShenEventAgent:sendPM_JieShenEventFinishGameReq(activityId, informerId, blockList, roadLine)
	local req = JieShenEventExtension_pb.PM_JieShenEventFinishGameReq()

	req.activityId = activityId
	req.informerId = informerId

	if blockList then
		for i, v in ipairs(blockList) do
			local param = req.blockList:add()

			param:ParseFromString(v:SerializeToString())
		end
	end

	if roadLine then
		for i, id in ipairs(roadLine) do
			req.roadLine:append(id)
		end
	end

	self:sendMsg(req)
end

function JieShenEventAgent:handlePM_JieShenEventFinishGameRes(status, msg)
	if status == 0 then
		JieShenEventController.instance:_handlePM_JieShenEventFinishGameRes(msg)
	end
end

function JieShenEventAgent:sendPM_JieShenEvnetGainTimelinePrizeReq(activityId, timelineId)
	local req = JieShenEventExtension_pb.PM_JieShenEvnetGainTimelinePrizeReq()

	req.activityId = activityId
	req.timelineId = timelineId

	self:sendMsg(req)
end

function JieShenEventAgent:handlePM_JieShenEvnetGainTimelinePrizeRes(status, msg)
	if status == 0 then
		JieShenEventController.instance:_handlePM_JieShenEvnetGainTimelinePrizeRes(msg)
	end
end

function JieShenEventAgent:sendPM_JieShenEvnetComboClueReq(activityId, targetClueId)
	local req = JieShenEventExtension_pb.PM_JieShenEvnetComboClueReq()

	req.activityId = activityId
	req.targetClueId = targetClueId

	self:sendMsg(req)
end

function JieShenEventAgent:handlePM_JieShenEvnetComboClueRes(status, msg)
	JieShenEventController.instance:_handlePM_JieShenEvnetComboClueRes(status, msg)
end

function JieShenEventAgent:sendPM_JieShenEvnetGainCluePrizeReq(activityId, tabId)
	local req = JieShenEventExtension_pb.PM_JieShenEvnetGainCluePrizeReq()

	req.activityId = activityId
	req.tabId = tabId

	self:sendMsg(req)
end

function JieShenEventAgent:handlePM_JieShenEvnetGainCluePrizeRes(status, msg)
	if status == 0 then
		JieShenEventController.instance:_handlePM_JieShenEvnetGainCluePrizeRes(msg)
	end
end

JieShenEventAgent.instance = JieShenEventAgent.New()

return JieShenEventAgent
