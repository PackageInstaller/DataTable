-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/agent/FameHallAgent.lua

module("logic.extensions.famehall.agent.FameHallAgent", package.seeall)

local FameHallAgent = class("FameHallAgent", BaseAgent)

function FameHallAgent:sendPM_FameHallGetInfoReq(type, periodId)
	local req = FameHallExtension_pb.PM_FameHallGetInfoReq()

	req.type = type

	if periodId then
		req.periodId = periodId
	end

	self:sendMsg(req)
end

function FameHallAgent:handlePM_FameHallGetInfoRes(status, msg)
	if status == 0 then
		FameHallController.instance:handlePM_FameHallGetInfoRes(msg)
	end
end

FameHallAgent.instance = FameHallAgent.New()

return FameHallAgent
