-- chunkname: @modules/logic/fight/system/work/FightWorkOpenView.lua

module("modules.logic.fight.system.work.FightWorkOpenView", package.seeall)

local FightWorkOpenView = class("FightWorkOpenView", FightWorkItem)

function FightWorkOpenView:onConstructor(viewName, param, isImmediate)
	self.viewName = viewName
	self.param = param
	self.isImmediate = isImmediate
	self.SAFETIME = 10
end

function FightWorkOpenView:onStart()
	self:com_registEvent(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView)
	ViewMgr.instance:openView(self.viewName, self.param, self.isImmediate)
end

function FightWorkOpenView:onOpenView(viewName)
	if viewName == self.viewName then
		self:onDone(true)
	end
end

function FightWorkOpenView:onDestructor()
	return
end

return FightWorkOpenView
