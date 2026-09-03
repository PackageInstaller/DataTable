-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/TestCollectionViewUtilsMediator.lua

TestCollectionViewUtilsMediator = class("TestCollectionViewUtilsMediator", DmPopupViewMediator)

TestCollectionViewUtilsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function TestCollectionViewUtilsMediator:initialize()
	super.initialize(self)
end

function TestCollectionViewUtilsMediator:dispose()
	super.dispose(self)
end

function TestCollectionViewUtilsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function TestCollectionViewUtilsMediator:mapEventListeners()
	return
end

function TestCollectionViewUtilsMediator:enterWithData(data)
	self:setupView()
end

function TestCollectionViewUtilsMediator:setupView()
	self._des = self:getChildView("Panel_base.Text_des")

	self._des:setString("CollectionView事例演示")
	self._des:setContentSize(cc.size(600, 400))
	self._des:setAnchorPoint(0.5, 1)

	local scrollView = ccui.ScrollView:create()

	scrollView:setContentSize(cc.size(300, 300))
	scrollView:center(self:getChildView("Panel_base"):getContentSize())
	scrollView:setBackGroundColorType(1)
	scrollView:setBackGroundColor(cc.c3b(0, 0, 0))
	scrollView:setDirection(3)
	self:getChildView("Panel_base"):addChild(scrollView)

	self.cellNumSize = cc.size(10, 10)

	local info = {
		isReuse = true,
		extraOffset = 0,
		isSchedule = true,
		view = scrollView,
		delegate = self,
		cellNumSize = self.cellNumSize,
		cellSize = cc.size(100, 100)
	}

	self._collectionView = CollectionViewUtils:new(info)

	self._collectionView:reloadData()
	self._collectionView:setZoomScale(0.8)
end

function TestCollectionViewUtilsMediator:cellAtIndex(view, row, col)
	row = self.cellNumSize.height - 1 - row

	local cell = self._collectionView:dequeueCellByKey()

	cell = cell or cc.Node:create()

	local testTTF = cc.Label:createWithTTF(string.format("%d行%d列", row, col), TTF_FONT_FZYH_M, 20)

	testTTF:setPosition(50, 50)
	cell:addChild(testTTF)

	return cell
end

function TestCollectionViewUtilsMediator:cellWillHide(view, row, col, cell)
	cell:removeAllChildren()
end

function TestCollectionViewUtilsMediator:cellWillShow(view, row, col, cell)
	return
end

function TestCollectionViewUtilsMediator:onEventForCollectionView(...)
	return
end
