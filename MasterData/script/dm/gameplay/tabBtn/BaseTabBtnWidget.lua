-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tabBtn/BaseTabBtnWidget.lua

BaseTabBtnWidget = class("BaseTabBtnWidget", BaseWidget, _M)

local maxLength = 4

function BaseTabBtnWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function BaseTabBtnWidget:dispose()
	self._closeView = true

	super.dispose(self)
end

function BaseTabBtnWidget:initSubviews(view)
	self._view = view
	self._scrollView = self._view:getChildByFullName("scrollview")

	self._scrollView:setScrollBarEnabled(false)
end

function BaseTabBtnWidget:initTabBtn(data, style)
	self._data = data or {}
	style = style or {}
	self._style = style
	self._shape = style.shape
	self._btnDatas = data.btnDatas or {}
	self._onClickTab = data.onClickTab
end

function BaseTabBtnWidget:getMainView()
	return self._mainAnim
end

function BaseTabBtnWidget:createTabController(tabBtns)
	self._tabController = TabController:new(tabBtns, nil, {
		buttonClick = function(sender, eventType, selectTag)
			self:onButtonTab(sender, eventType, selectTag)
		end
	})
end

function BaseTabBtnWidget:getScrollViewOffSetY()
	return self._scrollView:getInnerContainer():getPositionY()
end

function BaseTabBtnWidget:onButtonTab(sender, eventType, selectTag)
	if eventType == ccui.TouchEventType.began then
		self._scrollOffSetY = self:getScrollViewOffSetY()
	elseif eventType == ccui.TouchEventType.canceled then
		-- block empty
	elseif eventType == ccui.TouchEventType.ended and math.abs(self._scrollOffSetY - self:getScrollViewOffSetY()) < 2 then
		self._tabController:refreshSelectBtn(sender)
		self:_refrshSelectTabBtn(selectTag)
		self._onClickTab(name, selectTag)
	end
end

function BaseTabBtnWidget:bindRedPoint(btn, config)
	if not btn.redPoint then
		btn.redPoint = RedPoint:createDefaultNode()

		btn.redPoint:addTo(btn):posite(138, 100)
		btn.redPoint:setLocalZOrder(99900)
	end

	function btn:refreshRedPoint(curIndex)
		if config.redPointFunc then
			local factor1 = config.redPointFunc()
			local factor2 = not curIndex or curIndex and self:getTag() ~= curIndex

			self.redPoint:setVisible(factor1 and factor2)
		end
	end
end

function BaseTabBtnWidget:bindLockImg(btn, config)
	if not btn.lockImg then
		btn.lockImg = cc.Sprite:createWithSpriteFrameName("img_common_lock.png")

		btn.lockImg:setScale(0.7)
		btn.lockImg:addTo(btn, 1):posite(138, 105)
		btn.lockImg:setLocalZOrder(99900)
	end

	function btn:refreshLockState(isLock)
		btn.lockImg:setVisible(isLock)
	end

	btn:refreshLockState(config.lock)
end

function BaseTabBtnWidget:bindBtnAnim(btn, path, config, btnOffset)
	local tabText = config.tabText
	local fontSize = 28

	if utf8.len(tabText) > maxLength then
		fontSize = 26
	end

	local darkText = cc.Label:createWithTTF(config.tabText, TTF_FONT_FZYH_M, fontSize)

	GameStyle:setTabNormalTextEffect(darkText)
	darkText:setAnchorPoint(0.5, 0.5)

	local lightText = cc.Label:createWithTTF(config.tabText, TTF_FONT_FZYH_M, fontSize)

	lightText:setAnchorPoint(0.5, 0.5)
	GameStyle:setTabPressTextEffect(lightText)

	local anim = cc.MovieClip:create(path)

	anim:setPlaySpeed(1.2)

	function anim:setSelectState(isSelect)
		self:gotoAndPlay(0)

		if isSelect then
			-- block empty
		else
			self:stop()
		end
	end

	anim:addEndCallback(function()
		anim:stop()
	end)

	btn.anim = anim

	local width, height = -2, 6

	if btnOffset then
		anim:addTo(btn):center(btn:getContentSize()):offset(btnOffset.x, btnOffset.y)
	else
		anim:addTo(btn):center(btn:getContentSize()):offset(-34, 0)
	end

	local animNode = anim:getChildByName("name1")

	if animNode then
		darkText:addTo(animNode):center(animNode:getContentSize()):offset(width, height)
	end

	local animNode = anim:getChildByName("name2")

	if animNode then
		lightText:addTo(animNode):center(animNode:getContentSize()):offset(width, height)
	end

	anim:stop()
end

function BaseTabBtnWidget:setTabButtonHittingShape(button)
	local vertices = {
		cc.p(0, 55),
		cc.p(221, 0),
		cc.p(221, 100),
		cc.p(0, 155)
	}
	local shape = ccui.HittingPolygon:create(vertices)

	button:setHittingShape(shape)
end

function BaseTabBtnWidget:refreshAllRedPoint()
	for i = 1, #self._tabBtns do
		local btn = self._tabBtns[i]

		btn:refreshRedPoint((self._style.ignoreRedSelectState or nil) and false)
	end
end

function BaseTabBtnWidget:setSelectState(curTabType, isSelect)
	local tabBtn = self._tabBtns[curTabType]

	if tabBtn then
		tabBtn.anim:setSelectState(isSelect)
	end
end

function BaseTabBtnWidget:_refrshSelectTabBtn(curTabType)
	local config = self._btnDatas[curTabType]

	if config.lock then
		return false
	end

	self:setSelectState(self._curIndex, false)

	self._curIndex = curTabType

	self:setSelectState(self._curIndex, true)
	self:refreshAllRedPoint()
end

function BaseTabBtnWidget:selectTabByTag(curTabType)
	self:_refrshSelectTabBtn(curTabType)
	self._tabController:selectTabByTag(curTabType)
end
