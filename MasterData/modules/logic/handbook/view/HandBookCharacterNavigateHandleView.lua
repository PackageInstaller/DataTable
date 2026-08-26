-- chunkname: @modules/logic/handbook/view/HandBookCharacterNavigateHandleView.lua

module("modules.logic.handbook.view.HandBookCharacterNavigateHandleView", package.seeall)

local HandBookCharacterNavigateHandleView = class("HandBookCharacterNavigateHandleView", BaseView)

function HandBookCharacterNavigateHandleView:onInitView()
	self._goParentView = gohelper.findChild(self.viewGO, "#go_characterswitch")
	self._goSubView = gohelper.findChild(self.viewGO, "#go_center")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandBookCharacterNavigateHandleView:addEvents()
	return
end

function HandBookCharacterNavigateHandleView:removeEvents()
	return
end

HandBookCharacterNavigateHandleView.Status = {
	InParentView = 1,
	InSubView = 2
}

function HandBookCharacterNavigateHandleView:_editableInitView()
	self.status = HandBookCharacterNavigateHandleView.Status.InParentView
end

function HandBookCharacterNavigateHandleView:onUpdateParam()
	return
end

function HandBookCharacterNavigateHandleView:onOpen()
	self:refreshUI()
	self.addEventCb(self, HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, self.openSubView, self)
end

function HandBookCharacterNavigateHandleView:onCloseBtnClick()
	if self.status == HandBookCharacterNavigateHandleView.Status.InParentView then
		self:closeParentView()

		return
	end

	HandbookController.instance:dispatchEvent(HandbookController.EventName.PlayCharacterSwitchCloseAnim)
	self:closeSubView()
end

function HandBookCharacterNavigateHandleView:openSubView()
	self.status = HandBookCharacterNavigateHandleView.Status.InSubView

	self:refreshUI()
end

function HandBookCharacterNavigateHandleView:closeSubView()
	self.status = HandBookCharacterNavigateHandleView.Status.InParentView

	TaskDispatcher.runDelay(self.playCharacterSwitchOpenAnim, self, 0.267)
end

function HandBookCharacterNavigateHandleView:playCharacterSwitchOpenAnim()
	self:refreshUI()
	HandbookController.instance:dispatchEvent(HandbookController.EventName.PlayCharacterSwitchOpenAnim)
end

function HandBookCharacterNavigateHandleView:closeParentView()
	self:closeThis()
end

function HandBookCharacterNavigateHandleView:refreshUI()
	gohelper.setActive(self._goParentView, self.status == HandBookCharacterNavigateHandleView.Status.InParentView)
	gohelper.setActive(self._goSubView, self.status == HandBookCharacterNavigateHandleView.Status.InSubView)
end

function HandBookCharacterNavigateHandleView:onClose()
	TaskDispatcher.cancelTask(self.playCharacterSwitchOpenAnim, self)
end

function HandBookCharacterNavigateHandleView:onDestroyView()
	self.removeEventCb(self, HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, self.openSubView, self)
end

return HandBookCharacterNavigateHandleView
