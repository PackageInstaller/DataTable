-- chunkname: @modules/logic/sp02/dungeonmap/view/work/AtomicCheckTipToastWork.lua

module("modules.logic.sp02.dungeonmap.view.work.AtomicCheckTipToastWork", package.seeall)

local AtomicCheckTipToastWork = class("AtomicCheckTipToastWork", BaseWork)

function AtomicCheckTipToastWork:ctor()
	AtomicDungeonController.instance:registerCallback(AtomicDungeonEvent.ShowTipToastFinish, self.onSetDone, self)
end

function AtomicCheckTipToastWork:onStart()
	local needShowElementToast = AtomicDungeonController.instance:checkCanShowElementTipToast()

	if needShowElementToast then
		AtomicDungeonController.instance:showAlarmTipToast()
		AtomicDungeonController.instance:showElementTipToast()
	else
		self:onSetDone()
	end
end

function AtomicCheckTipToastWork:onSetDone()
	self:onDone(true)
end

function AtomicCheckTipToastWork:clearWork()
	AtomicDungeonController.instance:unregisterCallback(AtomicDungeonEvent.ShowTipToastFinish, self.onSetDone, self)
end

return AtomicCheckTipToastWork
