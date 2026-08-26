-- chunkname: @modules/logic/fight/view/cardeffect/FightMoveCardWork.lua

module("modules.logic.fight.view.cardeffect.FightMoveCardWork", package.seeall)

local FightMoveCardWork = class("FightMoveCardWork", BaseWork)

FightMoveCardWork.FlyTime = 0.5

function FightMoveCardWork:onStart(context)
	local handCardItemList = self.context.handCardItemList
	local startIndex = self.context.startIndex
	local endIndex = self.context.endIndex
	local startItem = handCardItemList[startIndex]
	local flyTime = FightMoveCardWork.FlyTime / FightModel.instance:getUISpeed()
	local flow = FlowParallel.New()

	self.flow = flow

	if startItem then
		local endAnchorX = FightViewHandCard.calcCardPosX(endIndex)
		local anchorWork = TweenWork.New({
			type = "DOAnchorPosX",
			tr = startItem.tr,
			to = endAnchorX,
			t = flyTime,
			ease = EaseType.OutQuart
		})

		flow:addWork(anchorWork)
	end

	if startIndex < endIndex then
		for i = startIndex + 1, endIndex do
			local cardItem = handCardItemList[i]

			if cardItem then
				local endAnchorX = FightViewHandCard.calcCardPosX(i - 1)
				local anchorWork = TweenWork.New({
					type = "DOAnchorPosX",
					tr = cardItem.tr,
					to = endAnchorX,
					t = flyTime,
					ease = EaseType.OutQuart
				})

				flow:addWork(anchorWork)
			end
		end
	else
		for i = endIndex, startIndex - 1 do
			local cardItem = handCardItemList[i]

			if cardItem then
				local endAnchorX = FightViewHandCard.calcCardPosX(i + 1)
				local anchorWork = TweenWork.New({
					type = "DOAnchorPosX",
					tr = cardItem.tr,
					to = endAnchorX,
					t = flyTime,
					ease = EaseType.OutQuart
				})

				flow:addWork(anchorWork)
			end
		end
	end

	flow:registerDoneListener(self.onMoveWorkDone, self)
	flow:start()
end

function FightMoveCardWork:onMoveWorkDone()
	return self:onDone(true)
end

function FightMoveCardWork:clearWork()
	if self.flow then
		self.flow:unregisterDoneListener(self.onMoveWorkDone, self)
		self.flow:stop()

		self.flow = nil
	end
end

return FightMoveCardWork
