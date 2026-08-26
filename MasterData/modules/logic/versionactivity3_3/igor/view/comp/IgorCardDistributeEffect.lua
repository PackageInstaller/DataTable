-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorCardDistributeEffect.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorCardDistributeEffect", package.seeall)

local IgorCardDistributeEffect = class("IgorCardDistributeEffect", BaseWork)

function IgorCardDistributeEffect:onStart(context)
	IgorCardDistributeEffect.super.onStart(self, context)

	self._flow = FlowParallel.New()

	local dt = 0.033

	if not context.startIndex then
		if not context.endIndex then
			local endIndex = #context.cardItemList

			for i = context.startIndex, endIndex do
				local cardIndex = i
				local cardItem = context.cardItemList[cardIndex]

				if cardItem then
					gohelper.setActive(cardItem.go, false)

					local oneCardFlow = FlowSequence.New()

					oneCardFlow:addWork(FunctionWork.New(function()
						gohelper.setActive(cardItem.go, false)
					end))

					local delay = (1 + 3 * (i - 1)) * dt

					if delay > 0 then
						oneCardFlow:addWork(WorkWaitSeconds.New(delay))
					end

					local cardTargetPosX = recthelper.getAnchorX(cardItem.tr)
					local cardTargetPosXOver = cardTargetPosX + 60
					local card_start_pos_X = cardTargetPosX - 1000

					oneCardFlow:addWork(FunctionWork.New(function()
						gohelper.onceAddComponent(cardItem.go, gohelper.Type_CanvasGroup).alpha = 0

						gohelper.setActive(cardItem.go, true)
						recthelper.setAnchorX(cardItem.tr, card_start_pos_X)
					end))

					local flyParallel = FlowParallel.New()

					flyParallel:addWork(TweenWork.New({
						from = 0,
						type = "DOFadeCanvasGroup",
						to = 1,
						go = cardItem.go,
						t = dt * 8,
						ease = EaseType.linear
					}))
					flyParallel:addWork(TweenWork.New({
						type = "DOAnchorPosX",
						tr = cardItem.tr,
						to = cardTargetPosXOver,
						t = dt * 8,
						ease = EaseType.InOutSine
					}))
					oneCardFlow:addWork(flyParallel)
					oneCardFlow:addWork(TweenWork.New({
						type = "DOAnchorPosX",
						tr = cardItem.tr,
						to = cardTargetPosX,
						t = dt * 4,
						ease = EaseType.OutCubic
					}))
					self._flow:addWork(oneCardFlow)
				end
			end

			AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_checkpoint_openingcards)
			self._flow:registerDoneListener(self._onCardDone, self)
			self._flow:start(context)
		end
	end
end

function IgorCardDistributeEffect:_onCardDone()
	self._flow:unregisterDoneListener(self._onCardDone, self)
	self:onDone(true)
end

function IgorCardDistributeEffect:clearWork()
	self._flow:unregisterDoneListener(self._onCardDone, self)
	self._flow:stop()
end

return IgorCardDistributeEffect
