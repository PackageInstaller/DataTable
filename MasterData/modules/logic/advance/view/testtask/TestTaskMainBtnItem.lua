-- chunkname: @modules/logic/advance/view/testtask/TestTaskMainBtnItem.lua

module("modules.logic.advance.view.testtask.TestTaskMainBtnItem", package.seeall)

local TestTaskMainBtnItem = class("TestTaskMainBtnItem", ActCenterItemBase)

function TestTaskMainBtnItem:init(go)
	TestTaskMainBtnItem.super.init(self, gohelper.cloneInPlace(go))

	local bgitem = gohelper.findChild(self.go, "bg")

	self._btnitem = gohelper.getClick(bgitem)
end

function TestTaskMainBtnItem:onInit(go)
	self:_refreshItem()
end

function TestTaskMainBtnItem:onClick()
	TestTaskController.instance:openTestTaskView()
end

function TestTaskMainBtnItem:_refreshItem()
	UISpriteSetMgr.instance:setMainSprite(self._imgitem, "icon_3")
	RedDotController.instance:addRedDot(self._goactivityreddot, RedDotEnum.DotNode.TestTaskBtn)
end

function TestTaskMainBtnItem:isShowRedDot()
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.TestTaskBtn)
end

return TestTaskMainBtnItem
