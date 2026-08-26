-- chunkname: @modules/logic/store/view/StoreSkinGoodsView.lua

module("modules.logic.store.view.StoreSkinGoodsView", package.seeall)

local StoreSkinGoodsView = class("StoreSkinGoodsView", BaseView)
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

function StoreSkinGoodsView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_leftbg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_icon")
	self._gooffTag = gohelper.findChild(self.viewGO, "view/bgroot/#simage_icon/#go_offTag")
	self._txtoff = gohelper.findChildText(self.viewGO, "view/bgroot/#simage_icon/#go_offTag/#txt_off")
	self._simagedreesing = gohelper.findChildSingleImage(self.viewGO, "view/bgroot/#simage_dreesing")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_buy")
	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "view/propinfo/cost/price/#txt_materialNum")
	self._simagematerial = gohelper.findChildImage(self.viewGO, "view/propinfo/cost/price/#txt_materialNum/#simage_material")
	self._txtprice = gohelper.findChildText(self.viewGO, "view/propinfo/cost/price/#txt_price")
	self._godeduction = gohelper.findChild(self.viewGO, "view/propinfo/cost/#go_deduction")
	self._txtdeduction = gohelper.findChildTextMesh(self.viewGO, "view/propinfo/cost/#go_deduction/#txt_deduction")
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

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function StoreSkinGoodsView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()

	if self.btnIcon then
		self.btnIcon:RemoveClickListener()
	end
end

function StoreSkinGoodsView:_btnbuyOnClick()
	local hasQuantity = ItemModel.instance:getItemQuantity(self._costType, self._costId)
	local realCost = self._costQuantity

	if self.deductionInfo then
		realCost = math.max(0, realCost - self.deductionInfo.deductionCount)
	end

	if self.isActivityStore then
		if hasQuantity < realCost then
			GameFacade.showToast(ToastEnum.DiamondBuy, self.costName)
		else
			self:_buyGoods()
		end
	elseif CurrencyController.instance:checkDiamondEnough(realCost, self.jumpCallBack, self) then
		self:_buyGoods()
	end
end

function StoreSkinGoodsView:_buyGoods()
	if self.isActivityStore then
		Activity107Rpc.instance:sendBuy107GoodsRequest(self._mo.activityId, self._mo.id, 1)
	else
		StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self)
	end
end

function StoreSkinGoodsView:jumpCallBack()
	ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	self:closeThis()
end

function StoreSkinGoodsView:_btncloseOnClick()
	self:closeThis()
end

function StoreSkinGoodsView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._goremain = gohelper.findChild(self.viewGO, "view/propinfo/content/remain")
	self._gonormaltitle = gohelper.findChild(self.viewGO, "view/bgroot/#go_normal_title")
	self._goadvancedtitle = gohelper.findChild(self.viewGO, "view/bgroot/#go_advanced_title")
end

function StoreSkinGoodsView:onUpdateParam()
	return
end

function StoreSkinGoodsView:onOpen()
	self.isActivityStore = self.viewParam.isActivityStore

	if self.isActivityStore then
		self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._btncloseOnClick, self)
		self:_updateActivityStore()
	else
		self:_updateSkinStore()
	end

	local heroname = lua_character.configDict[self.skinCo.characterId].name

	self._txtusedesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), heroname)
end

function StoreSkinGoodsView:_updateActivityStore()
	self._mo = self.viewParam.goodsMO

	local product = self._mo.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self.skinCo = SkinConfig.instance:getSkinCo(skinId)
	self._txtskinname.text = self.skinCo.characterSkin
	self._txtdesc.text = self.skinCo.skinDescription

	recthelper.setAnchorY(self._txtdesc.transform, -100)

	local costInfo = string.splitToNumber(self._mo.cost, "#")

	self._costType = costInfo[1]
	self._costId = costInfo[2]
	self._costQuantity = costInfo[3]

	local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)

	self.costName = costConfig.name

	local hadQuantity = ItemModel.instance:getItemQuantity(self._costType, self._costId)

	if hadQuantity >= self._costQuantity then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, "#bf2e11")
	end

	self._txtmaterialNum.text = self._costQuantity

	local id = costConfig.icon
	local str = string.format("%s_1", id)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._simagematerial, str)
	self.viewContainer:setCurrencyType({
		self._costId
	})
	self._simageicon:LoadImage(ResUrl.getStoreSkin(skinId))

	if not self.btnIcon then
		self.btnIcon = gohelper.getClick(self._simageicon.gameObject)

		self.btnIcon:AddClickListener(self.onClickIcon, self)
	end

	gohelper.setActive(self._txtprice.gameObject, false)
	gohelper.setActive(self._goremain, false)
	gohelper.setActive(self._gooffTag, false)
	gohelper.setActive(self._gonormaltitle, true)
	gohelper.setActive(self._goadvancedtitle, false)
	gohelper.setActive(self._simagedreesing, false)
end

function StoreSkinGoodsView:_updateSkinStore()
	self._mo = self.viewParam.goodsMO

	local product = self._mo.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]

	self.skinCo = SkinConfig.instance:getSkinCo(skinId)

	local skinStoreCfg = self._mo.config
	local costInfo = string.splitToNumber(skinStoreCfg.cost, "#")

	self._costType = costInfo[1]
	self._costId = costInfo[2]
	self._costQuantity = costInfo[3]

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
	else
		self.deductionInfo = nil
	end

	self:_refreshSkinDesc(skinStoreCfg, self.skinCo)
	self:_refreshSkinCost(skinStoreCfg)
	self:_refreshSkinIcon(skinStoreCfg)
end

function StoreSkinGoodsView:_refreshSkinDesc(skinGoodCfg, skinCfg)
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

	gohelper.setActive(self._gooffTag, skinGoodCfg.originalCost > 0)

	local offTag = self._costQuantity / skinGoodCfg.originalCost

	offTag = math.ceil(offTag * 100)
	self._txtoff.text = string.format("-%d%%", 100 - offTag)
end

function StoreSkinGoodsView:_refreshSkinCost(skinStoreCfg)
	local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)
	local realCost = self._costQuantity

	if self.deductionInfo then
		realCost = math.max(0, realCost - self.deductionInfo.deductionCount)

		gohelper.setActive(self._godeduction, true)

		local itemCo = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)

		self._txtdeduction.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("bp_deduction_item_count"), tostring(self.deductionInfo.deductionCount), itemCo.name)
	else
		gohelper.setActive(self._godeduction, false)
	end

	local hasQuantity = ItemModel.instance:getItemQuantity(self._costType, self._costId)

	if realCost <= hasQuantity then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, "#bf2e11")
	end

	self._txtmaterialNum.text = realCost

	local id = costConfig.icon
	local str = string.format("%s_1", id)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._simagematerial, str)

	local currencyList = {}

	if self._costId ~= CurrencyEnum.CurrencyType.Diamond then
		table.insert(currencyList, CurrencyEnum.CurrencyType.Diamond)
	end

	table.insert(currencyList, self._costId)

	if self.deductionInfo then
		table.insert(currencyList, self.deductionInfo.currencyType)
	end

	self.viewContainer:setCurrencyType(currencyList)
	gohelper.setActive(self._txtprice.gameObject, skinStoreCfg.originalCost > 0 or self.deductionInfo)

	if skinStoreCfg.originalCost > 0 then
		self._txtprice.text = skinStoreCfg.originalCost or self._costQuantity
	end
end

function StoreSkinGoodsView:_refreshSkinIcon(skinStoreCfg)
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
				local bgPath = paramsArray[6]

				signTexturePath = arrayLength > 6 and paramsArray[7] or signTexturePath

				if self._skinSpine then
					self._skinSpine:setResPath(spinePrefabPath, self._onSpine1Loaded, self, true)
				else
					self._skinSpineGO = gohelper.create2d(self._goUniqueSkinsSpineRoot, "uniqueSkinSpine")

					local spineRootRect = self._skinSpineGO.transform

					transformhelper.setLocalPos(spineRootRect, pos[1], pos[2], 0)

					self._skinSpine = GuiSpine.Create(self._skinSpineGO, false)

					self._skinSpine:setResPath(spinePrefabPath, self._onSpine1Loaded, self, true)

					if not string.nilorempty(spine2PrefabPath) then
						self._skinSpineGO2 = gohelper.create2d(self._goUniqueSkinsSpineRoot2, "uniqueSkinSpine2")

						local spine2RootRect = self._skinSpineGO2.transform

						transformhelper.setLocalPos(spine2RootRect, pos[1], pos[2], 0)

						self._skinSpine2 = GuiSpine.Create(self._skinSpineGO2, false)

						self._skinSpine2:setResPath(spine2PrefabPath, self._onSpine2Loaded, self, true)
					end
				end

				if not string.nilorempty(bgPath) then
					self._simageUniqueSkinIcon:LoadImage(bgPath)
					self._simageUniqueSkinSpineRoot:LoadImage(bgPath)
				else
					gohelper.setActive(self._uniqueImagebg.gameObject, false)
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

function StoreSkinGoodsView:_loadedSignImage()
	gohelper.onceAddComponent(self._simagedreesing.gameObject, gohelper.Type_Image):SetNativeSize()
end

function StoreSkinGoodsView:_loadedSpineBgDone()
	gohelper.onceAddComponent(self._simageUniqueSkinIcon.gameObject, gohelper.Type_Image):SetNativeSize()
end

function StoreSkinGoodsView:_onSpine1Loaded()
	local spineTr = self._skinSpine:getSpineTr()

	transformhelper.setLocalScale(spineTr, spineDefaultScale, spineDefaultScale, 1)
end

function StoreSkinGoodsView:_onSpine2Loaded()
	local spineTr = self._skinSpine2:getSpineTr()

	transformhelper.setLocalScale(spineTr, spineDefaultScale, spineDefaultScale, 1)
end

function StoreSkinGoodsView:_onSpineLoaded()
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

function StoreSkinGoodsView:setSpineRaycastTarget(raycast)
	self._raycastTarget = raycast == true

	if self._skinSpine then
		local spineGraphic = self._skinSpine:getSkeletonGraphic()

		if spineGraphic then
			spineGraphic.raycastTarget = self._raycastTarget
		end
	end
end

function StoreSkinGoodsView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end
end

function StoreSkinGoodsView:onClickIcon()
	if not self.skinCo then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, self.skinCo.id, false, nil, false)
end

function StoreSkinGoodsView:onClose()
	return
end

function StoreSkinGoodsView:onDestroyView()
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
end

return StoreSkinGoodsView
