-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preheatsale/agent/PreheatSaleAgent.lua

module("logic.extensions.preheatsale.agent.PreheatSaleAgent", package.seeall)

local PreheatSaleAgent = class("PreheatSaleAgent", BaseAgent)

function PreheatSaleAgent:sendPM_PreheatSaleGetInfoReq(activityIds)
	local req = PreheatSaleExtension_pb.PM_PreheatSaleGetInfoReq()

	for _, v in ipairs(activityIds) do
		req.activityIds:append(v)
	end

	self:sendMsg(req)
end

function PreheatSaleAgent:handlePM_PreheatSaleGetInfoRes(status, msg)
	if status == 0 then
		PreheatSaleController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PreheatSaleError, status)
		printInfo("预热售卖数据回调报错：" .. status)
	end
end

function PreheatSaleAgent:handlePM_PreheatSaleBuyEndRes(status, msg)
	if status == 0 then
		PreheatSaleController.instance:handleFinishPay(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.PreheatSaleError, status)
		printInfo("预热售卖数据回调报错：" .. status)
	end
end

PreheatSaleAgent.instance = PreheatSaleAgent.New()

return PreheatSaleAgent
