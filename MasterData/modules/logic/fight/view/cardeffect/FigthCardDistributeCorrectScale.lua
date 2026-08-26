-- chunkname: @modules/logic/fight/view/cardeffect/FigthCardDistributeCorrectScale.lua

module("modules.logic.fight.view.cardeffect.FigthCardDistributeCorrectScale", package.seeall)

local FigthCardDistributeCorrectScale = class("FigthCardDistributeCorrectScale", BaseWork)

function FigthCardDistributeCorrectScale:onStart(context)
	if not context.oldScale then
		local oldScale = FightCardDataHelper.getHandCardContainerScale()

		if not context.newScale then
			local newScale = FightCardDataHelper.getHandCardContainerScale(nil, context.cards)

			if context.oldScale ~= newScale then
				self:_releaseTween()
				FightController.instance:dispatchEvent(FightEvent.CancelVisibleViewScaleTween)

				local time = 0.2 / FightModel.instance:getUISpeed()

				self._tweenId = ZProj.TweenHelper.DOScale(context.handCardContainer.transform, newScale, newScale, newScale, time)

				TaskDispatcher.runDelay(self._delayDone, self, time)
			else
				self:onDone(true)
			end
		end
	end
end

function FigthCardDistributeCorrectScale:_delayDone()
	self:onDone(true)
end

function FigthCardDistributeCorrectScale:_releaseTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function FigthCardDistributeCorrectScale:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:_releaseTween()
end

return FigthCardDistributeCorrectScale
