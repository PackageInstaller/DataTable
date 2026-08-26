-- chunkname: @modules/logic/fight/view/cardeffect/FightEnemyPlayCardInEffect.lua

module("modules.logic.fight.view.cardeffect.FightEnemyPlayCardInEffect", package.seeall)

local FightEnemyPlayCardInEffect = class("FightEnemyPlayCardInEffect", BaseWork)
local ColorWhite = Color.white

function FightEnemyPlayCardInEffect:onStart(context)
	FightEnemyPlayCardInEffect.super.onStart(self, context)

	for i = 1, context.enemyNowActPoint do
		local opGO = gohelper.findChild(context.viewGO, string.format("root/enemycards/item%d/op", i))

		gohelper.setActive(opGO, true)

		local emptyGO = gohelper.findChild(context.viewGO, string.format("root/enemycards/item%d/empty", i))

		gohelper.setActive(emptyGO, true)

		local imgEmpty = gohelper.onceAddComponent(emptyGO, gohelper.Type_Image)

		imgEmpty.color = ColorWhite
	end

	TaskDispatcher.runDelay(self._delayDone, self, 0.34)
end

function FightEnemyPlayCardInEffect:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightEnemyPlayCardInEffect:_delayDone()
	self:onDone(true)
end

return FightEnemyPlayCardInEffect
