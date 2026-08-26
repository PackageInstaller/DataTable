-- chunkname: @modules/logic/store/view/recommend/StoreRoleSkinView.lua

module("modules.logic.store.view.recommend.StoreRoleSkinView", package.seeall)

local StoreRoleSkinView = class("StoreRoleSkinView", StoreRecommendBaseSubView)

function StoreRoleSkinView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._simagesignature1 = gohelper.findChildSingleImage(self.viewGO, "view/left/role1/#simage_signature1")
	self._simagesignature2 = gohelper.findChildSingleImage(self.viewGO, "view/left/role2/#simage_signature2")
	self._txtdurationTime = gohelper.findChildText(self.viewGO, "view/right/time/#txt_durationTime")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_buy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreRoleSkinView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function StoreRoleSkinView:removeEvents()
	self._btnbuy:RemoveClickListener()
end

function StoreRoleSkinView:_btnbuyOnClick()
	local var_4_0 = StatEnum.EventName.ClickRecommendPage
	local var_4_1 = {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store
	}

	var_4_1[StatEnum.EventProperties.RecommendPageId] = tostring((self.config or nil) and (self.config.id or ""))

	if self.config then
		var_4_1[StatEnum.EventProperties.RecommendPageName] = self.config.name or "StoreRoleSkinView"
	end

	var_4_1[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()

	StatController.instance:track(var_4_0, var_4_1)

	local skinGoods = {}

	if self.config.relations and not string.nilorempty(self.config.relations) then
		local relations = string.split(self.config.relations, "|")

		for _, relation in pairs(relations) do
			local goods = string.splitToNumber(relation, "#")

			if goods[1] == 5 then
				table.insert(skinGoods, goods[2])
			end
		end
	end

	local unSoldOutGoods = {}

	for _, skinGood in ipairs(skinGoods) do
		local skinGoodMo = StoreModel.instance:getGoodsMO(skinGood)
		local has = skinGoodMo:alreadyHas()

		if not has then
			table.insert(unSoldOutGoods, skinGoodMo)
		end
	end

	if #unSoldOutGoods < 1 then
		return
	end

	GameFacade.jumpByAdditionParam(self.config.systemJumpCode .. "#" .. tostring(unSoldOutGoods[1].goodsId) .. "#1")
end

function StoreRoleSkinView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._txtprice = gohelper.findChildText(self.viewGO, "view/left/#txt_price")
end

function StoreRoleSkinView:onUpdateParam()
	return
end

function StoreRoleSkinView:onOpen()
	StoreRoleSkinView.super.onOpen(self)
	self:refreshUI()
end

function StoreRoleSkinView:refreshUI()
	self.config = self.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreRoleSkinView)
	self._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(self.config)

	if self._txtprice then
		local symbol1, price1 = self:_getCostSymbolAndPrice(self.config.systemJumpCode)

		if symbol1 then
			self._txtprice.text = string.format("%s%s", symbol1, price1)
		end
	end
end

function StoreRoleSkinView:onClose()
	return
end

function StoreRoleSkinView:onDestroyView()
	return
end

function StoreRoleSkinView:_getCostSymbolAndPrice(systemJumpCode)
	if not systemJumpCode or systemJumpCode == "" then
		return
	end

	local paramsList = string.splitToNumber(systemJumpCode, "#")

	if type(paramsList) ~= "table" and #paramsList < 2 then
		return
	end

	local jumpGoodsId = paramsList[2]

	return PayModel.instance:getProductPrice(jumpGoodsId), ""
end

return StoreRoleSkinView
