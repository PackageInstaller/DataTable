-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/generalworldprogress/agent/GeneralWorldProgressAgent.lua

module("logic.extensions.generalworldprogress.agent.GeneralWorldProgressAgent", package.seeall)

local GeneralWorldProgressAgent = class("GeneralWorldProgressAgent", BaseAgent)

function GeneralWorldProgressAgent:sendPM_GeneralWorldProgressGetInfoReq(actId)
	local req = GeneralWorldProgressExtension_pb.PM_GeneralWorldProgressGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function GeneralWorldProgressAgent:handlePM_GeneralWorldProgressGetInfoRes(status, msg)
	if status == 0 then
		GeneralWorldProgressController.instance:handleGetInfo(msg)
	end
end

function GeneralWorldProgressAgent:sendPM_GeneralWorldProgressGainReq(actId, prizeId, oneKeyGain)
	local req = GeneralWorldProgressExtension_pb.PM_GeneralWorldProgressGainReq()

	req.actId = actId
	req.prizeId = prizeId
	req.oneKeyGain = oneKeyGain

	self:sendMsg(req)
end

function GeneralWorldProgressAgent:handlePM_GeneralWorldProgressGainRes(status, msg)
	if status == 0 then
		GeneralWorldProgressController.instance:handleGainPrize(msg)
	end
end

GeneralWorldProgressAgent.instance = GeneralWorldProgressAgent.New()

return GeneralWorldProgressAgent
