-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tabBtn/CompositeTabBtnWidget.lua

CompositeTabBtnWidget = class("CompositeTabBtnWidget", BaseWidget, _M)

function CompositeTabBtnWidget.class:createWidgetNode()
	local resFile = "asset/ui/CompositeTabBtnWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

local tabBtnHeight = 10
local subTabBtnHeight = 10

function CompositeTabBtnWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function CompositeTabBtnWidget:dispose()
	self._closeView = true

	super.dispose(self)
end

function CompositeTabBtnWidget:initSubviews(view)
	self._view = view
	self._tabClone1 = view:getChildByFullName("tabclone1")

	self._tabClone1:setSwallowTouches(false)
	self._tabClone1:setVisible(false)

	self._tabClone2 = view:getChildByFullName("tabclone2")

	self._tabClone2:setSwallowTouches(false)
	self._tabClone2:setVisible(false)

	self._scrollView = view:getChildByFullName("scrollview")

	self._scrollView:setScrollBarEnabled(false)
end

function CompositeTabBtnWidget:initTabBtn(data, style)
	self._btnDatas = data.btnDatas or {}
	self._onClickTab = data.onClickTab
	self._onClickSubTab = data.onClickSubTab
	self._style = style
	self._mainAnim = cc.MovieClip:create("zuobiankuang_paihang")

	self._mainAnim:setPlaySpeed(1.2)

	local animNode = self._mainAnim:getChildByName("bg")

	if animNode then
		local winSize = cc.Director:getInstance():getWinSize()
		local bgImg = ccui.Scale9Sprite:createWithSpriteFrameName("img_cefang_bg.png")

		bgImg:setAnchorPoint(1, 0.5)
		bgImg:setCapInsets(cc.rect(2, 2, 10, 8))
		bgImg:setContentSize(cc.size(200, 852))
		bgImg:addTo(animNode):center(animNode:getContentSize()):offset(40, 426 - (winSize.height - 640) / 2)
	end

	local animNode = self._mainAnim:getChildByName("btn1")

	if animNode then
		self._scrollView:changeParent(animNode, 1):posite(158, -240)
	end

	self:_createTabBtns()
	self:refreshAllRedPoint()
	self._mainAnim:addEndCallback(function()
		self._mainAnim:stop()
	end)
end

function CompositeTabBtnWidget:refreshTabBtnSelectState(selectIndex)
	selectIndex = selectIndex or self._mainTabIndex

	for i = 1, #self._tabBtns do
		self._tabBtns[i]:showLight(selectIndex and i == selectIndex)
	end
end

function CompositeTabBtnWidget:showLayoutForTest(layout, color)
	if layout then
		layout:setBackGroundColorType(1)
		layout:setBackGroundColor(color or cc.c3b(0, 255, 0))
		layout:setBackGroundColorOpacity(180)
	end
end

function CompositeTabBtnWidget:refreshAllRedPoint()
	for i = 1, #self._tabBtns do
		self._tabBtns[i]:refreshRedPoint()
		self._tabBtns[i]:refreshSubTabBtnRedPoint()
	end
end

function CompositeTabBtnWidget:_createTabBtns()
	local cellCount = #self._btnDatas
	local tabBtns = {}

	for i = 1, cellCount do
		local btn = self._tabClone1:clone()

		function btn:createButtonChildren(config)
			local maxLength = 4
			local fontSize = 28

			if maxLength < utf8.len(config.tabText) then
				fontSize = 26
			end

			local width, height = 60, 30

			self.darkNode = cc.Node:create()

			self.darkNode:addTo(self)

			local darkText = cc.Label:createWithTTF(config.tabText, TTF_FONT_FZYH_M, fontSize)
			local lineGradiantVec2 = {
				{
					ratio = 0.15,
					color = cc.c4b(231, 249, 255, 255)
				},
				{
					ratio = 0.85,
					color = cc.c4b(132, 167, 223, 255)
				}
			}

			darkText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = -1
			}))
			darkText:enableOutline(cc.c4b(13, 25, 76, 114.75), 2)
			darkText:enableShadow(cc.c4b(12, 19, 47, 114.75), cc.size(1, -1), 2)
			darkText:setAnchorPoint(0.5, 0.5)

			local darkImg = cc.Sprite:createWithSpriteFrameName("tab_unselt.png")

			darkImg:setAnchorPoint(0, 0)
			darkImg:addTo(self.darkNode):offset(-12, -34)
			darkText:addTo(self.darkNode):center(self.darkNode:getContentSize()):offset(width + 5, height)

			self.lightNode = cc.Node:create()

			self.lightNode:addTo(self)

			local lightText = cc.Label:createWithTTF(config.tabText, TTF_FONT_FZYH_M, fontSize)

			lightText:setAnchorPoint(0.5, 0.5)

			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 168, 65, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 239, 200, 255)
				}
			}

			lightText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
				x = 0,
				y = -1
			}))
			lightText:enableOutline(cc.c4b(57, 32, 4, 114.75), 2)
			lightText:enableShadow(cc.c4b(78, 19, 5, 114.75), cc.size(1, -1), 2)

			local lightImg = cc.Sprite:createWithSpriteFrameName("tab_selt.png")

			lightImg:setAnchorPoint(0, 0)
			lightImg:addTo(self.lightNode):offset(-42, -37)

			local lightBackImg = cc.Sprite:createWithSpriteFrameName("tab_selt_chang.png")

			lightBackImg:setAnchorPoint(0, 0)
			lightBackImg:addTo(lightImg):center(lightImg:getContentSize()):offset(-0, 3)
			lightText:addTo(self.lightNode):center(self.lightNode:getContentSize()):offset(width, height)
		end

		function btn:showLight(isLight)
			self.darkNode:setVisible(not isLight)
			self.lightNode:setVisible(isLight)
		end

		function btn:refreshRedPoint()
			if not self.redPoint then
				self.redPoint = RedPoint:createDefaultNode()

				self.redPoint:addTo(btn):posite(125, 60)
				self.redPoint:setLocalZOrder(99900)
			end

			if self.config.redPointFunc then
				local factor1 = self.config.redPointFunc()

				self.redPoint:setVisible(factor1)
			end
		end

		function btn:refreshLockState(isLock)
			if not self.lockImg then
				self.lockImg = cc.Sprite:createWithSpriteFrameName("img_common_lock.png")

				self.lockImg:setScale(0.8)
				self.lockImg:addTo(self, 1):posite(124, 58)
				self.lockImg:setLocalZOrder(99900)
			end

			self.lockImg:setVisible(isLock)
		end

		function btn:getLock()
			return self.lockImg:isVisible()
		end

		btn:setVisible(true)

		function btn:getConfig()
			return self.config
		end

		local config = self._btnDatas[i]

		btn:createButtonChildren(config)
		btn:refreshLockState(config.lock)

		tabBtns[#tabBtns + 1] = btn
		btn.config = config

		self:_bindSubTabBtns(btn)
		btn:addTo(self._scrollView)
		btn:setTag(i)
	end

	self._tabBtns = tabBtns
	self._tabController = TabController:new(tabBtns, nil, {
		ignoreRepeatClick = true,
		buttonClick = function(sender, eventType, selectTag)
			self:onButtonTab(sender, eventType, selectTag)
		end
	})
end

function CompositeTabBtnWidget:getTabBtnByIndex(index)
	index = index or self._mainTabIndex

	return self._tabBtns[index]
end

function CompositeTabBtnWidget:_getSubTabController(index)
	index = index or self._mainTabIndex

	return self:getTabBtnByIndex(index):getTabController()
end

function CompositeTabBtnWidget:rsetScrollContentSize()
	local allHeight = 0

	for i = 1, #self._tabBtns do
		local btn = self._tabBtns[i]

		allHeight = allHeight + btn:getSubHeight()
	end

	allHeight = math.max(allHeight, self._scrollView:getContentSize().height)

	self._scrollView:setInnerContainerSize(cc.size(251, allHeight + 90))

	local posY = allHeight

	for i = 1, #self._tabBtns do
		local btn = self._tabBtns[i]

		btn:setPositionY(posY)

		posY = posY - btn:getSubHeight()
	end
end

function CompositeTabBtnWidget:_bindSubTabBtns(parent)
	local tabClone2 = self._tabClone2

	function parent:createSubBtns()
		self.btnNode = cc.Node:create()

		self.btnNode:setVisible(false)
		self.btnNode:addTo(self)

		local config = self:getConfig()

		if not config.btnDatas then
			local btnDatas = {}
			local cellCount = #btnDatas

			self.subTabBtns = {}
			self.subHeight = cellCount * (tabClone2:getContentSize().height + subTabBtnHeight)

			for i = 1, cellCount do
				local btn = tabClone2:clone()

				btn:setSwallowTouches(false)
				btn:setVisible(true)

				local config = btnDatas[i]

				self.subTabBtns[#self.subTabBtns + 1] = btn
				btn.config = config

				function btn:getConfig()
					return self.config
				end

				function btn:createButtonChildren(config)
					local fontSize = 20
					local width, height = 65, 40

					self.darkNode = cc.Node:create()

					self.darkNode:addTo(self)

					local darkText = cc.Label:createWithTTF(config.tabText, TTF_FONT_FZYH_M, fontSize)

					darkText:setAnchorPoint(0.5, 0.5)
					darkText:addTo(self.darkNode):center(self.darkNode:getContentSize()):offset(width, height)

					self.lightNode = cc.Node:create()

					self.lightNode:addTo(self)

					local lightText = cc.Label:createWithTTF(config.tabText, TTF_FONT_FZYH_M, fontSize)

					lightText:setAnchorPoint(0.5, 0.5)

					local lightImg = cc.Sprite:createWithSpriteFrameName("img_xuanzhong.png")

					lightImg:setAnchorPoint(0, 0)
					lightImg:addTo(self.lightNode):offset(0, 10)
					lightText:addTo(self.lightNode):center(self.lightNode:getContentSize()):offset(width, height)
				end

				function btn:refreshRedPoint()
					if not self.redPoint then
						self.redPoint = RedPoint:createDefaultNode()

						self.redPoint:addTo(btn):posite(120, 60)
						self.redPoint:setLocalZOrder(99900)
					end

					if self.config.redPointFunc then
						local factor1 = self.config.redPointFunc()

						self.redPoint:setVisible(factor1)
					end
				end

				function btn:refreshLockState(isLock)
					if not self.lockImg then
						self.lockImg = cc.Sprite:createWithSpriteFrameName("img_common_lock.png")

						self.lockImg:setScale(0.8)
						self.lockImg:addTo(self, 1):posite(124, 58)
						self.lockImg:setLocalZOrder(99900)
					end

					self.lockImg:setVisible(isLock)
				end

				function btn:getLock()
					return self.lockImg:isVisible()
				end

				function btn:showLight(isLight)
					self.darkNode:setVisible(not isLight)
					self.lightNode:setVisible(isLight)
				end

				btn:createButtonChildren(config)
				btn:addTo(self.btnNode)
				btn:setTag(i)
				btn:setPosition(0, -(btn:getContentSize().height + subTabBtnHeight) * i)
			end
		end
	end

	function parent:refreshSubTabBtnSelectState(selectIndex)
		local subTabBtns = self:getSubTabBtns()

		for i = 1, #subTabBtns do
			subTabBtns[i]:showLight(i == selectIndex)
		end
	end

	function parent:refreshSubTabBtnRedPoint()
		local subTabBtns = self:getSubTabBtns()

		for i = 1, #subTabBtns do
			subTabBtns[i]:refreshRedPoint()
		end
	end

	function parent:setSubBtnsVisible(isVisible)
		self.btnNode:setVisible(isVisible)
	end

	function parent:isSubBtnsVisible()
		return self.btnNode:isVisible()
	end

	function parent:getSubHeight()
		local height = self:getContentSize().height + tabBtnHeight

		if self:isSubBtnsVisible() then
			height = height + self.subHeight
		end

		return height
	end

	function parent:getSubTabBtns()
		return self.subTabBtns
	end

	function parent:getSubTabBtnByIndex(index)
		return self:getSubTabBtns()[index]
	end

	function parent:getTabController()
		return self.tabController
	end

	parent:createSubBtns()

	parent.tabController = TabController:new(parent:getSubTabBtns(), nil, {
		buttonClick = function(sender, eventType, selectTag)
			self:onButtonSubTab(sender, eventType, selectTag)
		end
	})
end

function CompositeTabBtnWidget:hideAllSubTabBtns()
	for i = 1, #self._tabBtns do
		local btn = self._tabBtns[i]

		btn:setSubBtnsVisible(false)
	end
end

function CompositeTabBtnWidget:onButtonTab(sender, eventType, selectTag)
	if eventType == ccui.TouchEventType.began then
		self._scrollOffSetY = self:getScrollViewOffSetY()
	elseif eventType == ccui.TouchEventType.canceled then
		-- block empty
	elseif eventType == ccui.TouchEventType.ended and math.abs(self._scrollOffSetY - self:getScrollViewOffSetY()) < 2 then
		self._tabController:refreshSelectBtn(sender)

		if self._mainTabIndex == selectTag then
			self._mainTabIndex = nil
		else
			self._mainTabIndex = selectTag
		end

		local btn = self._tabBtns[selectTag]
		local config = btn:getConfig()

		if config.lock then
			if self._onClickTab and self._mainTabIndex then
				self._onClickTab(name, self._mainTabIndex)
			end
		else
			self:hideAllSubTabBtns()
			btn:setSubBtnsVisible(self._mainTabIndex ~= nil)
			self:rsetScrollContentSize()
			self:refreshTabBtnSelectState()

			if not self._mainTabIndex then
				self._tabBtns[selectTag]:showLight(true)
			end

			if self._onClickTab and self._mainTabIndex then
				self._onClickTab(name, self._mainTabIndex)
			end
		end
	end
end

function CompositeTabBtnWidget:onButtonSubTab(sender, eventType, selectTag)
	if eventType == ccui.TouchEventType.began then
		self._scrollOffSetY = self:getScrollViewOffSetY()
	elseif eventType == ccui.TouchEventType.canceled then
		-- block empty
	elseif eventType == ccui.TouchEventType.ended and math.abs(self._scrollOffSetY - self:getScrollViewOffSetY()) < 2 then
		local tabBtn = self:getTabBtnByIndex()
		local tabController = self:_getSubTabController()

		tabController:refreshSelectBtn(sender)

		self._subTabIndex = selectTag

		tabBtn:refreshSubTabBtnSelectState(selectTag)

		if self._onClickSubTab then
			self._onClickSubTab(name, self._mainTabIndex, self._subTabIndex)
		end
	end
end

function CompositeTabBtnWidget:selectTabByTag(curTabType)
	self._tabController:selectTabByTag(curTabType)
end

function CompositeTabBtnWidget:selectSubTabByTag(selectTag, curTabType)
	local btn = self._tabBtns[selectTag]
	local subTabController = btn:getTabController()

	subTabController:selectTabByTag(curTabType)

	local tabBtn = self:getTabBtnByIndex()
	local tabBtnHeight = tabBtn:getContentSize().height

	self:scrollTabPanel(curTabType, tabBtnHeight)
end

function CompositeTabBtnWidget:getScrollViewOffSetY()
	return self._scrollView:getInnerContainer():getPositionY()
end

function CompositeTabBtnWidget:getMainView()
	return self._mainAnim
end

function CompositeTabBtnWidget:scrollTabPanel(tag, tabBtnHeight)
	local maxY = -self._scrollView:getInnerContainer():getContentSize().height + self._scrollView:getContentSize().height

	posY = maxY + (tag - 4) * (tabBtnHeight + subTabBtnHeight) + 5

	if maxY < 0 and tag > 4 then
		self._scrollView:getInnerContainer():setPositionY(posY)
	end
end
