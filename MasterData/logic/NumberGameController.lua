-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/controller/NumberGameController.lua

module("logic.extensions.numberbomb.controller.NumberGameController", package.seeall)

local NumberGameController = class("NumberGameController", BaseController)

function NumberGameController:ctor()
	return
end

function NumberGameController:onInit()
	self:onReset()
end

function NumberGameController:onReset()
	self.actiId = nil
	self.prizeId = nil
	self.isFail = nil
end

function NumberGameController:csGetGameBaseInfoReq()
	local actiId = self:_getNumberGameActiId()

	if checknumber(actiId) <= 0 then
		return
	end

	NumberGameAgent.instance:sendPM_NGGetActInfoReq(actiId)
end

function NumberGameController:scSendGameBaseInfo(msg)
	NumberGameModel.instance:scSendGameBaseInfo(msg)
end

function NumberGameController:csBeginMatchGameReq()
	local actiId = self:_getNumberGameActiId()

	if checknumber(actiId) <= 0 then
		return
	end

	NumberGameAgent.instance:sendPM_NGBeginMatchReq(actiId)
end

function NumberGameController:scSendBeginMatchGame()
	NumberGameModel.instance:scSendBeginMatchGame()
end

function NumberGameController:csCancelMatchGameReq(isFail)
	self.isFail = isFail

	NumberGameAgent.instance:sendPM_NGCancelMatchReq()
end

function NumberGameController:scSendCancelMatchGame(status)
	if status ~= 0 then
		FloatWordMgr.instance:show("取消失败")

		return
	end

	NumberGameModel.instance:scSendCancelMatchGame()
end

function NumberGameController:scSendMatchGameFail()
	if self.isFail then
		self.isFail = nil

		return
	end

	NumberGameModel.instance:scSendMatchGameFail()
end

function NumberGameController:scSendGameStart(msg)
	NumberGameModel.instance:scSendAllPlayerData(msg)
end

function NumberGameController:csGameGuessNumberReq(number)
	NumberGameAgent.instance:sendPM_NGGuessNumberReq(number)
end

function NumberGameController:scSendGameOperation(msg)
	NumberGameModel.instance:scSendUpdataPlayerData(msg)
end

function NumberGameController:scSendNumberGameOver(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	NumberGameModel.instance:scSendNumberGameOver(msg)
end

function NumberGameController:csSendGameChatMsgReq(msgId)
	NumberGameAgent.instance:sendPM_NGSendChatMsgReq(msgId)
end

function NumberGameController:scGameChatMsg(msg)
	NumberGameModel.instance:scSendGameChatMsg(msg)
end

function NumberGameController:scSendGameChatAndLeave(msg)
	NumberGameModel.instance:scSendGameChatAndLeave(msg)
end

function NumberGameController:csReceiveGameSocrePrizeReq(prizeId)
	local actiId = self:_getNumberGameActiId()

	if checknumber(actiId) <= 0 then
		return
	end

	self.actiId = actiId
	self.prizeId = prizeId

	NumberGameAgent.instance:sendPM_NGGainScorePrizeReq(actiId, prizeId)
end

function NumberGameController:scGameSocrePrize()
	if checknumber(self.actiId) <= 0 or checknumber(self.prizeId) <= 0 then
		return
	end

	NumberGameModel.instance:scSendGameSocrePrize(self.actiId, self.prizeId)

	self.actiId = nil
	self.prizeId = nil

	NumberGameController.instance:csGetGameBaseInfoReq()
end

function NumberGameController:csSendNGGainProgressPrizeReq(prizeId)
	local actiId = self:_getNumberGameActiId()

	if checknumber(actiId) <= 0 then
		return
	end

	self.actiId = actiId
	self.prizeId = prizeId

	NumberGameAgent.instance:sendPM_NGGainProgressPrizeReq(actiId, prizeId)
end

function NumberGameController:scSendNGGainProgressPrize()
	if checknumber(self.actiId) <= 0 or checknumber(self.prizeId) <= 0 then
		return
	end

	NumberGameModel.instance:scSendNGGainProgressPrize(self.actiId, self.prizeId)

	self.actiId = nil
	self.prizeId = nil
end

function NumberGameController:csGetGameAnnalListReq()
	local actiId = self:_getNumberGameActiId()

	if checknumber(actiId) <= 0 then
		return
	end

	NumberGameAgent.instance:sendPM_NGGetGameRecordReq(actiId)
end

function NumberGameController:scGameAnnalList(msg)
	NumberGameModel.instance:scSendGameAnnalList(msg)
end

function NumberGameController:csGetGameRankListReq()
	local actiId = self:_getNumberGameActiId()

	if checknumber(actiId) <= 0 then
		return
	end

	NumberGameAgent.instance:sendPM_NGGetRankInfoReq(actiId)
end

function NumberGameController:scGameRankList(msg)
	NumberGameModel.instance:scSendGameRankList(msg)
end

function NumberGameController:_getNumberGameActiId()
	local actiId = NumberGameConfig.instance:getOpenActivityId()

	if checknumber(actiId) <= 0 then
		FloatWordMgr.instance:show("活动已结束！")

		return
	end

	return actiId
end

function NumberGameController:startMatch()
	NumberGameModel.instance:clearFinishCallBack()
	UIStateManager.instance:push(ViewName.NumberMatch)
end

function NumberGameController:startMatchView()
	UIStateManager.instance:push(ViewName.NumberMatch)
end

function NumberGameController:startMatchByTourArena(startCallBack, finishCallBack)
	NumberGameModel.instance:clearFinishCallBack()
	NumberGameModel.instance:setFinishCallBack(NumberGameModel.CallBackTypes_MathSuccess, function()
		GameUtil.callBack(startCallBack)
	end)
	NumberGameModel.instance:setFinishCallBack(NumberGameModel.CallBackTypes_GameEnd, function()
		local info = {}
		local isPass = false
		local gameScore = 0
		local overData = NumberGameModel.instance:getAndSetGameOverData(true)

		if overData then
			isPass = true
			gameScore = checknumber(overData.endScore)
		end

		info.isPass = isPass
		info.gameScore = gameScore

		GameUtil.callBack(finishCallBack, info)
	end)

	local commonInfo = NumberGameConfig.instance:getCommonInfo()
	local isOpen = false

	for _, str in ipairs(commonInfo.openTimes) do
		local list = string.split(str, "#")

		if #list >= 2 and GameUtil.checkIsInTimePeriod(list[1], list[2], true) then
			isOpen = true

			break
		end
	end

	if not isOpen then
		FloatWordMgr.instance:show("开放时间 " .. commonInfo.opentimeTips)

		return
	end

	self:startMatchView()
end

NumberGameController.instance = NumberGameController.New()

return NumberGameController
