-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redstargodsell/agent/MonopolySaleAgent.lua

module("logic.extensions.monopolysale.agent.MonopolySaleAgent", package.seeall)

local MonopolySaleAgent = class("MonopolySaleAgent", BaseAgent)

function MonopolySaleAgent:sendPM_GetMonopolySaleGiftInfoReq(activityId)
	local req = MonopolySaleExtension_pb.PM_GetMonopolySaleGiftInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MonopolySaleAgent:handlePM_GetMonopolySaleGiftInfoRes(status, msg)
	if status == 0 then
		RedstargodsellController.instance:handleInfo(msg)
	end
end

function MonopolySaleAgent:handlePM_NotifyBuyMonopolySaleGiftRes(status, msg)
	if status == 0 then
		RedstargodsellController.instance:handleNotifyBuyGift(msg)
	end
end

MonopolySaleAgent.instance = MonopolySaleAgent.New()

return MonopolySaleAgent
