-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadCardInitWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadCardInitWork", package.seeall)

local FightPreloadCardInitWork = class("FightPreloadCardInitWork", BaseWork)

function FightPreloadCardInitWork:onStart(context)
	if ViewMgr.instance:isOpenFinish(ViewName.FightView) then
		self:_updateCards()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	end
end

function FightPreloadCardInitWork:_onOpenViewFinish(viewName)
	if viewName == ViewName.FightView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
		self:_updateCards()
	end
end

function FightPreloadCardInitWork:_updateCards()
	local handCards = FightDataHelper.handCardMgr.handCard

	FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, handCards)

	local fightView = ViewMgr.instance:getContainer(ViewName.FightView)
	local handCardsGO = gohelper.findChild(fightView.viewGO, "root/handcards/handcards")

	gohelper.setActive(handCardsGO, true)

	local canvasGroup = gohelper.onceAddComponent(handCardsGO, gohelper.Type_CanvasGroup)

	if canvasGroup then
		canvasGroup.alpha = 0
	end

	TaskDispatcher.runDelay(self._delayDone, self, 0.01)
end

function FightPreloadCardInitWork:_delayDone()
	self:onDone(true)
end

function FightPreloadCardInitWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

return FightPreloadCardInitWork
