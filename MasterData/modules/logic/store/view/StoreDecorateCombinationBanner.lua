-- chunkname: @modules/logic/store/view/StoreDecorateCombinationBanner.lua

module("modules.logic.store.view.StoreDecorateCombinationBanner", package.seeall)

local StoreDecorateCombinationBanner = class("StoreDecorateCombinationBanner", FightUISkinMaterialTipViewBanner)

function StoreDecorateCombinationBanner:onInitView()
	StoreDecorateCombinationBanner.super.onInitView(self)

	self._goleftarrow = gohelper.findChild(self.viewGO, "left/banner/#go_leftarrow")
	self._gorightarrow = gohelper.findChild(self.viewGO, "left/banner/#go_rightarrow")
	self._gopaperpoint = gohelper.findChild(self.viewGO, "left/banner/#go_paperpoint")
	self._gopoint = gohelper.findChild(self.viewGO, "left/banner/#go_paperpoint/#go_point")
	self._goroominfoItem = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	self._goSceneLogo = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._goSceneLogo2 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo2")
	self._goSceneLogo3 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo3")
	self._goSceneLogo4 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo4")
end

function StoreDecorateCombinationBanner:_editableInitView()
	StoreDecorateCombinationBanner.super._editableInitView(self)

	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "left/banner/#go_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "left/banner/#go_rightarrow")
	self._pointItems = self:getUserDataTb_()
	self._showProduct = {}
	self._roomInfoItem = self:_createInfoItemUserDataTb_(self._goroominfoItem)
end

function StoreDecorateCombinationBanner:addEvents()
	self._btnleftarrow:AddClickListener(self._onLeftArrowClick, self)
	self._btnrightarrow:AddClickListener(self._onRightArrowClick, self)
end

function StoreDecorateCombinationBanner:removeEvents()
	self._btnleftarrow:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
end

StoreDecorateCombinationBanner.AutoSwitchInterval = 3

function StoreDecorateCombinationBanner:checkParam()
	self._goodsId = self.viewParam and self.viewParam.goodsId

	if not self._goodsId then
		return
	end

	self._goodsMo = StoreModel.instance:getGoodsMO(self._goodsId)

	if self._goodsMo then
		self._goodsCo = self._goodsMo.config or StoreConfig.instance:getGoodsConfig(self._goodsId)
	end

	local productList = GameUtil.splitString2(self._goodsCo.product, true)

	tabletool.clear(self._showProduct)

	local showProductCount = 0

	for _, product in ipairs(productList) do
		local itemConfig = ItemConfig.instance:getItemConfig(product[1], product[2])

		if itemConfig and PackageStoreEnum.DecorateCombinationType[itemConfig.subType] then
			table.insert(self._showProduct, product)

			showProductCount = showProductCount + 1
		end
	end

	self.showProductCount = showProductCount
end

function StoreDecorateCombinationBanner:onOpen()
	self:checkParam()
	self:_refreshSwitch()
end

function StoreDecorateCombinationBanner:refreshLogo()
	local productInfo = self._showProduct[self._curProductIndex]
	local itemConfig = ItemConfig.instance:getItemConfig(productInfo[1], productInfo[2])

	gohelper.setActive(self._goSceneLogo, false)
	gohelper.setActive(self._goSceneLogo2, itemConfig.subType == ItemEnum.SubType.FightFloatType)
	gohelper.setActive(self._goSceneLogo3, itemConfig.subType == ItemEnum.SubType.FightCard)
	gohelper.setActive(self._goSceneLogo4, false)
end

function StoreDecorateCombinationBanner:_refreshUI()
	local productInfo = self._showProduct[self._curProductIndex]

	self:_updateInfoItemUI(self._roomInfoItem, productInfo[2], productInfo[1])
	self:refreshLogo()
end

function StoreDecorateCombinationBanner:_refreshThemeImage(simageIcon, icon)
	simageIcon:LoadImage(ResUrl.getDecorateStoreBuyBannerFullPath(icon), function()
		ZProj.UGUIHelper.SetImageSize(simageIcon.gameObject)
	end, self)
end

function StoreDecorateCombinationBanner:_updateInfoItemUI(itemUserDataTb, itemId, itemType)
	local tb = itemUserDataTb
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	tb._txtdesc.text = config.desc
	tb._txtname.text = config.name

	local showTitle = config.subType ~= ItemEnum.SubType.PlayerBg

	gohelper.setActive(tb._gotag, false)
	gohelper.setActive(tb._gotag2, showTitle)
	gohelper.setActive(tb._btn, showTitle)

	tb._gotagtxt.text = luaLang("p_mainsceneswitchview_title_3")

	if showTitle then
		self:_addClickFightUI(tb._btn, itemId)

		local mo = FightUISwitchModel.instance:getStyleMoByItemId(itemId)

		if mo then
			tb._uiSkinId = mo.id

			if not string.nilorempty(mo.co.previewImage) then
				tb._simageinfobg:LoadImage(ResUrl.getMainSceneSwitchIcon(mo.co.previewImage))
			end
		end
	else
		self:_refreshThemeImage(tb._simageinfobg, itemId)
	end
end

function StoreDecorateCombinationBanner:_initPointItems(count)
	for i = 1, count do
		local item = self._pointItems[i]

		if not item then
			if i == 1 then
				if not self._gopoint then
					local go = gohelper.clone(self._gopoint, self._gopaperpoint, "point_" .. i)

					item = self:getUserDataTb_()
					item.go = go
					item.goGray = gohelper.findChild(go, "#go_gray")
					item.goLight = gohelper.findChild(go, "#go_light")
					self._pointItems[i] = item
				end
			end
		end

		gohelper.setActive(item.go, true)
	end

	for i = count + 1, #self._pointItems do
		gohelper.setActive(self._pointItems[i].go, false)
	end
end

function StoreDecorateCombinationBanner:_refreshPointState()
	if not self._pointItems then
		return
	end

	local showSwitch = self.showProductCount > 1

	gohelper.setActive(self._goleftarrow, showSwitch and self._curProductIndex > 1)
	gohelper.setActive(self._gorightarrow, showSwitch and self._curProductIndex < self.showProductCount)
	gohelper.setActive(self._gopaperpoint, showSwitch)

	for i, item in ipairs(self._pointItems) do
		if item.goGray then
			gohelper.setActive(item.goGray, i ~= self._curProductIndex)
		end

		if item.goLight then
			gohelper.setActive(item.goLight, i == self._curProductIndex)
		end
	end
end

function StoreDecorateCombinationBanner:_switchProductIndex(index)
	if not self._showProduct or self.showProductCount == 0 then
		return
	end

	if index < 1 or index > self.showProductCount then
		return
	end

	if index == self._curProductIndex then
		return
	end

	self._curProductIndex = index

	local showSwitch = self.showProductCount > 1

	if showSwitch then
		self:_refreshPointState()
		self:_startAutoSwitch()
	end

	self:_refreshUI()
end

function StoreDecorateCombinationBanner:_onLeftArrowClick()
	if not self._showProduct or self.showProductCount == 0 then
		return
	end

	local nextIndex = self._curProductIndex - 1

	if nextIndex < 1 then
		nextIndex = self.showProductCount
	end

	self:_switchProductIndex(nextIndex)
end

function StoreDecorateCombinationBanner:_onRightArrowClick()
	if not self._showProduct or self.showProductCount == 0 then
		return
	end

	local nextIndex = self._curProductIndex + 1

	if nextIndex > self.showProductCount then
		nextIndex = 1
	end

	self:_switchProductIndex(nextIndex)
end

function StoreDecorateCombinationBanner:_onMoveNextProduct()
	local nextIndex = self._curProductIndex + 1

	if nextIndex > self.showProductCount then
		nextIndex = 1
	end

	self:_switchProductIndex(nextIndex)
end

function StoreDecorateCombinationBanner:_startAutoSwitch()
	self:_stopAutoSwitch()
	TaskDispatcher.runDelay(self._onMoveNextProduct, self, StoreDecorateCombinationBanner.AutoSwitchInterval)
end

function StoreDecorateCombinationBanner:_stopAutoSwitch()
	TaskDispatcher.cancelTask(self._onMoveNextProduct, self)
end

function StoreDecorateCombinationBanner:_refreshSwitch()
	self:_stopAutoSwitch()
	self:_switchProductIndex(1)

	if self.showProductCount <= 1 then
		gohelper.setActive(self._goleftarrow, false)
		gohelper.setActive(self._gorightarrow, false)
		gohelper.setActive(self._gopaperpoint, false)

		return
	end

	local showSwitch = self.showProductCount > 1

	if showSwitch then
		self:_startAutoSwitch()
		self:_initPointItems(self.showProductCount)
	end

	self:_refreshPointState()
end

function StoreDecorateCombinationBanner:_addClickFightUI(btn, itemId)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		FightUISwitchController.instance:openSceneView(itemId)
	end, self)
end

function StoreDecorateCombinationBanner:onClose()
	StoreDecorateCombinationBanner.super.onClose(self)
	self:_stopAutoSwitch()

	if self._pointItems then
		tabletool.clear(self._pointItems)

		self._pointItems = nil
	end

	self._showProduct = nil
end

return StoreDecorateCombinationBanner
