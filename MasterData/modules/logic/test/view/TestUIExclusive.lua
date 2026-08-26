-- chunkname: @modules/logic/test/view/TestUIExclusive.lua

module("modules.logic.test.view.TestUIExclusive", package.seeall)

local TestUIExclusive = class("TestUIExclusive", BaseViewExtended)

function TestUIExclusive:onInitView()
	self.text = gohelper.findChildTextMesh(self.viewGO, "#txt_des")
end

function TestUIExclusive:addEvents()
	self.addClickCb(self, gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_close_exclusive")), self._onClick, self)
end

function TestUIExclusive:_onOpenSubView()
	return
end

function TestUIExclusive:onSetExclusiveViewVisible(state)
	if not state then
		GameFacade.showToast(ToastEnum.ClassShow)
	end

	self:setViewVisibleInternal(state)
end

function TestUIExclusive:_onClick()
	self:getParentView():hideExclusiveView(self)
end

function TestUIExclusive:onRefreshViewParam(str)
	self.str = str
end

function TestUIExclusive:onOpen()
	self.text.text = self.str
end

function TestUIExclusive:onClose()
	return
end

return TestUIExclusive
