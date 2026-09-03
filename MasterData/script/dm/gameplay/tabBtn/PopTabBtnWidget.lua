-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tabBtn/PopTabBtnWidget.lua

require("dm.gameplay.tabBtn.BaseTabBtnWidget")

PopTabBtnWidget = class("PopTabBtnWidget", BaseTabBtnWidget, _M)

function PopTabBtnWidget.class:createWidgetNode()
	local resFile = "asset/ui/LeftTabBtnWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function PopTabBtnWidget:initialize(view)
	super.initialize(self, view)
end

function PopTabBtnWidget:dispose()
	self._closeView = true

	super.dispose(self)
end

function PopTabBtnWidget:initSubviews(view)
	super.initSubviews(self, view)

	self._tabClone = self._view:getChildByFullName("tabclone2")

	self._tabClone:setVisible(false)
end

function PopTabBtnWidget:initTabBtn(data, style)
	super.initTabBtn(self, data, style)

	self._mainAnim = cc.MovieClip:create("zuobandh_tongyongtexiao")

	local animNode = self._mainAnim:getChildByName("bg")

	if animNode then
		local bgImg = ccui.Scale9Sprite:createWithSpriteFrameName("bg_diban_02.png")

		bgImg:setCapInsets(cc.rect(96, 50, 100, 57))
		bgImg:setRotation(90)
		bgImg:setContentSize(cc.size(485, 161))
		bgImg:addTo(animNode):posite(38, 288)
		self:createTabBtnsAnim()
		self._scrollView:removeFromParent(false)
		self._scrollView:addTo(animNode):center(animNode:getContentSize()):offset(35, 260)
	end

	self._mainAnim:addEndCallback(function()
		self._mainAnim:stop()
	end)
end

function PopTabBtnWidget:createBtnAnim(btn, config)
	self:bindRedPoint(btn, config)
	self:bindLockImg(btn, config)
	btn:setVisible(true)
	btn:setSwallowTouches(false)
	btn:refreshLockState(config.lock)
	self:bindBtnAnim(btn, "anniu_tongyongtexiao", config, {
		x = -10,
		y = -5
	})
end

function PopTabBtnWidget:createTabBtnsAnim()
	local cellCount = #self._btnDatas
	local allHeight = cellCount * (self._tabClone:getContentSize().height - 8) + 10

	allHeight = math.max(allHeight, self._scrollView:getContentSize().height)

	self._scrollView:setContentSize(cc.size(165, 385))
	self._scrollView:setInnerContainerSize(cc.size(165, allHeight))
	self._scrollView:setClippingEnabled(true)

	local tabBtns = {}

	for i = 1, cellCount do
		local btn = self._tabClone:clone()
		local config = self._btnDatas[i]

		self:createBtnAnim(btn, config)

		tabBtns[#tabBtns + 1] = btn

		btn:addTo(self._scrollView)
		btn:setTag(i)
		btn:setPosition(0, allHeight - 10 - (btn:getContentSize().height - 8) * i)
	end

	self._tabBtns = tabBtns

	self:createTabController(tabBtns)
end
