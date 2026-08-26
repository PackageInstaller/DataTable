-- chunkname: @modules/logic/test/view/TestUIView.lua

module("modules.logic.test.view.TestUIView", package.seeall)

local TestUIView = class("TestUIView", BaseViewExtended)

function TestUIView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
end

function TestUIView:addEvents()
	self.addClickCb(self, gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_decompose")), self._onClick, self)
	self.addClickCb(self, gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_1")), self._on1Click, self)
	self.addClickCb(self, gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_2")), self._on2Click, self)
	self.addClickCb(self, gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_3")), self._on3Click, self)
	self.addClickCb(self, gohelper.getClick(gohelper.findChild(self.viewGO, "#btn_close_exclusive")), self._onCloseExclusive, self)
end

function TestUIView:_onClick()
	if self.sub_view then
		self.sub_view:setViewVisible(true)
	else
		self.sub_view = self:openSubView(TestUISubView, "ui/viewres/test/testuisubview.prefab")
	end
end

function TestUIView:_on1Click()
	self:openSubView(TestHeroBagView)
end

function TestUIView:_on2Click()
	self:openExclusiveView(nil, 2, TestUIExclusive, "ui/viewres/test/testuiexclusiveview.prefab", nil, 2)
end

function TestUIView:_on3Click()
	self:openExclusiveView(nil, 3, TestUIExclusive, "ui/viewres/test/testuiexclusiveview.prefab", nil, 3)
end

function TestUIView:_onCloseExclusive()
	self:hideExclusiveGroup(1)
end

function TestUIView:onOpen()
	return
end

function TestUIView:onClose()
	return
end

return TestUIView
