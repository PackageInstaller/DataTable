-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paystrengthen/agent/PayStrengthenAgent.lua

module("logic.extensions.paystrengthen.agent.PayStrengthenAgent", package.seeall)

local PayStrengthenAgent = class("PayStrengthenAgent", BaseAgent)

function PayStrengthenAgent:sendPM_ActivityPayStrengthenInfoReq(activityId)
	local req = PayStrengthenExtension_pb.PM_ActivityPayStrengthenInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PayStrengthenAgent:handlePM_ActivityPayStrengthenInfoRes(status, msg)
	if status == 0 then
		PayStrengthenModel.instance:onActivityPayStrengthenInfoRes(msg.activityId, msg)
		GlobalDispatcher:dispatch(GlobalNotify.onActivityPayStrengthenInfoRes)
	end
end

function PayStrengthenAgent:sendPM_CommonBuyItemReq(type, param)
	local req = PayStrengthenExtension_pb.PM_CommonBuyItemReq()

	req.type = type
	req.param = param

	self:sendMsg(req)
end

function PayStrengthenAgent:handlePM_CommonBuyItemRes(status, msg)
	if status == 0 then
		local res = msg.res
		local type = res.type

		PayStrengthenModel.instance:addInfoIsLimit(type)
		GlobalDispatcher:dispatch(GlobalNotify.onNotifyCommonPayStrengthenSucRes, msg.res.type, msg.res.param)
	end
end

function PayStrengthenAgent:sendPM_ActivityBuyItemReq(type, param, activityId)
	local req = PayStrengthenExtension_pb.PM_ActivityBuyItemReq()

	req.type = type
	req.param = param
	req.activityId = activityId

	self:sendMsg(req)
end

function PayStrengthenAgent:handlePM_ActivityBuyItemRes(status, msg)
	if status == 0 then
		PayStrengthenModel.instance:onNotifyActivityPayStrengthenSucRes(msg.res)
		GlobalDispatcher:dispatch(GlobalNotify.onNotifyActivityPayStrengthenSucRes, msg.res.type, msg.res.param)
	end
end

function PayStrengthenAgent:handlePM_NotifyCommonPayStrengthenSucRes(status, msg)
	if status == 0 then
		local type = msg.type

		PayStrengthenModel.instance:addInfoIsLimit(type)
		GlobalDispatcher:dispatch(GlobalNotify.onNotifyCommonPayStrengthenSucRes, msg.type, msg.param)
	end
end

function PayStrengthenAgent:handlePM_NotifyActivityPayStrengthenSucRes(status, msg)
	if status == 0 then
		PayStrengthenModel.instance:onNotifyActivityPayStrengthenSucRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.onNotifyActivityPayStrengthenSucRes, msg.type, msg.param)
	end
end

function PayStrengthenAgent:sendPM_CommonStrengthenTimesLimitInfoReq(activityId)
	local req = PayStrengthenExtension_pb.PM_CommonStrengthenTimesLimitInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PayStrengthenAgent:handlePM_CommonStrengthenTimesLimitInfoRes(status, msg)
	if status == 0 then
		PayStrengthenModel.instance:onActivityPayStrengthenTimeLimitInfo(msg.activityId, msg)
		GlobalDispatcher:dispatch(GlobalNotify.onActivityPayStrengthenInfoRes)
	end
end

PayStrengthenAgent.instance = PayStrengthenAgent.New()

return PayStrengthenAgent
