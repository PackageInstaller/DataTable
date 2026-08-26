-- chunkname: @modules/logic/versionactivity3_5/schoolstart/rpc/V3a5_SchoolStartRpc.lua

module("modules.logic.versionactivity3_5.schoolstart.rpc.V3a5_SchoolStartRpc", package.seeall)

local V3a5_SchoolStartRpc = class("V3a5_SchoolStartRpc", BaseRpc)

function V3a5_SchoolStartRpc:sendGet228InfoRequest(activityId, callback, callbackObj)
	local req = Activity228Module_pb.GetAct228InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function V3a5_SchoolStartRpc:onReceiveGetAct228InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a5_SchoolStartModel.instance:setAct228Info(msg)
	V3a5_SchoolStartController.instance:dispatchEvent(V3a5_SchoolStartEvent.OnGetInfoReply)
end

function V3a5_SchoolStartRpc:sendAct228FlipGridRequest(activityId, row, col)
	local req = Activity228Module_pb.Act228FlipGridRequest()

	req.activityId = activityId
	req.row = row
	req.column = col

	self:sendMsg(req)
end

function V3a5_SchoolStartRpc:onReceiveAct228FlipGridGridReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a5_SchoolStartModel.instance:updatePosState(msg)
	V3a5_SchoolStartController.instance:setRummageReward(ViewName.CommonPropView, msg.bonuses)
	V3a5_SchoolStartController.instance:dispatchEvent(V3a5_SchoolStartEvent.OnFlipGridGridReply)
end

function V3a5_SchoolStartRpc:sendAct228GetFinalBonusRequest(activityId)
	local req = Activity228Module_pb.Act228GetFinalBonusRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function V3a5_SchoolStartRpc:onReceiveAct228GetFinalBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	V3a5_SchoolStartModel.instance:updateFinalState()
	V3a5_SchoolStartController.instance:setRummageReward(ViewName.CommonPropView, msg.bonuses)
	V3a5_SchoolStartController.instance:popupRewardView()
	V3a5_SchoolStartModel.instance:clearChangeIndexList()
	V3a5_SchoolStartController.instance:dispatchEvent(V3a5_SchoolStartEvent.OnGetBigRewardReply)
end

V3a5_SchoolStartRpc.instance = V3a5_SchoolStartRpc.New()

return V3a5_SchoolStartRpc
