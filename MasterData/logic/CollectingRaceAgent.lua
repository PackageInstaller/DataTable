-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingrace/agent/CollectingRaceAgent.lua

module("logic.extensions.collectingrace.agent.CollectingRaceAgent", package.seeall)

local CollectingRaceAgent = class("CollectingRaceAgent", BaseAgent)

function CollectingRaceAgent:sendPM_CollectingRaceInfoReq()
	local req = CollectingRaceExtension_pb.PM_CollectingRaceInfoReq()

	self:sendMsg(req)
end

function CollectingRaceAgent:handlePM_CollectingRaceInfoRes(status, msg)
	CollectingRaceController.instance:handleInfoRes(status, msg)
end

function CollectingRaceAgent:sendPM_CollectingRaceGainPrizeReq(activityId)
	local req = CollectingRaceExtension_pb.PM_CollectingRaceGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CollectingRaceAgent:handlePM_CollectingRaceGainPrizeRes(status, msg)
	CollectingRaceController.instance:handleGainPrizeRes(status, msg)
end

CollectingRaceAgent.instance = CollectingRaceAgent.New()

return CollectingRaceAgent
