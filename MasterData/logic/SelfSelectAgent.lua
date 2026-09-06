-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anlongselfselect/agent/SelfSelectAgent.lua

module("logic.extensions.selfselect.agent.SelfSelectAgent", package.seeall)

local SelfSelectAgent = class("SelfSelectAgent", BaseAgent)

SelfSelectAgent.PM_NotifySelfSelectBuySucRes = "SelfSelectAgent_PM_NotifySelfSelectBuySucRes"
SelfSelectAgent.PM_SelfSelectGainDailyPrizeRes = "SelfSelectAgent_PM_SelfSelectGainDailyPrizeRes"
SelfSelectAgent.PM_SelfSelectInfoRes = "SelfSelectAgent_PM_SelfSelectInfoRes"

function SelfSelectAgent:sendPM_SelfSelectInfoReq(activityId)
	local req = SelfSelectExtension_pb.PM_SelfSelectInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SelfSelectAgent:handlePM_SelfSelectInfoRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(SelfSelectAgent.PM_SelfSelectInfoRes, status, msg)
end

function SelfSelectAgent:sendPM_SelfSelectGainDailyPrizeReq(activityId)
	local req = SelfSelectExtension_pb.PM_SelfSelectGainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SelfSelectAgent:handlePM_SelfSelectGainDailyPrizeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(SelfSelectAgent.PM_SelfSelectGainDailyPrizeRes, status, msg)
end

function SelfSelectAgent:handlePM_NotifySelfSelectBuySucRes(status, msg)
	if status == 0 then
		-- block empty
	end

	self:dispatch(SelfSelectAgent.PM_NotifySelfSelectBuySucRes, status, msg)
end

SelfSelectAgent.instance = SelfSelectAgent.New()

return SelfSelectAgent
