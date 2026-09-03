-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/currency/view/NewCurrencyBuyPopMediator.lua

NewCurrencyBuyPopMediator = class("NewCurrencyBuyPopMediator", DmPopupViewMediator, _M)

NewCurrencyBuyPopMediator:has("_currencySystem", {
	is = "r"
}):injectWith("CurrencySystem")
NewCurrencyBuyPopMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
NewCurrencyBuyPopMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
NewCurrencyBuyPopMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local clickEventMap = {
	["main.Node_button_1.Button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickGoldTag"
	},
	["main.Node_button_2.Button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickCrystalTag"
	},
	["main.Node_button_3.Button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickExpTag"
	},
	["main.Node_cost.button"] = {
		ignoreClickAudio = true,
		func = "onClickSendBuy"
	}
}
local exchangeCardType = {
	[CurrencyType.kGold] = "IM_VillageGoldOre_6",
	[CurrencyType.kCrystal] = "IM_VillageCrystalOre_6",
	[CurrencyType.kExp] = "IM_VillageExpOre_6"
}

function NewCurrencyBuyPopMediator:initialize()
	super.initialize(self)
end

function NewCurrencyBuyPopMediator:dispose()
	super.dispose(self)
end

function NewCurrencyBuyPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SELL_ITEM_SUCC, self, self.updateConsumablePanel)
end

function NewCurrencyBuyPopMediator:mapEventListeners()
	return
end

function NewCurrencyBuyPopMediator:enterWithData(data)
	self._buyType = data._currencyType or CurrencyType.kGold
	self._showButtonTag = true
	self._bagSystem = self._developSystem:getBagSystem()
	self._tabBtnList = {}

	self:setupView()
	self:refreshView()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_CRYSTAL_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_EXP_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_GOLD_SUCC, self, self.refreshView)
end

function NewCurrencyBuyPopMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._bonusAnim = self:getView():getChildByName("bonusAnim")
	self._consumableItemPanel = self:getView():getChildByName("itemPanel")

	local titleText = self._mainPanel:getChildByFullName("title")

	titleText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local text_costNum = self._mainPanel:getChildByFullName("Node_cost.costvalue")

	titleText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	for i = 1, 3 do
		local buttonNode = self._mainPanel:getChildByFullName("Node_button_" .. i)
		local selectImag = buttonNode:getChildByFullName("Image")
		local button = buttonNode:getChildByFullName("Button")

		self._tabBtnList[i] = {
			button = button,
			selectImag = selectImag
		}

		if self._showButtonTag then
			buttonNode:setVisible(true)
		else
			buttonNode:setVisible(false)
		end
	end
end

function NewCurrencyBuyPopMediator:refreshView()
	local text_getNum = self._mainPanel:getChildByFullName("Text_getNum")
	local node_cost = self._mainPanel:getChildByFullName("Node_cost")
	local lockTip = node_cost:getChildByFullName("lockTip")
	local button = node_cost:getChildByFullName("button")
	local icon = node_cost:getChildByFullName("icon")
	local costvalue = node_cost:getChildByFullName("costvalue")
	local text_time = node_cost:getChildByFullName("Text_2")
	local text_expDes = self._mainPanel:getChildByFullName("Text_expDes")

	text_expDes:setVisible(false)

	for index, buttonInfo in pairs(self._tabBtnList) do
		local selectImag = buttonInfo.selectImag

		selectImag:setVisible(false)

		if index == 1 and self._buyType == CurrencyType.kGold then
			selectImag:setVisible(true)
		elseif index == 2 and self._buyType == CurrencyType.kCrystal then
			selectImag:setVisible(true)
		elseif index == 3 and self._buyType == CurrencyType.kExp then
			selectImag:setVisible(true)
		end
	end

	local bg = self._mainPanel:getChildByFullName("bg")

	if self._buyType == CurrencyType.kGold then
		bg:loadTexture("zygm_bg_jb.png", ccui.TextureResType.plistType)

		local text_des1 = self._mainPanel:getChildByFullName("Text_des1")

		if text_des1 then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(75, 18, 6, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(144, 51, 19, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_des1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_des1:enableOutline(cc.c4b(255, 219, 141, 255), 2)
		end

		local text_des2 = self._mainPanel:getChildByFullName("Text_des2")

		if text_des2 then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 238, 120, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_des2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_des2:enableOutline(cc.c4b(182, 77, 68, 255), 2)
			text_des2:setString(Strings:get("Resource_Exchange_Text_Gold"))
		end

		local text_getNum = self._mainPanel:getChildByFullName("Text_getNum")

		if text_getNum then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 238, 120, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_getNum:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_getNum:enableOutline(cc.c4b(212, 77, 32, 255), 2)
		end
	elseif self._buyType == CurrencyType.kCrystal then
		bg:loadTexture("zygm_bg_sj.png", ccui.TextureResType.plistType)

		local text_des1 = self._mainPanel:getChildByFullName("Text_des1")

		if text_des1 then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(45, 20, 62, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(98, 52, 122, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_des1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_des1:enableOutline(cc.c4b(229, 153, 236, 255), 2)
		end

		local text_des2 = self._mainPanel:getChildByFullName("Text_des2")

		if text_des2 then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 238, 120, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_des2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_des2:enableOutline(cc.c4b(125, 56, 80, 255), 2)
			text_des2:setString(Strings:get("Resource_Exchange_Text_Crystal"))
		end

		local text_getNum = self._mainPanel:getChildByFullName("Text_getNum")

		if text_getNum then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 238, 120, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_getNum:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_getNum:enableOutline(cc.c4b(159, 53, 186, 255), 2)
		end
	elseif self._buyType == CurrencyType.kExp then
		bg:loadTexture("zygm_bg_jy.png", ccui.TextureResType.plistType)
		text_expDes:setVisible(true)

		local text_des1 = self._mainPanel:getChildByFullName("Text_des1")

		if text_des1 then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(13, 43, 19, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(42, 77, 48, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_des1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_des1:enableOutline(cc.c4b(160, 223, 145, 255), 2)
		end

		if text_expDes then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(13, 43, 19, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(42, 77, 48, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_expDes:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_expDes:enableOutline(cc.c4b(160, 223, 145, 255), 2)
		end

		local text_des2 = self._mainPanel:getChildByFullName("Text_des2")

		if text_des2 then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 221, 131, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_des2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_des2:enableOutline(cc.c4b(47, 95, 52, 255), 2)
			text_des2:setString(Strings:get("Resource_Exchange_Text_Exp"))
		end

		local text_getNum = self._mainPanel:getChildByFullName("Text_getNum")

		if text_getNum then
			local lineGradiantVec2 = {
				{
					ratio = 0.3,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 0.7,
					color = cc.c4b(255, 221, 131, 255)
				}
			}
			local lineGradiantDir = {
				x = 0,
				y = -1
			}

			text_getNum:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
			text_getNum:enableOutline(cc.c4b(59, 95, 47, 255), 2)
		end
	end

	local unlockKey

	if self._buyType == CurrencyType.kGold then
		unlockKey = "BuyGold"

		local aBuyTimes = self._bagSystem:getBuyTimesByType(TimeRecordType.kBuyGold)
		local priceArr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BuyGold_Price", "content")
		local buyGold_Base = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BuyGold_Base", "content")
		local aTotTimes = buyGold_Base.maxTime
		local times = aBuyTimes + 1

		self._curPrice = priceArr[times] or priceArr[#priceArr]

		costvalue:setString(self._curPrice)
		text_time:setString(aBuyTimes .. "/" .. aTotTimes)

		local getResNum = self._buildingSystem:getBuyResGetNum("BuyGold_Base")

		text_getNum:setString(getResNum)
	elseif self._buyType == CurrencyType.kCrystal then
		unlockKey = "BuyCrystal"

		local aBuyTimes = self._bagSystem:getBuyTimesByType(TimeRecordType.kBuyCrystal)
		local priceArr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BuyCrystal_Price", "content")
		local buyCrystal_Base = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BuyCrystal_Base", "content")
		local aTotTimes = buyCrystal_Base.maxTime
		local times = aBuyTimes + 1

		self._curPrice = priceArr[times] or priceArr[#priceArr]

		costvalue:setString(self._curPrice)
		text_time:setString(aBuyTimes .. "/" .. aTotTimes)

		local getResNum = self._buildingSystem:getBuyResGetNum("BuyCrystal_Base")

		text_getNum:setString(getResNum)
	elseif self._buyType == CurrencyType.kExp then
		unlockKey = "BuyExp"

		local aBuyTimes = self._bagSystem:getBuyTimesByType(TimeRecordType.kBuyExp)
		local priceArr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BuyExp_Price", "content")
		local buyExp_Base = ConfigReader:getDataByNameIdAndKey("ConfigValue", "BuyExp_Base", "content")
		local aTotTimes = buyExp_Base.maxTime
		local times = aBuyTimes + 1

		self._curPrice = priceArr[times] or priceArr[#priceArr]

		costvalue:setString(self._curPrice)
		text_time:setString(aBuyTimes .. "/" .. aTotTimes)

		local getResNum = self._buildingSystem:getBuyResGetNum("BuyExp_Base")

		text_getNum:setString(getResNum)
	end

	if unlockKey then
		local unlock, tips = self._systemKeeper:isUnlock(unlockKey)
		local config = ConfigReader:getRecordById("UnlockSystem", unlockKey)
		local condition = config.Condition

		if condition.STAGE then
			unlock, tips = self._systemKeeper:checkStagePointLock(condition.STAGE)
		end

		button:setGray(not unlock)
		button:setTouchEnabled(unlock)
		icon:setVisible(unlock)
		costvalue:setVisible(unlock)
		lockTip:setVisible(not unlock)

		if not unlock then
			lockTip:setString(Strings:get("Currency_Buy_Unlock", {
				stage = tips
			}))
		end
	else
		button:setGray(false)
		button:setTouchEnabled(true)
		icon:setVisible(true)
		costvalue:setVisible(true)
		lockTip:setVisible(false)
	end

	self:updateConsumablePanel()
end

function NewCurrencyBuyPopMediator:onClickClose(sender, eventType)
	self:close()
end

function NewCurrencyBuyPopMediator:onClickGoldTag(sender, eventType)
	if self._buyType == CurrencyType.kGold then
		return
	end

	self._buyType = CurrencyType.kGold

	self:refreshView()
end

function NewCurrencyBuyPopMediator:onClickCrystalTag(sender, eventType)
	if self._buyType == CurrencyType.kCrystal then
		return
	end

	self._buyType = CurrencyType.kCrystal

	self:refreshView()
end

function NewCurrencyBuyPopMediator:onClickExpTag(sender, eventType)
	if self._buyType == CurrencyType.kExp then
		return
	end

	self._buyType = CurrencyType.kExp

	self:refreshView()
end

function NewCurrencyBuyPopMediator:onClickSendBuy(sender, eventType)
	if CurrencySystem:checkEnoughDiamond(self, self._curPrice) then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if self._buyType == CurrencyType.kCrystal then
			self._currencySystem:requestBuyCrystal({
				times = 1
			}, function(response)
				if DisposableObject:isDisposed(self) then
					return
				end

				AudioEngine:getInstance():playEffect("Se_Effect_Exchange_Crystal", false)
				self:runBuyCrystalAnim(response)
			end)
		elseif self._buyType == CurrencyType.kExp then
			self._currencySystem:requestBuyExp({
				times = 1
			}, function(response)
				if DisposableObject:isDisposed(self) then
					return
				end

				AudioEngine:getInstance():playEffect("Se_Effect_Exchange_Crystal", false)
				self:runBuyExpAnim(response)
			end)
		elseif self._buyType == CurrencyType.kGold then
			self._currencySystem:requestBuyGold({
				times = 1
			}, function(response)
				if DisposableObject:isDisposed(self) then
					return
				end

				AudioEngine:getInstance():playEffect("Se_Effect_Exchange_Crystal", false)
				self:runBuyGoldAnim(response)
			end)
		end
	end
end

function NewCurrencyBuyPopMediator:runBuyCrystalAnim(response)
	local anim = self._bonusAnim:getChildByName("CrystalAnim")

	if not anim then
		anim = cc.MovieClip:create("jinbidh_duihuanjingshi")

		anim:setPosition(cc.p(0, 0))
		self._bonusAnim:addChild(anim)
		anim:setName("CrystalAnim")
		anim:addEndCallback(function()
			anim:stop()
			anim:setVisible(false)
		end)
	end

	anim:gotoAndPlay(0)
	anim:setVisible(true)
end

function NewCurrencyBuyPopMediator:runBuyExpAnim(response)
	local anim = self._bonusAnim:getChildByName("ExpAnim")

	if not anim then
		anim = cc.MovieClip:create("zongdhjingyan_duihuantili")

		anim:setPosition(cc.p(0, 0))
		self._bonusAnim:addChild(anim)
		anim:setName("ExpAnim")
		anim:addEndCallback(function()
			anim:stop()
			anim:setVisible(false)
		end)
	end

	anim:gotoAndPlay(0)
	anim:setVisible(true)
end

function NewCurrencyBuyPopMediator:runBuyGoldAnim(response)
	self._soundId = AudioEngine:getInstance():playEffect("Se_Effect_Drop_Coin", false)

	self._bonusAnim:removeChildByName("DianJinShowAnim")

	local bonusNum = 1

	if response.data then
		for i, v in pairs(response.data) do
			bonusNum = math.max(bonusNum, v)
		end
	end

	if bonusNum > 1 then
		local anim = cc.MovieClip:create("dianjinshoutexiao_dianjinshoubaoji")

		anim:addTo(self._bonusAnim)
		anim:setName("DianJinShowAnim")
		anim:setPosition(cc.p(85, -44))
		anim:addEndCallback(function()
			anim:stop()
		end)
		anim:setLocalZOrder(2)

		local labelPanel = anim:getChildByName("label")

		self:showBonus(labelPanel, bonusNum)
	end

	local anim = self._bonusAnim:getChildByName("GoldAnim")

	if not anim then
		anim = cc.MovieClip:create("jinbidh_duihuanjinbi")

		anim:setPosition(cc.p(0, 0))
		self._bonusAnim:addChild(anim)
		anim:setName("GoldAnim")
		anim:addEndCallback(function()
			anim:stop()
			anim:setVisible(false)
			self._bonusAnim:removeChildByName("DianJinShowAnim")
		end)
	end

	anim:gotoAndPlay(0)
	anim:setVisible(true)
end

function NewCurrencyBuyPopMediator:updateConsumablePanel()
	local curId = exchangeCardType[self._buyType]
	local entry = self._bagSystem:getEntryById(curId)

	if entry then
		local item = entry.item
		local iconNode = self._consumableItemPanel:getChildByFullName("Node_icon")

		iconNode:removeAllChildren()

		local icon = IconFactory:createIcon({
			id = item:getId(),
			amount = entry.count
		})
		local scale = 0.6

		icon:setScale(scale)

		if icon.getAmountLabel then
			local label = icon:getAmountLabel()

			label:setScale(1 / scale)
			label:enableOutline(cc.c4b(0, 0, 0, 255), 2)
		end

		icon:addTo(iconNode)
		icon:center(iconNode:getContentSize())

		local nameLabel = self._consumableItemPanel:getChildByFullName("Text_name")

		nameLabel:setString(item:getName())

		local button = self._consumableItemPanel:getChildByFullName("entry.button")

		self._consumableItemPanel:getChildByFullName("entry.name"):setString(Strings:get("bag_UI13"))

		local function callFunc()
			self._bagSystem:tryUseActionPointItem(item:getId(), 1)
		end

		mapButtonHandlerClick(nil, button, {
			func = callFunc
		})
		self._consumableItemPanel:setVisible(true)
	else
		self._consumableItemPanel:setVisible(false)
	end
end
