-- chunkname: @modules/logic/test/view/TestUISubView.lua

module("modules.logic.test.view.TestUISubView", package.seeall)

local TestUISubView = class("TestUISubView", BaseViewExtended)

function TestUISubView:onInitView()
	return
end

function TestUISubView:addEvents()
	self.addClickCb(self, gohelper.getClick(gohelper.findChild(self.viewGO, "#simage_bg")), self._onClick, self)
	self.addClickCb(self, gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_decompose")), self._onOpenSubView, self)
end

function TestUISubView:_onOpenSubView()
	if self.sub_view then
		self.sub_view:setViewVisible(true)
	else
		self.sub_view = self:openSubView(TestUISubView, "ui/viewres/test/testuisubview.prefab")
	end
end

function TestUISubView:_onClick()
	self:setViewVisible(false)
end

function TestUISubView:onOpen()
	return
end

function TestUISubView:onClose()
	return
end

return TestUISubView
