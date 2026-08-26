-- chunkname: @modules/logic/fight/view/cardeffect/FightCardDissolveMoveEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardDissolveMoveEffect", package.seeall)

local FightCardDissolveMoveEffect = class("FightCardDissolveMoveEffect", BaseWork)
local TimeFactor = 1
local dt = TimeFactor * 0.033

function FightCardDissolveMoveEffect:onStart(context)
	FightCardDissolveMoveEffect.super.onStart(self, context)

	self._dt = dt / FightModel.instance:getUISpeed()

	local leftCardIndexs = {}

	for i, _ in ipairs(context.handCardItemList) do
		if not tabletool.indexOf(context.dissolveCardIndexs, i) then
			table.insert(leftCardIndexs, i)
		end
	end

	self._dissolveCardIndexs = nil
	self._moveCardFlow = FlowParallel.New()

	local count = 1

	for i, cardIndex in ipairs(leftCardIndexs) do
		local cardItemGO = context.handCardItemList[cardIndex].go
		local destItemGO = context.handCardItemList[i].go

		if not gohelper.isNil(cardItemGO) and not gohelper.isNil(destItemGO) and cardItemGO ~= destItemGO then
			local cardItemTr = cardItemGO.transform
			local oneCardFlow = FlowSequence.New()

			oneCardFlow:addWork(WorkWaitSeconds.New(3 * count * self._dt))

			local cardTargetPosX, _ = recthelper.getAnchor(destItemGO.transform)
			local cardTargetPosXOver = cardTargetPosX + 10

			oneCardFlow:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = cardItemTr,
				to = cardTargetPosXOver,
				t = self._dt * 5
			}))
			oneCardFlow:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = cardItemTr,
				to = cardTargetPosX,
				t = self._dt * 2
			}))
			self._moveCardFlow:addWork(oneCardFlow)

			count = count + 1
		end
	end

	self._moveCardFlow:registerDoneListener(self._onWorkDone, self)
	self._moveCardFlow:start()
end

function FightCardDissolveMoveEffect:onStop()
	FightCardDissolveMoveEffect.super.onStop(self)
	self._moveCardFlow:unregisterDoneListener(self._onWorkDone, self)

	if self._moveCardFlow.status == WorkStatus.Running then
		self._moveCardFlow:stop()
	end
end

function FightCardDissolveMoveEffect:_onWorkDone()
	self:onDone(true)
end

return FightCardDissolveMoveEffect
