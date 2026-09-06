-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/agent/GoddessCollectorAgent.lua

module("logic.extensions.goddesscollector.agent.GoddessCollectorAgent", package.seeall)

local GoddessCollectorAgent = class("GoddessCollectorAgent", BaseAgent)

GoddessCollectorAgent.PM_GoddessCollectorVerifyPetsRes = "GoddessCollectorAgent_PM_GoddessCollectorVerifyPetsRes"
GoddessCollectorAgent.PM_GoddessCollectorGainPrizeRes = "GoddessCollectorAgent_PM_GoddessCollectorGainPrizeRes"
GoddessCollectorAgent.PM_GoddessCollectorGetInfoRes = "GoddessCollectorAgent_PM_GoddessCollectorGetInfoRes"

function GoddessCollectorAgent:sendPM_GoddessCollectorGetInfoReq(activityId)
	local req = GoddessCollectorExtension_pb.PM_GoddessCollectorGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessCollectorAgent:handlePM_GoddessCollectorGetInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(GoddessCollectorAgent.PM_GoddessCollectorGetInfoRes, status, msg)
end

function GoddessCollectorAgent:sendPM_GoddessCollectorGainPrizeReq(activityId, prizeType, prizeId)
	local req = GoddessCollectorExtension_pb.PM_GoddessCollectorGainPrizeReq()

	req.activityId = activityId
	req.prizeType = prizeType
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GoddessCollectorAgent:handlePM_GoddessCollectorGainPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(GoddessCollectorAgent.PM_GoddessCollectorGainPrizeRes, status, msg)
end

function GoddessCollectorAgent:sendPM_GoddessCollectorVerifyPetsReq(activityId)
	local req = GoddessCollectorExtension_pb.PM_GoddessCollectorVerifyPetsReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessCollectorAgent:handlePM_GoddessCollectorVerifyPetsRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(GoddessCollectorAgent.PM_GoddessCollectorVerifyPetsRes, status, msg)
end

function GoddessCollectorAgent:sendPM_GoddessCollectorRankReq(activityId)
	local req = GoddessCollectorExtension_pb.PM_GoddessCollectorRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessCollectorAgent:handlePM_GoddessCollectorRankRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GoddesscollectorModel.instance:setRankInfos(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GoddessCollectorRank)
end

GoddessCollectorAgent.instance = GoddessCollectorAgent.New()

return GoddessCollectorAgent
