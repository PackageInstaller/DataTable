-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/state/YaXianStateFinishEvent.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateFinishEvent", package.seeall)

local YaXianStateFinishEvent = class("YaXianStateFinishEvent", YaXianStateBase)

YaXianStateFinishEvent.BLOCK_KEY = "YaXianStateFinishEvent"

function YaXianStateFinishEvent:start()
	self.stateType = YaXianGameEnum.GameStateType.FinishEvent
	self.gameLoadDone = YaXianGameModel.instance:gameIsLoadDone()
	self.openingLoadingView = ViewMgr.instance:isOpen(ViewName.LoadingView)

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(YaXianStateFinishEvent.BLOCK_KEY)

	if self.gameLoadDone and not self.openingLoadingView then
		self:onFinish()
	else
		if not self.gameLoadDone then
			YaXianGameController.instance:registerCallback(YaXianEvent.OnGameLoadDone, self.onGameLoadDone, self)
		end

		if self.openingLoadingView then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
		end
	end
end

function YaXianStateFinishEvent:onGameLoadDone()
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, self.onGameLoadDone, self)

	self.gameLoadDone = true

	self:checkCanStartFinishEvent()
end

function YaXianStateFinishEvent:onCloseViewFinish(viewName)
	if viewName == ViewName.LoadingView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)

		self.openingLoadingView = false

		self:checkCanStartFinishEvent()
	end
end

function YaXianStateFinishEvent:checkCanStartFinishEvent()
	if self.gameLoadDone and not self.openingLoadingView then
		self:onFinish()
	end
end

function YaXianStateFinishEvent:onFinish()
	local preEvent = self.originData.preEvent

	if preEvent and preEvent.eventType == YaXianGameEnum.GameStateType.Battle then
		self.startFinishBattleAnimation(self, self.sendRequest, self)

		return
	end

	self:sendRequest()
end

function YaXianStateFinishEvent:startFinishBattleAnimation(callback, callbackObj)
	local winItem, loseItem
	local playerInteractItem = YaXianGameController.instance:getPlayerInteractItem()
	local enemyItem = YaXianGameController.instance:getInteractItem(self.originData.preEvent.interactId)
	local fightResult = EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult

	if fightResult ~= FightEnum.FightResult.Succ then
		winItem = enemyItem
		loseItem = playerInteractItem
	else
		winItem = playerInteractItem
		loseItem = enemyItem
	end

	winItem:showEffect(YaXianGameEnum.EffectType.FightSuccess)
	loseItem:showEffect(YaXianGameEnum.EffectType.Die, callback, callbackObj)
end

function YaXianStateFinishEvent:sendRequest()
	Activity115Rpc.instance:sendAct115EventEndRequest(YaXianGameEnum.ActivityId, self.onReceiveReply, self)
end

function YaXianStateFinishEvent:onReceiveReply(cmd, resultCode)
	if resultCode == 0 then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnStateFinish, self.stateType)
	end

	UIBlockMgr.instance:endBlock(YaXianStateFinishEvent.BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function YaXianStateFinishEvent:dispose()
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, self.onGameLoadDone, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	YaXianStateFinishEvent.super.dispose(self)
end

return YaXianStateFinishEvent
