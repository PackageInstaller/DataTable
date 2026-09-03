-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopSurfaceMediator.lua

require("dm.gameplay.shop.view.component.ShopItem")

ShopSurfaceMediator = class("ShopSurfaceMediator", DmAreaViewMediator, _M)

ShopSurfaceMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopSurfaceMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBg = {
	"sd_pf_rwd_xz.png",
	"sd_pf_rwdi.png"
}
local kCellHeight = 202
local kCellWidth = 130
local kLeftWidth = 184
local kBtnHandlers = {
	["main.rolePanel_1.buyBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBuy"
	}
}

function ShopSurfaceMediator:initialize()
	super.initialize(self)
end

function ShopSurfaceMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self:getView():stopAllActions()
	self:stopItemActions()
	super.dispose(self)
end

function ShopSurfaceMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function ShopSurfaceMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshShopData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOP_REFRESH_SUCC, self, self.refreshShopData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHSHOPBYRSET_SUCC, self, self.refreshShopData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESHBYGOLDORDIMOND_SUCC, self, self.refreshShopData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SURFACE_BUY_SUCC, self, self.onBuyShopSuccess)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_SURFACE_SUCC, self, self.refreshShopData)
end

function ShopSurfaceMediator:onRemove()
	super.onRemove(self)
end

function ShopSurfaceMediator:setupView(mediator)
	self._mediator = mediator

	self:initMember()
end

function ShopSurfaceMediator:refreshData()
	self._curShopItems = self._shopSystem:getSurfaceList()
	self._selectIndex = self._selectIndex or 1

	if self._curSurface then
		local id = self._curSurface:getId()

		for i = 1, #self._curShopItems do
			if self._curShopItems[i]:getId() == id then
				self._selectIndex = i

				break
			end
		end

		self._curSurface = self._curShopItems[self._selectIndex]
	else
		self._curSurface = self._curShopItems[self._selectIndex]
	end
end

function ShopSurfaceMediator:initMember()
	local panel = self:getView()

	self._cellClone = panel:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._mainPanel = panel:getChildByFullName("main")

	self._cellClone:getChildByFullName("cell.touch_panel"):setLocalZOrder(10)
	self._cellClone:getChildByFullName("cell.touch_panel"):setTouchEnabled(true)
	self._cellClone:getChildByFullName("cell.touch_panel"):setSwallowTouches(false)

	self._rolePanel = self._mainPanel:getChildByFullName("rolePanel")
	self._rolePanel0 = self._mainPanel:getChildByFullName("rolePanel_0")
	self._rolePanel1 = self._mainPanel:getChildByFullName("rolePanel_1")
	self._limitPanel = self._rolePanel0:getChildByFullName("limitPanel")

	self._limitPanel:setVisible(false)
	self._limitPanel:getChildByFullName("text"):setLineSpacing(-9)

	self._surfaceName = self._rolePanel0:getChildByFullName("surfaceName")
	self._infoPanel = self._rolePanel1:getChildByFullName("infoPanel")
	self._surfaceDesc = self._infoPanel:getChildByFullName("surfaceDesc")
	self._name = self._rolePanel0:getChildByFullName("name")
	self._roleNode = self._rolePanel:getChildByFullName("roleNode")
	self._buyBtn = self._rolePanel1:getChildByFullName("buyBtn")
	self._costNode = self._rolePanel1:getChildByFullName("costNode")
	self._got = self._rolePanel1:getChildByFullName("got")
	self._moneyText = self._costNode:getChildByFullName("text")
	self._moneyIcon = self._costNode:getChildByFullName("icon")
	self._rarity = self._rolePanel1:getChildByFullName("rarity")

	self._rarity:ignoreContentAdaptWithSize(true)

	self._bonusPanel = self._mainPanel:getChildByFullName("bonusPanel")

	self._bonusPanel:setVisible(false)

	self._ruleBtn = self._mainPanel:getChildByFullName("ruleBtn")

	self._ruleBtn:setTouchEnabled(true)
	self._ruleBtn:addTouchEventListener(function(sender, eventType)
		self:onClickRule(sender, eventType)
	end)

	local iconLayout = self._cellClone:getChildByFullName("cell.icon_layout")

	self._posY = iconLayout:getContentSize().height / 2

	self:adjustView()
end

function ShopSurfaceMediator:adjustView()
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()
	local currentWidth = winSize.width - kLeftWidth - AdjustUtils.getAdjustX() - 3
	local delta = (winSize.width - 1136) / 2
	local positionX = kLeftWidth + AdjustUtils.getAdjustX() - delta

	self._scrollView = self._mainPanel:getChildByName("scrollView")

	self._scrollView:setContentSize(cc.size(currentWidth, kCellHeight))
	self._scrollView:setPositionX(positionX)
	self._scrollView:setInnerContainerSize(cc.size(currentWidth, kCellHeight))
	self._scrollView:setScrollBarEnabled(false)
end

function ShopSurfaceMediator:onBuyShopSuccess(event)
	local data = event:getData()

	if data.rewards then
		local view = self:getInjector():getInstance("GetSurfaceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			surfaceId = data.rewards[1].code
		}))
	end

	self:refreshData()

	local offsetX = self._scrollView:getInnerContainerPosition().x
	local offsetY = self._scrollView:getInnerContainerPosition().y

	self:refreshView()
	self._scrollView:setInnerContainerPosition(cc.p(offsetX, offsetY))
end

function ShopSurfaceMediator:refreshShopData()
	self:refreshData()

	local offsetX = self._scrollView:getInnerContainerPosition().x
	local offsetY = self._scrollView:getInnerContainerPosition().y

	self:refreshView()
	self._scrollView:setInnerContainerPosition(cc.p(offsetX, offsetY))
end

function ShopSurfaceMediator:clearView()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self._selectIndex = nil
	self._curSurface = nil

	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()
end

function ShopSurfaceMediator:refreshView()
	self:getView():stopAllActions()
	self:stopItemActions()
	self._scrollView:removeAllChildren()

	local length = #self._curShopItems

	self._items = {}

	self._scrollView:setInnerContainerPosition(cc.p(0, 0))

	for i = 1, length do
		self:createCell(self._scrollView, i)
	end

	self._scrollView:setBounceEnabled(true)

	local innerWidth = length * kCellWidth

	if innerWidth > self._scrollView:getContentSize().width then
		self._scrollView:setInnerContainerSize(cc.size(innerWidth, kCellHeight))
		self._scrollView:setMaxBounceOffset(20)
	else
		self._scrollView:setMaxBounceOffset(0.001)
	end

	self:refreshRolePanel()
	self:runListAnim()
end

function ShopSurfaceMediator:refreshItemPanel()
	local panel = self._curPanel:getChildByFullName("cell")
	local iconLayout = panel:getChildByFullName("icon_layout")
	local tipIcon = panel:getChildByFullName("tipIcon")

	tipIcon:setPositionY(139)

	local bg = panel:getChildByFullName("bg")

	bg:ignoreContentAdaptWithSize(true)
	bg:loadTexture(kBg[2], 1)
	iconLayout:getChildByFullName("HeroIcon"):setPositionY(self._posY - 23)

	self._curPanel = self._items[self._selectIndex]

	local panel = self._curPanel:getChildByFullName("cell")
	local iconLayout = panel:getChildByFullName("icon_layout")
	local tipIcon = panel:getChildByFullName("tipIcon")

	tipIcon:setPositionY(162)

	local bg = panel:getChildByFullName("bg")

	bg:ignoreContentAdaptWithSize(true)
	bg:loadTexture(kBg[1], 1)
	iconLayout:getChildByFullName("HeroIcon"):setPositionY(self._posY)
end

function ShopSurfaceMediator:refreshRolePanel()
	local path = "asset/scene/" .. self._curSurface:getBackGroundImg()

	self._mediator:changeBackground(path)

	self._roleId = self._curSurface:getTargetHeroId()

	self._rarity:setVisible(true)

	local config = ConfigReader:getRecordById("HeroBase", self._roleId)

	if not config then
		config = ConfigReader:getRecordById("MasterBase", self._roleId)

		self._rarity:setVisible(false)
	end

	self._name:setString(Strings:get(config.Name))

	if self._rarity:isVisible() then
		local hero = self._heroSystem:getHeroById(self._roleId)

		self._rarity:loadTexture(GameStyle:getHeroRarityImage((hero or nil) and hero:getRarity()), 1)
	end

	self._roleNode:removeAllChildren()

	local roleModel = self._curSurface:getModel()
	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		id = roleModel
	})

	self._roleNode:addChild(img)
	img:setPosition(cc.p(70, -100))

	local roleNode = self._infoPanel:getChildByFullName("roleNode")

	roleNode:removeAllChildren()

	local model = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "Model")
	local role = RoleFactory:createRoleAnimation(model)

	role:addTo(roleNode):posite(0, -5)
	role:setScale(0.7)
	self._surfaceName:setString(self._curSurface:getName())
	self._surfaceDesc:setString(self._curSurface:getDesc())

	local price = self._curSurface:getPrice()

	price = price == 0 and Strings:get("Recruit_Free") or price

	self._moneyText:setString(price)

	local goldIcon = IconFactory:createResourcePic({
		id = self._curSurface:getCostType()
	})

	goldIcon:addTo(self._moneyIcon)

	if self._curSurface:getStock() == 0 then
		self._got:setVisible(true)
		self._buyBtn:setVisible(false)
	else
		self._got:setVisible(false)
		self._buyBtn:setVisible(true)
	end

	self:setRecommendImg()
end

function ShopSurfaceMediator:createCell(cell, index)
	local itemIndex = index
	local itemData = self._curShopItems[itemIndex]

	if itemData then
		local clonePanel = self._cellClone:clone()

		clonePanel:setVisible(true)
		cell:addChild(clonePanel)
		clonePanel:setPosition((index - 1) * kCellWidth, 0)
		clonePanel:setTag(index)
		self:setInfo(clonePanel, itemData, itemIndex)

		if itemIndex == self._selectIndex then
			self._curPanel = clonePanel
		end

		self._items[itemIndex] = clonePanel
	end
end

function ShopSurfaceMediator:setInfo(panel, data, index)
	panel = panel:getChildByFullName("cell")

	local iconLayout = panel:getChildByFullName("icon_layout")
	local nameText = panel:getChildByFullName("goods_name")
	local limitIcon = panel:getChildByFullName("limitIcon")
	local bg = panel:getChildByFullName("bg")
	local tipIcon = panel:getChildByFullName("tipIcon")

	tipIcon:setPositionY(index == self._selectIndex and 162 or 139)
	bg:ignoreContentAdaptWithSize(true)

	local touchPanel = panel:getChildByFullName("touch_panel")

	touchPanel:addTouchEventListener(function()
		self:onClickItem(index)
	end)

	if index == self._selectIndex then
		if not kBg[1] then
			local bgPath = kBg[2]

			if index == self._selectIndex then
				if not self._posY then
					local posY = self._posY - 23

					bg:loadTexture(bgPath, 1)

					local color = cc.c3b(255, 255, 255)

					self:cleanMarkImage(panel)

					local times1 = data:getStock()

					if times1 == 0 then
						self:setMarkImg(panel, Strings:get("shop_UI43"))

						color = cc.c3b(125, 125, 125)
					end

					panel:setColor(color)

					local name = data:getName()

					nameText:setString(name)
					iconLayout:removeAllChildren()

					local heroImg = IconFactory:createRoleIconSpriteNew({
						frameId = "bustframe7_1",
						id = data:getModel()
					})

					heroImg:addTo(iconLayout):center(iconLayout:getContentSize())
					heroImg:setName("HeroIcon")
					heroImg:setPositionY(posY)
					heroImg:setScale(0.5)

					local isLimit = data:getIsLimit()

					limitIcon:setVisible(isLimit)
				end
			end
		end
	end
end

function ShopSurfaceMediator:onClickItem(index)
	self._selectIndex = index
	self._curSurface = self._curShopItems[self._selectIndex]

	self:refreshItemPanel()
	self:refreshRolePanel()
end

function ShopSurfaceMediator:onClickBuy()
	local times1 = self._curSurface:getStock()

	if times1 == 0 then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

	local view = self:getInjector():getInstance("ShopBuySurfaceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		item = self._curSurface
	}))
end

function ShopSurfaceMediator:cleanMarkImage(panel)
	local image = panel:getChildByFullName("SoldOutMark")

	if image then
		image:removeFromParent()

		return
	end
end

function ShopSurfaceMediator:setRecommendImg(panel, tagData)
	local isLimit = self._curSurface:getIsLimit()

	if not isLimit or self._curSurface:getStock() == 0 then
		if self._timer then
			self._timer:stop()

			self._timer = nil
		end

		self._limitPanel:setVisible(false)

		return
	end

	self._limitPanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._curSurface:getEndMills()

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()
			endMills = self._curSurface:getEndMills()

			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				performWithDelay(self:getView(), function()
					self._shopSystem:requestGetSurfaceShop()
					self._timer:stop()

					self._timer = nil

					self._limitPanel:setVisible(false)
				end, 0.5)

				return
			end

			local str = ""
			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])
			str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

			self._limitPanel:getChildByFullName("time"):setString(Strings:get("shop_UI45", {
				time = str
			}))
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ShopSurfaceMediator:setMarkImg(panel, type)
	local image = panel:getChildByFullName("ImageMark")

	if not type then
		if image then
			image:removeFromParent()
		end

		return
	end

	if not image then
		image = ccui.ImageView:create("sd_pf_ygm_2.png", 1)

		image:addTo(panel):posite(62, 38)
		image:setName("ImageMark")

		local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

		label:addTo(image):center(image:getContentSize())
		label:setName("TipMark")
	end

	image:getChildByFullName("TipMark"):setString(type)
end

function ShopSurfaceMediator:stopItemActions()
	local allCells = self._scrollView:getChildren()

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			local node = child

			if node and node:getChildByFullName("cell") then
				node = node:getChildByFullName("cell")

				node:stopAllActions()
			end
		end
	end
end

function ShopSurfaceMediator:runListAnim()
	self._scrollView:setTouchEnabled(false)

	local allCells = self._scrollView:getChildren()

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			local node = child

			if node and node:getChildByFullName("cell") then
				node = node:getChildByFullName("cell")

				node:setOpacity(0)
			end
		end
	end

	local length = #allCells
	local delayTime = 0.16666666666666666

	for i = 1, #allCells do
		local child = allCells[i]

		if child then
			local node = child

			if node and node:getChildByFullName("cell") then
				node = node:getChildByFullName("cell")

				local time = (i - 1) * delayTime
				local delayAction = cc.DelayTime:create(time)
				local callfunc = cc.CallFunc:create(function()
					CommonUtils.runActionEffect(node, "Node_1.myPetClone", "TaskDailyEffect", "anim1", false)
				end)
				local callfunc1 = cc.CallFunc:create(function()
					node:setOpacity(255)

					if length == i then
						self._scrollView:setTouchEnabled(true)
					end
				end)
				local seq = cc.Sequence:create(delayAction, callfunc, callfunc1)

				self:getView():runAction(seq)
			end
		end
	end
end

function ShopSurfaceMediator:onClickRule(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._bonusPanel:setVisible(true)
		self:refreshInnerAttrPanel()
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._bonusPanel:setVisible(false)
	end
end

function ShopSurfaceMediator:refreshInnerAttrPanel()
	local list = {
		Strings:get("Shop_Surface_Repeat_Tips")
	}

	if #list == 0 then
		self._bonusPanel:setVisible(false)

		return
	end

	local textLabel = self._bonusPanel:getChildByName("text")

	textLabel:setVisible(false)

	local width = 0
	local height = 23
	local posY = 175

	self._bonusPanel:getChildByName("panel"):removeAllChildren()

	for i = 1, #list do
		local text = textLabel:clone()

		text:setVisible(true)
		text:addTo(self._bonusPanel:getChildByName("panel"))
		text:setTag(12138)
		text:getVirtualRenderer():setDimensions(300, 0)
		text:setString(list[i])
		text:setPositionY(posY - text:getContentSize().height / 2 + 15)

		posY = posY - text:getContentSize().height
		width = math.max(width, text:getContentSize().width)
		height = height + text:getContentSize().height
	end

	self._bonusPanel:getChildByName("imageBg"):setContentSize(cc.size(width + 40, height))
end
