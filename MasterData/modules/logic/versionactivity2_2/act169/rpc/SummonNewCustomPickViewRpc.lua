-- chunkname: @modules/logic/versionactivity2_2/act169/rpc/SummonNewCustomPickViewRpc.lua

module("modules.logic.versionactivity2_2.act169.rpc.SummonNewCustomPickViewRpc", package.seeall)

local SummonNewCustomPickViewRpc = class("SummonNewCustomPickViewRpc", BaseRpc)

function SummonNewCustomPickViewRpc:sendGet169InfoRequest(activityId, callBack, callBackObj)
	local req = Activity169Module_pb.Get169InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callBack, callBackObj)
end

function SummonNewCustomPickViewRpc:onReceiveGet169InfoReply(resultCode, msg)
	if resultCode == 0 then
		SummonNewCustomPickViewModel.instance:onGetInfo(msg.activityId, msg.heroId)
		SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnGetServerInfoReply, msg.activityId, msg.heroId)
	end
end

function SummonNewCustomPickViewRpc:sendAct169SummonRequest(activityId, heroId)
	local req = Activity169Module_pb.Act169SummonRequest()

	req.activityId = activityId
	req.heroId = heroId or 0

	self:sendMsg(req)
end

function SummonNewCustomPickViewRpc:onReceiveAct169SummonReply(resultCode, msg)
	if resultCode == 0 then
		if not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
			SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnSummonCustomGet, msg.activityId, msg.heroId)
		end

		SummonNewCustomPickViewModel.instance:setReward(msg.activityId, msg.heroId)
		SummonNewCustomPickViewModel.instance:setGetRewardFxState(msg.activityId, true)
		SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnGetReward, msg.activityId, msg.heroId)
		CharacterModel.instance:setGainHeroViewShowState(false)
	end
end

SummonNewCustomPickViewRpc.instance = SummonNewCustomPickViewRpc.New()

return SummonNewCustomPickViewRpc
