-- chunkname: @modules/logic/fight/view/magiccircle/work/FightMagicCircleRemoveWork.lua

module("modules.logic.fight.view.magiccircle.work.FightMagicCircleRemoveWork", package.seeall)

local FightMagicCircleRemoveWork = class("FightMagicCircleRemoveWork", BaseWork)

function FightMagicCircleRemoveWork:ctor(magicItem)
	self.magicItem = magicItem
end

function FightMagicCircleRemoveWork:onStart()
	TaskDispatcher.runDelay(self._delayDone, self, 3)

	if self.magicItem then
		self.magicItem:playAnim("close", self.onCloseAnimDone, self)
	else
		self:onCloseAnimDone()
	end
end

function FightMagicCircleRemoveWork:_delayDone()
	logError("FightMagicCircleRemoveWork delay done")
	self:onCloseAnimDone()
end

function FightMagicCircleRemoveWork:onCloseAnimDone()
	if self.magicItem then
		self.magicItem:onRemoveMagic()
	end

	self:onDone(true)
end

function FightMagicCircleRemoveWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightMagicCircleRemoveWork:onDestroy()
	if self.magicItem then
		self.magicItem:onRemoveMagic()
	end

	self.magicItem = nil
end

return FightMagicCircleRemoveWork
