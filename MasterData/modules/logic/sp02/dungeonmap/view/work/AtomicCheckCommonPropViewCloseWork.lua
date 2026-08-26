-- chunkname: @modules/logic/sp02/dungeonmap/view/work/AtomicCheckCommonPropViewCloseWork.lua

module("modules.logic.sp02.dungeonmap.view.work.AtomicCheckCommonPropViewCloseWork", package.seeall)

local AtomicCheckCommonPropViewCloseWork = class("AtomicCheckCommonPropViewCloseWork", BaseWork)

function AtomicCheckCommonPropViewCloseWork:ctor()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.checkOnCloseView, self)
end

function AtomicCheckCommonPropViewCloseWork:onStart()
	local isOpenView = ViewMgr.instance:isOpen(ViewName.CommonPropView)
	local isOpeningView = ViewMgr.instance:isOpening(ViewName.CommonPropView)

	if not isOpenView and not isOpeningView then
		self:onSetDone()
	end
end

function AtomicCheckCommonPropViewCloseWork:checkOnCloseView(viewName)
	if viewName == ViewName.CommonPropView then
		self:onSetDone()
	end
end

function AtomicCheckCommonPropViewCloseWork:onSetDone()
	self:onDone(true)
end

function AtomicCheckCommonPropViewCloseWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.checkOnCloseView, self)
end

return AtomicCheckCommonPropViewCloseWork
