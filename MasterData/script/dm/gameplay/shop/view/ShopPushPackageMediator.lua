-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopPushPackageMediator.lua

ShopPushPackageMediator = class("ShopPushPackageMediator", DmPopupViewMediator, _M)

ShopPushPackageMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopPushPackageMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopPushPackageMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {
	["main.btn_back"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCloseClicked"
	},
	["main.btn_buy"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBuy"
	}
}
local PackageTips = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "PackageTips", "content")
local KShopSort = {
	[KShopPushPackageKind.KPush_Exp] = {
		bgImg = "push_exp.png"
	},
	[KShopPushPackageKind.KPush_Gold] = {
		bgImg = "push_gold.png"
	},
	[KShopPushPackageKind.KPush_Crystal] = {
		bgImg = "push_shuijing.png"
	},
	[KShopPushPackageKind.KPush_Draw] = {
		bgImg = "push_card.png"
	},
	[KShopPushPackageKind.KPush_Talent] = {
		bgImg = "push_yzjh.png"
	}
}
local KPushPackagePos = {
	[2] = {
		cc.p(40, 80),
		cc.p(180, 80)
	},
	[3] = {
		cc.p(-10, 80),
		cc.p(130, 80),
		cc.p(270, 80)
	},
	[4] = {
		cc.p(58, 132),
		cc.p(230, 132),
		cc.p(48, 12),
		cc.p(240, 12)
	}
}

function ShopPushPackageMediator:initialize()
	super.initialize(self)
end

function ShopPushPackageMediator:dispose()
	super.dispose(self)

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self._developSystem:setPushViewOpen(false)
end

function ShopPushPackageMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.onBuyPackageSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_PUSH_PACAKGE, self, self.refreshPushPackage)
end

function ShopPushPackageMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function ShopPushPackageMediator:enterWithData(data)
	self._pushId = data and data.pushId

	if data then
		self._packageId = data.packageId or self._pushId
	end

	self._developSystem:setPushViewOpen(true)

	self._data = self._developSystem:getPushPackageData()
	self._curTabType = self:getSelectTabId(self._packageId)

	self:initNodes()
	self:initTabController()

	if self._pushId then
		self._main:setVisible(false)
		self:refreshPushIdView()
	end
end

function ShopPushPackageMediator:getSelectTabId(pacId)
	if not pacId then
		return 1
	end

	for i, v in ipairs(self._data) do
		if pacId == v:getId() then
			return i
		end
	end

	return 1
end

function ShopPushPackageMediator:initNodes()
	self._main = self:getView():getChildByFullName("main")
	self._buyBtn = self._main:getChildByFullName("btn_buy")
	self._buyBtnDone = self._main:getChildByFullName("Image_buyDone")
	self._packgeName = self._main:getChildByFullName("packgeName")
	self._moneyNum = self._buyBtn:getChildByFullName("moneyNum")
	self._freeText = self._buyBtn:getChildByFullName("getText")
	self._discont = self._main:getChildByFullName("discont")
	self._cellClone = self._main:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)

	self._desc = self._main:getChildByFullName("desc")
	self._panelReward = self._main:getChildByFullName("Panel_reward")
	self._textRemainTime = self._main:getChildByFullName("text_remainTime")
	self._textRemainTimeDi = self._main:getChildByFullName("text_remainTimeDi")
	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._touchPanel:setSwallowTouches(true)
	self._buyBtnDone:addClickEventListener(function(sender, eventType)
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end)
end

function ShopPushPackageMediator:initTabController()
	local PackageSymbol = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "PackageSymbol", "content")
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i, v in ipairs(self._data) do
		local var_9_0 = {}

		var_9_0.tabText = Strings:get(PackageSymbol[v:getShopSort()] or "")

		function var_9_0.redPointFunc()
			return false
		end

		data[#data + 1] = var_9_0
	end

	config.btnDatas = data
	config.addCellHeight = 10

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		styleType = "three",
		hideBtnAnim = "true",
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)

	local view = self._tabBtnWidget:getMainView()
	local tabPanel = self:getView():getChildByFullName("main.tab_panel")

	tabPanel:removeAllChildren()
	view:addTo(tabPanel):posite(-20, 0)
	view:setLocalZOrder(1100)
	tabPanel:setVisible(#self._data > 1)
end

function ShopPushPackageMediator:refreshData()
	self._data = self._developSystem:getPushPackageData()
end

function ShopPushPackageMediator:onClickTab(name, tag)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

	self._curTabType = tag

	self:refreshView()
end

function ShopPushPackageMediator:refreshView()
	local curData = self._data[self._curTabType]
	local imgDi = self._main:getChildByFullName("Image_di")

	imgDi:loadTexture(KShopSort[curData:getShopSort()].bgImg, 1)

	local talkText = self._main:getChildByFullName("text_talk")

	talkText:setString(Strings:get(PackageTips[curData:getId()] or ""))

	local descString = curData:getDesc()

	self._desc:setString(descString)
	self._packgeName:setString(curData:getName())
	self._freeText:setVisible(false)
	self._moneyNum:setString("")

	local isFree = curData:getIsFree()

	if isFree == KShopBuyType.KFree then
		self._freeText:setVisible(true)
	elseif isFree == KShopBuyType.KMoney then
		local symbol, price = curData:getPaySymbolAndPrice()

		self._moneyNum:setString(symbol .. price)
	end

	self._discont:setVisible(false)
	self._panelReward:removeAllChildren()

	local rewardId = curData:getItem()
	local rewards = RewardSystem:getRewardsById(rewardId)

	for i = 1, #rewards do
		local data = rewards[i]
		local node = self._cellClone:clone()

		node:setVisible(true)

		local iconPanel = node:getChildByFullName("icon")
		local icon = IconFactory:createRewardIcon(data, {
			hideLevel = true,
			showAmount = true,
			notShowQulity = false,
			isWidget = true
		})

		icon:setScale(0.8)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), data, {
			needDelay = true
		})
		icon:addTo(iconPanel):center(iconPanel:getContentSize())

		if #rewards == 4 then
			node:setPosition(cc.p(-55 + (i - 1) * 113, 80))
		elseif #rewards < 6 then
			node:setPosition(KPushPackagePos[#rewards][i])
		else
			local x = (i - 1) % 3 * 160
			local y = 128 - math.floor((i - 1) / 3) * 120

			node:setPosition(cc.p(x, y))
		end

		node:addTo(self._panelReward)
	end

	self:refreshTimer()

	local buyPackItems = self._developSystem:getPlayer():getBuyPackItems()

	if table.indexof(buyPackItems, curData:getId()) then
		self._buyBtnDone:setVisible(true)
		self._buyBtn:setVisible(false)
	else
		self._buyBtnDone:setVisible(false)
		self._buyBtn:setVisible(true)
	end
end

function ShopPushPackageMediator:refreshTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	local pushPackageTimeList = self._developSystem:getPushGiftTimeList()
	local curData = self._data[self._curTabType]
	local packageId = curData:getId()

	if not pushPackageTimeList[packageId] then
		local limitTime = 0

		local function update()
			local curTime = self._gameServerAgent:remoteTimestamp()
			local remainTime = math.max(limitTime - curTime, 0)
			local fmtStr = "${d}:${HH}:${M}:${SS}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = parts[1]
			timeTab.hour = parts[2]
			timeTab.min = parts[3]
			timeTab.sec = parts[4]

			self._textRemainTime:setString(tonumber(timeTab.day) > 0 and timeTab.day .. ":" .. timeTab.hour .. Strings:get("PackageShop_Push_des3") or tonumber(timeTab.hour) > 0 and timeTab.hour .. ":" .. timeTab.min .. ":" .. timeTab.sec .. Strings:get("PackageShop_Push_des3") or tonumber(timeTab.min) > 0 and "00:" .. timeTab.min .. ":" .. timeTab.sec .. Strings:get("PackageShop_Push_des3") or "00:" .. "00:" .. timeTab.sec .. Strings:get("PackageShop_Push_des3"))

			if remainTime == 0 then
				self._timer:stop()

				self._timer = nil

				self._textRemainTimeDi:setVisible(false)
				self._textRemainTime:setVisible(false)
			else
				self._textRemainTimeDi:setVisible(true)
				self._textRemainTime:setVisible(true)
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(update, 1, false)

		update()
	end
end

function ShopPushPackageMediator:refreshPushIdView()
	local Price_Box = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Price_Box", "content")
	local pushData = self:getPackageDataById(self._pushId)

	if not pushData then
		print("===== self._pushId " .. self._pushId)
	end

	local kind = Price_Box[tostring(pushData:getPrice())]
	local animName = KPushPackageAnimName[kind]
	local anim = RoleFactory:createRoleAnimation(animName)

	anim:setScale(0.8)

	local node = cc.Node:create()

	anim:addTo(node)
	node:addTo(self:getView())
	node:setPosition(cc.p(-100, 320))

	local moveTo = cc.MoveTo:create(1.5, cc.p(568, 320))
	local delayAction = cc.DelayTime:create(0.5)
	local callbackFunc = cc.CallFunc:create(function()
		node:removeFromParent()
		self._main:setScale(0.7)

		local sc1 = cc.ScaleTo:create(0.1, 1.1)
		local sc2 = cc.ScaleTo:create(0.1, 1)

		self._main:runAction(cc.Sequence:create(sc1, sc2))
		self._main:setVisible(true)
	end)

	node:runAction(cc.Sequence:create(moveTo, delayAction, callbackFunc))
end

function ShopPushPackageMediator:getPackageDataById(id)
	for k, v in pairs(self._data) do
		if id == v:getId() then
			return v
		end
	end

	return nil
end

function ShopPushPackageMediator:onClickBuy()
	local curData = self._data[self._curTabType]
	local pushPackageTimeList = self._developSystem:getPushGiftTimeList()
	local packageId = curData:getId()

	if not pushPackageTimeList[packageId] then
		local curTime = self._gameServerAgent:remoteTimestamp()

		if pushPackageTimeList[packageId] < curTime then
			return
		end

		if self._shopSystem:getVersionCanBuy(curData, Strings:get("Activity_Version_Tips1")) then
			local isFree = curData:getIsFree()

			AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
			self._shopSystem:requestBuyPackageShop(curData:getId(), nil, isFree)

			self._isFree = isFree
		end
	end
end

function ShopPushPackageMediator:onCloseClicked(sender, eventType)
	self:close()
end

function ShopPushPackageMediator:onBuyPackageSuccCallback(event)
	local data = event:getData().data

	if data and data.rewards and #data.rewards > 0 then
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 200
		}, {
			rewards = data.rewards
		}))
	end

	if self._isFree and self._isFree == KShopBuyType.KFree then
		self:refreshView()

		return
	end

	self:refreshData()

	if #self._data == 0 then
		self:close()
	else
		self._curTabType = 1

		self:initTabController()
		self:refreshView()
	end
end

function ShopPushPackageMediator:refreshPushPackage()
	if self._isFree and self._isFree == KShopBuyType.KFree then
		return
	end

	self:refreshData()

	if #self._data == 0 then
		self:close()
	else
		self._curTabType = 1

		self:initTabController()
		self:refreshView()
	end
end

function ShopPushPackageMediator:onTouchMaskLayer()
	return
end
