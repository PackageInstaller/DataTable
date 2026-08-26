-- chunkname: @modules/logic/store/view/recommend/GiftDecorateSkinSetView.lua

module("modules.logic.store.view.recommend.GiftDecorateSkinSetView", package.seeall)

local GiftDecorateSkinSetView = class("GiftDecorateSkinSetView", StoreRecommendBaseSubView)

function GiftDecorateSkinSetView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._simagedec = gohelper.findChildSingleImage(self.viewGO, "view/Left/#simage_dec")
	self._btnlook = gohelper.findChildButtonWithAudio(self.viewGO, "view/Left/#btn_look")
	self._txtduration = gohelper.findChildText(self.viewGO, "view/Right/txt_tips/#txt_duration")
	self._txtprice = gohelper.findChildText(self.viewGO, "view/Right/#txt_price")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/Right/#btn_buy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GiftDecorateSkinSetView:addEvents()
	if self._btnlook then
		self._btnlook:AddClickListener(self._btnlookOnClick, self)
	end

	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function GiftDecorateSkinSetView:removeEvents()
	if self._btnlook then
		self._btnlook:RemoveClickListener()
	end

	self._btnbuy:RemoveClickListener()
end

function GiftDecorateSkinSetView:_btnlookOnClick()
	self:_jumpByIndex(2)
end

function GiftDecorateSkinSetView:_btnbuyOnClick()
	self:_jumpByIndex(1)
end

function GiftDecorateSkinSetView:onOpen()
	GiftDecorateSkinSetView.super.onOpen(self)

	self._systyemjumpList = string.split(self.config.systemJumpCode, " ")

	self:refreshUI()
end

function GiftDecorateSkinSetView:_jumpByIndex(index)
	if self:_isBought() then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	local var_7_0 = StatEnum.EventName.ClickRecommendPage
	local var_7_1 = {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store
	}

	var_7_1[StatEnum.EventProperties.RecommendPageId] = tostring((self.config or nil) and (self.config.id or ""))

	if self.config then
		var_7_1[StatEnum.EventProperties.RecommendPageName] = self.config.name or "GiftDecorateSkinSetView"
	end

	StatController.instance:track(var_7_0, var_7_1)

	if self._systyemjumpList and self._systyemjumpList[index] then
		GameFacade.jumpByAdditionParam(self._systyemjumpList[index])
	end
end

function GiftDecorateSkinSetView:_getIsBought(relation)
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

function GiftDecorateSkinSetView:_isBought()
	if not string.nilorempty(self.config.relations) then
		local relations = GameUtil.splitString2(self.config.relations, true)

		if relations[1] then
			return self:_getIsBought(relations[1])
		end
	end
end

function GiftDecorateSkinSetView:refreshUI()
	if self.config == nil then
		return
	end

	self._txtduration.text = StoreController.instance:getRecommendStoreTime(self.config)

	if self._txtprice then
		local symbol1, price1 = self:_getCostSymbolAndPrice(self._systyemjumpList and self._systyemjumpList[1])

		if symbol1 then
			self._txtprice.text = string.format("<size=48>%s</size>%s", symbol1, price1)
		end
	end
end

function GiftDecorateSkinSetView:_getCostSymbolAndPrice(systemJumpCode)
	if not systemJumpCode or systemJumpCode == "" then
		return
	end

	local paramsList = string.splitToNumber(systemJumpCode, "#")

	if type(paramsList) ~= "table" or #paramsList < 2 then
		return
	end

	local jumpGoodsId = paramsList[2]

	return StoreModel.instance:getCostSymbolAndPrice(jumpGoodsId)
end

return GiftDecorateSkinSetView
