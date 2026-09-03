-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/currency/view/CurrencyInfoWidget.lua

CurrencyBar = class("CurrencyBar", BaseWidget, _M)

CurrencyBar:has("_currencyId", {
	is = "rw"
})
CurrencyBar:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CurrencyBar:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
CurrencyBar:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
CurrencyBar:has("_leadStageArenaSystem", {
	is = "r"
}):injectWith("LeadStageArenaSystem")

local length = 4
local kAddBtnFuncMap = {
	[CurrencyIdKind.kGold] = function(self)
		local view = self:getInjector():getInstance("NewCurrencyBuyPopView")

		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			_currencyType = CurrencyType.kGold
		}, self))
	end,
	[CurrencyIdKind.kDiamond] = function(self)
		self._shopSystem:tryEnter({
			shopId = "Shop_Mall"
		})
	end,
	[CurrencyIdKind.kPower] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local view = self:getInjector():getInstance("CurrencyBuyPopView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			_currencyType = CurrencyType.kActionPoint
		}, self))
	end,
	[CurrencyIdKind.kCrystal] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local view = self:getInjector():getInstance("NewCurrencyBuyPopView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			_currencyType = CurrencyType.kCrystal
		}, self))
	end,
	[CurrencyIdKind.kDiamondDrawItem] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self._shopSystem:tryEnter({
			subid = "Shop_Package",
			shopId = ShopSpecialId.KShopTimelimitedmall
		})
	end,
	[CurrencyIdKind.kDiamondDrawExItem] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self._shopSystem:tryEnter({
			subid = "Shop_TimeLimit",
			shopId = ShopSpecialId.KShopTimelimitedmall
		})
	end,
	[CurrencyIdKind.kDiamondDrawReZeroItem] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self._shopSystem:tryEnter({
			shopId = ShopSpecialId.kShopPackage
		})
	end,
	[CurrencyIdKind.kHonor] = function(self)
		CurrencySystem:showSource(self, CurrencyIdKind.kHonor)
	end,
	[CurrencyIdKind.kClub] = function(self)
		CurrencySystem:showSource(self, CurrencyIdKind.kClub)
	end,
	[CurrencyIdKind.kPve] = function(self)
		CurrencySystem:showSource(self, CurrencyIdKind.kPve)
	end,
	[CurrencyIdKind.KMasterStage_Exp] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		CurrencySystem:showSource(self, CurrencyIdKind.KMasterStage_Exp)
	end,
	[CurrencyIdKind.kDiamondDrawExZuoHeItem] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self._shopSystem:tryEnter({
			subid = "Shop_TimeLimit",
			shopId = ShopSpecialId.KShopTimelimitedmall
		})
	end,
	[CurrencyIdKind.kDiamondDrawURItem] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		self._shopSystem:tryEnter({
			subid = "Shop_TimeLimit",
			shopId = ShopSpecialId.KShopTimelimitedmall
		})
	end,
	[CurrencyIdKind.kStageArenaPower] = function(self)
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

		local view = self:getInjector():getInstance("AlertView")
		local data = {
			title = Strings:get("StageArena_PartyUI26"),
			content = Strings:get("StageArena_PartyUI27", {
				price1 = self._leadStageArenaSystem:getThePrice()
			}),
			sureBtn = {},
			cancelBtn = {}
		}
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				outSelf._leadStageArenaSystem:requestBuyTimes()
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end
}
local kAddImgMap = {
	[CurrencyIdKind.kGold] = true,
	[CurrencyIdKind.kPower] = true,
	[CurrencyIdKind.kCrystal] = true,
	[CurrencyIdKind.kDiamond] = true,
	[CurrencyIdKind.kHonor] = true,
	[CurrencyIdKind.kClub] = true,
	[CurrencyIdKind.kPve] = true,
	[CurrencyIdKind.kDiamondDrawItem] = true,
	[CurrencyIdKind.kDiamondDrawExItem] = true,
	[CurrencyIdKind.KMasterStage_Exp] = true,
	[CurrencyIdKind.kDiamondDrawExZuoHeItem] = true,
	[CurrencyIdKind.kDiamondDrawReZeroItem] = true,
	[CurrencyIdKind.kDiamondDrawURItem] = true,
	[CurrencyIdKind.kStageArenaPower] = true
}

function CurrencyBar.class:createWidgetNode()
	local resFile = "asset/ui/CurrencyBar.csb"

	return cc.CSLoader:createNode(resFile)
end

function CurrencyBar:initialize(view)
	self._recoverCd = ConfigReader:getRecordById("Reset", "3").ResetSystem.cd

	super.initialize(self, view)
end

function CurrencyBar:userInject(injector)
	self._gameServerAgent = injector:getInstance("GameServerAgent")
	self._bagSystem = injector:getInstance(DevelopSystem):getBagSystem()
	self._mazeSystem = injector:getInstance(DevelopSystem):getMazeSystem()
end

function CurrencyBar:dispose()
	self:getEventDispatcher():removeEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.updateText)
	super.dispose(self)
end

function CurrencyBar:updateView(currencyId, addBtnDisable)
	self:setCurrencyId(currencyId, addBtnDisable)
	self:getEventDispatcher():addEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.updateText)
end

function CurrencyBar:setCurrencyId(currencyId, addBtnDisable)
	local view = self:getView()

	if self._currencyId ~= currencyId then
		self._currencyId = currencyId

		local goldIcon = IconFactory:createPic({
			id = CurrencyIdKind.kGold
		})
		local goldSize = goldIcon:getContentSize()
		local iconNode = view:getChildByFullName("icon_node")

		iconNode:removeAllChildren()

		local iconPic = IconFactory:createPic({
			id = currencyId
		}, {
			showWidth = goldSize.height
		})

		if iconPic then
			if currencyId == CurrencyIdKind.kStageArenaOldCoin then
				local nameText = ccui.Text:create(Strings:get("StageArena_GoldName") .. ":", TTF_FONT_FZYH_M, 18)

				nameText:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				nameText:getVirtualRenderer():setDimensions(200, 18)
				nameText:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_RIGHT)
				nameText:addTo(iconNode):offset(-120, 0)
			end

			iconPic:addTo(iconNode)
		end

		local addBtn = view:getChildByFullName("add_btn")
		local resource = RewardSystem:getResource(currencyId)

		if (kAddBtnFuncMap[currencyId] or next(resource)) and not addBtnDisable then
			addBtn:setVisible(true)
			mapButtonHandlerClick(self, "add_btn", {
				ignoreClickAudio = true,
				eventType = 4,
				func = function(sender, eventType)
					self:onClickAdd(sender, eventType)
				end
			})
		else
			addBtn:setVisible(false)
		end

		local plusImage = view:getChildByName("Image_1")

		if kAddImgMap[currencyId] or next(resource) then
			plusImage:setVisible(true)
		else
			plusImage:setVisible(false)
		end

		if PowerConfigMap[currencyId] and PowerConfigMap[currencyId].configId then
			view:getChildByFullName("tips.Text_25"):setString(Strings:get(PowerConfigMap[currencyId].next))
			view:getChildByFullName("tips.Text_27"):setString(Strings:get(PowerConfigMap[currencyId].all))
			self._bagSystem:bindSchedulerOnView(self)

			local tipsTouchPanel = addBtn:getChildByName("tipsTouchPanel")

			if tipsTouchPanel == nil then
				addBtn:setVisible(true)

				local touchLayout = ccui.Layout:create()
				local addBtnSize = addBtn:getContentSize()

				touchLayout:setContentSize(addBtnSize.width / 2, addBtnSize.height)
				touchLayout:setAnchorPoint(0, 0)
				touchLayout:setPosition(50, 0)
				touchLayout:setTouchEnabled(true)
				touchLayout:addTo(addBtn):setName("tipsTouchPanel")

				local function callFunc()
					local tipsPanel = view:getChildByName("tips")

					tipsPanel:setVisible(true)
					AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
				end

				mapButtonHandlerClick(nil, touchLayout, {
					ignoreClickAudio = true,
					func = callFunc
				})
			end
		else
			local tipsTouchPanel = addBtn:getChildByName("tipsTouchPanel")

			if tipsTouchPanel then
				tipsTouchPanel:removeFromParent()
			end
		end
	end

	self:updateText()
end

function CurrencyBar:updateText()
	if DisposableObject:isDisposed(self) then
		return
	end

	local view = self:getView()
	local currencyId = self._currencyId

	if not view.getChildByFullName then
		return
	end

	local textBg = view:getChildByFullName("text_bg")
	local textNode = view:getChildByFullName("text_bg.text")
	local strNode = view:getChildByFullName("text_bg.str")

	if getCurrentLanguage() == GameLanguageType.TH then
		textNode:setPositionY(-5)
		strNode:setPositionY(-5)
	end

	textNode:removeAllChildren()

	local text = ""
	local huge = false

	if currencyId == CurrencyIdKind.kGold or currencyId == CurrencyIdKind.kCrystal then
		text, huge = CurrencySystem:formatCurrency(self._bagSystem:getItemCount(currencyId))
	elseif currencyId == CurrencyIdKind.kDiamond then
		text, huge = CurrencySystem:formatCurrency(self._developSystem:getDiamonds())
	elseif currencyId == CurrencyIdKind.kPower then
		local level = self:getDevelopSystem():getPlayer():getLevel()
		local curPower, lastRecoverTime = self._bagSystem:getPower()
		local powerLimit = self._bagSystem:getRecoveryPowerLimit(level)
		local maxPowerLimit = self._bagSystem:getMaxPowerLimit()

		text = math.min(curPower, maxPowerLimit) .. "/" .. powerLimit

		local tipPanel = view:getChildByFullName("tips")
		local str1 = tipPanel:getChildByName("oneTimes")
		local str2 = tipPanel:getChildByName("allTimes")

		if powerLimit <= curPower then
			str1:setString("00:00:00")
			str2:setString("00:00:00")
		else
			local curTime = self._gameServerAgent:remoteTimestamp()
			local a, b = math.modf((curTime - lastRecoverTime) / self._recoverCd)
			local remainTime = (1 - b) * self._recoverCd
			local remainTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", remainTime)

			str1:setString(remainTimeStr)

			local allDoneTime = (powerLimit - curPower - 1) * self._recoverCd + remainTime
			local allDoneTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", allDoneTime)

			str2:setString(allDoneTimeStr)
		end
	elseif PowerConfigMap[currencyId] and PowerConfigMap[currencyId].configId then
		local curPower, lastRecoverTime, powerLimit, powerRecoverCd
		local func = PowerConfigMap[currencyId].func

		if not PowerConfigMap[currencyId].configFunc then
			local configFunc = "getPowerResetByCurrencyId"

			curPower, lastRecoverTime = self._bagSystem[func](self._bagSystem, currencyId)

			local resetConfig = self._bagSystem[configFunc](self._bagSystem, currencyId)

			powerLimit = resetConfig.limit or 3000
			powerRecoverCd = resetConfig.cd or 100
			text = curPower .. "/" .. powerLimit

			local tipPanel = view:getChildByFullName("tips")
			local str1 = tipPanel:getChildByName("oneTimes")
			local str2 = tipPanel:getChildByName("allTimes")

			if powerLimit <= curPower then
				str1:setString("00:00:00")
				str2:setString("00:00:00")
			else
				local curTime = self._gameServerAgent:remoteTimestamp()
				local a, b = math.modf((curTime - lastRecoverTime) / powerRecoverCd)
				local remainTime = (1 - b) * powerRecoverCd
				local remainTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", remainTime)

				str1:setString(remainTimeStr)

				local allDoneTime = (powerLimit - curPower - 1) * powerRecoverCd + remainTime
				local allDoneTimeStr = TimeUtil:formatTime("${HH}:${MM}:${SS}", allDoneTime)

				str2:setString(allDoneTimeStr)
			end
		end
	else
		text = currencyId == CurrencyIdKind.kArtifact and self._bagSystem:getArtifact() or currencyId == CurrencyIdKind.kMazeGold and self._bagSystem:getItemCount(currencyId) or currencyId == CurrencyIdKind.kMazeNormalGold and (self._mazeSystem._mazeChapter and self._mazeSystem._mazeChapter:getGold() or 0) or currencyId == CurrencyIdKind.kMazeInfinityGold and self._bagSystem:getItemCount(currencyId) or currencyId == CurrencyIdKind.kStageArenaOldCoin and self._leadStageArenaSystem:getOldCoin() or self._bagSystem:getItemCount(currencyId)
	end

	textNode:setString(text)

	if huge then
		strNode:setString(Strings:get("Common_Time_01"))
	else
		strNode:setString("")
	end

	local width = textNode:getContentSize().width + strNode:getContentSize().width
	local resource = RewardSystem:getResource(currencyId)

	if not kAddImgMap[currencyId] then
		local addImgShow = next(resource)

		if addImgShow then
			if width < 93 then
				textNode:setPositionX(90 - width)
				strNode:setPositionX(90 - strNode:getContentSize().width)
			else
				textNode:setPositionX(93 - width)
				strNode:setPositionX(93 - strNode:getContentSize().width)
			end
		else
			textNode:setPositionX(98 - width)
			strNode:setPositionX(98 - strNode:getContentSize().width)
		end
	end
end

function CurrencyBar:onClickAdd(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		cclog("currency bar id:" .. self._currencyId)

		local currencyId = self._currencyId
		local addBtnFunc = kAddBtnFuncMap[currencyId]

		if addBtnFunc then
			addBtnFunc(self)
		else
			local resource = RewardSystem:getResource(currencyId)

			if next(resource) then
				local hasNum = self._bagSystem:getItemCount(currencyId)
				local param = {
					needNum = 0,
					itemId = currencyId,
					hasNum = hasNum
				}
				local view = self:getInjector():getInstance("sourceView")

				self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, param))
			end
		end
	end
end

CurrencyInfoWidget = class("CurrencyInfoWidget", BaseWidget, _M)

CurrencyInfoWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
CurrencyInfoWidget:has("_developSystem", {
	is = "r"
}):injectWith(DevelopSystem)

function CurrencyInfoWidget.class:createWidgetNode()
	local resFile = "asset/ui/CurrencyInfoWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function CurrencyInfoWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews()

	self._currencyBars = {}
end

function CurrencyInfoWidget:dispose()
	if self._currencyBars then
		for _, currencyBar in pairs(self._currencyBars) do
			currencyBar:dispose()
		end

		self._currencyBars = nil
	end

	self:getEventDispatcher():removeEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.updateView)
	super.dispose(self)
end

function CurrencyInfoWidget:mapEvent()
	self:getEventDispatcher():addEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.updateView, false, 1)
end

function CurrencyInfoWidget:initSubviews()
	local bar1 = self:getView():getChildByFullName("currency_bar_1")

	self._defaultPosX = bar1:getPositionX()
end

function CurrencyInfoWidget:updateView()
	return
end

function CurrencyInfoWidget:updateCurrencyInfo(config)
	local view = self:getView()

	for pos = 1, 4 do
		local currencyBarNode = view:getChildByFullName("currency_bar_" .. pos)

		if currencyBarNode then
			local currencyId = config[pos]
			local currencyBar

			if currencyId then
				currencyBarNode:setVisible(true)

				local injector = self:getInjector()

				currencyBar = injector:injectInto(CurrencyBar:new(currencyBarNode))

				currencyBar:updateView(currencyId)

				self._currencyBars[pos] = currencyBar

				if PowerConfigMap[currencyId] then
					local rootView = view:getParent()

					if rootView and not rootView:getChildByName(currencyId) then
						local touchLayout = ccui.Layout:create()

						touchLayout:setContentSize(1386, 852)
						touchLayout:setAnchorPoint(0.5, 0.5)
						touchLayout:setPosition(568, 320)
						touchLayout:setTouchEnabled(true)
						touchLayout:addTo(rootView):setName(currencyId)
						touchLayout:setSwallowTouches(false)

						local function callFunc()
							currencyBarNode:getChildByName("tips"):setVisible(false)
						end

						mapButtonHandlerClick(nil, touchLayout, {
							ignoreClickAudio = true,
							func = callFunc
						})
					end
				end
			else
				currencyBarNode:setVisible(false)
			end
		end
	end

	self:updateView()
end

TopInfoWidget = class("TopInfoWidget", BaseWidget, _M)

TopInfoWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
TopInfoWidget:has("_titleWidth", {
	is = "r"
})

function TopInfoWidget.class:createWidgetNode()
	local resFile = "asset/ui/TopInfoWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

local kAnim = {
	[1] = "fanhuianniubai_fanhuianniu",
	[2] = "fanhuianniu_fanhuianniu"
}

function TopInfoWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)

	self._currencyBars = {}
	self._titleWidth = 0

	AdjustUtils.addSafeAreaRectForNode(self:getView():getChildByFullName("currency_bar_1"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.addSafeAreaRectForNode(self:getView():getChildByFullName("currency_bar_2"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.addSafeAreaRectForNode(self:getView():getChildByFullName("currency_bar_3"), AdjustUtils.kAdjustType.Right)
	AdjustUtils.addSafeAreaRectForNode(self:getView():getChildByFullName("currency_bar_4"), AdjustUtils.kAdjustType.Right)

	self._defaultPosX = self:getView():getChildByName("currency_bar_1"):getPositionX()
end

function TopInfoWidget:userInject(injector)
	local eventDispatcher = self:getEventDispatcher()

	eventDispatcher:addEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.refreshView, false, 1)
end

function TopInfoWidget:dispose()
	self:getEventDispatcher():removeEventListener(EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)

	if self._currencyBars then
		for _, currencyBar in pairs(self._currencyBars) do
			currencyBar:dispose()
		end

		self._currencyBars = nil
	end

	super.dispose(self)
end

function TopInfoWidget:initSubviews(view)
	self._titlePanel = view:getChildByFullName("titlePanel")

	AdjustUtils.addSafeAreaRectForNode(self:getView():getChildByFullName("back_btn"), AdjustUtils.kAdjustType.Right)

	local circle = self:getView():getChildByName("circle")

	AdjustUtils.addSafeAreaRectForNode(circle, AdjustUtils.kAdjustType.Right)
end

function TopInfoWidget:getGoldNumLabel()
	return self._currencyInfoNode:getChildByFullName("currency_bar_1.text")
end

local kStyle = {
	cc.c3b(255, 255, 255),
	(cc.c3b(96, 83, 84))
}
local kFontOutline = {
	cc.c4b(0, 0, 0, 127.5),
	(cc.c4b(255, 255, 255, 127.5))
}
local kFontStyle = {
	[1] = 127.5,
	[2] = 255
}
local kLine = {
	[1] = "common_bg_line01.png",
	[2] = "common_bg_line02.png"
}

function TopInfoWidget:updateView(config)
	local view = self:getView()

	if config.btnHandler then
		mapButtonHandlerClick(self, "back_btn", config.btnHandler)
	end

	self:hideTitle(false)

	if config.title then
		self:updateTitle(config.title, config.fontSize)
	elseif config.complexTitle then
		self:updateComplexTitle(config.complexTitle)
	else
		self:hideTitle(true)
	end

	if not config.style then
		local style = 2
		local stopAnim = not not config.stopAnim

		if config.currencyInfo then
			local currencyInfo = config.currencyInfo
			local num = 0

			for pos = 1, 4 do
				local currencyBarNode = view:getChildByFullName("currency_bar_" .. pos)

				currencyBarNode:getChildByFullName("text_bg.text"):setTextColor((not kStyle[style] or nil) and kStyle[1])
				currencyBarNode:getChildByFullName("text_bg.str"):setTextColor(kStyle[style] or kStyle[1])

				local currencyId = currencyInfo and currencyInfo[pos]
				local currencyBar

				if currencyId then
					num = num + 1

					if not self._currencyBars[pos] then
						local injector = self:getInjector()

						self._currencyBars[pos] = injector:injectInto(CurrencyBar:new(currencyBarNode))
					end

					currencyBarNode:setVisible(true)
					self._currencyBars[pos]:updateView(currencyId, nil)

					if PowerConfigMap[currencyId] then
						local rootView = view:getParent()

						if rootView and not rootView:getChildByName(currencyId) then
							local touchLayout = ccui.Layout:create()

							touchLayout:setContentSize(1386, 852)
							touchLayout:setAnchorPoint(0.5, 0.5)
							touchLayout:setPosition(568, 320)
							touchLayout:setTouchEnabled(true)
							touchLayout:addTo(rootView):setName(currencyId)
							touchLayout:setSwallowTouches(false)

							local function callFunc()
								currencyBarNode:getChildByName("tips"):setVisible(false)
							end

							mapButtonHandlerClick(nil, touchLayout, {
								ignoreClickAudio = true,
								func = callFunc
							})
						end
					end
				else
					currencyBarNode:setVisible(false)
				end
			end

			if num == 0 and not config.title or config.hideLine then
				self:getView():getChildByName("bgImagePanel"):setVisible(false)
			end
		end

		if config.currencyInfo == nil then
			for pos = 1, 4 do
				local currencyBarNode = view:getChildByFullName("currency_bar_" .. pos)

				currencyBarNode:setVisible(false)
			end
		end

		self:refreshView()

		for i = 1, length do
			local _titleNode = self._titlePanel:getChildByName("titleNode" .. i)

			_titleNode:setOpacity(kFontStyle[style])
		end

		local circle = self:getView():getChildByName("circle")

		if style == 2 then
			circle:setColor(cc.c3b(95, 82, 80))
		end

		if self._progressTimer then
			self._progressTimer:removeFromParent(true)
		end

		local bgImagePanel = self:getView():getChildByName("bgImagePanel")
		local sp = cc.Sprite:createWithSpriteFrameName(kLine[style])
		local progressTimer = cc.ProgressTimer:create(sp)

		bgImagePanel:addChild(progressTimer)
		progressTimer:setPosition(cc.p(693, 0))
		progressTimer:setScaleX(173.25)
		progressTimer:setType(1)
		progressTimer:setMidpoint(cc.p(0, 0))
		progressTimer:setBarChangeRate(cc.p(1, 0))
		progressTimer:setPercentage(0)

		self._progressTimer = progressTimer

		self:startAnim(style, stopAnim)

		if not not config.hideLine then
			self._progressTimer:setVisible(false)

			stopAnim = true
		end
	end
end

function TopInfoWidget:startAnim(style, stopAnim)
	if not self._mc then
		local mc = cc.MovieClip:create(kAnim[style])

		mc:addCallbackAtFrame(45, function()
			mc:stop()
		end)
		mc:setPlaySpeed(1.6)
		mc:setScale(0.7)
		mc:addTo(self:getView())
		mc:setPosition(cc.p(1058, -3))
		AdjustUtils.adjustLayoutByType(mc, AdjustUtils.kAdjustType.Right)
		AdjustUtils.addSafeAreaRectForNode(mc, AdjustUtils.kAdjustType.Right)

		self._mc = mc
	end

	if stopAnim then
		self._mc:gotoAndStop(45)
		self._progressTimer:setPercentage(100)
	else
		for i = 1, length do
			local _titleNode = self._titlePanel:getChildByName("titleNode" .. i)

			_titleNode:setRotation(0)
			_titleNode:runAction(cc.Sequence:create(cc.RotateTo:create(0.1, -8), cc.RotateTo:create(0.05, -5)))
		end

		for pos = 1, 4 do
			local currencyBarNode = self:getView():getChildByFullName("currency_bar_" .. pos)
			local posX, posY = currencyBarNode:getPosition()

			currencyBarNode:setPositionY(posY + 80)
			currencyBarNode:runAction(cc.MoveTo:create(0.3, cc.p(posX, posY)))
		end

		self._progressTimer:runAction(cc.ProgressFromTo:create(0.3, 0, 100))
		self._mc:gotoAndPlay(1)
	end
end

function TopInfoWidget:refreshView()
	return
end

function TopInfoWidget:updateTitle(title, fontSize)
	local words = string.split(title, " ")
	local labelWordCount = #words
	local j = 1
	local x = 1

	while true do
		if labelWordCount < j then
			break
		end

		local _titleNode = self._titlePanel:getChildByName("titleNode" .. j)

		if _titleNode then
			_titleNode:setString(words[j])

			if fontSize then
				_titleNode:setFontSize(fontSize)
			elseif getCurrentLanguage() ~= GameLanguageType.CN then
				_titleNode:setFontSize(37)
			end

			if getCurrentLanguage() ~= GameLanguageType.CN then
				_titleNode:setPositionY(50)
			end

			_titleNode:setPositionX(x)

			x = x + _titleNode:getContentSize().width + 3
		else
			break
		end

		j = j + 1
	end

	self._titleWidth = x
end

function TopInfoWidget:updateComplexTitle(title)
	for idx, data in pairs(title) do
		local _titleNode = self._titlePanel:getChildByName("titleNode" .. idx)

		if _titleNode then
			_titleNode:setString(data.str)
		end

		if data.pos then
			_titleNode:setPositionX(data.pos)
		end
	end
end

function TopInfoWidget:hideTitle(status)
	self._titlePanel:setVisible(not status)
end
