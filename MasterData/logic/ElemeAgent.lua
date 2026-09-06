-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/agent/ElemeAgent.lua

module("logic.extensions.eleme.agent.ElemeAgent", package.seeall)

local ElemeAgent = class("ElemeAgent", BaseAgent)

function ElemeAgent:ctor()
	return
end

function ElemeAgent:setExtId(extId)
	ElemeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ElemeAgent:sendPM_ElemeInfoReq(activityId)
	local req = ElemeExtension_pb.PM_ElemeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ElemeAgent:handlePM_ElemeInfoRes(status, msg)
	if status == 0 then
		ElemeController.instance:onGetInfo(msg)
	end
end

function ElemeAgent:sendPM_ElemeRefreshOrderReq(activityId, index)
	local req = ElemeExtension_pb.PM_ElemeRefreshOrderReq()

	req.activityId = activityId
	req.index = index

	self:sendMsg(req)
end

function ElemeAgent:handlePM_ElemeRefreshOrderRes(status, msg)
	if status == 0 then
		ElemeController.instance:onRefreshOrder(msg)
	end
end

function ElemeAgent:sendPM_ElemeTakeOrderReq(activityId, index)
	local req = ElemeExtension_pb.PM_ElemeTakeOrderReq()

	req.activityId = activityId
	req.index = index

	self:sendMsg(req)
end

function ElemeAgent:handlePM_ElemeTakeOrderRes(status, msg)
	if status == 0 then
		ElemeController.instance:onTakeOrder(msg)
	end
end

function ElemeAgent:sendPM_ElemeFightReq(activityId, index, form_pb)
	local req = ElemeExtension_pb.PM_ElemeFightReq()

	req.activityId = activityId
	req.index = index

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function ElemeAgent:handlePM_ElemeFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ElemeAgent:sendPM_ElemeGainPrizeReq(activityId, prizeId)
	local req = ElemeExtension_pb.PM_ElemeGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ElemeAgent:handlePM_ElemeGainPrizeRes(status, msg)
	if status == 0 then
		ElemeController.instance:onGetPrize(msg)
	end
end

function ElemeAgent:handlePM_NotifyElemeFightFinishRes(status, msg)
	ElemeController.instance:onFightEnd(msg)
end

ElemeAgent.instance = ElemeAgent.New()

return ElemeAgent
