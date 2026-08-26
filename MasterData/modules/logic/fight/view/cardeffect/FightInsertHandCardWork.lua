-- chunkname: @modules/logic/fight/view/cardeffect/FightInsertHandCardWork.lua

module("modules.logic.fight.view.cardeffect.FightInsertHandCardWork", package.seeall)

local FightInsertHandCardWork = class("FightInsertHandCardWork", BaseWork)

FightInsertHandCardWork.MoveTime = 0.3
FightInsertHandCardWork.InsertTime = 0.3
FightInsertHandCardWork.AnimDuration = 0.8

function FightInsertHandCardWork:onStart(context)
	local handCardItemList = self.context.handCardItemList
	local insertIndex = self.context.insertIndex
	local insertHandCardItem = self.context.insertHandCardItem

	self.insertCardItem = insertHandCardItem

	local moveTime = FightInsertHandCardWork.MoveTime / FightModel.instance:getUISpeed()
	local insertTime = FightInsertHandCardWork.InsertTime / FightModel.instance:getUISpeed()
	local animTime = FightInsertHandCardWork.AnimDuration / FightModel.instance:getUISpeed()
	local flow = FlowParallel.New()

	self.flow = flow

	gohelper.setActive(insertHandCardItem.go, true)

	local anchorX = FightViewHandCard.calcCardPosX(insertIndex)

	recthelper.setAnchor(insertHandCardItem.tr, anchorX, 150)

	local anchorWork = TweenWork.New({
		to = 0,
		type = "DOAnchorPosY",
		tr = insertHandCardItem.tr,
		t = insertTime
	})

	flow:addWork(anchorWork)

	for i = insertIndex, #handCardItemList - 1 do
		local cardItem = handCardItemList[i]
		local endAnchorX = FightViewHandCard.calcCardPosX(i + 1)

		anchorWork = TweenWork.New({
			type = "DOAnchorPosX",
			tr = cardItem.tr,
			to = endAnchorX,
			t = moveTime,
			ease = EaseType.OutQuart
		})

		flow:addWork(anchorWork)
	end

	local animFlow = FlowSequence.New()

	animFlow:addWork(DelayFuncWork.New(self.playCardAnim, self, animTime))
	animFlow:addWork(FunctionWork.New(self.stopCardAnim, self))
	flow:addWork(animFlow)
	flow:registerDoneListener(self.onInsertWorkDone, self)
	flow:start()
end

function FightInsertHandCardWork:playCardAnim()
	if self.insertCardItem then
		self.insertCardItem:tryPlayInsertAnim()
	end
end

function FightInsertHandCardWork:stopCardAnim()
	if self.insertCardItem then
		self.insertCardItem:tryStopInsertAnim()
	end
end

function FightInsertHandCardWork:onInsertWorkDone()
	return self:onDone(true)
end

function FightInsertHandCardWork:clearWork()
	if self.insertCardItem then
		self.insertCardItem:tryStopInsertAnim()
	end

	if self.flow then
		self.flow:unregisterDoneListener(self.onInsertWorkDone, self)
		self.flow:stop()

		self.flow = nil
	end
end

return FightInsertHandCardWork
