-- chunkname: @modules/logic/fight/view/cardeffect/FightEnemyActPointBreakEffect.lua

module("modules.logic.fight.view.cardeffect.FightEnemyActPointBreakEffect", package.seeall)

local FightEnemyActPointBreakEffect = class("FightEnemyActPointBreakEffect", BaseWork)

function FightEnemyActPointBreakEffect:onStart(context)
	FightEnemyActPointBreakEffect.super.onStart(self, context)

	if not context.enemyHasDeadEntity or context.enemyBreakActPoint == 0 then
		self:onDone(true)

		return
	end

	local cardCount = context.enemyNowActPoint + context.enemyBreakActPoint

	for i = 1, cardCount do
		gohelper.setActive(gohelper.findChild(context.viewGO, string.format("root/enemycards/item%d", i)), true)
	end

	for i = context.enemyNowActPoint + 1, cardCount do
		local emptyGO = gohelper.findChild(context.viewGO, string.format("root/enemycards/item%d/empty", i))

		if emptyGO then
			local dieAnimation = emptyGO:GetComponent(typeof(UnityEngine.Animation))

			if dieAnimation then
				dieAnimation:Play()
			end
		end
	end

	TaskDispatcher.runDelay(self._delayDone, self, 0.8)
end

function FightEnemyActPointBreakEffect:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightEnemyActPointBreakEffect:_delayDone()
	local context = self.context
	local cardCount = context.enemyNowActPoint + context.enemyBreakActPoint

	for i = 1, cardCount do
		gohelper.setActive(gohelper.findChild(context.viewGO, string.format("root/enemycards/item%d", i)), i <= context.enemyNowActPoint)
	end

	for i = context.enemyNowActPoint + 1, cardCount do
		local dieGO = gohelper.findChild(context.viewGO, string.format("root/enemycards/item%d/empty/die", i))

		gohelper.setActive(dieGO, false)

		local emptyGO = gohelper.findChild(context.viewGO, string.format("root/enemycards/item%d/empty", i))

		if emptyGO then
			local dieAnimation = emptyGO:GetComponent(typeof(UnityEngine.Animation))

			if dieAnimation then
				dieAnimation:Stop()
			end

			local imgEmpty = emptyGO:GetComponent(gohelper.Type_Image)

			if imgEmpty then
				imgEmpty.color = Color.white
			end
		end
	end

	self:onDone(true)
end

return FightEnemyActPointBreakEffect
