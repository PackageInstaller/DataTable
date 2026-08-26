-- chunkname: @modules/logic/fight/system/work/FightWorkWaitCloseView.lua

module("modules.logic.fight.system.work.FightWorkWaitCloseView", package.seeall)

local FightWorkWaitCloseView = class("FightWorkWaitCloseView", FightWorkItem)

function FightWorkWaitCloseView:onConstructor(viewName)
	self.viewName = viewName
end

function FightWorkWaitCloseView:onStart()
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish)
	self:cancelFightWorkSafeTimer()
end

function FightWorkWaitCloseView:onCloseViewFinish(viewName)
	if viewName == self.viewName then
		self:onDone(true)
	end
end

function FightWorkWaitCloseView:onDestructor()
	return
end

return FightWorkWaitCloseView
