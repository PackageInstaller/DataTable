-- chunkname: @modules/logic/turnback/rpc/TurnbackRpc.lua

module("modules.logic.turnback.rpc.TurnbackRpc", package.seeall)

local TurnbackRpc = class("TurnbackRpc", BaseRpc)

function TurnbackRpc:sendGetTurnbackInfoRequest(callback, callbackObj)
	local req = TurnbackModule_pb.GetTurnbackInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function TurnbackRpc:onReceiveGetTurnbackInfoReply(resultCold, msg)
	if resultCold == 0 then
		TurnbackModel.instance:setTurnbackInfo(msg.info)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshView)
	end
end

function TurnbackRpc:sendTurnbackFirstShowRequest(turnbackId)
	local req = TurnbackModule_pb.TurnbackFirstShowRequest()

	req.id = turnbackId

	return self:sendMsg(req)
end

function TurnbackRpc:onReceiveTurnbackFirstShowReply(resultCold, msg)
	if resultCold == 0 then
		-- block empty
	end
end

function TurnbackRpc:sendTurnbackBonusPointRequest(param)
	local req = TurnbackModule_pb.TurnbackBonusPointRequest()

	req.id = param.id
	req.bonusPointId = param.bonusPointId

	return self:sendMsg(req)
end

function TurnbackRpc:onReceiveTurnbackBonusPointReply(resultCold, msg)
	if resultCold == 0 then
		TurnbackModel.instance:updateHasGetTaskBonus(msg)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshTaskRewardItem)
	end
end

function TurnbackRpc:sendTurnbackOnceBonusRequest(turnbackId, callback, callbackObj)
	local req = TurnbackModule_pb.TurnbackOnceBonusRequest()

	req.id = turnbackId

	return self:sendMsg(req, callback, callbackObj)
end

function TurnbackRpc:onReceiveTurnbackOnceBonusReply(resultCold, msg)
	if resultCold == 0 then
		TurnbackModel.instance:setOnceBonusGetState()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshOnceBonusGetState)
	end
end

function TurnbackRpc:sendTurnbackSignInRequest(turnbackId, signInDay)
	local req = TurnbackModule_pb.TurnbackSignInRequest()

	req.id = turnbackId
	req.day = signInDay

	return self:sendMsg(req)
end

function TurnbackRpc:onReceiveTurnbackSignInReply(resultCode, msg)
	if resultCode == 0 then
		TurnbackSignInModel.instance:updateSignInInfoState(msg.day, TurnbackEnum.SignInState.HasGet)
		TurnbackModel.instance:setLastGetSigninReward(msg.day)

		if TurnbackModel.instance:getCurTurnbackId() > 2 then
			TurnbackController.instance:dispatchEvent(TurnbackEvent.OnSignInReply, {
				isNormal = false,
				day = msg.day
			})
		else
			TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshSignInItem)
		end
	end
end

function TurnbackRpc:onReceiveTurnbackAdditionPush(resultCode, msg)
	if resultCode == 0 then
		local turnbackInfoMo = TurnbackModel.instance:getCurTurnbackMoWithNilError()

		if turnbackInfoMo and turnbackInfoMo.id == msg.id then
			turnbackInfoMo:setRemainAdditionCount(msg.remainAdditionCount)
		end
	end
end

function TurnbackRpc:sendBuyDoubleBonusRequest(turnbackId)
	local req = TurnbackModule_pb.BuyDoubleBonusRequest()

	req.id = turnbackId

	return self:sendMsg(req)
end

function TurnbackRpc:onReceiveBuyDoubleBonusReply(resultCode, msg)
	if resultCode == 0 then
		TurnbackController.instance:showPopupView(msg.doubleBonus)
		TurnbackModel.instance:setBuyDoubleBonus()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.AfterBuyDoubleReward)
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	end
end

function TurnbackRpc:sendFinishReadTaskRequest(id)
	return TaskRpc.instance:sendFinishReadTaskRequest(id)
end

function TurnbackRpc:sendGetTurnbackDailyBonusRequest(turnbackId)
	local req = TurnbackModule_pb.GetTurnbackDailyBonusRequest()

	req.id = turnbackId

	return self:sendMsg(req)
end

function TurnbackRpc:onReceiveGetTurnbackDailyBonusReply(resultCode, msg)
	if resultCode == 0 then
		TurnbackModel.instance:setDailyBonus(msg.day)
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.AfterReceiveDayFree)
	end
end

function TurnbackRpc:sendAcceptAllTurnbackBonusPointRequest(turnbackId)
	local req = TurnbackModule_pb.AcceptAllTurnbackBonusPointRequest()

	req.id = turnbackId

	return self:sendMsg(req)
end

function TurnbackRpc:onReceiveAcceptAllTurnbackBonusPointReply(resultCode, msg)
	if resultCode == 0 then
		TurnbackModel.instance:updateHasGetTaskBonus(msg)

		if TurnbackModel.instance:checkHasGetAllTaskReward() and not TurnbackModel.instance:getBuyDoubleBonus() then
			TurnbackModel.instance:setOpenPopTipView(true)
		end

		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshTaskRewardItem)
	end
end

function TurnbackRpc:sendTurnbackReturnRewardRequest(turnbackId, rewardId)
	local req = TurnbackModule_pb.TurnbackReturnRewardRequest()

	req.id = turnbackId
	req.rewardId = rewardId

	return self:sendMsg(req)
end

function TurnbackRpc:onReceiveTurnbackReturnRewardReply(resultCode, msg)
	if resultCode == 0 then
		TurnbackModel.instance:onGetResourceReturnReward(msg.hasGetReturnRewardIds)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.OnTurnbackReturnRewardReply)
	end
end

function TurnbackRpc:sendAcceptAllTurnbackReturnRewardRequest(turnbackId)
	local req = TurnbackModule_pb.AcceptAllTurnbackReturnRewardRequest()

	req.id = turnbackId

	return self:sendMsg(req)
end

function TurnbackRpc:onReceiveAcceptAllTurnbackReturnRewardReply(resultCode, msg)
	if resultCode == 0 then
		TurnbackModel.instance:onGetResourceReturnReward(msg.hasGetReturnRewardIds)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.OnTurnbackReturnRewardReply)
	end
end

TurnbackRpc.instance = TurnbackRpc.New()

return TurnbackRpc
