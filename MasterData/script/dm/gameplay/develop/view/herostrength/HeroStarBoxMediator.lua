-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStarBoxMediator.lua

HeroStarBoxMediator = class("HeroStarBoxMediator", DmPopupViewMediator, _M)

HeroStarBoxMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local offsetX = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	50,
	50,
	12,
	22,
	30
}

function HeroStarBoxMediator:initialize()
	super.initialize(self)
end

function HeroStarBoxMediator:dispose()
	self._selectImage:release()
	super.dispose(self)
end

function HeroStarBoxMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROSTARUP_BOX_SUCC, self, self.updateView)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._sureWidget = self:bindWidget("main.selectBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickOk, self)
		}
	})
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Hero_Star_UI_Box_Choice_SC"),
		title1 = Strings:get("Hero_Star_UI_Box_Choice_EN"),
		bgSize = {
			width = 837,
			height = 574
		}
	})
end

function HeroStarBoxMediator:enterWithData(data)
	self:initData(data)

	if #self._starRewardsConfig <= 0 then
		return
	end

	self:initView()
	self:initTabView()
end

function HeroStarBoxMediator:initData(data)
	self._heroId = data.heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._starRewards = self._heroData:getStarRewards()
	self._starRewardsConfig = self._heroData:getStarRewardsConfig()
	self._selectTab = 1

	for i = 1, #self._starRewardsConfig do
		local starIndex = self._starRewardsConfig[i].star
		local reward = self._starRewards[starIndex]

		if reward then
			local isGotReward = reward:isGotReward()

			if not isGotReward then
				self._selectTab = i

				break
			end
		end
	end

	self._itemIndex = nil
end

function HeroStarBoxMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._selectImage = self._main:getChildByFullName("selectImage")

	self._selectImage:retain()
	self._selectImage:removeFromParent(false)

	self._tabpanel = self._main:getChildByFullName("tabpanel")
	self._selectBtn = self._main:getChildByFullName("selectBtn")
	self._lockTip = self._main:getChildByFullName("lockTip")
	self._nodes = {}

	for i = 1, 3 do
		local node = self._main:getChildByFullName("node_" .. i)
		local panel = node:getChildByFullName("panel")

		panel:addClickEventListener(function()
			self:onClickReward(i)
		end)

		self._nodes[i] = node
	end
end

function HeroStarBoxMediator:initTabView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #self._starRewardsConfig do
		local star = self._starRewardsConfig[i].star

		data[#data + 1] = {
			tabText = Strings:get("Hero_Star_UI_Reward", {
				star = star
			}),
			tabTextTranslate = Strings:get("UITitle_EN_456xingjiangli"),
			redPointFunc = function()
				local starIndex = self._starRewardsConfig[i].star
				local reward = self._starRewards[starIndex]

				return reward and not reward:isGotReward()
			end
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 634)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._selectTab)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(20, 4)
	view:setLocalZOrder(1100)
	view:setScale(0.7)
end

function HeroStarBoxMediator:refreshData()
	local starIndex = self._starRewardsConfig[self._selectTab].star

	self._reward = self._starRewards[starIndex]
	self._rewardNum = self._starRewardsConfig[self._selectTab].rewardNum
	self._rewardRarity = self._starRewardsConfig[self._selectTab].rewardRarity
end

function HeroStarBoxMediator:refreshView()
	local id = "YFZZhu"
	local itemId = "IHF_YFZZhu"

	self._selectBtn:setVisible(not not self._reward)
	self._lockTip:setVisible(not self._reward)

	if self._lockTip:isVisible() then
		local str = Strings:get("Hero_Star_UI_Reward_Unlock", {
			star = self._starRewardsConfig[self._selectTab].star
		})

		self._lockTip:getChildByFullName("text"):setString(str)

		for i = 1, #self._nodes do
			local node = self._nodes[i]
			local panel = node:getChildByFullName("panel")

			panel:removeAllChildren()

			local roleModel = IconFactory:getRoleModelByKey("HeroBase", id)
			local heroIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe4_7",
				id = roleModel
			})

			heroIcon:addTo(panel):center(panel:getContentSize())
			heroIcon:setColor(cc.c3b(0, 0, 0))

			local rarity = node:getChildByFullName("rarity")

			rarity:removeAllChildren()

			local anim = IconFactory:getHeroRarityAnim(self._rewardRarity)

			anim:addTo(rarity):offset(offsetX[self._rewardRarity], 5)
			anim:setScale(0.8)

			local iconNode = node:getChildByFullName("node")

			iconNode:removeAllChildren()

			local icon = IconFactory:createItemIcon({
				id = itemId,
				amount = self._rewardNum
			}, {
				color = cc.c3b(0, 0, 0)
			})

			icon:addTo(iconNode):setScale(0.7)

			local askImage = ccui.ImageView:create("img_yinghun_icon_ask.png", 1)

			askImage:addTo(iconNode)
			panel:setTouchEnabled(false)
			node:setGray(false)

			local button = node:getChildByFullName("button")

			button:setVisible(false)
		end
	else
		local isGotReward = self._reward:isGotReward()

		for i = 1, #self._nodes do
			itemId = self._reward:getItemIds()[i]
			id = ConfigReader:getDataByNameIdAndKey("ItemConfig", itemId, "TargetId").id

			local node = self._nodes[i]
			local panel = node:getChildByFullName("panel")

			panel:removeAllChildren()

			local roleModel = IconFactory:getRoleModelByKey("HeroBase", id)
			local heroIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe4_7",
				id = roleModel
			})

			heroIcon:addTo(panel):center(panel:getContentSize())

			local rarity = node:getChildByFullName("rarity")

			rarity:removeAllChildren()

			local anim = IconFactory:getHeroRarityAnim(self._rewardRarity)

			anim:addTo(rarity):offset(offsetX[self._rewardRarity], 5)
			anim:setScale(0.8)

			local iconnode = node:getChildByFullName("node")

			iconnode:removeAllChildren()

			local icon = IconFactory:createItemIcon({
				id = itemId,
				amount = self._reward:getItemCount()
			})

			icon:addTo(iconnode):setScale(0.7)
			node:setGray(false)
			panel:setTouchEnabled(not isGotReward)

			local button = node:getChildByFullName("button")

			button:addClickEventListener(function()
				self:onClickSeek(i)
			end)

			if isGotReward then
				button:setVisible(false)

				if itemId == self._reward:getSelectId() then
					local image = ccui.ImageView:create("img_yinghun_get.png", 1)

					image:addTo(iconnode):posite(42, 35)
				else
					node:setGray(true)
				end
			else
				button:setVisible(true)
			end
		end

		if self._selectBtn:isVisible() then
			self._selectBtn:setVisible(not isGotReward)
		end
	end

	if self._selectBtn:isVisible() then
		self._sureWidget:getButton():setGray(not self._itemIndex)
		self._sureWidget:getButton():setTouchEnabled(not not self._itemIndex)
	end
end

function HeroStarBoxMediator:updateView()
	self._itemIndex = nil

	self._selectImage:setVisible(false)
	self._selectImage:removeFromParent(false)
	self._selectImage:addTo(self:getView())
	self:refreshData()
	self:refreshView()
	self._tabBtnWidget:refreshAllRedPoint()

	local rewards = {
		self._getReward
	}
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}))
end

function HeroStarBoxMediator:onClickTab(name, tag)
	self._selectTab = tag
	self._itemIndex = nil

	self._selectImage:setVisible(false)
	self._selectImage:removeFromParent(false)
	self._selectImage:addTo(self:getView())
	self:refreshData()
	self:refreshView()
end

function HeroStarBoxMediator:onClickReward(index)
	self._itemIndex = index

	self._selectImage:setVisible(true)
	self._selectImage:removeFromParent(false)
	self._selectImage:addTo(self._nodes[self._itemIndex])
	self._selectImage:setPosition(cc.p(0, 38))
	self._sureWidget:getButton():setGray(not self._itemIndex)
	self._sureWidget:getButton():setTouchEnabled(not not self._itemIndex)
end

function HeroStarBoxMediator:onClickSeek(i)
	local itemId = self._reward:getItemIds()[i]
	local id = ConfigReader:getDataByNameIdAndKey("ItemConfig", itemId, "TargetId").id

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("HeroShowNotOwnView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		showType = 3,
		id = id
	}))
end

function HeroStarBoxMediator:onClickOk()
	if not self._itemIndex then
		return
	end

	local params = {
		heroId = self._heroId,
		star = self._starRewardsConfig[self._selectTab].star,
		itemId = self._reward:getItemIds()[self._itemIndex]
	}

	self._getReward = {
		code = params.itemId,
		amount = self._reward:getItemCount(),
		type = RewardType.kItem
	}

	self._heroSystem:requestSelectStarUpReward(params)
end

function HeroStarBoxMediator:onClickBack()
	self:close()
end
