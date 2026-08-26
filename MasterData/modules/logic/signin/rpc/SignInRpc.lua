-- chunkname: @modules/logic/signin/rpc/SignInRpc.lua

module("modules.logic.signin.rpc.SignInRpc", package.seeall)

local SignInRpc = class("SignInRpc", BaseRpc)

function SignInRpc:sendGetSignInInfoRequest(callback, callbackObj)
	local req = SignInModule_pb.GetSignInInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function SignInRpc:onReceiveGetSignInInfoReply(resultCode, msg)
	if resultCode == 0 then
		SignInModel.instance:setSignInInfo(msg)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInInfo)
	end
end

function SignInRpc:sendSignInRequest()
	local req = SignInModule_pb.SignInRequest()

	self:sendMsg(req)
end

function SignInRpc:onReceiveSignInReply(resultCode, msg)
	if resultCode == 0 then
		SignInModel.instance:setSignDayRewardGet(msg)
		SignInController.instance:checkShowSigninReward(msg)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInReply)
		ChargeRpc.instance:sendGetMonthCardInfoRequest()
	end
end

function SignInRpc:sendSignInAddupRequest(id)
	local req = SignInModule_pb.SignInAddupRequest()

	req.id = id

	self:sendMsg(req)
end

function SignInRpc:onReceiveSignInAddupReply(resultCode, msg)
	if resultCode == 0 then
		SignInModel.instance:setSignTotalRewardGet(msg.id)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInAddUp)
	end
end

function SignInRpc:sendSignInHistoryRequest(month)
	local req = SignInModule_pb.SignInHistoryRequest()

	req.month = month

	self:sendMsg(req)
end

function SignInRpc:onReceiveSignInHistoryReply(resultCode, msg)
	if resultCode == 0 then
		SignInModel.instance:setSignInHistory(msg)
		SignInController.instance:dispatchEvent(SignInEvent.GetHistorySignInSuccess, msg.month)
	end
end

function SignInRpc:sendGetHeroBirthdayRequest(heroId)
	local req = SignInModule_pb.GetHeroBirthdayRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function SignInRpc:onReceiveGetHeroBirthdayReply(resultCode, msg)
	if resultCode == 0 then
		SignInModel.instance:setHeroBirthdayGet(msg.heroId)
		SignInModel.instance:addSignInBirthdayCount(msg.heroId)
		SignInController.instance:dispatchEvent(SignInEvent.GetHeroBirthday)
	end
end

function SignInRpc:sendSignInTotalRewardRequest(id, callback, callbackObj)
	local req = SignInModule_pb.SignInTotalRewardRequest()

	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function SignInRpc:onReceiveSignInTotalRewardReply(resultCode, msg)
	if resultCode == 0 then
		SignInModel.instance:onReceiveSignInTotalRewardReply(msg)
		SignInController.instance:dispatchEvent(SignInEvent.OnSignInTotalRewardReply, msg.id)
	end
end

function SignInRpc:sendSignInTotalRewardAllRequest(callback, callbackObj)
	local req = SignInModule_pb.SignInTotalRewardAllRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function SignInRpc:onReceiveSignInTotalRewardAllReply(resultCode, msg)
	if resultCode == 0 then
		SignInModel.instance:onReceiveSignInTotalRewardAllReply(msg)
		SignInController.instance:dispatchEvent(SignInEvent.OnReceiveSignInTotalRewardAllReply)
	end
end

function SignInRpc:sendSupplementMonthCardRequest(callback, callbackObj)
	local req = SignInModule_pb.SupplementMonthCardRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function SignInRpc:onReceiveSupplementMonthCardReply(resultCode, msg)
	if resultCode == 0 then
		SignInModel.instance:setSupplementMonthCard(msg.days)
		SignInController.instance:dispatchEvent(SignInEvent.OnReceiveSupplementMonthCardReply)
	end
end

SignInRpc.instance = SignInRpc.New()

return SignInRpc
