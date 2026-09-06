-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/controller/FanRuiLotteryController.lua

module("logic.extensions.fanruilottery.controller.FanRuiLotteryController", package.seeall)

local FanRuiLotteryController = class("FanRuiLotteryController", BaseController)

function FanRuiLotteryController:ctor()
	return
end

function FanRuiLotteryController:onInit()
	GlobalDispatcher:addListener(FanRuiLotteryAgent.handlePM_FanRuiLotteryGetInfoRes, self._handlePM_FanRuiLotteryGetInfoRes, self)
	GlobalDispatcher:addListener(FanRuiLotteryAgent.handlePM_FanRuiLotteryLotteryRes, self._handlePM_FanRuiLotteryLotteryRes, self)
	GlobalDispatcher:addListener(FanRuiLotteryAgent.handlePM_FanRuiLotteryStartGameRes, self._handlePM_FanRuiLotteryStartGameRes, self)
	GlobalDispatcher:addListener(FanRuiLotteryAgent.handlePM_FanRuiLotteryEndGameRes, self._handlePM_FanRuiLotteryEndGameRes, self)
	GlobalDispatcher:addListener(FanRuiLotteryAgent.handlePM_FanRuiLotteryExchangeRes, self._handlePM_FanRuiLotteryExchangeRes, self)
	self:onReset()
end

function FanRuiLotteryController:onReset()
	return
end

function FanRuiLotteryController:_handlePM_FanRuiLotteryGetInfoRes(msg)
	FanRuiLotteryModel.instance:setData(msg)
	self:checkRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FanRuiLotteryGetInfoRes)
end

function FanRuiLotteryController:_handlePM_FanRuiLotteryLotteryRes(msg)
	FanRuiLotteryModel.instance:setGetLotteryPrize(msg)
	self:checkRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FanRuiLotteryLotteryRes, msg.changeSetId, msg.prizeId)
end

function FanRuiLotteryController:sendPM_FanRuiLotteryStartGameReq(actId, useCheatItem, chipCount)
	local clientKey = math.random(1, 100000)

	FanRuiLotteryModel.instance:saveClientKey(clientKey)
	FanRuiLotteryAgent.instance:sendPM_FanRuiLotteryStartGameReq(actId, useCheatItem, chipCount, clientKey)
end

function FanRuiLotteryController:_handlePM_FanRuiLotteryStartGameRes(msg)
	FanRuiLotteryModel.instance:saveServerKey(msg.serverKey)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FanRuiLotteryStartGameRes)
end

function FanRuiLotteryController:sendPM_FanRuiLotteryEndGameReq(actId, isWin)
	local encryptedKey = 0
	local clientKey = FanRuiLotteryModel.instance:getClientKey()
	local serverKey = bit.bxor(FanRuiLotteryModel.instance:getServerKey(), clientKey)
	local winIndex = 0

	winIndex = isWin and isWin == true and 1 or 0
	encryptedKey = winIndex % 2 == 0 and encryptedKey + (winIndex + serverKey) * 5381 or encryptedKey + (winIndex + clientKey) * 31

	FanRuiLotteryAgent.instance:sendPM_FanRuiLotteryEndGameReq(actId, winIndex, encryptedKey)
end

function FanRuiLotteryController:_handlePM_FanRuiLotteryEndGameRes(msg)
	if msg.changeSetId and checknumber(msg.changeSetId) > 0 then
		self:checkRedPoint()
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FanRuiLotteryEndGameRes, msg.changeSetId)
end

function FanRuiLotteryController:_handlePM_FanRuiLotteryExchangeRes(msg)
	FanRuiLotteryModel.instance:setNextExchangeTime(msg)
	self:checkRedPoint()
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_FanRuiLotteryExchangeRes)
end

function FanRuiLotteryController:getInfo()
	local actId = FanRuiLotteryModel.instance:getCurrActId()

	if actId then
		FanRuiLotteryAgent.instance:sendPM_FanRuiLotteryGetInfoReq(actId)
	else
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_FANRUI_LOTTERY_LOTTERYABLE, false)
	end
end

function FanRuiLotteryController:checkRedPoint()
	local actId = FanRuiLotteryModel.instance:getCurrActId()
	local isCanGetPrize = false
	local actCfg = FanRuiLotteryConfig.instance:getActivityCfg(actId)
	local prizeList = FanRuiLotteryConfig.instance:getLotteryPrize(actId)

	for i, v in ipairs(prizeList) do
		if not FanRuiLotteryModel.instance:getIsGetPrize(v.prizeId) then
			isCanGetPrize = true
		end
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(actCfg.lotteryCost)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_FANRUI_LOTTERY_LOTTERYABLE, (MaterialModel.instance:IsEnough(matType, matId, matNum) == false or nil) and false)
end

FanRuiLotteryController.instance = FanRuiLotteryController.New()

return FanRuiLotteryController
