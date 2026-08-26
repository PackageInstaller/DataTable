-- chunkname: @modules/logic/necrologiststory/view/NecrologistStoryButtonView.lua

module("modules.logic.necrologiststory.view.NecrologistStoryButtonView", package.seeall)

local NecrologistStoryButtonView = class("NecrologistStoryButtonView", BaseView)

function NecrologistStoryButtonView:onInitView()
	self.btnNext = gohelper.findChildClickWithAudio(self.viewGO, "")
	self.btnAuto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_auto")
	self.goautooff = gohelper.findChild(self.viewGO, "#go_topright/#btn_auto/#image_autooff")
	self.goautoon = gohelper.findChild(self.viewGO, "#go_topright/#btn_auto/#image_autoon")
	self.btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_skip")
	self.btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_exit")
	self.btnEnd = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_end")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryButtonView:addEvents()
	self.btnNext:AddClickDownListener(self.onClickNextDown, self)
	self.addClickCb(self, self.btnNext, self.onClickNext, self)
	self.addClickCb(self, self.btnAuto, self.onClickAuto, self)
	self.addClickCb(self, self.btnSkip, self.onClickSkip, self)
	self.addClickCb(self, self.btnEnd, self.onClickEnd, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStart, self._onStoryStart, self)
	self.addEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, self._onAutoChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function NecrologistStoryButtonView:removeEvents()
	self.btnNext:RemoveClickDownListener()
	self:removeClickCb(self.btnNext)
	self:removeClickCb(self.btnAuto)
	self:removeClickCb(self.btnSkip)
	self:removeClickCb(self.btnEnd)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnStoryStart, self._onStoryStart, self)
	self.removeEventCb(self, NecrologistStoryController.instance, NecrologistStoryEvent.OnAutoChange, self._onAutoChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function NecrologistStoryButtonView:_editableInitView()
	return
end

function NecrologistStoryButtonView:_onOpenView(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if isTop then
		return
	end

	local mo = NecrologistStoryModel.instance:getCurStoryMO()

	if mo and mo:getIsAuto() then
		mo:setIsAuto(false)

		self.isAutoFlag = true
	end
end

function NecrologistStoryButtonView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	local mo = NecrologistStoryModel.instance:getCurStoryMO()

	if mo and self.isAutoFlag then
		mo:setIsAuto(true)
	end

	self.isAutoFlag = false
end

function NecrologistStoryButtonView:onClickNextDown()
	local mo = NecrologistStoryModel.instance:getCurStoryMO()

	if mo then
		mo:setIsAuto(false)
	end
end

function NecrologistStoryButtonView:onClickEnd()
	self:closeThis()
end

function NecrologistStoryButtonView:_onAutoChange()
	self:refreshButton()
end

function NecrologistStoryButtonView:onClickNext()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnClickNext)
end

function NecrologistStoryButtonView:onClickAuto()
	local mo = NecrologistStoryModel.instance:getCurStoryMO()
	local isAuto = mo:getIsAuto()

	mo:setIsAuto(not isAuto)
end

function NecrologistStoryButtonView:onClickSkip()
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnClickSkip)
end

function NecrologistStoryButtonView:_onStoryStart()
	self:refreshButton()
end

function NecrologistStoryButtonView:refreshButton()
	local mo = NecrologistStoryModel.instance:getCurStoryMO()
	local isAuto = mo:getIsAuto()

	gohelper.setActive(self.goautooff, not isAuto)
	gohelper.setActive(self.goautoon, isAuto)
end

function NecrologistStoryButtonView:onDestroyView()
	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end
end

return NecrologistStoryButtonView
