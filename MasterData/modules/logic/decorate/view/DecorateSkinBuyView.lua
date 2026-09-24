-- chunkname: @modules/logic/decorate/view/DecorateSkinBuyView.lua

module("modules.logic.decorate.view.DecorateSkinBuyView", package.seeall)

local DecorateSkinBuyView = class("DecorateSkinBuyView", BaseView)
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

function DecorateSkinBuyView:onInitView()
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
	self._gotab = gohelper.findChild(self.viewGO, "view/extra")
	self._gospecial = gohelper.findChild(self.viewGO, "view/propinfo/content/remain/#go_special")
	self._gospecialDescGo = gohelper.findChild(self.viewGO, "view/propinfo/content/desc/#go_special")
	self._goimg_orange = gohelper.findChild(self.viewGO, "view/common/#btn_buy/bg/#go_img_orange")
	self._goimg_red = gohelper.findChild(self.viewGO, "view/common/#btn_buy/bg/#go_img_red")
	self.goUniqueMask = gohelper.findChild(self.viewGO, "view/bgroot/mask")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateSkinBuyView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncost1:AddClickListener(self._btncost1OnClick, self)
	self._btncost2:AddClickListener(self._btncost2OnClick, self)
	self.btnSkinTips:AddClickListener(self._btnSkinTipsOnClick, self)
end

function DecorateSkinBuyView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btncost1:RemoveClickListener()
	self._btncost2:RemoveClickListener()
	self.btnSkinTips:RemoveClickListener()
end

function DecorateSkinBuyView:_btnSkinTipsOnClick()
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

function DecorateSkinBuyView:_btncost1OnClick()
	self:_refeshSelectCost(1)
end

function DecorateSkinBuyView:_btncost2OnClick()
	self:_refeshSelectCost(2)
end

function DecorateSkinBuyView:_btnbuyOnClick()
	local has, items = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	self._discountItems = items

	local isCanBuySceneUIPackage = DecorateStoreModel.instance:isCanBuySceneUIPackage()

	if has and items and isCanBuySceneUIPackage then
		local co = ItemModel.instance:getItemConfig(items[1], items[2])

		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateDiscountTip2, MsgBoxEnum.BoxType.Yes_No, self._checkAndBuyGoods, self.closeThis, nil, self, self, nil, (co or nil) and (co.name or ""), self._goodConfig.name)
	else
		self:_checkAndBuyGoods()
	end
end

function DecorateSkinBuyView:_checkAndBuyGoods()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()
	local costParam = self._currencyParam[curIndex]

	if costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(costParam[3], CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._exchangeFinished, self, self.closeThis, self) then
			self:_buyGoods(curIndex)
		end
	elseif costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(costParam[3], self.closeThis, self) then
			self:_buyGoods(curIndex)
		end
	elseif costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.OldTravelTicket then
		local currencyMo = CurrencyModel.instance:getCurrency(costParam[2])

		if currencyMo then
			if currencyMo.quantity >= costParam[3] then
				self:_buyGoods(curIndex)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(costParam[1], costParam[2], costParam[3]) then
		self:_buyGoods(curIndex)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateStoreCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, self._storeCurrencyNotEnoughCallback, nil, nil, self, nil)
	end
end

function DecorateSkinBuyView:_storeCurrencyNotEnoughCallback()
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function DecorateSkinBuyView:_buyGoods()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()

	StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self, curIndex)
end

function DecorateSkinBuyView:jumpCallBack()
	ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	self:closeThis()
end

function DecorateSkinBuyView:_btncloseOnClick()
	self:closeThis()
end

function DecorateSkinBuyView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._goremain = gohelper.findChild(self.viewGO, "view/propinfo/content/remain")
	self._gonormaltitle = gohelper.findChild(self.viewGO, "view/bgroot/#go_normal_title")
	self._goadvancedtitle = gohelper.findChild(self.viewGO, "view/bgroot/#go_advanced_title")

	self:_setActive_redOrOrange(false)

	self._godiscount2 = gohelper.findChild(self.viewGO, "view/common/#btn_buy/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self._godiscount2, "#txt_cost_price")
	self._godeduction3IconGo = gohelper.findChildTextMesh(self.viewGO, "view/common/cost/#btn_cost2/#go_discount3/icon")

	local godetail = gohelper.findChild(self.viewGO, "view/common/go_detail")
	local godiscount1 = gohelper.findChild(self._gocost, "#go_discount_1")
	local godiscount2 = gohelper.findChild(self._gocost, "#go_discount_2")

	gohelper.setActive(godetail, false)
	gohelper.setActive(godiscount1, false)
	gohelper.setActive(godiscount2, false)

	self._initTopRightPosX = recthelper.getAnchorX(self._gotopright.transform)

	self:_addEvents()
end

function DecorateSkinBuyView:_addEvents()
	self.addEventCb(self, StoreController.instance, StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateSkinBuyView:_removeEvents()
	self.removeEventCb(self, StoreController.instance, StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateSkinBuyView:_onGoodItemClick(goodId)
	if self._goodsId == goodId then
		return
	end

	self._mo = StoreModel.instance:getGoodsMO(goodId)

	self:_setGoodData(self._mo.goodsId)
	self:_refreshUI()
end

function DecorateSkinBuyView:onUpdateParam()
	return
end

function DecorateSkinBuyView:onOpen()
	self._mo = self.viewParam.goodsMO or self.viewParam.goodsMo

	self:_setGoodData(self._mo.goodsId)
	self:_refreshUI()
end

function DecorateSkinBuyView:_setGoodData(goodId)
	self._goodsId = goodId
	self._goodConfig = StoreConfig.instance:getGoodsConfig(self._goodsId)
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)

	local product = self._goodConfig.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self._skinCo = SkinConfig.instance:getSkinCo(skinId)
end

function DecorateSkinBuyView:_refreshUI()
	self:_refreshDesc()
	self:_updateSkinStore()
	self:_refeshSelectCost(1)
end

function DecorateSkinBuyView:_refreshDesc()
	local heroname = lua_character.configDict[self._skinCo.characterId].name

	self._txtusedesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), heroname)
end

function DecorateSkinBuyView:_updateSkinStore()
	self:_refreshSkinDesc(self._goodConfig, self._skinCo)
	self:refreshCost()
	self:_refreshSkinIcon(self._goodConfig)
	self:refreshStoreSkinTips()
	self:_refreshSpecial()
	self:_refreshTab()
	self:_refreshPos()
end

local offsetPos = {
	0,
	100
}

function DecorateSkinBuyView:_refreshPos()
	if self._tabComp then
		local isShowTab = true

		if self._tabComp:getShowGoods() then
			isShowTab = #self._tabComp:getShowGoods() > 1

			if isShowTab then
				transformhelper.setLocalPos(self.viewGO.transform, offsetPos[2], 0, 0)
				recthelper.setAnchorX(self._gotopright.transform, self._initTopRightPosX - offsetPos[2])
			else
				transformhelper.setLocalPos(self.viewGO.transform, offsetPos[1], 0, 0)
			end
		end
	end
end

function DecorateSkinBuyView:_refreshTab()
	if self._tabComp then
		self._tabComp:hide(true)
	end

	local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)

	if not decorateCo then
		return
	end

	if decorateCo.fatherGoods <= 0 and decorateCo.bundleType <= 0 then
		return
	end

	local goodId = self._goodsId

	if decorateCo.fatherGoods > 0 then
		goodId = decorateCo.fatherGoods
	end

	if not self._tabComp then
		local go = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._gotab)

		self._tabComp = DecorateStoreGoodTabComp.Get(go)
	end

	self._tabComp:hide(false)
	self._tabComp:refresh(goodId)
end

function DecorateSkinBuyView:_refreshSkinDesc(skinGoodCfg, skinCfg)
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

function DecorateSkinBuyView:_refreshSkinIcon(skinStoreCfg)
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

function DecorateSkinBuyView:_loadedSignImage()
	gohelper.onceAddComponent(self._simagedreesing.gameObject, gohelper.Type_Image):SetNativeSize()
end

function DecorateSkinBuyView:_loadedSpineBgDone()
	gohelper.onceAddComponent(self._simageUniqueSkinIcon.gameObject, gohelper.Type_Image):SetNativeSize()
end

function DecorateSkinBuyView:_onSpine1Loaded()
	local spineTr = self._skinSpine:getSpineTr()

	transformhelper.setLocalScale(spineTr, spineDefaultScale, spineDefaultScale, 1)
end

function DecorateSkinBuyView:_onSpine2Loaded()
	local spineTr = self._skinSpine2:getSpineTr()

	transformhelper.setLocalScale(spineTr, spineDefaultScale, spineDefaultScale, 1)
end

function DecorateSkinBuyView:_onSpineLoaded()
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

function DecorateSkinBuyView:setSpineRaycastTarget(raycast)
	self._raycastTarget = raycast == true

	if self._skinSpine then
		local spineGraphic = self._skinSpine:getSkeletonGraphic()

		if spineGraphic then
			spineGraphic.raycastTarget = self._raycastTarget
		end
	end
end

function DecorateSkinBuyView:refreshStoreSkinTips()
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

function DecorateSkinBuyView:refreshCost()
	self:_refreshCurrency()
	self:_refreshCost()
end

function DecorateSkinBuyView:_refreshCurrency()
	local currencyParam = {}

	self._currencyParam = {}

	if self._goodConfig.cost ~= "" then
		local costs = string.splitToNumber(self._goodConfig.cost, "#")

		costs[3] = self:_getCostNum(tonumber(costs[3]))

		table.insert(currencyParam, costs[2])
		table.insert(self._currencyParam, costs)
	end

	if self._goodConfig.cost2 ~= "" then
		local cost2s = string.splitToNumber(self._goodConfig.cost2, "#")

		table.insert(currencyParam, cost2s[2])

		cost2s[3] = self:_getCostNum(tonumber(cost2s[3]))

		table.insert(self._currencyParam, cost2s)
	end

	for _, v in pairs(currencyParam) do
		if v == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			table.insert(currencyParam, CurrencyEnum.CurrencyType.Diamond)
		end
	end

	local result = LuaUtil.getReverseArrTab(currencyParam)

	self.viewContainer:setCurrencyType(result)
end

function DecorateSkinBuyView:_getCostNum(costNum)
	local has, _, discount = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	if discount then
		return (has or nil) and (costNum * discount * 0.001 or costNum)
	end

	return costNum
end

function DecorateSkinBuyView:_refreshCost()
	local isCost2 = #self._currencyParam > 1

	if isCost2 then
		for i in ipairs(self._currencyParam) do
			local imgicon1 = self["_imageiconunselect" .. i]
			local txtnum1 = self["_txtcurpriceunselect" .. i]
			local txtoriginalNum1 = self["_txtoriginalpriceunselect" .. i]
			local goicon1 = self["_goiconunselect" .. i]
			local imgicon2 = self["_imageiconselect" .. i]
			local txtnum2 = self["_txtcurpriceselect" .. i]
			local txtoriginalNum2 = self["_txtoriginalpriceselect" .. i]
			local goicon2 = self["_goiconselect" .. i]

			if goicon1 then
				gohelper.setActive(goicon1, true)
			end

			if goicon2 then
				gohelper.setActive(goicon2, true)
			end

			self:_refreshPayCost(imgicon1, txtnum1, txtoriginalNum1, i)
			self:_refreshPayCost(imgicon2, txtnum2, txtoriginalNum2, i)
		end
	else
		self:_refreshPayCost(self._imageiconsingle, self._txtcurpricesingle, self._txtoriginalpricesingle, 1)
	end

	gohelper.setActive(self._gocost, isCost2)
	gohelper.setActive(self._gocostsingle, not isCost2)
end

function DecorateSkinBuyView:_refreshPayCost(imgicon, txtnum, txtoriginalNum, index)
	local type = self._currencyParam[index][1]
	local id = self._currencyParam[index][2]
	local count = self._currencyParam[index][3]
	local curCount = ItemModel.instance:getItemQuantity(type, id)
	local isEnough = count <= curCount
	local cost1Icon = self:_getCurrencyIconStr(type, id)

	if imgicon then
		UISpriteSetMgr.instance:setCurrencyItemSprite(imgicon, cost1Icon)
	end

	if txtnum then
		txtnum.text = count

		SLFramework.UGUI.GuiHelper.SetColor(txtnum, isEnough and "#393939" or "#bf2e11")
	end

	if txtoriginalNum then
		local originalPrice = self._decorateConfig["originalCost" .. index]

		if originalPrice and originalPrice > 0 then
			txtoriginalNum.text = originalPrice
		end

		gohelper.setActive(txtoriginalNum.gameObject, originalPrice and originalPrice > 0)
	end
end

function DecorateSkinBuyView:_refeshSelectCost(index)
	for i in ipairs(self._currencyParam) do
		local goselect = self["_goselect" .. i]
		local gounselect = self["_gounselect" .. i]

		gohelper.setActive(goselect, index == i)
		gohelper.setActive(gounselect, index ~= i)
	end

	DecorateStoreModel.instance:setCurCostIndex(index)
	self:_refreshCost()
end

function DecorateSkinBuyView:_getCurrencyIconStr(itemType, itemId)
	return string.format("%s_1", string.len(itemId) == 1 and itemType .. "0" .. itemId or itemType .. itemId)
end

function DecorateSkinBuyView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end
end

function DecorateSkinBuyView:onClickIcon()
	if not self._skinCo then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, self._skinCo.id, false, nil, false)
end

function DecorateSkinBuyView:onClose()
	return
end

function DecorateSkinBuyView:onDestroyView()
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

	if self._tabComp then
		self._tabComp:destroy()

		self._tabComp = nil
	end

	self:_removeEvents()
end

function DecorateSkinBuyView:_refreshSpecial()
	local hasSpecialOfferItem = false

	gohelper.setActive(self._gospecial, hasSpecialOfferItem)
	gohelper.setActive(self._gospecialDescGo, false)
	self:_setActive_redOrOrange(hasSpecialOfferItem)
end

function DecorateSkinBuyView:_setActive_redOrOrange(bRed)
	gohelper.setActive(self._goimg_orange, not bRed)
	gohelper.setActive(self._goimg_red, bRed)
end

return DecorateSkinBuyView
