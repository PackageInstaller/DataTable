-- chunkname: @modules/logic/store/view/recommend/GiftrecommendViewBase.lua

module("modules.logic.store.view.recommend.GiftrecommendViewBase", package.seeall)

local GiftrecommendViewBase = class("GiftrecommendViewBase", StoreRecommendBaseSubView)

function GiftrecommendViewBase:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._txtduration = gohelper.findChildText(self.viewGO, "view/txt_tips/#txt_duration")
	self._txtprice1 = gohelper.findChildText(self.viewGO, "view/left/#txt_price1")
	self._btnbuy1 = gohelper.findChildButtonWithAudio(self.viewGO, "view/left/#btn_buy1")
	self._txtprice2 = gohelper.findChildText(self.viewGO, "view/middle/#txt_price2")
	self._btnbuy2 = gohelper.findChildButtonWithAudio(self.viewGO, "view/middle/#btn_buy2")
	self._txtprice3 = gohelper.findChildText(self.viewGO, "view/right/#txt_price3")
	self._btnbuy3 = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_buy3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GiftrecommendViewBase:addEvents()
	self._btnbuy1:AddClickListener(self._btnbuy1OnClick, self)
	self._btnbuy2:AddClickListener(self._btnbuy2OnClick, self)
	self._btnbuy3:AddClickListener(self._btnbuy3OnClick, self)
end

function GiftrecommendViewBase:removeEvents()
	self._btnbuy1:RemoveClickListener()
	self._btnbuy2:RemoveClickListener()
	self._btnbuy3:RemoveClickListener()
end

function GiftrecommendViewBase:_btnbuy1OnClick()
	if self._isBought1 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if self._systemJumpCode1 then
		self:statClick()

		local goodsId = string.splitToNumber(self._systemJumpCode1, "#")[2]
		local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(goodsId)

		if chargeConfig and chargeConfig.type == StoreEnum.StoreChargeType.Optional then
			module_views_preloader.OptionalChargeView(function()
				GameFacade.jumpByAdditionParam(self._systemJumpCode1)
			end)
		else
			self:_jumpToStoreGoodView(self._systemJumpCode1)
		end
	end
end

function GiftrecommendViewBase:_btnbuy2OnClick()
	if self._isBought2 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if self._systemJumpCode2 then
		self:statClick()
		self:_jumpToStoreGoodView(self._systemJumpCode2)
	end
end

function GiftrecommendViewBase:_btnbuy3OnClick()
	if self._isBought3 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if self._systemJumpCode3 then
		self:statClick()
		self:_jumpToStoreGoodView(self._systemJumpCode3)
	end
end

function GiftrecommendViewBase:_jumpToStoreGoodView(jumpCode)
	local goodId = string.splitToNumber(jumpCode, "#")[2]
	local goodMo = StoreModel.instance:getGoodsMO(goodId)

	StoreController.instance:openPackageStoreGoodsView(goodMo)
end

function GiftrecommendViewBase:statClick()
	local var_9_0 = StatEnum.EventName.ClickRecommendPage
	local var_9_1 = {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store
	}

	var_9_1[StatEnum.EventProperties.RecommendPageId] = tostring((self.config or nil) and (self.config.id or ""))

	if self.config then
		var_9_1[StatEnum.EventProperties.RecommendPageName] = self.config.name or self.__cname
	end

	var_9_1[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()

	StatController.instance:track(var_9_0, var_9_1)
end

function GiftrecommendViewBase:_getCostSymbolAndPrice(systemJumpCode)
	if not systemJumpCode or systemJumpCode == "" then
		return
	end

	local paramsList = string.splitToNumber(systemJumpCode, "#")

	if type(paramsList) ~= "table" and #paramsList < 2 then
		return
	end

	local jumpGoodsId = paramsList[2]

	return StoreModel.instance:getCostSymbolAndPrice(jumpGoodsId)
end

function GiftrecommendViewBase:_getIsBought(relation)
	if not relation then
		return false
	end

	local relationType = relation[1]
	local relationId = relation[2]

	if not relationType or not relationId then
		return false
	end

	local storePackageGoodsMO = StoreModel.instance:getGoodsMO(relationId)

	if storePackageGoodsMO == nil or storePackageGoodsMO:isSoldOut() then
		return true
	end

	return false
end

function GiftrecommendViewBase:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function GiftrecommendViewBase:onOpen()
	GiftrecommendViewBase.super.onOpen(self)
	self.addEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self.refreshUI, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshUI, self)
	self:refreshUI()
end

function GiftrecommendViewBase:refreshUI()
	self._txtprice1.text = ""
	self._txtprice2.text = ""
	self._txtprice3.text = ""

	if self.config == nil then
		return
	end

	local jumpCodeParamsList = string.split(self.config.systemJumpCode, " ")

	if jumpCodeParamsList then
		self._systemJumpCode1 = jumpCodeParamsList[1]
		self._systemJumpCode2 = jumpCodeParamsList[2]
		self._systemJumpCode3 = jumpCodeParamsList[3]

		local symbol1, price1 = self:_getCostSymbolAndPrice(jumpCodeParamsList[1])

		if symbol1 then
			self._txtprice1.text = string.format("%s%s", symbol1, price1)
		end

		local symbol2, price2 = self:_getCostSymbolAndPrice(jumpCodeParamsList[2])

		if symbol2 then
			self._txtprice2.text = string.format("%s%s", symbol2, price2)
		end

		local symbol3, price3 = self:_getCostSymbolAndPrice(jumpCodeParamsList[3])

		if symbol3 then
			self._txtprice3.text = string.format("%s%s", symbol3, price3)
		end
	end

	if not string.nilorempty(self.config.relations) then
		local relations = GameUtil.splitString2(self.config.relations, true)

		if type(relations) == "table" then
			self._isBought1 = self:_getIsBought(relations[1])
			self._isBought2 = self:_getIsBought(relations[2])
			self._isBought3 = self:_getIsBought(relations[3])
		end
	end

	self._txtduration.text = StoreController.instance:getRecommendStoreTime(self.config)
end

function GiftrecommendViewBase:onClose()
	self.removeEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self.refreshUI, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshUI, self)
end

function GiftrecommendViewBase:onDestroyView()
	return
end

return GiftrecommendViewBase
