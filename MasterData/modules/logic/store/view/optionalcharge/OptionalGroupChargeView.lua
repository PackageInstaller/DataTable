-- chunkname: @modules/logic/store/view/optionalcharge/OptionalGroupChargeView.lua

module("modules.logic.store.view.optionalcharge.OptionalGroupChargeView", package.seeall)

local OptionalGroupChargeView = class("OptionalGroupChargeView", BaseView)

function OptionalGroupChargeView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Title/#txt_TitleEn")
	self._txtSelectNum = gohelper.findChildText(self.viewGO, "Title/image_TitleTips/#txt_SelectNum")
	self._gogiftContent = gohelper.findChild(self.viewGO, "#go_giftContent")
	self._gogiftItem = gohelper.findChild(self.viewGO, "#go_giftContent/#go_giftItem")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Buy")
	self._txtPrice = gohelper.findChildText(self.viewGO, "#btn_Buy/#txt_Price")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Tips/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OptionalGroupChargeView:addEvents()
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self.payFinished, self)
end

function OptionalGroupChargeView:removeEvents()
	self._btnBuy:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self.payFinished, self)
end

function OptionalGroupChargeView:_btnBuyOnClick()
	if not self.curSelectGiftId or self.curSelectGiftId == 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	local selectInfos = {}

	selectInfos[self.curSelectGiftId] = 1

	PayController.instance:startPay(self.packageGoodsMO.id, selectInfos)
end

function OptionalGroupChargeView:_btnCloseOnClick()
	self:closeThis()
end

function OptionalGroupChargeView:_onGiftItemClick(giftItem)
	if self.curSelectGiftId == giftItem.config.id then
		return
	end

	self.curSelectGiftId = giftItem.config.id

	self:refreshGiftItemSelectState()
end

function OptionalGroupChargeView:_onRewardItemClick(rewardItem)
	MaterialTipController.instance:showMaterialInfo(rewardItem.itemData[1], rewardItem.itemData[2])
end

function OptionalGroupChargeView:payFinished()
	self:closeThis()
end

function OptionalGroupChargeView:_editableInitView()
	self.giftItemMap = self:getUserDataTb_()

	gohelper.setActive(self._gogiftItem, false)
end

function OptionalGroupChargeView:onUpdateParam()
	return
end

function OptionalGroupChargeView:onOpen()
	self.packageGoodsMO = self.viewParam
	self.chargeGoodsConfig = self.packageGoodsMO.config
	self.chargeOptionCoList = StoreConfig.instance:getChargeOptionalGroup(self.chargeGoodsConfig.id)
	self.curSelectGiftId = 1

	self:createGiftItem()
	self:refreshUI()
	self:refreshGiftItemSelectState()

	if self.packageGoodsMO then
		StoreController.instance:statOpenChargeGoods(self.packageGoodsMO.belongStoreId, self.packageGoodsMO.config)
	end
end

function OptionalGroupChargeView:refreshUI()
	self._txtTitle.text = self.chargeGoodsConfig.name
	self._txtTitleEn.text = self.chargeGoodsConfig.nameEn

	local costStr = string.format("<color=#e98457>%s</color>", PayModel.instance:getProductPrice(self.packageGoodsMO.id))

	self._txtPrice.text = formatLuaLang("price_cost", costStr)
	self._txtSelectNum.text = string.format("<color=#e98457>%d</color>/%d", 1, 1)
end

function OptionalGroupChargeView:createGiftItem()
	for index, chargeOptionConfig in ipairs(self.chargeOptionCoList) do
		local giftItem = self.giftItemMap[chargeOptionConfig.id]

		if not giftItem then
			giftItem = {
				config = chargeOptionConfig,
				go = gohelper.cloneInPlace(self._gogiftItem, "giftItem" .. chargeOptionConfig.id)
			}
			giftItem.root = gohelper.findChild(giftItem.go, "root")
			giftItem.goNormalBg = gohelper.findChild(giftItem.go, "root/go_normalbg")
			giftItem.txtName = gohelper.findChildText(giftItem.go, "root/txt_name")
			giftItem.btnClick = gohelper.findChildButtonWithAudio(giftItem.go, "root/btn_click")
			giftItem.goContent = gohelper.findChild(giftItem.go, "root/go_content")
			giftItem.goItem = gohelper.findChild(giftItem.go, "root/go_content/go_item")
			giftItem.imageIndex = gohelper.findChildImage(giftItem.go, "root/image_index")
			giftItem.goSelect = gohelper.findChild(giftItem.go, "go_select")
			giftItem.itemList = {}
			self.giftItemMap[chargeOptionConfig.id] = giftItem
		end

		gohelper.setActive(giftItem.go, true)
		giftItem.btnClick:AddClickListener(self._onGiftItemClick, self, giftItem)

		giftItem.txtName.text = chargeOptionConfig.name

		UISpriteSetMgr.instance:setStoreGoodsSprite(giftItem.imageIndex, "releasegift_img_num" .. chargeOptionConfig.id)
		self:createRewardItem(giftItem)
	end
end

function OptionalGroupChargeView:createRewardItem(giftItem)
	local itemDataList = GameUtil.splitString2(giftItem.config.items, true)

	gohelper.setActive(giftItem.goItem, false)

	for index, itemData in ipairs(itemDataList) do
		local rewardItem = giftItem.itemList[index]

		if not rewardItem then
			rewardItem = {
				itemData = itemData,
				root = gohelper.cloneInPlace(giftItem.goItem, "rewardItem" .. index)
			}
			rewardItem.imageRare = gohelper.findChildImage(rewardItem.root, "image_rare")
			rewardItem.simageIcon = gohelper.findChildSingleImage(rewardItem.root, "simage_icon")
			rewardItem.txtCount = gohelper.findChildText(rewardItem.root, "countbg/txt_count")
			rewardItem.btnClick = gohelper.findChildButtonWithAudio(rewardItem.root, "btn_click")

			gohelper.setActive(rewardItem.root, true)

			giftItem.itemList[index] = rewardItem
		end

		rewardItem.itemConfig, rewardItem.iconPath = ItemModel.instance:getItemConfigAndIcon(rewardItem.itemData[1], rewardItem.itemData[2])

		UISpriteSetMgr.instance:setUiFBSprite(rewardItem.imageRare, "bg_pinjidi_" .. rewardItem.itemConfig.rare)
		rewardItem.simageIcon:LoadImage(rewardItem.iconPath)
		rewardItem.btnClick:AddClickListener(self._onRewardItemClick, self, rewardItem)

		rewardItem.txtCount.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("optionalgroupchargeview_rewardItemCount"), luaLang("multiple"), tostring(itemData[3]))
	end
end

function OptionalGroupChargeView:refreshGiftItemSelectState()
	for index, giftItem in pairs(self.giftItemMap) do
		local isSelect = giftItem.config.id == self.curSelectGiftId
		local scale = isSelect and 1.1 or 1

		gohelper.setActive(giftItem.goSelect, isSelect)
		gohelper.setActive(giftItem.goNormalBg, not isSelect)
		transformhelper.setLocalScale(giftItem.root.transform, scale, scale, scale)
	end

	local curSelectGiftConfig = self.giftItemMap[self.curSelectGiftId].config

	self._txtdesc.text = curSelectGiftConfig.desc
end

function OptionalGroupChargeView:onClose()
	for _, giftItem in pairs(self.giftItemMap) do
		giftItem.btnClick:RemoveClickListener()

		for _, rewardItem in pairs(giftItem.itemList) do
			rewardItem.simageIcon:UnLoadImage()
			rewardItem.btnClick:RemoveClickListener()
		end
	end
end

function OptionalGroupChargeView:onDestroyView()
	return
end

return OptionalGroupChargeView
