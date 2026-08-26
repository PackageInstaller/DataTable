-- chunkname: @modules/logic/summon/rpc/SummonRpc.lua

module("modules.logic.summon.rpc.SummonRpc", package.seeall)

local SummonRpc = class("SummonRpc", BaseRpc)

function SummonRpc:sendSummonRequest(poolId, count, guideId, stepId, callback, callbackObj)
	local req = SummonModule_pb.SummonRequest()

	req.poolId = poolId
	req.guideId = guideId or 0
	req.stepId = stepId or 0
	req.count = count

	self:sendMsg(req, callback, callbackObj)

	SummonController.instance.isWaitingSummonResult = true

	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolHistorySummonRequest, poolId, count)
end

function SummonRpc:onReceiveSummonReply(resultCode, msg)
	SummonController.instance.isWaitingSummonResult = false

	if resultCode ~= 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonFailed)
		self:sendGetSummonInfoRequest()

		return
	end

	local summonResult = msg.summonResult

	SummonController.instance:summonSuccess(summonResult)
	SummonController.instance:dispatchEvent(SummonEvent.onReceiveSummonReply, msg)
end

function SummonRpc:sendGetSummonInfoRequest(callback, callbackObj)
	local req = SummonModule_pb.GetSummonInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function SummonRpc:onReceiveGetSummonInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SummonController.instance:updateSummonInfo(msg)
end

function SummonRpc:sendSummonQueryTokenRequest()
	local req = SummonModule_pb.SummonQueryTokenRequest()

	self:sendMsg(req)
end

function SummonRpc:onReceiveSummonQueryTokenReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SummonPoolHistoryController.instance:updateSummonQueryToken(msg)
end

function SummonRpc:sendOpenLuckyBagRequest(luckyBagId, heroId, callback, callbackObj)
	local req = SummonModule_pb.OpenLuckyBagRequest()

	req.luckyBagId = luckyBagId
	req.heroId = heroId

	return self:sendMsg(req, callback, callbackObj)
end

function SummonRpc:onReceiveOpenLuckyBagReply(resultCode, msg)
	if resultCode == 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onLuckyBagOpened)
		self:sendGetSummonInfoRequest()
	end
end

function SummonRpc:sendChooseDoubleUpHeroRequest(poolId, heroIds, callback, callbackObj)
	local req = SummonModule_pb.ChooseMultiUpHeroRequest()

	req.poolId = poolId

	for i, heroId in ipairs(heroIds) do
		req.heroIds:append(heroId)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function SummonRpc:onReceiveChooseMultiUpHeroReply(resultCode, msg)
	if resultCode == 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onCustomPicked)
		self:sendGetSummonInfoRequest()
	end
end

function SummonRpc:sendChooseEnhancedPoolHeroRequest(poolId, heroId, callback, callbackObj)
	local req = SummonModule_pb.ChooseEnhancedPoolHeroRequest()

	req.poolId = poolId
	req.heroId = heroId

	return self:sendMsg(req, callback, callbackObj)
end

function SummonRpc:onReceiveChooseEnhancedPoolHeroReply(resultCode, msg)
	if resultCode == 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onCustomPicked)
		self:sendGetSummonInfoRequest()
	end
end

function SummonRpc:sendGetSummonProgressRewardsRequest(poolId, callback, callbackObj)
	local req = SummonModule_pb.GetSummonProgressRewardsRequest()

	req.poolId = poolId

	return self:sendMsg(req, callback, callbackObj)
end

function SummonRpc:onReceiveGetSummonProgressRewardsReply(resultCode, msg)
	if resultCode == 0 then
		SummonController.instance:summonProgressRewards(msg)
	end
end

function SummonRpc:sendPopUpRecommendWindowRequest(poolId, orderId, callback, callbackObj)
	local req = SummonModule_pb.PopUpRecommendWindowRequest()

	req.poolId = poolId
	req.orderId = orderId

	self:sendMsg(req, callback, callbackObj)
end

function SummonRpc:onReceivePopUpRecommendWindowReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local poolId = msg.poolId
	local popUpCount = msg.popUpCount
	local orderId = msg.orderId

	SummonMainModel.instance:setSummonPoolPackageProp(poolId, orderId, popUpCount)
end

function SummonRpc:sendInfallibleSummonRequest(poolId, callback, callbackObj)
	local req = SummonModule_pb.InfallibleSummonRequest()

	req.poolId = poolId

	self:sendMsg(req, callback, callbackObj)

	SummonController.instance.isWaitingSummonResult = true

	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolHistorySummonRequest, poolId)
end

function SummonRpc:onReceiveInfallibleSummonReply(resultCode, msg)
	SummonController.instance.isWaitingSummonResult = false

	if resultCode ~= 0 then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonFailed)
		self:sendGetSummonInfoRequest()

		return
	end

	local summonResult = msg.summonResult

	SummonController.instance:onInfallibleSummonSuccess(summonResult)
	SummonController.instance:dispatchEvent(SummonEvent.onReceiveSummonReply, msg)
end

function SummonRpc:sendSelectSummonchoosableRewardRequest(poolId, progress, chooseIndex, callback, callbackObj)
	local req = SummonModule_pb.SelectSummonchoosableRewardRequest()

	req.poolId = poolId
	req.progress = progress
	req.chooseIndex = chooseIndex

	self:sendMsg(req, callback, callbackObj)
end

function SummonRpc:onReceiveSelectSummonchoosableRewardReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	SummonController.instance:summonOptionProgressRewards(msg)
end

SummonRpc.instance = SummonRpc.New()

return SummonRpc
