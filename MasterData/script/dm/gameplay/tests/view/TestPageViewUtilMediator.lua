-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/TestPageViewUtilMediator.lua

TestPageViewUtilMediator = class("TestPageViewUtilMediator", DmPopupViewMediator)

TestPageViewUtilMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function TestPageViewUtilMediator:initialize()
	super.initialize(self)
end

function TestPageViewUtilMediator:dispose()
	super.dispose(self)
end

function TestPageViewUtilMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function TestPageViewUtilMediator:mapEventListeners()
	return
end

function TestPageViewUtilMediator:enterWithData(data)
	self:setupView()
end

function TestPageViewUtilMediator:setupView()
	self._des = self:getChildView("Panel_base.Text_des")

	self._des:setString("page view事例演示")
	self._des:setContentSize(cc.size(600, 400))
	self._des:setAnchorPoint(0.5, 1)

	local scollView = ccui.ScrollView:create()

	scollView:setContentSize(cc.size(300, 300))
	scollView:center(self:getChildView("Panel_base"):getContentSize())
	scollView:setBackGroundColorType(1)
	scollView:setBackGroundColor(cc.c3b(0, 0, 0))
	self:getChildView("Panel_base"):addChild(scollView)

	local info = {
		pageNum = 6,
		view = scollView,
		delegate = self
	}

	self._pageViewUtil = PageViewUtil:new(info)

	self._pageViewUtil:reloadData()
	schedule(scollView, function()
		self._pageViewUtil:scrollToDirection(1)
	end, 3)
end

function TestPageViewUtilMediator:getPageNum()
	return 6
end

function TestPageViewUtilMediator:getPageByIndex(index)
	local testTTF = cc.Label:createWithTTF("test" .. index, TTF_FONT_FZYH_M, 60)

	testTTF:setPosition(150, 150)

	return testTTF
end

function TestPageViewUtilMediator:pageTouchedAtIndex(index)
	print("pageTouchedAtIndex", index)
end
