-- chunkname: @modules/logic/survival/controller/work/SurvivalOpenViewWork.lua

module("modules.logic.survival.controller.work.SurvivalOpenViewWork", package.seeall)

local SurvivalOpenViewWork = class("SurvivalOpenViewWork", BaseWork)

function SurvivalOpenViewWork:ctor(param)
	self.viewName = param.viewName
	self.viewParam = param.viewParam
	self.isImmediate = param.isImmediate
end

function SurvivalOpenViewWork:onStart()
	local ok, msg = pcall(self.open, self)

	if not ok then
		__G__TRACKBACK__(msg)
		self:onDone(false)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenView, self)
end

function SurvivalOpenViewWork:open()
	ViewMgr.instance:openView(self.viewName, self.viewParam, self.isImmediate)
end

function SurvivalOpenViewWork:onOpenView()
	self:onDone(true)
end

function SurvivalOpenViewWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenView, self)
end

function SurvivalOpenViewWork:onDestroy()
	return
end

return SurvivalOpenViewWork
