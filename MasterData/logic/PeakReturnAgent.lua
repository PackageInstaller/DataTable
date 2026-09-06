-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/agent/PeakReturnAgent.lua

module("logic.extensions.peakreturn.agent.PeakReturnAgent", package.seeall)

local PeakReturnAgent = class("PeakReturnAgent", BaseAgent)

function PeakReturnAgent:sendPM_PeakReturnGetInfoReq(actId)
	local req = PeakReturnExtension_pb.PM_PeakReturnGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakReturnAgent:handlePM_PeakReturnGetInfoRes(status, msg)
	if status == 0 then
		local data = GameUtil.pbToTable(msg) or {}

		GlobalDispatcher:dispatch(GlobalNotify.UpdataPeakDiamondInfo, data)
	end
end

function PeakReturnAgent:sendPM_PeakReturnGainPrizeReq(actId)
	local req = PeakReturnExtension_pb.PM_PeakReturnGainPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function PeakReturnAgent:handlePM_PeakReturnGainPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataPeakDiamondPrize, true)
	end
end

PeakReturnAgent.instance = PeakReturnAgent.New()

return PeakReturnAgent
