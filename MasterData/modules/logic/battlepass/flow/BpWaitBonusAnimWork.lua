-- chunkname: @modules/logic/battlepass/flow/BpWaitBonusAnimWork.lua

module("modules.logic.battlepass.flow.BpWaitBonusAnimWork", package.seeall)

local BpWaitBonusAnimWork = class("BpWaitBonusAnimWork", BaseWork)

function BpWaitBonusAnimWork:onStart()
	if not BpModel.instance.preStatus or not ViewMgr.instance:isOpen(ViewName.BpView) then
		self:onDone(true)
	else
		BpController.instance:registerCallback(BpEvent.BonusAnimEnd, self.onAnimDone, self)
		BpController.instance:dispatchEvent(BpEvent.ForcePlayBonusAnim)
	end
end

function BpWaitBonusAnimWork:onAnimDone()
	self:onDone(true)
end

function BpWaitBonusAnimWork:clearWork()
	BpController.instance:unregisterCallback(BpEvent.BonusAnimEnd, self.onAnimDone, self)
end

return BpWaitBonusAnimWork
