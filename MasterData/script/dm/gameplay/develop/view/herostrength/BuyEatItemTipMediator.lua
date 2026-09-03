-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/BuyEatItemTipMediator.lua

require("dm.gameplay.base.URLContext")
require("dm.gameplay.base.UrlEntry")

BuyEatItemTipMediator = class("BuyEatItemTipMediator", SourceMediator, _M)

BuyEatItemTipMediator:has("_player", {
	is = "r"
}):injectWith("Player")
BuyEatItemTipMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
BuyEatItemTipMediator:has("_spStageSystem", {
	is = "r"
}):injectWith("SpStageSystem")
BuyEatItemTipMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
BuyEatItemTipMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuyEatItemTipMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
BuyEatItemTipMediator:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")

local kBtnHandlers = {}
local kShopTips = {
	[kShopResetType.KResetDay] = "MAZE_TIMES",
	[kShopResetType.KResetWeek] = "MAZE_WEEKTIMES",
	[kShopResetType.KResetMonth] = "MAZE_MONTHTIMES"
}

function BuyEatItemTipMediator:enterWithData(data)
	self._itemData = data

	self:setUpView()
end

function BuyEatItemTipMediator:createDataSource()
	self._sourceList = {}

	local itemSources = ConfigReader:getDataByNameIdAndKey("ItemConfig", self._itemData.itemId, "Resource")

	for k, v in pairs(itemSources) do
		local resourceConfig = ConfigReader:getRecordById("ItemResource", v)

		if string.find(resourceConfig.URL, "SpStageMainViewWithTimes") then
			self:createStageDataSource(resourceConfig)
		elseif string.find(resourceConfig.URL, "NewCurrencyBuyView") then
			self:createExchangeDataSource(resourceConfig)
		elseif string.find(resourceConfig.URL, "BuildingGetResView") then
			self:createBuildingDataSource(resourceConfig)
		elseif string.find(resourceConfig.URL, "shopView") then
			self:_refreshExpGiftItemData()
			self:createGiftDataSource(resourceConfig)
		end
	end
end

function BuyEatItemTipMediator:onRegister()
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByFullName("main")
	self._viewPanel = self._main:getChildByFullName("tableView")
	self._tableViewBg = self._main:getChildByFullName("Image_13")
	self._blockPanel = self._main:getChildByName("block")

	self._blockPanel:setVisible(false)

	self._cellPanel = self._main:getChildByName("cellmodel")

	self._cellPanel:setVisible(false)

	local giftNode = self._main:getChildByFullName("NodeExpGift")

	self._giftNode = cc.CSLoader:createNode("asset/ui/ExpGift.csb")

	self._giftNode:setVisible(false)
	giftNode:addChild(self._giftNode)

	local bgNode = self._main:getChildByFullName("bgNode")

	self._bgNode = bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("SOURCE_TITLE"),
		title1 = Strings:get("UITitle_EN_Huodetujing"),
		bgSize = {
			width = 835,
			height = 580
		}
	})

	self:_refreshExpGiftItemData()

	local priceBtn = self._giftNode:getChildByFullName("Node_gift.Button_price")

	priceBtn:addClickEventListener(function()
		self:onClickBuyGift()
	end)
end

function BuyEatItemTipMediator:_refreshExpGiftItemData()
	local minSort, showShopItem, minorShowItem = 9999
	local shopItems = self._shopSystem:getPackageList()

	for k, item in pairs(shopItems) do
		if (item:getShopSort() == kShopResetType.KResetDay or item:getShopSort() == kShopResetType.KResetWeek or item:getShopSort() == kShopResetType.KResetMonth) and self._shopSystem:checkPackageExist(item:getId()) and item:getSpecialType() == "DayExp" and minSort > item:getSort() then
			minorShowItem = item
			minSort = item:getSort()

			local showTime = self._shopSystem:checkTimeTagShow(item)

			if showTime and item:getLeftCount() > 0 then
				showShopItem = item
			end
		end
	end

	self._minorShowItem = minorShowItem
	self._showShopItem = showShopItem

	self:_adjustView()
end

function BuyEatItemTipMediator:_adjustView()
	if self._showShopItem then
		self._viewPanel:setPosition(0, 78)
		self._viewPanel:setContentSize(680, 435)
		self._tableViewBg:setPosition(0, 78)
		self._tableViewBg:setContentSize(680, 435)
		self._bgNode:getView():setPosition(-86, 17)
		self._bgNode:setContentSize(1125, 580)
	else
		self._viewPanel:setPosition(158, 78)
		self._viewPanel:setContentSize(680, 435)
		self._tableViewBg:setPosition(158, 78)
		self._tableViewBg:setContentSize(680, 435)
		self._bgNode:getView():setPosition(74, 17)
		self._bgNode:setContentSize(835, 580)
	end
end

function BuyEatItemTipMediator:createStageDataSource(resourceConfig)
	local stageType = SpStageType.kExp
	local stageData = kSpStageTeamAndPointType[stageType]
	local unlock = self._systemKeeper:isUnlock(stageData.unlockType)
	local spStageIds = ConfigReader:getRecordById("ConfigValue", "StageSp_List").content
	local stageId = spStageIds[stageType]
	local rewards = self._spStageSystem:getRewardById(stageId)

	self._stageType = stageType
	self._stageId = stageId

	local stageConfig = self._spStageSystem:getPointConfigByType(stageType)

	if stageConfig then
		local maxDifficulty, stageSource

		for i = 1, #stageConfig do
			local data = stageConfig[i]
			local pointId = data.Id
			local close = self._spStageSystem:isPointClose(stageId, pointId)

			data.unlock = unlock and not close

			if stageSource == nil then
				stageSource = data
			elseif not close and (maxDifficulty == nil or maxDifficulty < data.Difficulty) then
				maxDifficulty = data.Difficulty
				stageSource = data
			end
		end

		stageSource.enterParams = {
			stageType = stageType,
			stageId = stageId,
			pointId = stageSource.Id,
			difficulty = stageSource.Difficulty
		}
		stageSource.rewards = rewards
		stageSource.title = Strings:get("StageSp_Exp_Name") .. " " .. Strings:get(stageSource.PointName)
		stageSource.url = resourceConfig.URL
		stageSource.timesLimit = self._spStageSystem:getStageLeaveTime(stageId) <= 0

		table.insert(self._sourceList, stageSource)
	end
end

function BuyEatItemTipMediator:createExchangeDataSource(resourceConfig)
	local getResNum = self._buildingSystem:getBuyResGetNum("BuyExp_Base")

	self._sourceList = self._sourceList or {}

	local exchageSource = {}

	exchageSource.rewards = {
		{
			code = "PlayerHeroExp",
			type = RewardType.kItem,
			amount = getResNum
		}
	}
	exchageSource.title = Strings:get("Resource_Exchange_Title_Exp")
	exchageSource.url = resourceConfig.URL
	exchageSource.enterParams = {
		_currencyType = CurrencyType.kExp
	}

	local aBuyTimes = self._bagSystem:getBuyTimesByType(TimeRecordType.kBuyExp)
	local buyExpCfg = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BuyExp_Base", "content")

	exchageSource.timesLimit = aBuyTimes >= buyExpCfg.maxTime

	table.insert(self._sourceList, exchageSource)
end

function BuyEatItemTipMediator:createBuildingDataSource(resourceConfig)
	self._sourceList = self._sourceList or {}

	local outList, resList, resNoLimitList = self._buildingSystem:getAllBuildOutAndRes()
	local buildingDataSource = {}

	function buildingDataSource.clickGoHandler(data)
		local view = self:getInjector():getInstance("BuildingOneKeyGetResView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view))
	end

	buildingDataSource.rewards = {
		{
			code = "PlayerHeroExp",
			type = RewardType.kItem,
			amount = resNoLimitList[KBuildingType.kExpOre]
		}
	}
	buildingDataSource.title = Strings:get("Building_Home_Product")
	buildingDataSource.url = resourceConfig.URL

	table.insert(self._sourceList, buildingDataSource)
end

function BuyEatItemTipMediator:getIconPositions(iconNum, iconSize)
	local offset = 10
	local posArr = {}

	if iconNum == 1 then
		table.insert(posArr, {
			0,
			0
		})
	elseif iconNum == 2 then
		table.insert(posArr, {
			-iconSize.width / 2 - offset,
			0
		})
		table.insert(posArr, {
			iconSize.width / 2 + offset,
			0
		})
	elseif iconNum == 3 then
		table.insert(posArr, {
			0,
			iconSize.height / 2 + offset
		})
		table.insert(posArr, {
			-iconSize.width / 2 - offset,
			-iconSize.height / 2 - offset
		})
		table.insert(posArr, {
			iconSize.width / 2 + offset,
			-iconSize.height / 2 - offset
		})
	elseif iconNum == 4 then
		table.insert(posArr, {
			-iconSize.width / 2 - offset,
			iconSize.height / 2 + offset
		})
		table.insert(posArr, {
			iconSize.width / 2 + offset,
			iconSize.height / 2 + offset
		})
		table.insert(posArr, {
			-iconSize.width / 2 - offset,
			-iconSize.height / 2 - offset
		})
		table.insert(posArr, {
			iconSize.width / 2 + offset,
			-iconSize.height / 2 - offset
		})
	end

	return posArr
end

local function decimal(nNum, n)
	if type(nNum) ~= "number" then
		return nNum
	end

	n = n or 0
	n = math.floor(n)

	local fmt = "%." .. n .. "f"

	return (tonumber(string.format(fmt, nNum)))
end

function BuyEatItemTipMediator:createGiftDataSource(resourceConfig)
	if not self._showShopItem then
		local showShopItem = self._minorShowItem

		if self._showShopItem then
			local rewards = RewardSystem:getRewardsById(showShopItem:getItem())
			local priceText = self._giftNode:getChildByFullName("Node_gift.Button_price.Text_price")
			local prePriceText = self._giftNode:getChildByFullName("Node_gift.Button_price.Text_pre_price")
			local discountText = self._giftNode:getChildByFullName("Node_gift.Text_discount")
			local discountDescText = self._giftNode:getChildByFullName("Node_gift.Text_discount_desc")
			local iconNode = self._giftNode:getChildByFullName("Node_gift.Node_icon")
			local symbol, price = showShopItem:getPaySymbolAndPrice()
			local drawPosX, drawPosY = prePriceText:getPosition()
			local drawNode = cc.DrawNode:create()

			drawNode:drawLine(cc.p(drawPosX - 22, drawPosY), cc.p(drawPosX + 28, drawPosY), cc.c4f(1, 0.81, 0.45, 1))
			prePriceText:getParent():addChild(drawNode)
			priceText:setString(symbol .. price)

			local price = showShopItem:getPrice() or ""

			prePriceText:setString(symbol .. price)

			if showShopItem:getCostOff() then
				local discountStr = Strings:get("ShopReset_ExpPay1_Discount_1", {
					num = decimal(10 / tonumber(showShopItem:getCostOff()), 1)
				})

				discountText:setString(discountStr)
			end

			discountText:setVisible(false)
			discountDescText:setString(Strings:get("ShopReset_ExpPay1_Discount_2"))
			iconNode:removeAllChildren()

			local posArr = self:getIconPositions(#rewards, {
				width = 70,
				height = 70
			})

			for i = 1, #rewards do
				local icon = IconFactory:createRewardIcon(rewards[i], {
					isWidget = true
				})

				icon:setTouchEnabled(true)
				icon:setScale(0.65)
				icon:addTo(iconNode)
				icon:setPosition(cc.p(posArr[i][1], posArr[i][2]))
			end

			self._giftNode:setVisible(true)
		else
			self._giftNode:setVisible(false)
		end

		if showShopItem then
			local tips = kShopTips[showShopItem:getShopSort()] or "MAZE_TIMES"

			self._sourceList = self._sourceList or {}

			local giftDataSource = {}

			giftDataSource.rewards = RewardSystem:getRewardsById(showShopItem:getItem())
			giftDataSource.title = Strings:get(showShopItem:getName())
			giftDataSource.url = resourceConfig.URL .. showShopItem:getId()
			giftDataSource.timesLimit = self._showShopItem == nil
			giftDataSource.tips = Strings:get(tips)

			table.insert(self._sourceList, giftDataSource)
		end
	end
end

function BuyEatItemTipMediator:setUpView()
	self._noTips = self._main:getChildByName("Text_notips")

	self._noTips:setVisible(false)

	local needCountLabel = self._main:getChildByName("Text_needcount")
	local ownCountLabel = self._main:getChildByName("Text_owncount")
	local nameLabel = self._main:getChildByFullName("nameLabel")
	local itemPanel = self._main:getChildByFullName("itemPanel")
	local descText = self._main:getChildByFullName("Text_desc")

	needCountLabel:setVisible(false)
	ownCountLabel:setVisible(false)
	nameLabel:setVisible(false)
	itemPanel:setVisible(false)
	descText:setVisible(false)
	self:createSourceList()
	self:refreshView()
end

function BuyEatItemTipMediator:refreshView()
	self:createDataSource()

	if self._tabelView then
		self._tabelView:reloadData()
	end
end

function BuyEatItemTipMediator:createCell(cell, index)
	local data = self._sourceList[index]
	local blockPanel = cell:getChildByName("block")

	if not blockPanel then
		blockPanel = self._blockPanel:clone()

		blockPanel:addTo(cell):posite(29, 35)
		blockPanel:setName("block")
	end

	blockPanel:setVisible(true)

	local titleText = cell:getChildByName("Text_name")

	titleText:setVisible(true)
	titleText:setString(data.title)

	local isUnlock, tip = UrlEntryManage.checkEnabledWithUserData(data.url)
	local isOpen = isUnlock and not data.timesLimit
	local goBtn = cell:getChildByName("btn_go")

	goBtn:setVisible(isOpen)
	goBtn:addClickEventListener(function()
		self:onClickGo(data)
	end)

	local notopenImg = cell:getChildByName("Image_notopen")

	notopenImg:setVisible(not isOpen)

	if data.timesLimit then
		tip = data.tips or ""

		notopenImg:ignoreContentAdaptWithSize(true)
		notopenImg:setString(tip)
	end

	if not isOpen then
		cell:setTouchEnabled(true)
		cell:setSwallowTouches(false)
		cell:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				sender._moved = false
			elseif eventType == ccui.TouchEventType.moved then
				sender._moved = true
			elseif eventType == ccui.TouchEventType.ended and not sender._moved then
				self:dispatch(ShowTipEvent({
					tip = tip
				}))
			end
		end)
	else
		cell:setTouchEnabled(false)
	end

	local targetImg = blockPanel:getChildByFullName("targetImg")

	targetImg:setVisible(false)

	if blockPanel:getChildByFullName("blockname") then
		cell:getChildByFullName("Text_desc"):removeFromParent()
		blockPanel:getChildByFullName("blockname"):removeFromParent()
		blockPanel:getChildByFullName("challengetimes"):removeFromParent()
		blockPanel:getChildByFullName("starPanel"):removeFromParent()
		blockPanel:getChildByFullName("btn_wipeone"):removeFromParent()
		blockPanel:getChildByFullName("btn_wipemulti"):removeFromParent()
	end

	for i = 1, 4 do
		local rewardData = data.rewards[i]
		local iconBg = blockPanel:getChildByName("icon" .. i)

		iconBg:removeAllChildren()

		if rewardData then
			local icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:setSwallowTouches(true)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
				swallowTouches = true,
				needDelay = true
			})
			icon:setScaleNotCascade(0.52)
			icon:addTo(iconBg):center(iconBg:getContentSize())

			if self._itemData.itemId == tostring(rewardData.code) then
				local posX = iconBg:getPositionX() + iconBg:getContentSize().width / 2
				local posY = iconBg:getPositionY() + iconBg:getContentSize().height / 2

				targetImg:setPosition(cc.p(posX, posY))
				targetImg:setVisible(true)
			end
		end
	end
end

function BuyEatItemTipMediator:onClickGo(data)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(data.url)

	if entry then
		if data.enterParams then
			for k, v in pairs(data.enterParams) do
				params[k] = v
			end
		end

		entry:response(context, params)
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
	end
end

function BuyEatItemTipMediator:onGuideClickGo(data)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._spStageSystem:tryEnter({
		spType = self._stageType
	})

	local params = {
		stageType = self._stageType,
		stageId = self._stageId,
		pointId = data.Id,
		difficulty = data.Difficulty
	}
	local view = self:getInjector():getInstance("SpStageDftView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params, nil))
end

function BuyEatItemTipMediator:onClickBuyGift()
	if self._shopSystem:getVersionCanBuy(self._showShopItem, Strings:get("Activity_Version_Tips1")) then
		AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
		self._shopSystem:requestBuyPackageShop(self._showShopItem:getId(), nil, false)
	end
end

function BuyEatItemTipMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		if self._tabelView then
			for i = 1, #self._sourceList do
				local index = i
				local cell = self._tabelView:cellAtIndex(index - 1)

				if cell then
					local cell_Old = cell:getChildByTag(123)
					local goBtn = cell_Old:getChildByName("btn_go")

					storyDirector:setClickEnv("SourceView.goBtn" .. index, goBtn, function(sender, eventType)
						local sourceId = self._sourceList[index]
						local sourceConfig = ConfigReader:getRecordById("ItemResource", tostring(sourceId))

						self:onGuideClickGo(sourceConfig)
					end)
				end
			end
		end

		storyDirector:notifyWaiting("enter_Source_View")
	end))

	self:getView():runAction(sequence)
end
