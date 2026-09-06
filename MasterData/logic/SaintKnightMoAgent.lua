-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightmo/agent/SaintKnightMoAgent.lua

module("logic.extensions.saintknightmo.agent.SaintKnightMoAgent", package.seeall)

local SaintKnightMoAgent = class("SaintKnightMoAgent", BaseAgent)

function SaintKnightMoAgent:sendPM_SaintKnightMoInfoReq()
	local req = SaintKnightMoExtension_pb.PM_SaintKnightMoInfoReq()

	self:sendMsg(req)
end

function SaintKnightMoAgent:handlePM_SaintKnightMoInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SaintKnightMoInfoRes, msg)
	end
end

function SaintKnightMoAgent:sendPM_SaintKnightMoGainPrizeReq()
	local req = SaintKnightMoExtension_pb.PM_SaintKnightMoGainPrizeReq()

	self:sendMsg(req)
end

function SaintKnightMoAgent:handlePM_SaintKnightMoGainPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SaintKnightMoGainPrizeRes)
	end
end

SaintKnightMoAgent.instance = SaintKnightMoAgent.New()

return SaintKnightMoAgent
