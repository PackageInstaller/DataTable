-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityBlockSummerExchangeMediator.lua

ActivityBlockSummerExchangeMediator = class("ActivityBlockSummerExchangeMediator", DmAreaViewMediator, _M)

ActivityBlockSummerExchangeMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityBlockSummerExchangeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityBlockSummerExchangeMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")
ActivityBlockSummerExchangeMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
ActivityBlockSummerExchangeMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local kBtnHandlers = {}
local kNums = 4
local kCellHeight = 518
local kCellWidth = 832

function ActivityBlockSummerExchangeMediator:initialize()
	super.initialize(self)
end

function ActivityBlockSummerExchangeMediator:dispose()
	super.dispose(self)
end

function ActivityBlockSummerExchangeMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PASSPORT_REFRESH, self, self.refreshView)
end

function ActivityBlockSummerExchangeMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))
end

function ActivityBlockSummerExchangeMediator:resumeWithData()
	self:initData()
	self:initView()
	self:refreshScrollView()
	self:setTalkView()
	self:setTimeUi()
end

function ActivityBlockSummerExchangeMediator:refreshView()
	self:initData()
	self:refreshScrollView()
	self:setTalkView()
	self:setTimeUi()
end

function ActivityBlockSummerExchangeMediator:enterWithData(data)
	self._data = data

	self:setupTopInfoWidget()
	self:initData()
	self:initView()
	self:refreshScrollView()
	self:setTalkView()
	self:setTimeUi()
end

function ActivityBlockSummerExchangeMediator:refreshTableView()
	if self._rewardView then
		self._rewardView:reloadData()
	end
end

function ActivityBlockSummerExchangeMediator:initData()
	self._activityId = self._data.activityId
	self._summerActivity = self._activitySystem:getActivityById(self._activityId)
	self._exchangeMap = {}

	if self._summerActivity then
		self._exchangeActivitys = self._summerActivity:getExchangeActivity()

		if self._exchangeActivitys then
			local currencyInfo = self._exchangeActivitys:getActivityConfig().ResourcesBanner
			local config = {
				style = 1,
				currencyInfo = currencyInfo,
				btnHandler = {
					clickAudio = "Se_Click_Close_1",
					func = bind1(self.onClickBack, self)
				},
				title = Strings:get(self._exchangeActivitys:getTitle())
			}

			self._topInfoWidget:updateView(config)

			self._exchangeMap = self._exchangeActivitys:getSortSummerExchangeList()
		end
	end
end

function ActivityBlockSummerExchangeMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._cellClone = self:getView():getChildByFullName("cellClone")

	self._cellClone:setVisible(false)
	self._cellClone:getChildByFullName("cell.rewardPanel"):setTouchEnabled(false)

	self._cellWidth = self._cellClone:getContentSize().width
	self._cellHeight = self._cellClone:getContentSize().height
	self._cellHeight = self._cellHeight + 3
	self._scrollBg = self._main:getChildByFullName("scrollBg")
	self._scrollBarBg = self._main:getChildByFullName("scrollBarBg")
	self._titleDesc = self._main:getChildByFullName("titleDesc")
	self._scrollView = self._main:getChildByFullName("scrollView")

	self._scrollView:setScrollBarEnabled(true)
	self._scrollView:setScrollBarAutoHideTime(9999)
	self._scrollView:setScrollBarColor(cc.c3b(243, 220, 142))
	self._scrollView:setScrollBarAutoHideEnabled(true)
	self._scrollView:setScrollBarWidth(5)
	self._scrollView:setScrollBarOpacity(255)
	self._scrollView:setScrollBarPositionFromCorner(cc.p(10, 15))

	self._rolePanel = self._main:getChildByFullName("talkPanel.rolePanel")
	self._talkText = self._main:getChildByFullName("talkPanel.Text_talk")
	self._talkRole = self._main:getChildByFullName("talkPanel")

	self._rolePanel:removeAllChildren()
	self._talkRole:getChildByName("Image_19"):setVisible(false)

	self._shopSpine = ShopSpine:new()

	self._shopSpine:addSpine(self._rolePanel)
	self._talkRole:addClickEventListener(function(sender)
		self:onClickTalkRole(sender)
	end)

	self._timeNode = self._main:getChildByFullName("timeNode")
	self._time = self._main:getChildByFullName("timeNode.time")

	self._titleDesc:setString(Strings:get(self._exchangeActivitys:getDesc()))
end

function ActivityBlockSummerExchangeMediator:setTalkView()
	self._showTalk = false

	self:onClickTalkRole()
end

function ActivityBlockSummerExchangeMediator:onClickTalkRole(sender)
	self._showTalk = not self._showTalk

	local talkBg = self._talkRole:getChildByName("Image_20")

	talkBg:setVisible(self._showTalk)
	self._talkText:setVisible(self._showTalk)
	self._talkText:setString(self._shopSystem:getShopTalkShow())
	self:playAnimation(sender)
end

function ActivityBlockSummerExchangeMediator:playAnimation(sender)
	local function callback(voice)
		return
	end

	if self._buySuccessedInstance then
		self._buySuccessedInstance = false

		self._shopSpine:playAnimation(nil, nil, KShopVoice.buyEnd, callback)

		return
	end

	if sender then
		if self._shopSpine:getActionStatus() then
			self._shopSpine:playAnimation(KShopAction.click, false, KShopVoice.click, callback)
		end
	else
		self._shopSpine:playAnimation(KShopAction.begin, false, KShopVoice.begin, callback)
	end
end

function ActivityBlockSummerExchangeMediator:refreshScrollView()
	self._scrollView:removeAllChildren()

	local length = math.ceil(#self._exchangeMap / kNums)
	local viewHeight = self._scrollView:getContentSize().height
	local allHeight = math.max(viewHeight, self._cellHeight * length)

	self._scrollView:setInnerContainerSize(cc.size(kCellWidth, allHeight))
	self._scrollView:setInnerContainerPosition(cc.p(0, -(allHeight - kCellHeight)))

	self._cells = {}

	for i = 1, length do
		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(kCellWidth, self._cellHeight))
		layout:addTo(self._scrollView)
		layout:setTag(i)
		layout:setAnchorPoint(cc.p(0, 1))
		layout:setPosition(cc.p(0, allHeight - self._cellHeight * (i - 1)))
		layout:setTouchEnabled(false)
		self:createCell(layout, i)
	end
end

function ActivityBlockSummerExchangeMediator:createCell(cell, index)
	for i = 1, kNums do
		local itemIndex = kNums * (index - 1) + i
		local itemData = self._exchangeMap[itemIndex]

		if itemData then
			local clonePanel = self._cellClone:clone()

			clonePanel:setVisible(true)
			cell:addChild(clonePanel)
			clonePanel:setPosition((i - 1) * (self._cellWidth + 6), 0)
			clonePanel:setTag(i)
			self:setInfo(clonePanel, itemData, itemIndex)

			self._cells["cell" .. itemData:getExchangeId()] = cell
		end
	end
end

function ActivityBlockSummerExchangeMediator:setInfo(clonePanel, itemData, itemIndex)
	local imageMark = clonePanel:getChildByFullName("ImageMark")
	local cell = clonePanel:getChildByFullName("cell")
	local iconLayout = clonePanel:getChildByFullName("cell.icon_layout")

	iconLayout:removeAllChildren()

	local goodsName = clonePanel:getChildByFullName("cell.goods_name")
	local touchPanel = clonePanel:getChildByFullName("cell.touch_panel")

	touchPanel:setSwallowTouches(false)

	local rewardPanel = clonePanel:getChildByFullName("cell.rewardPanel")
	local infoPanel = clonePanel:getChildByFullName("cell.info_panel")
	local duihuanText = clonePanel:getChildByFullName("cell.info_panel.duihuan_text")
	local curTime = clonePanel:getChildByFullName("cell.info_panel.curTime")
	local maxTime = clonePanel:getChildByFullName("cell.info_panel.maxTime")
	local moneyLayout = clonePanel:getChildByFullName("cell.money_layout")
	local moneyIcon = clonePanel:getChildByFullName("cell.money_layout.money_icon")

	moneyIcon:removeAllChildren()

	local money = clonePanel:getChildByFullName("cell.money_layout.money")
	local cruTimeNum = itemData:getExchangeCount() - itemData:getLeftExchangeCount()
	local maxTimeNum = itemData:getExchangeCount()
	local rewards = RewardSystem:getRewardsById(itemData:getTargetRewardId())

	if not rewards[1] then
		local rewardData = {}
		local name = RewardSystem:getName(rewardData)
		local cost = itemData:getCostItem()
		local leftExchangeCount = itemData:getLeftExchangeCount()

		if rewards and rewards[1] then
			local rewardIcon = IconFactory:createRewardIcon(rewards[1], {
				isWidget = true
			})

			iconLayout:addChild(rewardIcon)
			rewardIcon:setAnchorPoint(cc.p(0, 0.5))
			rewardIcon:setPosition(cc.p(0, 40))
			rewardIcon:setScaleNotCascade(0.8)
			IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), rewards[1], {
				needDelay = true
			})
		end

		goodsName:setString(name)
		GameStyle:setQualityText(goodsName, RewardSystem:getQuality(rewardData), true)
		curTime:setString("（" .. cruTimeNum)
		maxTime:setString("\\" .. maxTimeNum .. "）")
		duihuanText:setPositionX(infoPanel:getContentSize().width / 2 - (duihuanText:getContentSize().width + curTime:getContentSize().width + maxTime:getContentSize().width) / 2 + 10)
		curTime:setPositionX(duihuanText:getPositionX() + duihuanText:getContentSize().width - 30)
		maxTime:setPositionX(curTime:getPositionX() + curTime:getContentSize().width)

		local costItem = itemData:getCostItem()
		local icon = IconFactory:createIcon({
			id = costItem.code,
			amount = costItem.amount
		}, {
			hideLevel = true,
			showAmount = false,
			notShowQulity = true,
			isWidget = false
		})

		icon:addTo(moneyIcon):center(moneyIcon:getContentSize()):setScale(0.3)
		money:setString(costItem.amount)
		moneyIcon:setPositionX(moneyLayout:getContentSize().width / 2 - (moneyIcon:getContentSize().width + money:getContentSize().width) / 2)
		money:setPositionX(moneyIcon:getPositionX() + moneyIcon:getContentSize().width)
		touchPanel:setTouchEnabled(true)
		touchPanel:addTouchEventListener(function(sender, eventType)
			self:onClickGet(sender, eventType, itemData)
		end)

		if leftExchangeCount <= 0 then
			imageMark:setVisible(true)
			cell:setColor(cc.c3b(120, 120, 120))
			touchPanel:setTouchEnabled(false)
		else
			imageMark:setVisible(false)
			cell:setColor(cc.c3b(255, 255, 255))
		end
	end
end

function ActivityBlockSummerExchangeMediator:onClickGet(sender, eventType, itemData)
	if eventType == ccui.TouchEventType.began then
		self._isReturn = true
	elseif eventType == ccui.TouchEventType.ended and self._isReturn then
		local activityId = self._activityId
		local subActivityId = self._exchangeActivitys:getActivityId()

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local view = self:getInjector():getInstance("PassBuyItemView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			shopType = 1,
			itemData = itemData,
			activityId = activityId,
			subActivityId = subActivityId
		}))
	end
end

function ActivityBlockSummerExchangeMediator:setTimeUi()
	local timeStamp = self._exchangeActivitys:getTimeFactor()
	local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[1], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local table = {
		year = y,
		month = mon,
		day = d,
		hour = h,
		min = m,
		sec = s
	}
	local startTime = TimeUtil:timeByRemoteDate(table)
	local _, _, y, mon, d, h, m, s = string.find(timeStamp.start[2], "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
	local table = {
		year = y,
		month = mon,
		day = d,
		hour = h,
		min = m,
		sec = s
	}
	local endTime = TimeUtil:timeByRemoteDate(table)
	local timeStartStr = ""
	local timeEndStr = ""

	if timeStamp then
		timeStartStr = TimeUtil:localDate("%Y.%m.%d", startTime)
		timeEndStr = TimeUtil:localDate("%Y.%m.%d", endTime)
	end

	self._time:setString(timeStartStr .. "-" .. timeEndStr)
end

function ActivityBlockSummerExchangeMediator:onClickBack(sender, eventType)
	self:dismiss()
end
