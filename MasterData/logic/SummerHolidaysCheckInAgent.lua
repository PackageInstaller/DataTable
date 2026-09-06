-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerholidayscheckin/agent/SummerHolidaysCheckInAgent.lua

module("logic.extensions.summerholidayscheckin.agent.SummerHolidaysCheckInAgent", package.seeall)

local SummerHolidaysCheckInAgent = class("SummerHolidaysCheckInAgent", BaseAgent)

SummerHolidaysCheckInAgent.SummerHolidaysCheckInGetInfoRes = "SummerHolidaysCheckInAgent.SummerHolidaysCheckInGetInfoRes"
SummerHolidaysCheckInAgent.SummerHolidaysCheckInStampRes = "SummerHolidaysCheckInAgent.SummerHolidaysCheckInStampRes"
SummerHolidaysCheckInAgent.SummerHolidaysCheckInGainPrizeRes = "SummerHolidaysCheckInAgent.SummerHolidaysCheckInGainPrizeRes"

function SummerHolidaysCheckInAgent:sendPM_SummerHolidaysCheckInGetInfoReq(activityId)
	local req = SummerHolidaysCheckInExtension_pb.PM_SummerHolidaysCheckInGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummerHolidaysCheckInAgent:handlePM_SummerHolidaysCheckInGetInfoRes(status, msg)
	if status == 0 then
		SummerholidayscheckinModel.instance:setInfo(msg)
		SummerholidayscheckinController.instance:setCheckInRedpoint()
		GlobalDispatcher:dispatch(SummerHolidaysCheckInAgent.SummerHolidaysCheckInGetInfoRes)
	end
end

function SummerHolidaysCheckInAgent:sendPM_SummerHolidaysCheckInStampReq(activityId)
	local req = SummerHolidaysCheckInExtension_pb.PM_SummerHolidaysCheckInStampReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummerHolidaysCheckInAgent:handlePM_SummerHolidaysCheckInStampRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("盖章成功")

		local activityid = msg.activityId

		SummerholidayscheckinModel.instance:addCheckInTimes(activityid)
		SummerholidayscheckinController.instance:setCheckInRedpoint()
		GlobalDispatcher:dispatch(SummerHolidaysCheckInAgent.SummerHolidaysCheckInStampRes)
	end
end

function SummerHolidaysCheckInAgent:sendPM_SummerHolidaysCheckInGainPrizeReq(activityId)
	local req = SummerHolidaysCheckInExtension_pb.PM_SummerHolidaysCheckInGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummerHolidaysCheckInAgent:handlePM_SummerHolidaysCheckInGainPrizeRes(status, msg)
	if status == 0 then
		SummerholidayscheckinModel.instance:addGainPrize(msg.prizeId)
		GlobalDispatcher:dispatch(SummerHolidaysCheckInAgent.SummerHolidaysCheckInGainPrizeRes)
	end
end

SummerHolidaysCheckInAgent.instance = SummerHolidaysCheckInAgent.New()

return SummerHolidaysCheckInAgent
