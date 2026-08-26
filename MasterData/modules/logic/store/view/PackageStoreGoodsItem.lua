-- chunkname: @modules/logic/store/view/PackageStoreGoodsItem.lua

module("modules.logic.store.view.PackageStoreGoodsItem", package.seeall)

local PackageStoreGoodsItem = class("PackageStoreGoodsItem", ListScrollCellExtend)

function PackageStoreGoodsItem:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._iconImage = self._simageicon:GetComponent(gohelper.Type_Image)
	self._gofx = gohelper.findChild(self.viewGO, "#go_fx")
	self._simageitembg = gohelper.findChildSingleImage(self.viewGO, "#simage_itembg")
	self._simageiconbg = gohelper.findChildSingleImage(self.viewGO, "#simage_iconbg")
	self._simageiconnum = gohelper.findChildSingleImage(self.viewGO, "#simage_iconnum")
	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "cost/txt_materialNum")
	self._imagematerial = gohelper.findChildImage(self.viewGO, "cost/simage_material")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txteng = gohelper.findChildText(self.viewGO, "#txt_name/#txt_eng")
	self._txtremain = gohelper.findChildText(self.viewGO, "txt_remain")
	self._gosoldout = gohelper.findChild(self.viewGO, "#go_soldout")
	self._gohas = gohelper.findChild(self.viewGO, "go_has")
	self._goitemreddot = gohelper.findChild(self.viewGO, "go_itemreddot")
	self._gotag = gohelper.findChild(self.viewGO, "#go_tag")
	self._imagediscount = gohelper.findChild(self.viewGO, "#go_tag/#image_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "#go_tag/#txt_discount")
	self._gowenhao = gohelper.findChild(self.viewGO, "#go_wenhao")
	self._gosoldoutbg = gohelper.findChild(self._gosoldout, "bg")
	self._gosoldouttagbg = gohelper.findChild(self._gosoldout, "bg_tag")
	self._gooptionalgift = gohelper.findChild(self.viewGO, "#go_optionalgift")
	self._goskindiscount = gohelper.findChild(self.viewGO, "#go_skindiscount")
	self._gooptionalvx = gohelper.findChild(self.viewGO, "#packs_vx")
	self._godestinygift = gohelper.findChild(self.viewGO, "#go_destinygift")
	self._gosummonSimulationPickFX = gohelper.findChild(self.viewGO, "#go_summonSimulationPickFX")
	self._txtpickdesc = gohelper.findChildText(self.viewGO, "#txt_pickdesc")
	self._goSkinTips = gohelper.findChild(self.viewGO, "#go_SkinTips")
	self._imgProp = gohelper.findChildImage(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txttips = gohelper.findChildTextMesh(self.viewGO, "#go_tips/image/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PackageStoreGoodsItem:addEvents()
	return
end

function PackageStoreGoodsItem:removeEvents()
	return
end

function PackageStoreGoodsItem:_editableInitView()
	self._btnGO = gohelper.findChild(self.viewGO, "clickArea")
	self._btn = gohelper.getClickWithAudio(self._btnGO, AudioEnum.UI.play_ui_common_pause)

	self._btn:AddClickListener(self._onClick, self)

	self._gocost = gohelper.findChild(self.viewGO, "cost")
	self._btnCost = gohelper.getClick(self._gocost)

	self._btnCost:AddClickListener(self._onClickCost, self)

	self._golevelLock = gohelper.findChild(self.viewGO, "#go_levelLock")
	self._txtneedLevel = gohelper.findChildText(self.viewGO, "#go_levelLock/levellock/#txt_needLevel")
	self._golevelLockbg = gohelper.findChild(self.viewGO, "#go_levelLock/bg")
	self._golevelLockbgtag = gohelper.findChild(self.viewGO, "#go_levelLock/bg_tag")
	self._soldout = false
	self._hascloth = false
	self._lastStartPayTime = 0
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goremaintime = gohelper.findChild(self.viewGO, "go_remaintime")
	self._txtremiantime = gohelper.findChildText(self.viewGO, "go_remaintime/bg/#txt_remiantime")
	self._gonewtag = gohelper.findChild(self.viewGO, "go_newtag")
	self._nationalgifttag = gohelper.findChild(self.viewGO, "go_nationalgift")
	self._gomooncardup = gohelper.findChild(self.viewGO, "#go_mooncardup")
	self._gomaterialup = gohelper.findChild(self.viewGO, "#go_materialup")
	self._gocobranded = gohelper.findChild(self.viewGO, "#go_cobranded")
	self._golinkgift = gohelper.findChild(self.viewGO, "#go_linkgift")
	self._gologoTab = gohelper.findChild(self.viewGO, "#simage_logo")
	self._gotxtv2a8_09 = gohelper.findChild(self.viewGO, "txt_v2a8_09")
	self._gojinfanglun = gohelper.findChild(self.viewGO, "#go_jinfanglun")
	self._goSP02Logo = gohelper.findChild(self.viewGO, "go_logo")

	gohelper.setActive(self._txteng, false)
	gohelper.setActive(self._gooptionalgift, false)
	gohelper.setActive(self._gooptionalvx, false)
	gohelper.setActive(self._txtpickdesc.gameObject, false)

	self._bgEffectDic = self:getUserDataTb_()
	self._loader = MultiAbLoader.New()
end

function PackageStoreGoodsItem:_onClick()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj, self._mo)
	end

	StoreController.instance:forceReadTab(self._mo.belongStoreId)

	local goodsIds = {
		self._mo.goodsId
	}

	ChargeRpc.instance:sendReadChargeNewRequest(goodsIds, self._onRefreshNew, self)

	if not self:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if self._cfgType == StoreEnum.StoreChargeType.LinkGiftGoods then
		local chargeConditionalConfig = StoreConfig.instance:getChargeConditionalConfig(self._mo.config.taskid)

		if chargeConditionalConfig.clientType == StoreEnum.ChargeConditionalClientType.Default then
			if self._mo.buyCount > 0 and StoreCharageConditionalHelper.isHasCanFinishGoodsTask(self._mo.goodsId) then
				TaskRpc.instance:sendFinishTaskRequest(self._mo.config.taskid)
				StoreGoodsTaskController.instance:requestGoodsTaskList()
			else
				StoreController.instance:openPackageStoreGoodsView(self._mo)
			end
		elseif chargeConditionalConfig.clientType == StoreEnum.ChargeConditionalClientType.SP02 then
			local param = {}
			local actParam = string.splitToNumber(chargeConditionalConfig.signInIdParam, "#")

			param.actId = actParam[1]

			ViewMgr.instance:openView(ViewName.SP02_LinkGiftPanelView, param)
		end
	elseif self._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif self._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif self._cfgType == StoreEnum.StoreChargeType.SceneUIPackage then
		ViewMgr.instance:openView(ViewName.SceneUIPackageGoodsTipView, {
			canJump = true,
			goodsId = self._mo.goodsId
		})
	else
		StoreController.instance:openPackageStoreGoodsView(self._mo)
	end
end

function PackageStoreGoodsItem:_onRefreshNew(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	gohelper.setActive(self._gonewtag, false)
end

function PackageStoreGoodsItem:_onClickCost()
	if self.isLevelOpen == false then
		return
	end

	if not self:_isStoreItemUnlock() then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsUnlock)

		return
	end

	if self._hascloth then
		GameFacade.showToast(ToastEnum.PackageStoreGoodsHasCloth)
	elseif self._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif self._mo.isChargeGoods then
		if Time.time - self._lastStartPayTime > 0.3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
			PayController.instance:startPay(self._mo.goodsId)

			self._lastStartPayTime = Time.time
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
		StoreController.instance:openPackageStoreGoodsView(self._mo)
	end
end

function PackageStoreGoodsItem:_isStoreItemUnlock()
	local episodeId = self._mo.config.needEpisodeId

	if not episodeId or episodeId == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function PackageStoreGoodsItem:onUpdateMO(mo)
	self._mo = mo

	local var_9_0

	if mo then
		::label_9_0::

		var_9_0 = mo.config and mo.config.type
	end

	self._cfgType = var_9_0

	gohelper.setActive(self._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(mo.goodsId))
	gohelper.setActive(self._golevellimit, not self:_isStoreItemUnlock())
	gohelper.setActive(self._gomooncardup, false)
	gohelper.setActive(self._nationalgifttag, tonumber(mo.config.offTag) == ChargePackageEnum.OffTagType.New)

	if not self:_isStoreItemUnlock() then
		local episodeId = self._mo.config.needEpisodeId
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
		local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if chapterConfig and chapterConfig.type == DungeonEnum.ChapterType.Hard then
			episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
			chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
		end

		local chapterIndex, episodeIndex, episodeType

		if episodeConfig and chapterConfig then
			chapterIndex = chapterConfig.chapterIndex
			episodeIndex, episodeType = DungeonConfig.instance:getChapterEpisodeIndexWithSP(chapterConfig.id, episodeConfig.id)

			if type == DungeonEnum.EpisodeType.Sp then
				chapterIndex = "SP"
			end
		end

		self._txtlvlimit.text = string.format(luaLang("level_limit_unlock"), string.format("%s-%s", chapterIndex, episodeIndex))
	end

	self._txtname.text = self._mo.config.name

	self._simageicon:LoadImage(ResUrl.getStorePackageIcon(self._mo.config.bigImg))

	local underlayParam

	if string.nilorempty(self._mo.config.underlay) then
		logError("商店改版 缺少底板配置 使用保底配置 商品id:" .. tostring(self._mo.goodsId))

		underlayParam = string.splitToNumber(ChargePackageEnum.DefaultUnderlayParam, "#")
	end

	local var_9_1

	do
		underlayParam = string.splitToNumber(self._mo.config.underlay, "#")
		var_9_1 = self._mo.isChargeGoods and PayModel.instance:getProductOriginPriceNum(self._mo.id) or 0
	end

	logNormal(string.format("---商店改版 底板配置 id: %s 底板id: %s 价格: %s ", self._mo.goodsId, underlayParam[1], var_9_1))

	local itemBgIconName = "panel/package_quality_" .. self:_getNumStr(underlayParam[1])

	logNormal("商店改版 底板: " .. itemBgIconName)
	self._simageitembg:LoadImage(ResUrl.getStorePackageIcon(itemBgIconName))

	local itemBgIndex
	local itemIconBgName = itemBgIconName .. "_" .. self:_getNumStr(self._mo.config.showBg ~= nil and self._mo.config.showBg ~= 0 and self._mo.config.showBg or StoreHelper.getPackageIconBgIndex(self._mo.goodsId, self._mo.id, underlayParam[1]))

	logNormal("商店改版 图标底板: " .. itemIconBgName)
	self._simageiconbg:LoadImage(ResUrl.getStorePackageIcon(itemIconBgName))

	local showLevelBg = mo.buyLevel ~= nil and mo.buyLevel ~= 0

	gohelper.setActive(self._simageiconnum, showLevelBg)

	if showLevelBg then
		local levelIconName = itemBgIconName .. "_" .. self:_getNumStr(mo.buyLevel)

		logNormal("商店改版 等级图标: " .. levelIconName)
		self._simageiconnum:LoadImage(ResUrl.getStorePackageIcon(levelIconName))
	end

	local bgEffectId = underlayParam[2]
	local showEffect = bgEffectId ~= nil and bgEffectId ~= 0

	gohelper.setActive(self._gofx, showEffect)

	if showEffect then
		self._curBgEffectId = bgEffectId

		logNormal("商店改版 特效:" .. tostring(bgEffectId))

		if not self._bgEffectDic[bgEffectId] then
			local resPath = "ui/viewres/store/effect/packagestoregoodsitem_effect_" .. self:_getNumStr(bgEffectId) .. ".prefab"

			self._loader:addPath(resPath)
			self._loader:startLoad(self.onEffectLoadFinish, self)
		else
			self:refreshBgEffect()
		end
	end

	local haveSlogan = not string.nilorempty(self._mo.config.slogan)

	gohelper.setActive(self._gotips, haveSlogan)

	if haveSlogan then
		self._txttips.text = self._mo.config.slogan
	end

	local cost = self._mo.cost

	if string.nilorempty(cost) or cost == 0 then
		self._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(self._imagematerial.gameObject, false)
	elseif self._mo.isChargeGoods then
		self._txtmaterialNum.text = PayModel.instance:getProductPrice(self._mo.id)

		gohelper.setActive(self._imagematerial.gameObject, false)

		self._costQuantity = cost
	else
		local costs = string.split(cost, "|")

		if not costs[mo.buyCount + 1] then
			local costParam = costs[#costs]
			local costInfo = string.splitToNumber(costParam, "#")

			self._costType = costInfo[1]
			self._costId = costInfo[2]
			self._costQuantity = costInfo[3]

			local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)

			self._txtmaterialNum.text = self._costQuantity

			gohelper.setActive(self._imagematerial.gameObject, true)

			local str = string.format("%s_1", string.len(self._costId) == 1 and self._costType .. "0" .. self._costId or self._costType .. self._costId)

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerial, str)
		end
	end

	local maxBuyCount = mo.maxBuyCount
	local remain = maxBuyCount - mo.buyCount

	self._soldout = mo:isSoldOut()

	local content

	if self._mo.isChargeGoods then
		content = StoreConfig.instance:getChargeRemainText(maxBuyCount, mo.refreshTime, remain, mo.offlineTime)
	else
		local showRefreshTime = StoreHelper.getShowRefreshTimeByGoodsMO(mo)

		content = StoreConfig.instance:getRemainText(maxBuyCount, showRefreshTime, remain, mo.offlineTime)
	end

	if string.nilorempty(content) then
		gohelper.setActive(self._txtremain.gameObject, false)
	else
		gohelper.setActive(self._txtremain.gameObject, true)

		self._txtremain.text = content
	end

	local offEndTime = mo.offlineTime - ServerTime.now()

	gohelper.setActive(self._goremaintime, mo.offlineTime > 0)

	local str, strFormat = TimeUtil.secondToRoughTime(offEndTime, true)

	self._txtremiantime.text = str .. strFormat

	local offTag = tonumber(mo:getDiscount())

	if offTag and offTag > 0 then
		self.hasTag = true

		gohelper.setActive(self._gotag, true)

		self._txtdiscount.text = string.format("-%d%%", offTag)
	else
		self.hasTag = false

		gohelper.setActive(self._gotag, false)
	end

	local needShowNew = mo:needShowNew()

	if needShowNew then
		StoreModel.instance:markPackageGoodsNewRedDot(mo.goodsId)
	end

	gohelper.setActive(self._gonewtag, needShowNew)

	self._hascloth = self._mo:alreadyHas()

	gohelper.setActive(self._gohas, false)
	gohelper.setActive(self._gosoldout, false)
	ZProj.UGUIHelper.SetColorAlpha(self._iconImage, 1)

	if self._hascloth then
		gohelper.setActive(self._gohas, true)
	elseif self._soldout then
		gohelper.setActive(self._gosoldout, not StoreCharageConditionalHelper.isCharageTaskNotFinish(mo.goodsId))
		gohelper.setActive(self._gosoldoutbg, not self.hasTag)
		gohelper.setActive(self._gosoldouttagbg, self.hasTag)
		ZProj.UGUIHelper.SetColorAlpha(self._iconImage, 0.8)
	end

	gohelper.setActive(self._gowenhao, false)

	if self._mo.goodsId == StoreEnum.MonthCardGoodsId then
		gohelper.setActive(self._gowenhao, true)

		self._wenhaoClick = gohelper.getClick(self._gowenhao)

		self._wenhaoClick:AddClickListener(self.showMonthCardTips, self)

		local showtag = StoreHelper.checkMonthCardLevelUpTagOpen()

		gohelper.setActive(self._gomooncardup, showtag)
	elseif self._mo.goodsId == StoreEnum.SeasonCardGoodsId then
		gohelper.setActive(self._gowenhao, true)

		self._wenhaoClick = gohelper.getClick(self._gowenhao)

		self._wenhaoClick:AddClickListener(self._showSeasonCardTips, self)
	else
		GameUtil.onDestroyViewMember_ClickListener(self, "_wenhaoClick")
	end

	self.isLevelOpen = mo:isLevelOpen()

	gohelper.setActive(self._golevelLock, self.isLevelOpen == false)
	gohelper.setActive(self._golevelLockbg, not self.hasTag)
	gohelper.setActive(self._golevelLockbgtag, self.hasTag)

	self._txtneedLevel.text = formatLuaLang("packagestoregoodsitem_level", mo.buyLevel)

	self:_onUpdateMO_newMatUpTag(mo)
	self:_onUpdateMO_coBrandedTag(mo)
	self:_onUpdateMO_gosummonSimulationPickFX(mo)
	self:_onUpdateMO_linkPackage(mo)
	self:_onUpdateMO_gosummonSimulationPickTag(mo)
	self:_onUpdateMO_goskinDiscountTag(mo)
	self:_onUpdateMO_godestinySummonPackageTag(mo)
	self:refreshSkinTips(mo)
	self:_onUpdateMO_newLinkTag(mo)
	gohelper.setActive(self._gotxtv2a8_09, PackageStoreEnum.AnimHeadDict[mo.goodsId])
end

function PackageStoreGoodsItem:onEffectLoadFinish()
	if not self._bgEffectDic[self._curBgEffectId] then
		local framePrefab = self._loader:getFirstAssetItem():GetResource()

		self._bgEffectDic[self._curBgEffectId] = gohelper.clone(framePrefab, self._gofx)
	end

	self:refreshBgEffect()
end

function PackageStoreGoodsItem:refreshBgEffect()
	for id, go in pairs(self._bgEffectDic) do
		gohelper.setActive(go, id == self._curBgEffectId)
	end
end

function PackageStoreGoodsItem:showMonthCardTips()
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc))
end

function PackageStoreGoodsItem:getAnimator()
	return self._animator
end

function PackageStoreGoodsItem:refreshSkinTips(goodsMO)
	local isSkinStoreGoods, skinId = SkinConfig.instance:isSkinStoreGoods(goodsMO.goodsId)

	if not isSkinStoreGoods then
		gohelper.setActive(self._goSkinTips, false)

		return
	end

	if StoreModel.instance:isSkinGoodsCanRepeatBuy(goodsMO, skinId) then
		gohelper.setActive(self._goSkinTips, true)

		local skinConfig = SkinConfig.instance:getSkinCo(skinId)
		local compensate = string.splitToNumber(skinConfig.compensate, "#")
		local currencyId = compensate[2]
		local currencyNum = compensate[3]
		local currencyCo = CurrencyConfig.instance:getCurrencyCo(currencyId)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imgProp, string.format("%s_1", currencyCo.icon))

		self._txtPropNum.text = tostring(currencyNum)
	else
		gohelper.setActive(self._goSkinTips, false)
	end
end

function PackageStoreGoodsItem:onDestroy()
	self._btn:RemoveClickListener()
	self._btnCost:RemoveClickListener()
	GameUtil.onDestroyViewMember_ClickListener(self, "_wenhaoClick")

	if self._linkGiftItemComp then
		self._linkGiftItemComp:onDestroy()

		self._linkGiftItemComp = nil
	end

	tabletool.clear(self._bgEffectDic)

	self._bgEffectDic = nil

	self._loader:dispose()

	self._loader = nil
end

function PackageStoreGoodsItem:_onUpdateMO_newMatUpTag(mo)
	local goodsId = mo.goodsId
	local isActive = StoreHelper.checkNewMatUpTagOpen(goodsId)

	gohelper.setActive(self._gomaterialup, isActive)
end

function PackageStoreGoodsItem:_onUpdateMO_coBrandedTag(mo)
	if not mo.config.showLinkageTag then
		gohelper.setActive(self._gocobranded, mo.config.showLinkageTag)
		gohelper.setActive(self._gologoTab, mo.config.showLogoTag)
	end
end

function PackageStoreGoodsItem:_showSeasonCardTips()
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.SeasonCardTipsDesc))
end

local kActiveSummonSimulationPickFXGoodsId = {
	811466,
	StoreEnum.SeasonCardGoodsId
}

function PackageStoreGoodsItem:_onUpdateMO_gosummonSimulationPickFX(mo)
	local isActive = mo.config.bigImg == StoreEnum.SummonSimulationPick

	if not isActive then
		for _, goodsId in ipairs(kActiveSummonSimulationPickFXGoodsId) do
			if mo.goodsId == goodsId then
				isActive = true

				break
			end
		end
	end

	gohelper.setActive(self._gosummonSimulationPickFX, isActive)
end

function PackageStoreGoodsItem:_onUpdateMO_linkPackage(mo)
	local isLinkGift = self._cfgType == StoreEnum.StoreChargeType.LinkGiftGoods
	local chargeConditionalConfig = StoreConfig.instance:getChargeConditionalConfig(self._mo.config.taskid)

	if not isLinkGift or not chargeConditionalConfig then
		self:_setShowGoLinkGift(false)

		return
	end

	self:_setShowGoLinkGift(chargeConditionalConfig.clientType == StoreEnum.ChargeConditionalClientType.Default)

	if chargeConditionalConfig.clientType == StoreEnum.ChargeConditionalClientType.Default then
		if isLinkGift then
			if self._linkGiftItemComp == nil then
				self._linkGiftItemComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._golinkgift, StoreLinkGiftItemComp, self)
			end

			self._linkGiftItemComp:onUpdateMO(mo)

			local str = self._linkGiftItemComp:getBuyStateStr()

			if not string.nilorempty(str) then
				self._txtmaterialNum.text = str
			end
		end
	elseif chargeConditionalConfig.clientType == StoreEnum.ChargeConditionalClientType.SP02 then
		local haveCanFinishTask = StoreCharageConditionalHelper.isHasCanFinishGoodsTask(self._mo.config.id)

		gohelper.setActive(self._txtremain, not haveCanFinishTask)

		if haveCanFinishTask then
			self._txtmaterialNum.text = luaLang("sp02_link_gift_store_reward_tip")
		end
	end
end

function PackageStoreGoodsItem:_setShowGoLinkGift(show)
	gohelper.setActive(self._golinkgift, show)
	gohelper.setActive(self._iconImage, not show)
end

function PackageStoreGoodsItem:_onUpdateMO_gosummonSimulationPickTag(mo)
	local isActive = mo.config.bigImg == StoreEnum.SummonSimulationPick2

	gohelper.setActive(self._gojinfanglun, isActive)
end

function PackageStoreGoodsItem:_onUpdateMO_goskinDiscountTag(mo)
	local isActive = mo.config.id == StoreEnum.V3a3_SkinDiscountItemId

	gohelper.setActive(self._goskindiscount, isActive)
end

function PackageStoreGoodsItem:_onUpdateMO_godestinySummonPackageTag(mo)
	local isActive = mo.config.id == StoreEnum.V3a4_DestinySummonPackage

	gohelper.setActive(self._godestinygift, isActive)
end

function PackageStoreGoodsItem:_onUpdateMO_newLinkTag(mo)
	local isActive = mo.config.newShowLinkTag == StoreEnum.NewLinkTagType.SP02

	gohelper.setActive(self._goSP02Logo, isActive)
end

function PackageStoreGoodsItem:setClickCallback(callback, callbackObj)
	self._clickCallback = callback
	self._clickCallbackObj = callbackObj
end

function PackageStoreGoodsItem:_getNumStr(num)
	if tonumber(num) < 10 then
		return "0" .. num
	end

	return tostring(num)
end

return PackageStoreGoodsItem
