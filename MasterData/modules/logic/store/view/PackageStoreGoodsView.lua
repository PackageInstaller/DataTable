-- chunkname: @modules/logic/store/view/PackageStoreGoodsView.lua

module("modules.logic.store.view.PackageStoreGoodsView", package.seeall)

local PackageStoreGoodsView = class("PackageStoreGoodsView", BaseView)
local activity1_4PackageId = 811326
local monthCardId = 610001
local monthCardX = -399
local monthCardY = 90

function PackageStoreGoodsView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "view/#simage_blur")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_rightbg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "view/propinfo/#simage_icon")
	self._simageiconbg = gohelper.findChildSingleImage(self.viewGO, "view/propinfo/#simage_iconbg")
	self._simageiconnum = gohelper.findChildSingleImage(self.viewGO, "view/propinfo/#simage_iconnum")
	self._txtgoodsNameCn = gohelper.findChildText(self.viewGO, "view/propinfo/txt_goodslayout/#txt_goodsNameCn")
	self._goSecondGoodsName = gohelper.findChild(self.viewGO, "view/propinfo/#txt_goodsNameCn/#txt_goodstips")
	self._btnbuy = gohelper.findChildButton(self.viewGO, "view/propinfo/#btn_buy")
	self._gotips = gohelper.findChild(self.viewGO, "view/propinfo/#go_tips")
	self._txtlocktips = gohelper.findChildText(self.viewGO, "view/propinfo/#go_tips/#txt_locktips")
	self._btnclose = gohelper.findChildButton(self.viewGO, "view/#btn_close")
	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "view/propinfo/#btn_buy/cost/#txt_materialNum")
	self._txtprice = gohelper.findChildText(self.viewGO, "view/propinfo/#btn_buy/cost/#txt_price")
	self._imagematerial = gohelper.findChildImage(self.viewGO, "view/propinfo/#btn_buy/cost/simage_material")
	self._goLine1 = gohelper.findChild(self.viewGO, "view/bg/line")
	self._gopropInfoTitle = gohelper.findChild(self.viewGO, "view/propinfo/title")
	self._gopropInfoTitleLayout = gohelper.findChild(self.viewGO, "view/propinfo/txt_goodslayout")
	self._gonormal = gohelper.findChild(self.viewGO, "view/normal")
	self._goDetailDescNormal = gohelper.findChild(self.viewGO, "view/normal_detail")
	self._goyueka = gohelper.findChild(self.viewGO, "view/yueka")
	self._reward = gohelper.findChild(self._goyueka, "reward")
	self._txtleft = gohelper.findChildText(self._reward, "left/txt")
	self._txtright = gohelper.findChildText(self._reward, "right/txt")
	self._iconleft = gohelper.findChild(self._reward, "left/#go_lefticon")
	self._iconleft2 = gohelper.findChild(self._reward, "left/#go_lefticon2")
	self._goicon2new = gohelper.findChild(self._reward, "left/#go_lefticon2/new")
	self._iconright = gohelper.findChild(self._reward, "right/#go_righticon")
	self._iconpower = gohelper.findChild(self._reward, "right/#go_powericon")
	self._godailyrelease = gohelper.findChild(self.viewGO, "view/dailyrelease")
	self._dailyreleasereward = gohelper.findChild(self._godailyrelease, "reward")
	self._txtdailyreleasereleft = gohelper.findChildText(self._dailyreleasereward, "left/txt")
	self._txtdailyreleasereright = gohelper.findChildText(self._dailyreleasereward, "right/txt")
	self._icondailyreleasereleft = gohelper.findChild(self._dailyreleasereward, "left/#go_lefticon")
	self._icon2dailyreleasereleft = gohelper.findChild(self._dailyreleasereward, "left/#go_lefticon2")
	self._icondailyreleasereright = gohelper.findChild(self._dailyreleasereward, "right/#go_righticon")
	self._icondailyreleaserepower = gohelper.findChild(self._dailyreleasereward, "right/#go_powericon")
	self._txtDailyReleaseDesc1 = gohelper.findChildText(self._godailyrelease, "desc/info/txt")
	self._txtDailyReleaseDesc2 = gohelper.findChildText(self._godailyrelease, "desc/info/txt (1)")
	self._gonewbiePick = gohelper.findChild(self.viewGO, "view/propinfo/#simage_icon/#go_pickdesc")
	self._golittlemonthcard = gohelper.findChild(self.viewGO, "view/littlemonthcard")
	self._littlemonthcardreward = gohelper.findChild(self._golittlemonthcard, "reward")
	self._littlemonthcardtxtleft = gohelper.findChildText(self._littlemonthcardreward, "left/txt")
	self._littlemonthcardtxtright = gohelper.findChildText(self._littlemonthcardreward, "right/txt")
	self._littlemonthcardiconleft = gohelper.findChild(self._littlemonthcardreward, "left/#go_lefticon")
	self._littlemonthcardiconleft2 = gohelper.findChild(self._littlemonthcardreward, "left/#go_lefticon2")
	self._littlemonthcardiconright = gohelper.findChild(self._littlemonthcardreward, "right/#go_righticon")
	self._littlemonthcardiconpower = gohelper.findChild(self._littlemonthcardreward, "right/#go_powericon")
	self._golittlemonthcardicon2new = gohelper.findChild(self._littlemonthcardreward, "left/#go_lefticon2/new")
	self._goSkinTips = gohelper.findChild(self.viewGO, "view/#go_SkinTips")
	self._imgProp = gohelper.findChildImage(self.viewGO, "view/#go_SkinTips/#txt_Tips/#image_Prop")
	self._txtPropNum = gohelper.findChildTextMesh(self.viewGO, "view/#go_SkinTips/#txt_Tips/#txt_Num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PackageStoreGoodsView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)

	if self._btnoverview then
		self._btnoverview:AddClickListener(self._btnoverviewOnClick, self)
	end
end

function PackageStoreGoodsView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()

	if self._btnoverview then
		self._btnoverview:RemoveClickListener()
	end
end

function PackageStoreGoodsView:_btnbuyOnClick()
	local isCurGoodHasNext = StoreConfig.instance:hasNextGood(self._mo.id)

	if isCurGoodHasNext then
		StoreModel.instance:setCurBuyPackageId(self._mo.id)
	end

	if self._mo.id == StoreEnum.MonthCardGoodsId then
		local storeMonthCardInfo = StoreModel.instance:getMonthCardInfo()

		if storeMonthCardInfo and storeMonthCardInfo:getRemainDay() >= StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId).maxDaysLimit - 1 then
			GameFacade.showToast(ToastEnum.PackageStoreGoods)

			return
		end
	end

	if self._mo.isChargeGoods then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
		PayController.instance:startPay(self._mo.goodsId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

		if self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			if CurrencyController.instance:checkFreeDiamondEnough(self._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._buyGoods, self, self.closeThis, self) then
				self:_buyGoods()
			end
		elseif self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.Diamond then
			if CurrencyController.instance:checkDiamondEnough(self._costQuantity, self.closeThis, self) then
				self:_buyGoods()
			end
		else
			self:_buyGoods()
		end
	end
end

function PackageStoreGoodsView:_buyGoods()
	StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self)
end

function PackageStoreGoodsView:_btncloseOnClick()
	self:closeThis()
end

function PackageStoreGoodsView:_btnoverviewOnClick()
	if not string.nilorempty(self._overviewJumpId) then
		GameFacade.jumpByAdditionParam(self._overviewJumpId)
	end
end

function PackageStoreGoodsView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._productList = {}
	self._gooffTag = gohelper.findChild(self.viewGO, "view/propinfo/#simage_icon/#go_offTag")
	self._txtoff = gohelper.findChildText(self.viewGO, "view/propinfo/#simage_icon/#go_offTag/#txt_off")
	self._gotxtCost = gohelper.findChildText(self.viewGO, "view/propinfo/#btn_buy/cost/txt")
	self._gotxtv2a8_09 = gohelper.findChild(self.viewGO, "view/propinfo/#simage_icon/txt_v2a8_09")
	self._seasoncardGo = gohelper.findChild(self.viewGO, "view/seasoncard")

	local rewardGo = gohelper.findChild(self._seasoncardGo, "reward")

	self._seasoncard_txtleft = gohelper.findChildText(rewardGo, "left/txt")
	self._seasoncard_txtright = gohelper.findChildText(rewardGo, "right/txt")
	self._seasoncard_iconleft = gohelper.findChild(rewardGo, "left/#go_lefticon")
	self._seasoncard_iconleft2 = gohelper.findChild(rewardGo, "left/#go_lefticon2")
	self._seasoncard_goicon2new = gohelper.findChild(rewardGo, "left/#go_lefticon2/new")
	self._seasoncard_iconright = gohelper.findChild(rewardGo, "right/#go_righticon")
	self._seasoncard_iconpower = gohelper.findChild(rewardGo, "right/#go_powericon")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_overview")
	self._txtpickdesc = gohelper.findChildTextMesh(self.viewGO, "view/propinfo/#simage_icon/#go_pickdesc/#txt_pickdesc")
end

function PackageStoreGoodsView:onUpdateParam()
	self:onOpen()
end

function PackageStoreGoodsView:onOpen()
	self._mo = self.viewParam
	self._overviewJumpId = self._mo and self._mo.config and self._mo.config.overviewJumpId

	StoreModel.instance:setCurBuyPackageId(nil)
	StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self._mo.config)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)

	self._txtgoodsNameCn.text = self._mo.config.name

	self._simageicon:LoadImage(ResUrl.getStorePackageIcon(self._mo.config.bigImg), self._loadiconCb, self)

	if string.nilorempty(self._mo.config.underlay) then
		logError("商店改版 缺少底板配置 商品id:" .. tostring(self._mo.goodsId))
	else
		local underlayParam = string.splitToNumber(self._mo.config.underlay, "#")

		logNormal(string.format("---商店改版 底板配置 id: %s 底板id: %s 价格: %s ", self._mo.goodsId, underlayParam[1], self._mo.isChargeGoods and PayModel.instance:getProductOriginPriceNum(self._mo.id) or 0))

		local itemBgIconName = "panel/package_quality_" .. self:_getNumStr(underlayParam[1])

		logNormal("商店改版 底板: " .. itemBgIconName)

		local itemBgIndex = StoreHelper.getPackageIconBgIndex(self._mo.goodsId, self._mo.id, underlayParam[1])
		local itemIconBgName = itemBgIconName .. "_" .. self:_getNumStr(itemBgIndex)

		logNormal("商店改版 图标底板: " .. itemIconBgName)
		self._simageiconbg:LoadImage(ResUrl.getStorePackageIcon(itemIconBgName))

		local showLevelBg = self._mo.buyLevel ~= nil and self._mo.buyLevel ~= 0

		gohelper.setActive(self._simageiconnum, showLevelBg)

		if showLevelBg then
			local levelIconName = itemBgIconName .. "_" .. self:_getNumStr(self._mo.buyLevel)

			logNormal("商店改版 等级图标: " .. levelIconName)
			self._simageiconnum:LoadImage(ResUrl.getStorePackageIcon(levelIconName))
		end
	end

	if self._mo.config.id == monthCardId then
		recthelper.setAnchor(self._simageicon.transform, monthCardX, monthCardY)
	end

	if self._mo.goodsId == StoreEnum.LittleMonthCardGoodsId or self._mo.config.id == monthCardId or self._mo.config.type == StoreEnum.StoreEnum.StoreChargeType.DailyReleasePackage then
		recthelper.setAnchor(self._btnbuy.transform, 280.63, -232.8)
	end

	gohelper.setActive(self._goSecondGoodsName, self._mo.config.id == activity1_4PackageId)
	self._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	self:_refreshPriceArea()
	self:_refreshTagArea()

	local isMonthCard = self._mo.goodsId == StoreEnum.MonthCardGoodsId
	local isSeasonCard = self._mo.goodsId == StoreEnum.SeasonCardGoodsId
	local isLittleMonthCard = self._mo.goodsId == StoreEnum.LittleMonthCardGoodsId
	local isDailyReleasePackage = self._mo.config.type == StoreEnum.StoreEnum.StoreChargeType.DailyReleasePackage
	local showDetailDescPackage = not string.nilorempty(self._mo.config.detailDesc)

	gohelper.setActive(self._gonormal, false)
	gohelper.setActive(self._goDetailDescNormal, false)
	gohelper.setActive(self._goyueka, false)
	gohelper.setActive(self._godailyrelease, false)
	gohelper.setActive(self._golittlemonthcard, false)
	gohelper.setActive(self._seasoncardGo, false)

	if isMonthCard then
		gohelper.setActive(self._goyueka, true)
		self:_updateMonthCard()
	elseif isSeasonCard then
		gohelper.setActive(self._seasoncardGo, true)
		self:_updateSeasonCard()
	elseif isLittleMonthCard then
		gohelper.setActive(self._golittlemonthcard, true)
		self:_updateLittleMonthCard()
	elseif isDailyReleasePackage then
		gohelper.setActive(self._godailyrelease, true)
		self:_updateDailyReleasePackage()
	elseif showDetailDescPackage then
		gohelper.setActive(self._goDetailDescNormal, true)
		self:_updateDetailDescNormalPack()
	else
		gohelper.setActive(self._gonormal, true)
		self:_updateNormal()
	end

	local isNewbiePackage = self._mo.id == StoreEnum.NewbiePackId
	local showTag = isNewbiePackage or not string.nilorempty(self._mo.config.slogan)

	gohelper.setActive(self._gonewbiePick, showTag)

	if showTag then
		self._txtpickdesc.text = self._mo.config.slogan
	end

	self:refreshSkinTips(self._mo)

	if self._btnoverview then
		gohelper.setActive(self._btnoverview, not string.nilorempty(self._overviewJumpId))
	end

	gohelper.setActive(self._gotxtv2a8_09, PackageStoreEnum.AnimHeadDict[self._mo.goodsId])
end

function PackageStoreGoodsView:_refreshPriceArea()
	local cost = self._mo.cost

	gohelper.setActive(self._txtprice.gameObject, self._mo.config.originalCost > 0)
	gohelper.setActive(self._gotxtCost.gameObject, string.nilorempty(cost) == false)

	if string.nilorempty(cost) or cost == 0 then
		self._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(self._imagematerial.gameObject, false)
	elseif self._mo.isChargeGoods then
		self._txtmaterialNum.text = string.format("%s<indent=33>%s", StoreModel.instance:getCostStr(cost))
		self._txtprice.text = string.format("%s<indent=33>%s", StoreModel.instance:getCostStr(self._mo.config.originalCost))

		gohelper.setActive(self._imagematerial.gameObject, false)
	else
		local costs = string.split(cost, "|")

		if not costs[self._mo.buyCount + 1] then
			local costParam = costs[#costs]
			local costInfo = string.splitToNumber(costParam, "#")

			self._costType = costInfo[1]
			self._costId = costInfo[2]
			self._costQuantity = costInfo[3]

			local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)
			local id = costConfig.icon
			local str = string.format("%s_1", id)

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerial, str)

			self._txtmaterialNum.text = self._costQuantity
			self._txtprice.text = self._mo.config.originalCost

			gohelper.setActive(self._imagematerial.gameObject, true)

			local hadQuantity = ItemModel.instance:getItemQuantity(self._costType, self._costId)

			if hadQuantity >= self._costQuantity then
				SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, "#393939")
			else
				SLFramework.UGUI.GuiHelper.SetColor(self._txtmaterialNum, "#bf2e11")
			end
		end
	end
end

function PackageStoreGoodsView:_refreshTagArea()
	local offTag = tonumber(self._mo:getDiscount())

	if offTag and offTag > 0 then
		gohelper.setActive(self._gooffTag, true)

		self._txtoff.text = string.format("-%d%%", offTag)
	else
		gohelper.setActive(self._gooffTag, false)
	end
end

function PackageStoreGoodsView:_updateNormal()
	local isLevelOpen = self._mo:isLevelOpen()

	gohelper.setActive(self._btnbuy.gameObject, isLevelOpen)
	gohelper.setActive(self._gotips, isLevelOpen == false)

	if isLevelOpen == false then
		self._txtlocktips.text = formatLuaLang("account_level_unlock", self._mo.buyLevel)
	end

	local gorightbg = gohelper.findChild(self._gonormal, "info/remain/#go_rightbg")
	local txtremaintime = gohelper.findChildText(self._gonormal, "info/remain/#go_rightbg/#txt_remaintime")

	if self._mo.offlineTime > 0 then
		local limitSec = math.floor(self._mo.offlineTime - ServerTime.now())

		gohelper.setActive(gorightbg, true)

		txtremaintime.text = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
	else
		gohelper.setActive(gorightbg, false)
	end

	local goleftbg = gohelper.findChild(self._gonormal, "info/remain/#go_leftbg")
	local txtremain = gohelper.findChildText(self._gonormal, "info/remain/#go_leftbg/#txt_remain")
	local goremain = gohelper.findChild(self._gonormal, "info/remain")

	self:_updateNormalPackCommon(goleftbg, txtremain, goremain)

	local goProduct = gohelper.findChild(self._gonormal, "info/scroll/#scroll_product/product")
	local goProductRoot = gohelper.findChild(self._gonormal, "info/scroll/#scroll_product/Viewport/Content")

	gohelper.setActive(goProduct, false)
	self:_updateNormalPackGoods(goProduct, goProductRoot)
end

function PackageStoreGoodsView:_updateDetailDescNormalPack()
	gohelper.setActive(self._goLine1, false)
	gohelper.setActive(self._gopropInfoTitle, false)
	gohelper.setActive(self._gopropInfoTitleLayout, false)

	local isLevelOpen = self._mo:isLevelOpen()

	gohelper.setActive(self._btnbuy.gameObject, isLevelOpen)
	gohelper.setActive(self._gotips, isLevelOpen == false)

	if isLevelOpen == false then
		self._txtlocktips.text = formatLuaLang("account_level_unlock", self._mo.buyLevel)
	end

	local txtremaintime = gohelper.findChildText(self._goDetailDescNormal, "info/remain/#go_rightbg/#txt_remaintime")
	local rightbg = gohelper.findChild(self._goDetailDescNormal, "info/remain/#go_rightbg")

	if self._mo.offlineTime > 0 then
		local limitSec = math.floor(self._mo.offlineTime - ServerTime.now())

		gohelper.setActive(rightbg, true)

		txtremaintime.text = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
	else
		gohelper.setActive(rightbg, false)
	end

	local goremain2 = gohelper.findChild(self._goDetailDescNormal, "info/remain")
	local goleftbg2 = gohelper.findChild(self._goDetailDescNormal, "info/remain/#go_leftbg")
	local txtremain2 = gohelper.findChildText(self._goDetailDescNormal, "info/remain/#go_leftbg/#txt_remain")

	self:_updateNormalPackCommon(goleftbg2, txtremain2, goremain2)

	local goProduct = gohelper.findChild(self._goDetailDescNormal, "info/scroll/#scroll_product/product")
	local goProductRoot = gohelper.findChild(self._goDetailDescNormal, "info/scroll/#scroll_product/Viewport/Content")

	gohelper.setActive(goProduct, false)
	self:_updateNormalPackGoods(goProduct, goProductRoot)

	local txtDescGo = gohelper.findChild(self._goDetailDescNormal, "info/desc/info/txt")
	local detailDesc = self._mo.config.detailDesc
	local detailDescStrList = string.split(detailDesc, "\n")

	gohelper.CreateObjList(nil, function(callBackObj, itemViewGo, str, index)
		local txtDesc = gohelper.findChildText(itemViewGo, "")

		txtDesc.text = str
	end, detailDescStrList, nil, txtDescGo)

	local txtgoodsNameCn = gohelper.findChildText(self._goDetailDescNormal, "title/#txt_goodsNameCn")

	txtgoodsNameCn.text = self._mo.config.name
end

function PackageStoreGoodsView:_updateNormalPackCommon(leftbg, txtremain, goremain)
	local maxBuyCount = self._mo.maxBuyCount
	local remain = maxBuyCount - self._mo.buyCount
	local content

	if self._mo.isChargeGoods then
		content = StoreConfig.instance:getChargeRemainText(maxBuyCount, self._mo.refreshTime, remain, self._mo.offlineTime)
	else
		local showRefreshTime = StoreHelper.getShowRefreshTimeByGoodsMO(self._mo)

		content = StoreConfig.instance:getRemainText(maxBuyCount, showRefreshTime, remain, self._mo.offlineTime)
	end

	if string.nilorempty(content) then
		gohelper.setActive(leftbg, false)
		gohelper.setActive(txtremain.gameObject, false)
		gohelper.setActive(goremain, self._mo.offlineTime > 0)
	else
		gohelper.setActive(leftbg, true)
		gohelper.setActive(txtremain.gameObject, true)

		txtremain.text = content
	end
end

function PackageStoreGoodsView:_updateNormalPackGoods(goProduct, goProductRoot)
	local arr = self._mo.config.product and GameUtil.splitString2(self._mo.config.product) or {}

	for i, v in ipairs(arr) do
		local item = self._productList[i]

		if item == nil then
			item = PackageStoreGoodsViewItem.New()

			local itemGo = gohelper.clone(goProduct, goProductRoot, "productItem")

			item:init(itemGo)

			self._productList[i] = item
		end

		item:onUpdateMO(v)
		item:setActive(true)
	end

	for i = #arr + 1, #self._productList do
		self._productList[i]:setActive(false)
	end
end

function PackageStoreGoodsView:_updateMonthCard()
	gohelper.setActive(self._btnbuy.gameObject, true)
	gohelper.setActive(self._gotips, false)

	local monthCardCo = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local onceBonus = string.split(monthCardCo.onceBonus, "|")[1]
	local temp = string.splitToNumber(onceBonus, "#")
	local type = temp[1]
	local id = temp[2]
	local quantity = temp[3]

	self._monthCardItemIcon = self._monthCardItemIcon or IconMgr.instance:getCommonItemIcon(self._iconleft)

	self:_setIcon(self._monthCardItemIcon, type, id, quantity)

	local onceBonus = string.split(monthCardCo.onceBonus, "|")[2]
	local temp = string.splitToNumber(onceBonus, "#")
	local type = temp[1]
	local id = temp[2]
	local quantity = temp[3]

	self._monthCardItemIcon2 = self._monthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(self._iconleft2)

	gohelper.setAsFirstSibling(self._monthCardItemIcon2.go)
	self:_setIcon(self._monthCardItemIcon2, type, id, quantity)

	local showtag = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(self._goicon2new, showtag)

	local dailyBonus = string.split(monthCardCo.dailyBonus, "|")[1]

	temp = string.splitToNumber(dailyBonus, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._monthCardDailyItemIcon = self._monthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(self._iconright)

	self:_setIcon(self._monthCardDailyItemIcon, type, id, quantity)

	local powerBonus = string.split(monthCardCo.dailyBonus, "|")[2]

	temp = string.splitToNumber(powerBonus, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._monthCardPowerItemIcon = self._monthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(self._iconpower)

	self:_setIcon(self._monthCardPowerItemIcon, type, id, quantity)
end

function PackageStoreGoodsView:_updateLittleMonthCard()
	gohelper.setActive(self._btnbuy.gameObject, true)
	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._golittlemonthcardicon2new, false)

	local littleMonthCardCo = StoreConfig.instance:getMonthCardAddConfig(StoreEnum.LittleMonthCardGoodsId)
	local monthCardCo = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local onceBonus = string.split(littleMonthCardCo.onceBonus, "|")[1]
	local temp = string.splitToNumber(onceBonus, "#")
	local type = temp[1]
	local id = temp[2]
	local quantity = temp[3]

	self._littleMonthCardItemIcon = self._littleMonthCardItemIcon or IconMgr.instance:getCommonItemIcon(self._littlemonthcardiconleft)

	self:_setIcon(self._littleMonthCardItemIcon, type, id, quantity)

	local onceBonus2 = string.split(littleMonthCardCo.onceBonus, "|")[2]

	temp = string.splitToNumber(onceBonus2, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._littleMonthCardItemIcon2 = self._littleMonthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(self._littlemonthcardiconleft2)

	gohelper.setAsFirstSibling(self._littleMonthCardItemIcon2.go)
	self:_setIcon(self._littleMonthCardItemIcon2, type, id, quantity)

	local dailyBonus = string.split(monthCardCo.dailyBonus, "|")[1]

	temp = string.splitToNumber(dailyBonus, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._littleMonthCardDailyItemIcon = self._littleMonthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(self._littlemonthcardiconright)

	self:_setIcon(self._littleMonthCardDailyItemIcon, type, id, quantity)

	local powerBonus = string.split(monthCardCo.dailyBonus, "|")[2]

	temp = string.splitToNumber(powerBonus, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._littleMonthCardPowerItemIcon = self._littleMonthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(self._littlemonthcardiconpower)

	self:_setIcon(self._littleMonthCardPowerItemIcon, type, id, quantity)
end

function PackageStoreGoodsView:_updateSeasonCard()
	local f = StoreConfig.instance:getSeasonCardMultiFactor()

	gohelper.setActive(self._btnbuy.gameObject, true)
	gohelper.setActive(self._gotips, false)

	local monthCardCo = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local onceBonus = string.split(monthCardCo.onceBonus, "|")[1]
	local temp = string.splitToNumber(onceBonus, "#")
	local type = temp[1]
	local id = temp[2]
	local quantity = temp[3] * f

	self._monthCardItemIcon = self._monthCardItemIcon or IconMgr.instance:getCommonItemIcon(self._seasoncard_iconleft)

	self:_setIcon(self._monthCardItemIcon, type, id, quantity)

	local onceBonus = string.split(monthCardCo.onceBonus, "|")[2]
	local temp = string.splitToNumber(onceBonus, "#")
	local type = temp[1]
	local id = temp[2]
	local quantity = temp[3] * f

	self._monthCardItemIcon2 = self._monthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(self._seasoncard_iconleft2)

	gohelper.setAsFirstSibling(self._monthCardItemIcon2.go)
	self:_setIcon(self._monthCardItemIcon2, type, id, quantity)

	local showtag = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(self._seasoncard_goicon2new, showtag)

	local dailyBonus = string.split(monthCardCo.dailyBonus, "|")[1]

	temp = string.splitToNumber(dailyBonus, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._monthCardDailyItemIcon = self._monthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(self._seasoncard_iconright)

	self:_setIcon(self._monthCardDailyItemIcon, type, id, quantity)

	local powerBonus = string.split(monthCardCo.dailyBonus, "|")[2]

	temp = string.splitToNumber(powerBonus, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._monthCardPowerItemIcon = self._monthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(self._seasoncard_iconpower)

	self:_setIcon(self._monthCardPowerItemIcon, type, id, quantity)
end

function PackageStoreGoodsView:_updateDailyReleasePackage(storeMo)
	gohelper.setActive(self._btnbuy.gameObject, true)
	gohelper.setActive(self._gotips, false)

	local dailyReleasePackageCfg = StoreConfig.instance:getDailyReleasePackageCfg(self._mo.goodsId)
	local dayNum = dailyReleasePackageCfg.days
	local onceBonusArr = string.split(dailyReleasePackageCfg.onceBonus, "|")
	local temp = string.splitToNumber(onceBonusArr[1], "#")
	local type = temp[1]
	local id = temp[2]
	local quantity = temp[3]

	self._dailyReleasePackageIcon = self._dailyReleasePackageIcon or IconMgr.instance:getCommonItemIcon(self._icon2dailyreleasereleft)

	self:_setIcon(self._dailyReleasePackageIcon, type, id, quantity)

	if #onceBonusArr > 1 then
		local onceBonus = onceBonusArr[2]
		local temp = string.splitToNumber(onceBonus, "#")
		local type = temp[1]
		local id = temp[2]
		local quantity = temp[3]

		self._dailyReleasePackageIcon2 = self._dailyReleasePackageIcon2 or IconMgr.instance:getCommonItemIcon(self._icondailyreleasereleft)

		self:_setIcon(self._dailyReleasePackageIcon2, type, id, quantity)
	end

	local dailyBonus = string.split(dailyReleasePackageCfg.dailyBonus, "|")[1]

	temp = string.splitToNumber(dailyBonus, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._dailyReleasePackageDailyItemIcon1 = self._dailyReleasePackageDailyItemIcon1 or IconMgr.instance:getCommonItemIcon(self._icondailyreleasereright)

	self:_setIcon(self._dailyReleasePackageDailyItemIcon1, type, id, quantity * dayNum)

	local powerBonus = string.split(dailyReleasePackageCfg.dailyBonus, "|")[2]

	temp = string.splitToNumber(powerBonus, "#")
	type = temp[1]
	id = temp[2]
	quantity = temp[3]
	self._dailyReleasePackageDailyItemIcon2 = self._dailyReleasePackageDailyItemIcon2 or IconMgr.instance:getCommonItemIcon(self._icondailyreleaserepower)

	self:_setIcon(self._dailyReleasePackageDailyItemIcon2, type, id, quantity * dayNum)

	self._txtDailyReleaseDesc1.text = dailyReleasePackageCfg.desc1
	self._txtDailyReleaseDesc2.text = dailyReleasePackageCfg.desc2
end

function PackageStoreGoodsView:_loadiconCb()
	self._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function PackageStoreGoodsView:_setIcon(icon, type, id, quantity)
	if type == MaterialEnum.MaterialType.PowerPotion then
		icon:setMOValue(type, id, quantity, nil, true)
		icon:setCantJump(true)
		icon:setCountFontSize(36)
		icon:setScale(0.7)
		icon:SetCountLocalY(43.6)
		icon:SetCountBgHeight(25)
		icon:setItemIconScale(1.1)

		local icontrs = icon:getIcon().transform

		recthelper.setAnchor(icontrs, -7.2, 3.5)

		local deadline1 = icon:getDeadline1()

		recthelper.setAnchor(deadline1.transform, 78, 82.8)
		transformhelper.setLocalScale(deadline1.transform, 0.7, 0.7, 1)

		self._simgdeadline = gohelper.findChildImage(deadline1, "timebg")

		UISpriteSetMgr.instance:setStoreGoodsSprite(self._simgdeadline, "img_xianshi1")
	else
		icon:setMOValue(type, id, quantity, nil, true)
		icon:setCantJump(true)
		icon:setCountFontSize(36)
		icon:setScale(0.7)
		icon:SetCountLocalY(43.6)
		icon:SetCountBgHeight(25)
	end
end

function PackageStoreGoodsView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
	end
end

function PackageStoreGoodsView:_payFinished()
	self:closeThis()
end

function PackageStoreGoodsView:refreshSkinTips(goodsMO)
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

function PackageStoreGoodsView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function PackageStoreGoodsView:onDestroyView()
	self._simageicon:UnLoadImage()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	GameUtil.onDestroyViewMemberList(self, "_productList")

	if self._monthCardItemIcon then
		self._monthCardItemIcon:onDestroy()
	end

	if self._monthCardDailyItemIcon then
		self._monthCardDailyItemIcon:onDestroy()
	end
end

function PackageStoreGoodsView:_getNumStr(num)
	if tonumber(num) < 10 then
		return "0" .. num
	end

	return tostring(num)
end

return PackageStoreGoodsView
