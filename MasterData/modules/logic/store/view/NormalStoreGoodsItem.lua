-- chunkname: @modules/logic/store/view/NormalStoreGoodsItem.lua

module("modules.logic.store.view.NormalStoreGoodsItem", package.seeall)

local NormalStoreGoodsItem = class("NormalStoreGoodsItem", ListScrollCellExtend)

function NormalStoreGoodsItem:onInitView()
	self._goNormalBg = gohelper.findChild(self.viewGO, "bg")
	self._goActBg = gohelper.findChild(self.viewGO, "actBg")
	self._goActBgEff = gohelper.findChild(self.viewGO, "actBg/mask")
	self._gogoods = gohelper.findChild(self.viewGO, "#go_goods")
	self._goicon = gohelper.findChildSingleImage(self.viewGO, "#go_goods/#go_icon")
	self._goroomiconmask = gohelper.findChild(self.viewGO, "#go_goods/#go_roomiconmask")
	self._simageroomicon = gohelper.findChildSingleImage(self.viewGO, "#go_goods/#go_roomiconmask/#simage_roomicon")
	self._gonum = gohelper.findChild(self.viewGO, "#go_goods/#go_num")
	self._gonumBg = gohelper.findChild(self.viewGO, "#go_goods/#go_num/bg")
	self._gonumText = gohelper.findChildText(self.viewGO, "#go_goods/#go_num/bg/#txt_num")
	self._rare = gohelper.findChildImage(self.viewGO, "rare")
	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "cost/txt_materialNum")
	self._imagematerial = gohelper.findChildImage(self.viewGO, "cost/txt_materialNum/simage_material")
	self._txtremain = gohelper.findChildText(self.viewGO, "layout/txt_remain")
	self._txtgoodsName = gohelper.findChildText(self.viewGO, "layout/txt_goodsName")
	self._gosoldout = gohelper.findChild(self.viewGO, "go_soldout")
	self._golevellimit = gohelper.findChild(self.viewGO, "go_levellimit")
	self._txtlvlimit = gohelper.findChildText(self.viewGO, "go_levellimit/bg/txt")
	self._gohas = gohelper.findChild(self.viewGO, "go_has")
	self._goline = gohelper.findChild(self.viewGO, "#go_line")
	self._goitemreddot = gohelper.findChild(self.viewGO, "go_itemreddot")
	self._godiscount = gohelper.findChild(self.viewGO, "go_tag/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "go_tag/#go_discount/#txt_discount")
	self._txtoriginalCost = gohelper.findChildText(self.viewGO, "cost/txt_materialNum/txt_originalCost")
	self._gooffflineTime = gohelper.findChild(self.viewGO, "#go_offflineTime")
	self._txtoffflineTime = gohelper.findChildText(self.viewGO, "#go_offflineTime/#txt_offflineTime")
	self._goRefreshTime = gohelper.findChild(self.viewGO, "#go_refreshtime")
	self._txtRefreshTime = gohelper.findChildText(self.viewGO, "#go_refreshtime/#txt_refreshtime")
	self._goroomactive = gohelper.findChild(self.viewGO, "#go_roomactive")
	self._goroomnum = gohelper.findChild(self.viewGO, "#go_roomactive/#go_roomnum")
	self._goroomticket = gohelper.findChild(self.viewGO, "#go_roomactive/#go_tag")
	self._txtroomnum = gohelper.findChildText(self.viewGO, "#go_roomactive/#go_roomnum/bg/#txt_roomnum")
	self._simageroomactiveicon = gohelper.findChildImage(self.viewGO, "#go_roomactive/#go_roomnum/bg/#txt_roomnum/#simage_roomactiveicon")
	self._txtCost2Num = gohelper.findChildText(self.viewGO, "cost/txt_yudiNum")
	self._imageCost2 = gohelper.findChildImage(self.viewGO, "cost/txt_yudiNum/simage_material")
	self._goherofull = gohelper.findChild(self.viewGO, "go_herofull")
	self._goUnique = gohelper.findChild(self.viewGO, "#go_unique")
	self._goLimit = gohelper.findChild(self.viewGO, "go_tag/#go_limit")
	self._goActTag = gohelper.findChild(self.viewGO, "go_tag/#go_act")
	self._goCost = gohelper.findChild(self.viewGO, "cost")
	self._goPath = gohelper.findChild(self.viewGO, "#go_path")
	self._txtPath = gohelper.findChildText(self.viewGO, "#go_path/#txt_path")
	self._btnPath = gohelper.findChildButton(self.viewGO, "#go_path/btn")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NormalStoreGoodsItem:addEvents()
	self.addEventCb(self, StoreController.instance, StoreEvent.jumpClickRoomChildGoods, self._onJumpClick, self)
end

function NormalStoreGoodsItem:removeEvents()
	self.removeEventCb(self, StoreController.instance, StoreEvent.jumpClickRoomChildGoods, self._onJumpClick, self)
end

function NormalStoreGoodsItem:_onJumpClick(jumpGoodsId)
	if not jumpGoodsId or not self._mo then
		return
	end

	if jumpGoodsId == self._mo.goodsId then
		self:_onClick()
	end
end

function NormalStoreGoodsItem:_editableInitView()
	self._btnGO = gohelper.findChild(self.viewGO, "clickArea")
	self._btn = gohelper.getClickWithAudio(self._btnGO, AudioEnum.UI.Store_Good_Click)

	self._btn:AddClickListener(self._onClick, self)
	self._btnPath:AddClickListener(self._onClickPath, self)

	self._soldout = false
	self._limitSold = false
	self._hascloth = false

	gohelper.setActive(self._goline, false)
	gohelper.setActive(self._goUnique, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._imgicon = gohelper.findChildImage(self.viewGO, "#go_goods/#go_icon")
	self._gonewtag = gohelper.findChild(self.viewGO, "go_newtag")

	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnHour, self.onHourRefresh, self)
end

function NormalStoreGoodsItem:_onClickPath()
	if not self._mo then
		return
	end

	if self._mo:getIsJumpGoods() then
		local jumpId = self._mo.config.jumpId

		GameFacade.jump(jumpId)
	end
end

function NormalStoreGoodsItem:_onClick()
	local isActGoods = self._mo:getIsActGoods()

	if isActGoods then
		self:_onActGoodsClick()
	elseif self._mo:getIsJumpGoods() then
		self:_onJumpGoodsClick()
	else
		self:_onNormalGoodsClick()
	end

	if self._mo:needShowRead() then
		StoreRpc.instance:sendReadStoreNewRequest({
			self._mo.goodsId
		}, self._onRefreshNew, self)
	end
end

function NormalStoreGoodsItem:_onJumpGoodsClick()
	if self._hascloth then
		GameFacade.showToast(ToastEnum.NormalStoreGoodsHasCloth)
	elseif self._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif self._limitSold then
		GameFacade.showToast(ToastEnum.PackageStoreGoods)
	else
		MaterialTipController.instance:showMaterialInfo(self._itemType, self._itemId)
	end
end

function NormalStoreGoodsItem:_onNormalGoodsClick()
	if self._hascloth then
		local config = ItemModel.instance:getItemConfig(self._itemType, self._itemId)

		if self:_isAlreadyHasIgnoreType(config.subType) then
			local goodsConfig = StoreConfig.instance:getGoodsConfig(self._mo.goodsId)
			local maxBuyCount = goodsConfig.maxBuyCount
			local remain = maxBuyCount - self._mo.buyCount

			if remain > 0 then
				StoreController.instance:openNormalGoodsView(self._mo)

				return
			end
		end

		GameFacade.showToast(ToastEnum.NormalStoreGoodsHasCloth)
	elseif self._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif self._limitSold then
		GameFacade.showToast(ToastEnum.PackageStoreGoods)
	elseif not self:_isStoreItemUnlock() then
		self._mo.lvlimitchapter = self.lvlimitchapter
		self._mo.lvlimitepisode = self.lvlimitepisode
		self._mo.isHardChapter = self.isHardChapter

		StoreController.instance:openNormalGoodsView(self._mo)
	elseif StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(self._mo.goodsId) then
		self._mo.limitWeekWalkLayer = StoreConfig.instance:getGoodsConfig(self._mo.goodsId).needWeekwalkLayer

		StoreController.instance:openNormalGoodsView(self._mo)
	else
		StoreController.instance:openNormalGoodsView(self._mo)
	end
end

function NormalStoreGoodsItem:_isStoreItemUnlock()
	if self._mo:getIsActGoods() then
		return true
	end

	local episodeId = StoreConfig.instance:getGoodsConfig(self._mo.goodsId).needEpisodeId

	if not episodeId or episodeId == 0 then
		return true
	end

	if episodeId == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function NormalStoreGoodsItem:_onActGoodsClick()
	if not self._mo then
		return
	end

	local actGoodsId = self._mo:getActGoodsId()
	local belongStoreId = self._mo:getBelongStoreId()
	local goodsRemainBuyCount = FurnaceTreasureModel.instance:getGoodsRemainCount(belongStoreId, actGoodsId)

	if goodsRemainBuyCount < FurnaceTreasureEnum.DEFAULT_BUY_COUNT then
		GameFacade.showToast(ToastEnum.CurrencyChanged)

		return
	end

	ViewMgr.instance:openView(ViewName.FurnaceTreasureBuyView, {
		goodsId = actGoodsId,
		storeId = belongStoreId
	})
end

function NormalStoreGoodsItem:onHourRefresh()
	if self._mo:getIsActGoods() then
		return
	end

	local config = StoreConfig.instance:getGoodsConfig(self._mo.goodsId)

	self:refreshNextRefreshTime(config)
end

function NormalStoreGoodsItem:getAnimator()
	return self._animator
end

function NormalStoreGoodsItem:hideOffflineTime()
	self._hideOffflineTime = true
end

function NormalStoreGoodsItem:onUpdateMO(mo)
	if not mo then
		return
	end

	self._mo = mo

	local isActGoods = mo:getIsActGoods()

	if isActGoods then
		self:refreshActGoods()
	else
		self:refreshNormalGoods()
	end

	gohelper.setActive(self._goNormalBg, not isActGoods)
	gohelper.setActive(self._goActBg, isActGoods)
	gohelper.setActive(self._goActTag, isActGoods)
end

NormalStoreGoodsItem.AlreadyHasIgnoreType = {
	ItemEnum.SubType.RoomBlockGift,
	ItemEnum.SubType.RoomBlockGiftNew
}

function NormalStoreGoodsItem:_isAlreadyHasIgnoreType(subType)
	return LuaUtil.tableContains(NormalStoreGoodsItem.AlreadyHasIgnoreType, subType)
end

function NormalStoreGoodsItem:refreshNormalGoods()
	local mo = self._mo
	local isStoreItemUnlock = self:_isStoreItemUnlock()

	gohelper.setActive(self._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(mo.goodsId))
	gohelper.setActive(self._golevellimit, not isStoreItemUnlock)

	if not isStoreItemUnlock then
		local episodeId = StoreConfig.instance:getGoodsConfig(mo.goodsId).needEpisodeId

		if episodeId == StoreEnum.Need4RDEpisodeId then
			self._txtlvlimit.text = string.format("%s%s", luaLang("level_limit_4RD_unlock"), luaLang("dungeon_unlock"))
		else
			local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
			local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
			local langKey = "dungeon_main_unlock"

			self.isHardChapter = false

			if chapterConfig and chapterConfig.type == DungeonEnum.ChapterType.Hard then
				episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeConfig.preEpisode)
				chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)
				langKey = "dungeon_main_hard_unlock"
				self.isHardChapter = true
			end

			local chapterIndex, episodeIndex, episodeType

			if episodeConfig and chapterConfig then
				chapterIndex = chapterConfig.chapterIndex

				local var_17_0, var_17_1 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(chapterConfig.id, episodeConfig.id)

				episodeIndex = var_17_0

				if var_17_1 == DungeonEnum.EpisodeType.Sp then
					chapterIndex = "SP"
				end
			end

			self._txtlvlimit.text = string.format(luaLang(langKey), string.format("%s-%s", chapterIndex, episodeIndex))
			self.lvlimitchapter = chapterIndex
			self.lvlimitepisode = episodeIndex
		end
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(mo.goodsId) then
		gohelper.setActive(self._golevellimit, true)

		local needWeekwalkLayer = StoreConfig.instance:getGoodsConfig(mo.goodsId).needWeekwalkLayer

		self._txtlvlimit.text = string.format(luaLang("dungeon_weekwalk_unlock"), needWeekwalkLayer)
	end

	local goodsConfig = StoreConfig.instance:getGoodsConfig(mo.goodsId)

	self:updateGoodsItemAttribute(goodsConfig)

	local config = ItemModel.instance:getItemConfig(self._itemType, self._itemId)

	if string.nilorempty(mo.config.name) == false then
		self._txtgoodsName.text = mo.config.name
	elseif config then
		self._txtgoodsName.text = config.name
	else
		logError("找不到商品配置: " .. goodsConfig.product)
	end

	self:_refreshGoods(goodsConfig)

	local cost = goodsConfig.cost

	if string.nilorempty(cost) then
		self._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(self._imagematerial.gameObject, false)

		self._costQuantity = 0
	else
		local costs = string.split(cost, "|")

		if not costs[mo.buyCount + 1] then
			local costParam = costs[#costs]
			local costInfo = string.splitToNumber(costParam, "#")
			local costType = costInfo[1]
			local costId = costInfo[2]

			self._costQuantity = costInfo[3]

			local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(costType, costId)
			local id = costConfig.icon
			local str = string.format("%s_1", id)

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerial, str)
			gohelper.setActive(self._imagematerial.gameObject, true)

			self._txtmaterialNum.text = self._costQuantity
		end
	end

	local cost2 = goodsConfig.cost2

	if string.nilorempty(cost2) then
		gohelper.setActive(self._txtCost2Num.gameObject, false)
		gohelper.setActive(self._goline, false)

		self._txtmaterialNum.fontSize = 36
		self._txtCost2Num.fontSize = 36
	else
		self._txtmaterialNum.fontSize = 30
		self._txtCost2Num.fontSize = 30

		gohelper.setActive(self._txtCost2Num.gameObject, true)
		gohelper.setActive(self._goline, true)

		local costs = string.split(cost2, "|")

		if not costs[mo.buyCount + 1] then
			local costParam = costs[#costs]
			local costInfo = string.splitToNumber(costParam, "#")
			local costType = costInfo[1]
			local costId = costInfo[2]
			local costQuantity = costInfo[3]
			local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(costType, costId)
			local id = costConfig.icon
			local str = string.format("%s_1", id)

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageCost2, str)

			self._txtCost2Num.text = costQuantity
		end
	end

	if self._mo.config.jumpId ~= 0 then
		gohelper.setActive(self._goCost, false)
		gohelper.setActive(self._goline, false)
		gohelper.setActive(self._goPath, true)

		if self._mo.config.activityId ~= 0 then
			self._txtPath.text = luaLang("getGoodsByActivity")
		elseif self._mo.config.bindgoodid ~= 0 then
			self._txtPath.text = luaLang("getGoodsByBingGoods")
		end
	end

	gohelper.setActive(self._godiscount, mo.config.originalCost > 0)

	if goodsConfig.cost and goodsConfig.cost2 then
		gohelper.setActive(self._txtoriginalCost.gameObject, false)
	else
		gohelper.setActive(self._txtoriginalCost.gameObject, mo.config.originalCost > 0)
	end

	local offTag = math.ceil(100 * self._costQuantity / mo.config.originalCost)

	self._txtdiscount.text = string.format("-%d%%", 100 - offTag)
	self._txtoriginalCost.text = mo.config.originalCost

	gohelper.setActive(self._gooffflineTime, not self._hideOffflineTime and mo.offlineTime > 0 and StoreHelper.isHasRefreshTimeByGoodsCfg(mo.config))

	local offEndTime = mo.offlineTime - ServerTime.now()

	if offEndTime > 0 then
		if offEndTime > 3600 then
			local time, str = TimeUtil.secondToRoughTime(offEndTime)

			self._txtoffflineTime.text = formatLuaLang("remain", time .. str)
		else
			self._txtoffflineTime.text = luaLang("not_enough_one_hour")
		end
	end

	self._soldout = mo:isSoldOut()

	self:refreshNextRefreshTime(goodsConfig)
	gohelper.setActive(self._gonewtag, false)

	if mo:needShowRead() then
		local isRoomBlockPackage = self._itemType == MaterialEnum.MaterialType.BlockPackage
		local isRoomBuilding = self._itemType == MaterialEnum.MaterialType.Building

		if not isRoomBlockPackage and not isRoomBuilding then
			gohelper.setActive(self._gonewtag, mo:needShowRead())
		end
	end

	local maxBuyCount = goodsConfig.maxBuyCount
	local remain = maxBuyCount - mo.buyCount
	local content = StoreConfig.instance:getRemain(goodsConfig, remain, mo.offlineTime)

	if string.nilorempty(content) then
		gohelper.setActive(self._txtremain.gameObject, false)
	else
		gohelper.setActive(self._txtremain.gameObject, true)

		self._txtremain.text = content
	end

	self._hascloth = mo:alreadyHas()

	gohelper.setActive(self._gohas, false)
	gohelper.setActive(self._gosoldout, false)
	gohelper.setActive(self._btnPath.gameObject, not self._hascloth)

	if self._hascloth then
		if self:_isAlreadyHasIgnoreType(config.subType) and remain > 0 then
			gohelper.setActive(self._gohas, false)
		else
			gohelper.setActive(self._gohas, true)
		end
	elseif self._soldout then
		gohelper.setActive(self._gosoldout, true)
		gohelper.setActive(self._goherofull, false)
	end

	self:refreshGoUnique()
	self:refreshLimitHas()
end

function NormalStoreGoodsItem:updateGoodsItemAttribute(goodsConfig)
	local product = goodsConfig.product
	local productInfoArr = GameUtil.splitString2(product, true)
	local productInfo = productInfoArr[1]

	self._itemType = productInfo[1]
	self._itemId = productInfo[2]
	self._itemQuantity = productInfo[3]
	self.itemConfig, self.itemIcon = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId, true)
end

function NormalStoreGoodsItem:refreshNextRefreshTime(goodsConfig)
	if self._soldout then
		local isShow = not StoreHelper.isHasRefreshTimeByGoodsCfg(goodsConfig)

		gohelper.setActive(self._goRefreshTime, self._soldout)

		if self._soldout then
			local remainRefreshTime = StoreHelper.getEndTimeStampByGoodsCfgMO(goodsConfig, self._mo) - ServerTime.now()

			if remainRefreshTime > 0 then
				gohelper.setActive(self._goRefreshTime, true)

				if remainRefreshTime > TimeUtil.OneHourSecond then
					local time, str = TimeUtil.secondToRoughTime(remainRefreshTime)

					self._txtRefreshTime.text = formatLuaLang("refresh_remain_time", time .. str)
				else
					self._txtRefreshTime.text = luaLang("not_enough_one_hour")
				end
			end
		end
	end
end

function NormalStoreGoodsItem:refreshLimitHas()
	if self._itemType == MaterialEnum.MaterialType.Equip and not self._soldout then
		self._limitSold = EquipModel.instance:isLimitAndAlreadyHas(self._itemId)

		gohelper.setActive(self._golevellimit, self._limitSold)

		self._txtlvlimit.text = string.format(luaLang("reachUpperLimit"))
	else
		self._limitSold = false
	end
end

function NormalStoreGoodsItem:refreshActGoods()
	self._soldout = false
	self._limitSold = false
	self._hascloth = false

	local mo = self._mo
	local belongStoreId = mo:getBelongStoreId()
	local actGoodsId = self._mo:getActGoodsId()

	gohelper.setActive(self._goitemreddot, false)
	gohelper.setActive(self._golevellimit, false)

	local isGreatActGoods = mo:getIsGreatActGoods()

	gohelper.setActive(self._goActBgEff, isGreatActGoods)
	self:updateActGoodsItemAttribute(belongStoreId, actGoodsId)

	local itemConfig = ItemModel.instance:getItemConfig(self._itemType, self._itemId)

	if itemConfig then
		self._txtgoodsName.text = itemConfig.name or ""
	end

	self:_refreshGoods()

	local costId = FurnaceTreasureModel.instance:getCostItem(belongStoreId)

	if not costId then
		self._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(self._imagematerial.gameObject, false)
	else
		local costType = MaterialEnum.MaterialType.Currency
		local strCost = FurnaceTreasureConfig.instance:get147GoodsCost(actGoodsId)

		if string.nilorempty(strCost) then
			self._costQuantity = 0
		else
			local costInfo = string.splitToNumber(strCost, "#")

			self._costQuantity = costInfo[1]
		end

		local costConfig = ItemModel.instance:getItemConfigAndIcon(costType, costId)
		local iconId = costConfig.icon
		local iconStr = string.format("%s_1", iconId)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerial, iconStr)
		gohelper.setActive(self._imagematerial.gameObject, true)

		self._txtmaterialNum.text = self._costQuantity
	end

	gohelper.setActive(self._txtCost2Num.gameObject, false)

	self._txtmaterialNum.fontSize = 36
	self._txtCost2Num.fontSize = 36

	gohelper.setActive(self._godiscount, false)
	gohelper.setActive(self._txtoriginalCost.gameObject, false)
	gohelper.setActive(self._gooffflineTime, false)
	gohelper.setActive(self._goRefreshTime, false)
	gohelper.setActive(self._gonewtag, false)

	local goodsRemainBuyCount = FurnaceTreasureModel.instance:getGoodsRemainCount(belongStoreId, actGoodsId)

	self._txtremain.text = string.format("%s:%d", luaLang("store_buylimit_day"), goodsRemainBuyCount)

	gohelper.setActive(self._txtremain.gameObject, true)
	gohelper.setActive(self._gohas, false)
	gohelper.setActive(self._gosoldout, false)
	gohelper.setActive(self._goherofull, false)
	self:refreshGoUnique()
end

function NormalStoreGoodsItem:updateActGoodsItemAttribute(storeId, actGoodsId)
	local poolId = FurnaceTreasureModel.instance:getGoodsPoolId(storeId, actGoodsId)

	self._itemType, self._itemId, self._itemQuantity = FurnaceTreasureConfig.instance:getAct147GoodsShowItem(poolId)
	self.itemConfig, self.itemIcon = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId, true)
end

local HideRoomActiveStoreType = {
	StoreEnum.StoreId.CritterStore
}

function NormalStoreGoodsItem:_refreshGoods(goodsConfig)
	local function iconLoadcb(width, height)
		recthelper.setSize(self._imgicon.transform, width, height)
	end

	local _equipwidth = 278
	local _equipheight = 228
	local _iconwidth = 256
	local _iconheight = 256
	local isNilItemIcon = false

	if self._itemType == MaterialEnum.MaterialType.Equip then
		self._goicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(self.itemConfig.icon), iconLoadcb(_equipwidth, _equipheight))
	elseif not string.nilorempty(self.itemIcon) then
		self._goicon:LoadImage(self.itemIcon, iconLoadcb(_iconwidth, _iconheight))
	else
		isNilItemIcon = true
	end

	local isRoomBlockPackage = self._itemType == MaterialEnum.MaterialType.BlockPackage
	local isRoomBuilding = self._itemType == MaterialEnum.MaterialType.Building

	gohelper.setActive(self._goicon.gameObject, not isRoomBlockPackage and not isRoomBuilding and not isNilItemIcon)
	gohelper.setActive(self._goroomactive, not LuaUtil.tableContains(HideRoomActiveStoreType, self._mo.belongStoreId) and (isRoomBlockPackage or isRoomBuilding))
	gohelper.setActive(self._goroomticket, self:checkShowTicket() and not self._soldout)
	self:refreshRoomItemUI(isRoomBlockPackage, isRoomBuilding)

	if isRoomBlockPackage or isRoomBuilding then
		UISpriteSetMgr.instance:setRoomSprite(self._simageroomactiveicon, "jianshezhi")
	end

	local roomnum = 0
	local product = goodsConfig and goodsConfig.product

	if not string.nilorempty(product) then
		local productInfoArr = GameUtil.splitString2(product, true)

		for _, v in ipairs(productInfoArr) do
			if v[1] == MaterialEnum.MaterialType.BlockPackage then
				roomnum = roomnum + RoomConfig.instance:getBlockPackageFullDegree(v[2]) * v[3]
			elseif v[1] == MaterialEnum.MaterialType.Building then
				local roomBuildingConfig = RoomConfig.instance:getBuildingConfig(v[2])

				roomnum = roomnum + roomBuildingConfig.buildDegree * v[3]
			end
		end
	end

	self._txtroomnum.text = roomnum

	self:showStackableNum()
	self:_checkHeroFullDuplicateCount()
	self:refreshRare()
end

function NormalStoreGoodsItem:refreshRare()
	local isShowRare = false

	if self._mo:getIsActGoods() then
		UISpriteSetMgr.instance:setStoreGoodsSprite(self._rare, FurnaceTreasureEnum.RareBgName)

		isShowRare = true
	elseif self.itemConfig then
		UISpriteSetMgr.instance:setStoreGoodsSprite(self._rare, "rare" .. self.itemConfig.rare)

		isShowRare = true
	end

	gohelper.setActive(self._rare.gameObject, isShowRare)
end

function NormalStoreGoodsItem:refreshRoomItemUI(isRoomBlockPackage, isRoomBuilding)
	gohelper.setActive(self._goroomiconmask, isRoomBlockPackage or isRoomBuilding)

	if isRoomBlockPackage or isRoomBuilding then
		self._simageroomicon:LoadImage((string.nilorempty(self._mo.config.bigImg) or nil) and self.itemIcon, function()
			self._simageroomicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
		end)
	end
end

function NormalStoreGoodsItem:showStackableNum()
	if not self.itemConfig then
		gohelper.setActive(self._gonum.gameObject, false)

		return
	end

	if (not self.itemConfig.isStackable or self.itemConfig.isStackable == 1 or self._itemType == MaterialEnum.MaterialType.Equip) and self._itemQuantity > 1 then
		gohelper.setActive(self._gonum.gameObject, true)

		self._gonumText.text = GameUtil.numberDisplay(self._itemQuantity)
	else
		gohelper.setActive(self._gonum.gameObject, false)
	end
end

function NormalStoreGoodsItem:_checkHeroFullDuplicateCount()
	gohelper.setActive(self._goherofull, (self._itemType == MaterialEnum.MaterialType.Hero or nil) and CharacterModel.instance:isHeroFullDuplicateCount(self._itemId))
end

function NormalStoreGoodsItem:refreshGoUnique()
	gohelper.setActive(self._goLimit, ItemConfig.instance:isUniqueByCo(self._itemType, self.itemConfig))
end

function NormalStoreGoodsItem:checkShowTicket()
	if self._mo.belongStoreId == StoreEnum.StoreId.OldRoomStore or self._mo.belongStoreId == StoreEnum.StoreId.NewRoomStore then
		if self._itemType ~= MaterialEnum.MaterialType.BlockPackage and self._itemType ~= MaterialEnum.MaterialType.Building then
			return false
		end

		if self._mo:getIsJumpGoods() then
			return false
		end

		if self.itemConfig.rare <= 3 then
			if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 or ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
				return true
			end
		elseif self.itemConfig.rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return true
		end
	end

	return false
end

function NormalStoreGoodsItem:_onRefreshNew(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	gohelper.setActive(self._gonewtag, false)
end

function NormalStoreGoodsItem:onDestroy()
	if self._goicon then
		self._goicon:UnLoadImage()

		self._goicon = nil
	end

	self._simageroomicon:UnLoadImage()
	self._btn:RemoveClickListener()
	self._btnPath:RemoveClickListener()
end

return NormalStoreGoodsItem
