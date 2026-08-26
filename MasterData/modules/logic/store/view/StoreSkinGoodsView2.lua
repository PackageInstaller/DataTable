-- chunkname: @modules/logic/store/view/StoreSkinGoodsView2.lua

module("modules.logic.store.view.StoreSkinGoodsView2", package.seeall)

local StoreSkinGoodsView2 = class("StoreSkinGoodsView2", BaseView)
local spineDefaultPos = {
	45,
	-46,
	0
}
local spineBgSpecialPos = {
	-460,
	0,
	0
}
local spineDefaultScale = 0.85
local defaultSignaturePng = "singlebg/signature/color/img_dressing1.png"

function StoreSkinGoodsView2:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_leftbg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_icon")
	self._simagedreesing = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_dreesing")
	self._txtskinname = gohelper.findChildText(self.viewGO, "view/propinfo/#txt_skinname")
	self._txtdesc = gohelper.findChildText(self.viewGO, "view/propinfo/content/desc/#txt_desc")
	self._txtusedesc = gohelper.findChildText(self.viewGO, "view/propinfo/content/desc/usedesc")
	self._goleftbg = gohelper.findChild(self.viewGO, "view/propinfo/content/remain/#go_leftbg")
	self._txtremainday = gohelper.findChildText(self.viewGO, "view/propinfo/content/remain/#go_leftbg/#txt_remainday")
	self._gorightbg = gohelper.findChild(self.viewGO, "view/propinfo/content/remain/#go_rightbg")
	self._txtremain = gohelper.findChildText(self.viewGO, "view/propinfo/content/remain/#go_rightbg/#txt_remain")
	self._scrollproduct = gohelper.findChildScrollRect(self.viewGO, "view/propinfo/#scroll_product")
	self._goicon = gohelper.findChild(self.viewGO, "view/propinfo/#scroll_product/product/go_goods/#go_icon")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_close")
	self._godeco = gohelper.findChild(self.viewGO, "view/bgroot/deco")
	self._simageGeneralSkinIcon = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_icon")
	self._simageUniqueSkinIcon = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_s+icon")
	self._imageUniqueSkinIcon = gohelper.findChildImage(self.viewGO, "view/bgroot/#simage_s+icon")
	self._goUniqueSkinsImage = gohelper.findChild(self.viewGO, "view/bgroot/#simage_s+icon")
	self._goUniqueSkinsSpineRoot = gohelper.findChild(self.viewGO, "view/bgroot/#simage_s+spineroot")
	self._goUniqueSkinsTitle = gohelper.findChild(self.viewGO, "view/bgroot/#simage_s+decoration")
	self._simageUniqueSkinSpineRoot = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_s+spineroot")
	self._imageUniqueSkinSpineRoot = gohelper.findChildImage(self.viewGO, "view/bgroot/#simage_s+spineroot")
	self._goUniqueSkinsSpineRoot2 = gohelper.findChild(self.viewGO, "view/bgroot/#simage_s+spineroot2")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/#btn_buy")
	self._godiscount = gohelper.findChild(self.viewGO, "view/common/#btn_buy/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "view/common/#btn_buy/#go_discount/#txt_discount")
	self._gocost = gohelper.findChild(self.viewGO, "view/common/cost")
	self._btncost1 = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/cost/#btn_cost1")
	self._gounselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/unselect")
	self._goiconunselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/unselect/icon")
	self._imageiconunselect1 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost1/unselect/icon/simage_icon")
	self._txtcurpriceunselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/unselect/txt_Num")
	self._txtoriginalpriceunselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/unselect/#txt_original_price")
	self._goselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/select")
	self._goiconselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/select/icon")
	self._imageiconselect1 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost1/select/icon/simage_icon")
	self._txtcurpriceselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/select/txt_Num")
	self._txtoriginalpriceselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/select/#txt_original_price")
	self._btncost2 = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/cost/#btn_cost2")
	self._gounselect2 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/unselect")
	self._imageiconunselect2 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost2/unselect/icon/simage_icon")
	self._txtcurpriceunselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/unselect/txt_Num")
	self._txtoriginalpriceunselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/unselect/#txt_original_price")
	self._goselect2 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/select")
	self._imageiconselect2 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost2/select/icon/simage_icon")
	self._txtcurpriceselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/select/txt_Num")
	self._txtoriginalpriceselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/select/#txt_original_price")
	self._gocostsingle = gohelper.findChild(self.viewGO, "view/common/cost_single")
	self._imageiconsingle = gohelper.findChildImage(self.viewGO, "view/common/cost_single/simage_material")
	self._txtcurpricesingle = gohelper.findChildText(self.viewGO, "view/common/cost_single/#txt_materialNum")
	self._txtoriginalpricesingle = gohelper.findChildText(self.viewGO, "view/common/cost_single/#txt_price")
	self.goDiscount3 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/#go_discount3")
	self.txtDiscount3 = gohelper.findChildTextMesh(self.viewGO, "view/common/cost/#btn_cost2/#go_discount3/#txt_cost_price")
	self.goStoreSkinTips = gohelper.findChild(self.viewGO, "view/#go_storeskin")
	self.txtStoreSkinTips = gohelper.findChildTextMesh(self.viewGO, "view/#go_storeskin/tips/#txt_tips")
	self.simageStoreSkinTips = gohelper.findChildSingleImage(self.viewGO, "view/#go_storeskin/#simage_package")
	self.btnSkinTips = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_storeskin/#simage_package")
	self._gospecial = gohelper.findChild(self.viewGO, "view/propinfo/content/remain/#go_special")
	self._gospecialDescGo = gohelper.findChild(self.viewGO, "view/propinfo/content/desc/#go_special")
	self._goimg_orange = gohelper.findChild(self.viewGO, "view/common/#btn_buy/bg/#go_img_orange")
	self._goimg_red = gohelper.findChild(self.viewGO, "view/common/#btn_buy/bg/#go_img_red")
	self.goUniqueMask = gohelper.findChild(self.viewGO, "view/bgroot/mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsView2:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncost1:AddClickListener(self._btncost1OnClick, self)
	self._btncost2:AddClickListener(self._btncost2OnClick, self)
	self.btnSkinTips:AddClickListener(self._btnSkinTipsOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function StoreSkinGoodsView2:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btncost1:RemoveClickListener()
	self._btncost2:RemoveClickListener()
	self.btnSkinTips:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function StoreSkinGoodsView2:_payFinished()
	self:closeThis()
end

function StoreSkinGoodsView2:setCurCostIndex(index)
	self._curCostIndex = index
end

function StoreSkinGoodsView2:getCurCostIndex()
	return self._curCostIndex or 1
end

function StoreSkinGoodsView2:_btnSkinTipsOnClick()
	if not self._mo then
		return
	end

	local goodConfig = self._mo.config
	local productInfo = string.splitToNumber(goodConfig.product, "#")
	local skinId = productInfo[2]
	local isHasStoreId, goodsId = StoreModel.instance:isSkinHasStoreId(skinId)

	if not isHasStoreId then
		return
	end

	local storeGoodsMo = StoreModel.instance:getGoodsMO(goodsId)

	if not storeGoodsMo then
		return
	end

	StoreController.instance:openPackageStoreGoodsView(storeGoodsMo)
end

function StoreSkinGoodsView2:_btncost1OnClick()
	local curIndex = self:getCurCostIndex()

	if curIndex == 1 then
		return
	end

	self:setCurCostIndex(1)
	self:refreshCost()
end

function StoreSkinGoodsView2:_btncost2OnClick()
	local curIndex = self:getCurCostIndex()

	if curIndex == 2 then
		return
	end

	self:setCurCostIndex(2)
	self:refreshCost()
end

function StoreSkinGoodsView2:_btnbuyOnClick()
	if not self._mo then
		return
	end

	local curIndex = self:getCurCostIndex()
	local goodsConfig = self._mo.config
	local product = goodsConfig.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]
	local skinCo = SkinConfig.instance:getSkinCo(skinId)

	if not self._goodsPriceInfo then
		local info = StoreHelper.getSkinGoodsPriceInfo(goodsConfig, skinId)
		local coinsCurPrice = info.coinsCurPrice
		local deductionItemType = info.deductionItemType
		local deductionItemId = info.deductionItemId
		local coinsItemType = info.coinsItemType
		local coinsItemId = info.coinsItemId
		local overuseCoinsReductionDt = info.overuseCoinsReductionDt
		local specialofferItemType = info.specialofferItemType
		local specialofferItemId = info.specialofferItemId
		local hasSpecialOfferItem = info.hasSpecialOfferItem

		if specialofferItemType then
			local specialofferItemCO = ItemModel.instance:getItemConfig(specialofferItemType, specialofferItemId)

			if ItemEnum.Tag.GoldenMilletPresentSkin == specialofferItemCO.clienttag and GoldenMilletPresentModel.instance:isShowRedDot() and not hasSpecialOfferItem then
				GameFacade.showMessageBox(MessageBoxIdDefine.GoldenMilletPresentSkinBeforeBuy, MsgBoxEnum.BoxType.Yes, function()
					GoldenMilletPresentController.instance:openGoldenMilletPresentView()
					self:closeThis()
				end, nil, nil, self, nil, nil)

				return
			end
		end

		if StoreModel.instance:isSkinCanShowMessageBox(skinId) then
			local skinStoreId = skinCo.skinStoreId
			local skinGoodsMo = StoreModel.instance:getGoodsMO(skinStoreId)

			GameFacade.showMessageBox(MessageBoxIdDefine.SkinGoodsJumpTips, MsgBoxEnum.BoxType.Yes_No, function()
				StoreController.instance:openStoreView(StoreEnum.StoreId.VersionPackage, skinStoreId)
				self:closeThis()
			end, nil, nil, self, nil, nil, skinGoodsMo.config.name)

			return
		end

		if curIndex == 1 then
			local goodsId = StoreConfig.instance:getSkinChargeGoodsId(skinId)

			if goodsId then
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
				PayController.instance:startPay(goodsId)
			else
				GameFacade.showToast(ToastEnum.CanNotBuy)
			end

			return
		end

		if overuseCoinsReductionDt < 0 then
			local deductionConfig = ItemModel.instance:getItemConfig(deductionItemType, deductionItemId)
			local costConfig = ItemModel.instance:getItemConfig(coinsItemType, coinsItemId)
			local param1 = deductionConfig.name
			local param2 = goodsConfig.name
			local param3 = math.abs(overuseCoinsReductionDt)
			local param4 = costConfig.name

			GameFacade.showMessageBox(MessageBoxIdDefine.SkinStoreDeductionUseTips, MsgBoxEnum.BoxType.Yes_No, function()
				self:_checkAndBuyGoods(coinsCurPrice)
			end, nil, nil, self, nil, nil, param1, param2, param3, param4)

			return
		end

		self:_checkAndBuyGoods(coinsCurPrice)
	end
end

function StoreSkinGoodsView2:_checkAndBuyGoods(priceNum)
	if CurrencyController.instance:checkDiamondEnough(priceNum, self.jumpCallBack, self) then
		self:_buyGoods()
	end
end

function StoreSkinGoodsView2:_buyGoods()
	StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self)
end

function StoreSkinGoodsView2:jumpCallBack()
	ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	self:closeThis()
end

function StoreSkinGoodsView2:_btncloseOnClick()
	self:closeThis()
end

function StoreSkinGoodsView2:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._goremain = gohelper.findChild(self.viewGO, "view/propinfo/content/remain")
	self._gonormaltitle = gohelper.findChild(self.viewGO, "view/bgroot/#go_normal_title")
	self._goadvancedtitle = gohelper.findChild(self.viewGO, "view/bgroot/#go_advanced_title")

	self:_setActive_redOrOrange(false)

	self._godiscount2 = gohelper.findChild(self.viewGO, "view/common/#btn_buy/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self._godiscount2, "#txt_cost_price")
end

function StoreSkinGoodsView2:onUpdateParam()
	return
end

function StoreSkinGoodsView2:onOpen()
	self:setCurCostIndex((self.viewParam or nil) and (self.viewParam.index or 1))
	self:_updateSkinStore()

	local heroname = lua_character.configDict[self.skinCo.characterId].name

	self._txtusedesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), heroname)

	if self._mo then
		StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self._mo.config)
	end
end

function StoreSkinGoodsView2:_updateSkinStore()
	self._mo = self.viewParam.goodsMO or self.viewParam.goodsMo

	local product = self._mo.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self.skinCo = SkinConfig.instance:getSkinCo(skinId)

	local skinStoreCfg = self._mo.config
	local costInfo = string.splitToNumber(skinStoreCfg.cost, "#")

	self._costType = costInfo[1]
	self._costId = costInfo[2]
	self._costQuantity = costInfo[3]
	self.deductionInfo = nil

	if not string.nilorempty(self._mo.config.deductionItem) then
		local info = GameUtil.splitString2(self._mo.config.deductionItem, true)
		local itemCount = ItemModel.instance:getItemCount(info[1][2])

		if itemCount > 0 then
			self.deductionInfo = {
				deductionCount = info[2][1],
				currencyType = {
					isCurrencySprite = true,
					type = info[1][1],
					id = info[1][2]
				}
			}
		end
	end

	self:_refreshSkinDesc(skinStoreCfg, self.skinCo)
	self:refreshCost(skinStoreCfg)
	self:_refreshSkinIcon(skinStoreCfg)
	self:refreshStoreSkinTips()
	self:_refreshSpecial()
end

function StoreSkinGoodsView2:_refreshSkinDesc(skinGoodCfg, skinCfg)
	self._txtskinname.text = skinCfg.characterSkin
	self._txtdesc.text = skinCfg.skinDescription

	local offlineTime = self._mo:getOfflineTime()

	if offlineTime > 0 then
		local limitSec = math.floor(offlineTime - ServerTime.now())

		gohelper.setActive(self._goremain, true)

		self._txtremainday.text = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
	else
		gohelper.setActive(self._goremain, false)
	end
end

function StoreSkinGoodsView2:_refreshSkinIcon(skinStoreCfg)
	if not self._mo.config.isAdvancedSkin then
		local isAdvancedSkin = self._mo.config.skinLevel == 1
		local isUniqueSkin = self._mo.config.skinLevel == 2

		gohelper.setActive(self._godeco, not isUniqueSkin)
		gohelper.setActive(self._gonormaltitle, not isAdvancedSkin and not isUniqueSkin)
		gohelper.setActive(self._goadvancedtitle, isAdvancedSkin)
		gohelper.setActive(self._simageGeneralSkinIcon.gameObject, not isUniqueSkin)
		gohelper.setActive(self._goUniqueSkinsImage, isUniqueSkin)
		gohelper.setActive(self._goUniqueSkinsSpineRoot, isUniqueSkin)
		gohelper.setActive(self._goUniqueSkinsSpineRoot2, isUniqueSkin)
		gohelper.setActive(self._goUniqueSkinsTitle, isUniqueSkin)
		gohelper.setActive(self.goUniqueMask, isUniqueSkin)

		local signTexturePath = defaultSignaturePng

		if isUniqueSkin then
			self._simagedreesing:LoadImage(ResUrl.getCharacterSkinIcon("bg_zhuangshi"))

			local resPath = self._mo.config.bigImg
			local spineParams = self._mo.config.spineParams

			if not string.nilorempty(spineParams) then
				local paramsArray = string.split(spineParams, "#")
				local arrayLength = #paramsArray
				local spinePrefabPath = paramsArray[1]
				local spine2PrefabPath = paramsArray[2]
				local pos = string.splitToNumber(paramsArray[3], ",")
				local scale = tonumber(paramsArray[4]) or 1
				local bgPath = paramsArray[6]

				signTexturePath = arrayLength > 6 and paramsArray[7] or signTexturePath

				if not self._skinSpine then
					self._skinSpineGO = gohelper.create2d(self._goUniqueSkinsSpineRoot, "uniqueSkinSpine")

					local spineRootRect = self._skinSpineGO.transform

					transformhelper.setLocalPos(spineRootRect, pos[1], pos[2], 0)

					self._skinSpine = GuiSpine.Create(self._skinSpineGO, false)
				end

				self._skinSpine:setResPath(spinePrefabPath, self._onSpine1Loaded, self, true)

				if not string.nilorempty(spine2PrefabPath) then
					if not self._skinSpine2 then
						self._skinSpineGO2 = gohelper.create2d(self._goUniqueSkinsSpineRoot2, "uniqueSkinSpine2")

						local spine2RootRect = self._skinSpineGO2.transform

						transformhelper.setLocalPos(spine2RootRect, pos[1], pos[2], 0)

						self._skinSpine2 = GuiSpine.Create(self._skinSpineGO2, false)
					end

					self._skinSpine2:setResPath(spine2PrefabPath, self._onSpine2Loaded, self, true)
				end

				if self._skinSpineGO then
					transformhelper.setLocalScale(self._skinSpineGO.transform, scale, scale, scale)
				end

				if self._skinSpineGO2 then
					transformhelper.setLocalScale(self._skinSpineGO2.transform, scale, scale, scale)
				end

				if not string.nilorempty(bgPath) then
					self._simageUniqueSkinIcon:LoadImage(bgPath)
					self._simageUniqueSkinSpineRoot:LoadImage(bgPath)
				end

				gohelper.setActive(self._skinSpineGO, true)
			elseif string.find(resPath, "prefab") then
				gohelper.setActive(self._goUniqueSkinsTitle, false)

				local resPathArray = string.split(resPath, "#")
				local arrayLength = #resPathArray
				local spinePrefabPath = resPathArray[1]
				local bgPath = resPathArray[3]

				signTexturePath = arrayLength > 3 and resPathArray[4] or signTexturePath

				if self._skinSpine then
					self._skinSpine:setResPath(spinePrefabPath, self._onSpineLoaded, self, true)
				else
					self._skinSpineGO = gohelper.create2d(self._goUniqueSkinsSpineRoot, "uniqueSkinSpine")
					self._skinSpine = GuiSpine.Create(self._skinSpineGO, false)

					transformhelper.setLocalPos(self._skinSpineGO.transform, spineDefaultPos[1], spineDefaultPos[2], spineDefaultPos[3])
					self._skinSpine:setResPath(spinePrefabPath, self._onSpineLoaded, self, true)
					transformhelper.setLocalPos(self._goUniqueSkinsSpineRoot.transform, spineBgSpecialPos[1], spineBgSpecialPos[2], 0)
				end

				self._simageUniqueSkinIcon:LoadImage(bgPath, self._loadedSpineBgDone, self)
				transformhelper.setLocalPos(self._simageUniqueSkinIcon.transform, spineBgSpecialPos[1], spineBgSpecialPos[2], spineBgSpecialPos[3])
				self._imageUniqueSkinIcon:SetNativeSize()
				self._imageUniqueSkinSpineRoot:SetNativeSize()
				gohelper.setActive(self._skinSpineGO, true)
			elseif not string.nilorempty(resPath) then
				self._simageUniqueSkinIcon:LoadImage(self._mo.config.bigImg)
			else
				self._simageUniqueSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
			end
		elseif string.nilorempty(skinStoreCfg.bigImg) == false then
			self._simageGeneralSkinIcon:LoadImage(skinStoreCfg.bigImg)
		else
			self._simageGeneralSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end

		self._simagedreesing:LoadImage(signTexturePath, self._loadedSignImage, self)
	end
end

function StoreSkinGoodsView2:_loadedSignImage()
	gohelper.onceAddComponent(self._simagedreesing.gameObject, gohelper.Type_Image):SetNativeSize()
end

function StoreSkinGoodsView2:_loadedSpineBgDone()
	gohelper.onceAddComponent(self._simageUniqueSkinIcon.gameObject, gohelper.Type_Image):SetNativeSize()
end

function StoreSkinGoodsView2:_onSpine1Loaded()
	local spineTr = self._skinSpine:getSpineTr()

	transformhelper.setLocalScale(spineTr, spineDefaultScale, spineDefaultScale, 1)
end

function StoreSkinGoodsView2:_onSpine2Loaded()
	local spineTr = self._skinSpine2:getSpineTr()

	transformhelper.setLocalScale(spineTr, spineDefaultScale, spineDefaultScale, 1)
end

function StoreSkinGoodsView2:_onSpineLoaded()
	local posX = 0
	local posY = 0
	local scaleX = 0.88
	local scaleY = 0.84
	local spineTr = self._skinSpine:getSpineTr()
	local rootTrans = self._simageUniqueSkinIcon.transform

	recthelper.setAnchor(spineTr, recthelper.getAnchor(rootTrans))
	recthelper.setWidth(spineTr, recthelper.getWidth(rootTrans))
	recthelper.setHeight(spineTr, recthelper.getHeight(rootTrans))
	recthelper.setAnchor(spineTr, posX, posY)
	transformhelper.setLocalScale(spineTr, scaleX, scaleY, 1)
	self:setSpineRaycastTarget(self._raycastTarget)
end

function StoreSkinGoodsView2:setSpineRaycastTarget(raycast)
	self._raycastTarget = raycast == true

	if self._skinSpine then
		local spineGraphic = self._skinSpine:getSkeletonGraphic()

		if spineGraphic then
			spineGraphic.raycastTarget = self._raycastTarget
		end
	end
end

function StoreSkinGoodsView2:refreshStoreSkinTips()
	local goodConfig = self._mo.config
	local productInfo = string.splitToNumber(goodConfig.product, "#")
	local skinId = productInfo[2]
	local isHasStoreId, goodsId = StoreModel.instance:isSkinHasStoreId(skinId)

	gohelper.setActive(self.goStoreSkinTips, isHasStoreId)

	if not isHasStoreId then
		return
	end

	local storeGoodsMo = StoreModel.instance:getGoodsMO(goodsId)

	if not storeGoodsMo then
		return
	end

	local text = luaLang("storeskingoodsview2_storeskin_txt_tips")

	self.txtStoreSkinTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(text, storeGoodsMo.config.name)

	local path = ResUrl.getStorePackageIcon(storeGoodsMo.config.bigImg)

	self.simageStoreSkinTips:LoadImage(path, function()
		ZProj.UGUIHelper.SetImageSize(self.simageStoreSkinTips.gameObject)
	end)
end

function StoreSkinGoodsView2:refreshCost()
	local showCurrency = {}
	local goodsConfig = self._mo.config

	if string.nilorempty(goodsConfig.cost) then
		gohelper.setActive(self._gocost, false)

		return
	end

	gohelper.setActive(self._gocost, true)

	local curIndex = self:getCurCostIndex()
	local productInfo = string.splitToNumber(goodsConfig.product, "#")
	local skinId = productInfo[2]
	local skinCo = SkinConfig.instance:getSkinCo(skinId)
	local info = StoreHelper.getSkinGoodsPriceInfo(goodsConfig, skinId)

	self._goodsPriceInfo = info

	local rmbCurPrice = info.rmbCurPrice
	local rmbOriginalPrice = info.rmbOriginalPrice
	local coinsItemType = info.coinsItemType
	local coinsItemId = info.coinsItemId
	local coinsCurPrice = info.coinsCurPrice
	local coinsOriginalPrice = info.coinsOriginalPrice
	local coinsReduction = info.coinsReduction
	local hasDeductionItem = info.hasDeductionItem
	local deductionItemType = info.deductionItemType
	local deductionItemId = info.deductionItemId
	local bCoinsEnough = info.bCoinsEnough
	local hasSpecialOfferItem = info.hasSpecialOfferItem
	local specialofferItemType = info.specialofferItemType
	local specialofferItemId = info.specialofferItemId
	local isShowCoinsOriginalPrice = hasDeductionItem and coinsCurPrice and coinsCurPrice < coinsOriginalPrice
	local coinsItemCO = ItemModel.instance:getItemConfig(coinsItemType, coinsItemId)
	local imageiconsingleSpriteName = string.format("%s_1", coinsItemCO.icon)

	table.insert(showCurrency, coinsItemId)

	if hasDeductionItem then
		table.insert(showCurrency, {
			isCurrencySprite = true,
			type = deductionItemType,
			id = deductionItemId
		})

		local disCntStr = tostring(-coinsReduction)

		self.txtDiscount3.text = disCntStr
		self._txtdiscount2.text = disCntStr
	end

	if hasSpecialOfferItem then
		table.insert(showCurrency, {
			isCurrencySprite = true,
			type = specialofferItemType,
			id = specialofferItemId
		})
	end

	gohelper.setActive(self.goDiscount3, hasDeductionItem)
	gohelper.setActive(self._godiscount2, hasDeductionItem and not rmbCurPrice)
	self.viewContainer:setCurrencyType(showCurrency)

	local isShowOffTag = false

	if isShowOffTag then
		local offDiscount = math.ceil(coinsCurPrice / coinsOriginalPrice * 100)

		isShowOffTag = offDiscount < 100 and offDiscount > 0
		self._txtdiscount.text = string.format("-%d%%", 100 - offDiscount)
	end

	gohelper.setActive(self._godiscount, isShowOffTag)

	if coinsCurPrice then
		self._txtcurpricesingle.text = coinsCurPrice
	end

	if coinsOriginalPrice then
		self._txtoriginalpricesingle.text = coinsOriginalPrice
	end

	gohelper.setActive(self._txtoriginalpricesingle, isShowCoinsOriginalPrice)
	gohelper.setActive(self._gocost, rmbCurPrice)
	gohelper.setActive(self._gocostsingle, not rmbCurPrice)

	if not rmbCurPrice then
		if curIndex == 1 then
			self:setCurCostIndex(2)
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconsingle, imageiconsingleSpriteName, true)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpricesingle, bCoinsEnough and "#393939" or "#bf2e11")

		return
	end

	local priceStr = string.format("%s%s", StoreModel.instance:getCostStr(rmbCurPrice))

	self._txtcurpriceunselect1.text = priceStr
	self._txtcurpriceselect1.text = priceStr

	SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect1, "#393939")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect1, "#ffffff")
	gohelper.setActive(self._txtoriginalpriceselect1, rmbOriginalPrice)
	gohelper.setActive(self._txtoriginalpriceunselect1, rmbOriginalPrice)

	if rmbOriginalPrice then
		self._txtoriginalpriceselect1.text = rmbOriginalPrice
		self._txtoriginalpriceunselect1.text = rmbOriginalPrice
	end

	gohelper.setActive(self._goselect1, curIndex == 1)
	gohelper.setActive(self._gounselect1, curIndex ~= 1)

	self._txtcurpriceunselect2.text = coinsCurPrice
	self._txtcurpriceselect2.text = coinsCurPrice

	SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, bCoinsEnough and "#393939" or "#bf2e11")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, bCoinsEnough and "#ffffff" or "#bf2e11")
	gohelper.setActive(self._txtoriginalpriceselect2, isShowCoinsOriginalPrice)
	gohelper.setActive(self._txtoriginalpriceunselect2, isShowCoinsOriginalPrice)

	if coinsOriginalPrice then
		self._txtoriginalpriceselect2.text = coinsOriginalPrice
		self._txtoriginalpriceunselect2.text = coinsOriginalPrice
	end

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconselect2, imageiconsingleSpriteName, true)
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconunselect2, imageiconsingleSpriteName, true)
	gohelper.setActive(self._goselect2, curIndex == 2)
	gohelper.setActive(self._gounselect2, curIndex ~= 2)
end

function StoreSkinGoodsView2:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end
end

function StoreSkinGoodsView2:onClickIcon()
	if not self.skinCo then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, self.skinCo.id, false, nil, false)
end

function StoreSkinGoodsView2:onClose()
	return
end

function StoreSkinGoodsView2:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simagedreesing:UnLoadImage()

	if self._skinSpine then
		self._skinSpine:doClear()

		self._skinSpine = nil
	end

	if self._skinSpine2 then
		self._skinSpine2:doClear()

		self._skinSpine2 = nil
	end

	self.simageStoreSkinTips:UnLoadImage()
end

function StoreSkinGoodsView2:_refreshSpecial()
	local info = self._goodsPriceInfo
	local hasSpecialOfferItem = info.hasSpecialOfferItem

	gohelper.setActive(self._gospecial, hasSpecialOfferItem)
	gohelper.setActive(self._gospecialDescGo, hasSpecialOfferItem)
	self:_setActive_redOrOrange(hasSpecialOfferItem)
end

function StoreSkinGoodsView2:_setActive_redOrOrange(bRed)
	gohelper.setActive(self._goimg_orange, not bRed)
	gohelper.setActive(self._goimg_red, bRed)
end

return StoreSkinGoodsView2
