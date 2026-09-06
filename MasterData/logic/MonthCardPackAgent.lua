-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcardspack/agent/MonthCardPackAgent.lua

module("logic.extensions.monthcardspack.agent.MonthCardPackAgent", package.seeall)

local MonthCardPackAgent = class("MonthCardPackAgent", BaseAgent)

function MonthCardPackAgent:sendPM_MonthCardPackGetInfoReq(activityId)
	local req = MonthCardPackExtension_pb.PM_MonthCardPackGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MonthCardPackAgent:handlePM_MonthCardPackGetInfoRes(status, msg)
	MonthCardPackController.instance:onMonthCardPackGetInfo(status, msg)
end

MonthCardPackAgent.instance = MonthCardPackAgent.New()

return MonthCardPackAgent
