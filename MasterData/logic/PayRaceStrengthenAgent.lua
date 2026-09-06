-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payracestrengthen/agent/PayRaceStrengthenAgent.lua

module("logic.extensions.payracestrengthen.agent.PayRaceStrengthenAgent", package.seeall)

local PayRaceStrengthenAgent = class("PayRaceStrengthenAgent", BaseAgent)

function PayRaceStrengthenAgent:sendPM_PayRaceStrengthenInfoReq()
	local req = PayRaceStrengthenExtension_pb.PM_PayRaceStrengthenInfoReq()

	self:sendMsg(req)
end

function PayRaceStrengthenAgent:handlePM_PayRaceStrengthenInfoRes(status, msg)
	if status == 0 then
		PayRaceStrenthenModel.instance:onPayRaceStrengthenInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PayRaceStrengthenInfoRes)
	end
end

function PayRaceStrengthenAgent:handleNotifyPayRaceStrengthenSucRes(status, msg)
	if status == 0 then
		PayRaceStrenthenModel.instance:onNotifyPayRaceStrengthenSucRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyPayRaceStrengthenSucRes)
	end
end

PayRaceStrengthenAgent.instance = PayRaceStrengthenAgent.New()

return PayRaceStrengthenAgent
