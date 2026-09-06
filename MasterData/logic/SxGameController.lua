-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/controller/SxGameController.lua

module("logic.extensions.sxgame.controller.SxGameController", package.seeall)

local SxGameController = class("SxGameController", BaseController)

function SxGameController:ctor()
	return
end

function SxGameController:onInit()
	self._stateFsm = SxGameStateFSM.New()

	self._stateFsm:onInit()
	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadData, self)
end

function SxGameController:onReset()
	self.sxGameInfo = nil
end

function SxGameController:initMapData()
	return
end

function SxGameController:add2Queue()
	self._stateFsm:swicthState("SxGameAdd2Queue")
end

function SxGameController:findScore()
	self._stateFsm:swicthState("SxGameFindScore")
end

function SxGameController:scoreAction()
	self._stateFsm:swicthState("SxGameScoreAction")
end

function SxGameController:viewSwap()
	self._stateFsm:swicthState("SxGameViewSwap")
end

function SxGameController:viewSwapBack()
	self._stateFsm:swicthState("SxGameViewSwapBack")
end

function SxGameController:continueFindScore()
	self._stateFsm:swicthState("SxGameContinueFindScore")
end

function SxGameController:defaultState()
	self._stateFsm:swicthState("SxGameDefaultState")
end

function SxGameController:specialState(...)
	self._stateFsm:swicthState("SxGameSpecialState")
end

function SxGameController:addAction(actionData)
	GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesTryDoAction)

	if (self._stateFsm:getCurStateName() == "SxGameAdd2Queue" or self._stateFsm:getCurStateName() == "SxGameDefaultState") and not SxGameModel.instance:isWaitingMoveRes() then
		local secuss = SxGameModel.instance:addAction(actionData)

		if secuss then
			self:add2Queue()
		end

		return secuss
	end

	return false
end

function SxGameController:addActionByGuest(x, y)
	GlobalDispatcher:dispatch(GlobalNotify.ThreeMathesTryDoAction)

	if (self._stateFsm:getCurStateName() == "SxGameAdd2Queue" or self._stateFsm:getCurStateName() == "SxGameDefaultState") and not SxGameModel.instance:isWaitingMoveRes() then
		local secuss = SxGameModel.instance:addActionByGuest(x, y)

		if secuss then
			self:add2Queue()
		end

		return secuss
	end

	return false
end

function SxGameController:getCurrStateName()
	return self._stateFsm:getCurStateName()
end

function SxGameController:playNormalEffect()
	return
end

function SxGameController:playSpecialEffect()
	return
end

function SxGameController:isCanDoAction()
	if self._stateFsm:getCurStateName() == "SxGameAdd2Queue" or self._stateFsm:getCurStateName() == "SxGameDefaultState" then
		return true
	end

	return false
end

function SxGameController:getInfo(callback)
	if SxGameModel.instance:getRemainCnt() == nil then
		SxGameAgent.instance:sendUserSiteInfoReq(callback)
	else
		GameUtil.callBack(callback)

		callback = nil
	end
end

function SxGameController:_reloadData(callback)
	SxGameModel.instance:setRemainCnt(nil)
end

function SxGameController:openSxgameView(times)
	if (times == nil and MiniGameCollectionModel.instance:getResiduePlayTimes() or times) > 0 then
		SxGameAgent.instance:sendStartGameReq(SxGameModel.instance:randomClientKey(), function()
			local info = {}

			function info.finishCallBack()
				local giftArr = SxGameModel.instance:getGiftArr()

				SxGameAgent.instance:sendEndGameReq(SxGameModel.instance:getRunStep(), 1000, giftArr[SxGameCellType.Red] or 0, giftArr[SxGameCellType.Green] or 0, giftArr[SxGameCellType.Yellow] or 0, giftArr[SxGameCellType.Purple] or 0)
			end

			UIStateManager.instance:push(ViewName.Sxgame, info)
		end)
	else
		TipsFacade.instance:openCommonTips(lang("今日游戏次数不足，改日再战吧！"))
	end
end

function SxGameController:sendGetActInfo()
	SxGameAgent.instance:sendAncientFossilSiteGetInfoReq()
end

function SxGameController:onGetActInfo(msg)
	self.sxGameInfo = GameUtil.pbToTable(msg)
	self.sxGameInfo.gainPrizeIds = self.sxGameInfo.gainPrizeIds or {}

	GlobalDispatcher:dispatch(GlobalNotify.SxActInfoUpdate, self)
end

function SxGameController:sendGetProgressPrize(periodId, prizeId)
	SxGameAgent.instance:sendGainScorePrizeReq(periodId, prizeId)
end

function SxGameController:onGetProgressPrize(msg)
	if self.sxGameInfo then
		table.insert(self.sxGameInfo.gainPrizeIds, msg.prizeId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SxActInfoUpdate, self)
end

function SxGameController:getGainPrizeIds()
	if self.sxGameInfo then
		return self.sxGameInfo.gainPrizeIds
	end

	return {}
end

function SxGameController:getResiduePlayTimes()
	if self.sxGameInfo then
		local hasPlayTimes = self.sxGameInfo.hasPlayTimes
		local total = checknumber(MiniGameCollectionConfig.instance:getParamValueByKey("SX_DAILY_MAX_TIMES"))

		return total - hasPlayTimes
	end

	return 0
end

function SxGameController:getActScore()
	if self.sxGameInfo then
		return self.sxGameInfo.score
	end

	return 0
end

SxGameController.instance = SxGameController.New()

return SxGameController
