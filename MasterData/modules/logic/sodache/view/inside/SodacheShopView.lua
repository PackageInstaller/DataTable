-- chunkname: @modules/logic/sodache/view/inside/SodacheShopView.lua

module("modules.logic.sodache.view.inside.SodacheShopView", package.seeall)

local SodacheShopView = class("SodacheShopView", BaseView)

function SodacheShopView:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "Left/#go_Normal")
	self._scrollShop = gohelper.findChild(self.viewGO, "Left/#go_Normal/#scroll_Shop")
	self._btnBlackMarket = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Normal/BtnGroup/#btn_BlackMarket")
	self._gobtntype = gohelper.findChild(self.viewGO, "Left/#go_Normal/BtnGroup/bg/#btn_card")
	self._btnMultiSelect = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Normal/BtnGroup/#btn_MultiSelect")
	self._goMultiSelect = gohelper.findChild(self.viewGO, "Left/#go_Normal/BtnGroup/#btn_MultiSelect/#go_MultiSelect")
	self._goUnMultiSelect = gohelper.findChild(self.viewGO, "Left/#go_Normal/BtnGroup/#btn_MultiSelect/normal")
	self._goBlackMarket = gohelper.findChild(self.viewGO, "Left/#go_BlackMarket")
	self._btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_BlackMarket/#btn_Shop")
	self._goblackshopitem = gohelper.findChild(self.viewGO, "Left/#go_BlackMarket/#scroll_BlackMarket/Viewport/Content/#go_CardpackItem")
	self._txtchat = gohelper.findChildTextMesh(self.viewGO, "Left/#go_BlackMarket/chat/#scroll_Chat/Viewport/Content/#txt_Chat")
	self._goSingleCard = gohelper.findChild(self.viewGO, "Right/#go_SingleCard")
	self._scrollMultiCard = gohelper.findChild(self.viewGO, "Right/#scroll_MultiCard")
	self._txtBuyCost = gohelper.findChildText(self.viewGO, "Right/bottom/#btn_Buy/#go_Cost/#txt_BuyCost")
	self._imageCostIcon = gohelper.findChildImage(self.viewGO, "Right/bottom/#btn_Buy/#go_Cost/costicon/image_icon")
	self._goCount = gohelper.findChild(self.viewGO, "Right/bottom/#go_Count")
	self._inputCount = gohelper.findChildTextMeshInputField(self.viewGO, "Right/bottom/#go_Count/valuebg/#input_Count")
	self._btnMin = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#go_Count/#btn_Min")
	self._btnSub = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#go_Count/#btn_Sub")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#go_Count/#btn_Add")
	self._btnMax = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#go_Count/#btn_Max")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#btn_Buy")
	self._gocoin = gohelper.findChild(self.viewGO, "#go_topright/currencyview")
	self._goempty = gohelper.findChild(self.viewGO, "Right/#go_empty")
	self._btnbag = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Normal/BtnGroup/#btn_bag")
	self._chessAnim = gohelper.findChildAnim(self.viewGO, "Left/#go_BlackMarket/chess")
	self._goshopitem = gohelper.findChild(self.viewGO, "Left/#go_Normal/#scroll_Shop/Viewport/Content/ShopItem")
	self._gosubtypeitem = gohelper.findChild(self.viewGO, "Left/#go_Normal/#scroll_Shop/Viewport/Content/Grid")
	self._viewAnim = gohelper.findComponentAnim(self.viewGO)
	self._leftAnim = gohelper.findChildAnim(self.viewGO, "Left/#go_Normal")
	self._rightAnim = gohelper.findChildAnim(self.viewGO, "Right/#go_SingleCard")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheShopView:addEvents()
	self._btnBlackMarket:AddClickListener(self._onClickBlackShop, self)
	self._btnMultiSelect:AddClickListener(self._btnMultiSelectOnClick, self)
	self._btnShop:AddClickListener(self._onClickShop, self)
	self._btnMin:AddClickListener(self._btnMinOnClick, self)
	self._btnSub:AddClickListener(self._btnSubOnClick, self)
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self._btnMax:AddClickListener(self._btnMaxOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self._btnbag:AddClickListener(self._btnbagOnClick, self)
	self._inputCount:AddOnEndEdit(self._onInputChange, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnClickGoodsItem, self.refreshRightInfo, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnShopItemUpdate, self.refreshShopInfo, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnBagUpdate, self.refreshPrice, self)
end

function SodacheShopView:removeEvents()
	self._btnBlackMarket:RemoveClickListener()
	self._btnMultiSelect:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnMin:RemoveClickListener()
	self._btnSub:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnMax:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnbag:RemoveClickListener()
	self._inputCount:RemoveOnEndEdit()
end

function SodacheShopView:refreshShopInfo()
	if self.shopType == SodacheEnum.ShopType.Normal then
		self:_onItemTypeClick(self._curItemType, true)
	else
		for i = #self.selectMo.curSelectGoods, 1, -1 do
			local mo = self.selectMo.curSelectGoods[i]

			if mo.shopMo.count == 0 then
				table.remove(self.selectMo.curSelectGoods, i)
			elseif mo.shopMo.count ~= -1 and mo.shopMo.count < mo.selectCount then
				mo.selectCount = mo.shopMo.count
			end
		end

		self:_refreshBlackMarketItems(true)
		UIBlockHelper.instance:startBlock("SodacheShopView_Refresh", 1)

		self.viewParam[SodacheEnum.ShopType.BlackMarket] = nil

		gohelper.setActive(self._btnBlackMarket, false)
		TaskDispatcher.runDelay(self._onClickShop, self, 1)
	end
end

function SodacheShopView:_btnBlackMarketOnClick()
	self.shopType = SodacheEnum.ShopType.BlackMarket

	self.selectMo:clearAllGoodSelect()

	self.selectMo.isMultSelect = false

	self:_refreshView()
	self:_refreshBlackMarketItems()
	self:playBlackMarketChar(SodacheEnum.ShopChatTriggerType.OpenBlackMarket)
end

function SodacheShopView:_refreshBlackMarketItems(isUpdate)
	if not isUpdate then
		table.sort(self.curShopUnitMo.shop.items, SodacheShopView.sortGoods)
	end

	gohelper.CreateObjList(self, self._onCreateBlackShopItem, self.curShopUnitMo.shop.items, nil, self._goblackshopitem, SodacheBlackMarketShopItem)
	self:refreshRightInfo()
end

function SodacheShopView:playBlackMarketChar(type)
	local co = SodacheConfig.instance:getShopChatRandomCo(type)

	if not co then
		return
	end

	self._txtchat.text = ""
	self._nowIndex = 0
	self._txtArr = GameUtil.getUCharArrWithoutRichTxt(co[1].content)

	self._chessAnim:Play("jump")
	TaskDispatcher.runRepeat(self._tickPlayChat, self, 0.06)
end

function SodacheShopView:_tickPlayChat()
	if self._nowIndex >= #self._txtArr then
		self._chessAnim:Play("idle")
		TaskDispatcher.cancelTask(self._tickPlayChat, self)

		return
	end

	self._nowIndex = self._nowIndex + 1
	self._txtchat.text = table.concat(self._txtArr, "", 1, self._nowIndex)
end

function SodacheShopView:_onCreateBlackShopItem(obj, data, index)
	obj:setCellParam(self.selectMo)
	obj:updateMo(data)
end

function SodacheShopView:_refreshView()
	self.curShopUnitMo = self.viewParam[self.shopType]

	gohelper.setActive(self._goNormal, self.shopType == SodacheEnum.ShopType.Normal)
	gohelper.setActive(self._goBlackMarket, self.shopType == SodacheEnum.ShopType.BlackMarket)
	gohelper.setActive(self._goCount, false)
	gohelper.setActive(self._goSingleCard, false)
	gohelper.setActive(self._scrollMultiCard, self.shopType == SodacheEnum.ShopType.BlackMarket or self.selectMo.isMultSelect)
	gohelper.setActive(self._goMultiSelect, self.selectMo.isMultSelect)
	gohelper.setActive(self._goUnMultiSelect, not self.selectMo.isMultSelect)
end

function SodacheShopView:_btnMultiSelectOnClick()
	self.selectMo.isMultSelect = not self.selectMo.isMultSelect

	self:_refreshView()
	self:_onItemTypeClick()
end

function SodacheShopView:_onClickShop()
	self._viewAnim.enabled = true

	self._viewAnim:Play("switch", 0, 0)
	UIBlockHelper.instance:startBlock("SodacheShopView_Shop_Switch", 0.1667)
	TaskDispatcher.runDelay(self._btnShopOnClick, self, 0.1667)
end

function SodacheShopView:_onClickBlackShop()
	self._viewAnim.enabled = true

	self._viewAnim:Play("switch", 0, 0)
	UIBlockHelper.instance:startBlock("SodacheShopView_Shop_Switch", 0.1667)
	TaskDispatcher.runDelay(self._btnBlackMarketOnClick, self, 0.1667)
end

function SodacheShopView:_btnShopOnClick()
	TaskDispatcher.cancelTask(self._tickPlayChat, self)

	self.shopType = SodacheEnum.ShopType.Normal
	self.selectMo.isMultSelect = false

	self:_refreshView()

	if self._curItemType then
		self:_onItemTypeClick()
	end
end

function SodacheShopView:_btnbagOnClick()
	ViewMgr.instance:openView(ViewName.SodacheStatusView)
end

function SodacheShopView:_btnMinOnClick()
	self.selectMo:setCurGoodMin()
	self:refreshRightInfo()
end

function SodacheShopView:_btnSubOnClick()
	self.selectMo:addCurGoodCount(-1)
	self:refreshRightInfo()
end

function SodacheShopView:_btnAddOnClick()
	local fixrate = self:getFixRate()
	local price = math.floor(self.selectMo.curSelectGoods[1].shopMo.price * (1 + fixrate / 1000))

	if SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin, SodacheEnum.BagType.Inside) < price + self.allPrice then
		return
	end

	self.selectMo:addCurGoodCount(1)
	self:refreshRightInfo()
end

function SodacheShopView:_btnMaxOnClick()
	local fixrate = self:getFixRate()
	local price = math.floor(self.selectMo.curSelectGoods[1].shopMo.price * (1 + fixrate / 1000))
	local canBuyCount = math.floor(SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin, SodacheEnum.BagType.Inside) / price)

	canBuyCount = math.max(canBuyCount, 1)

	self.selectMo:addCurGoodCount(canBuyCount - self.selectMo:getGoodSelectCount())
	self:refreshRightInfo()
end

function SodacheShopView:_onInputChange()
	local count = tonumber(self._inputCount:GetText()) or 0
	local curCount = self.selectMo:getGoodSelectCount()

	if count == curCount then
		return
	end

	self.selectMo:addCurGoodCount(count - curCount)
	self:refreshRightInfo()
end

function SodacheShopView:_btnBuyOnClick()
	local nowCoin = SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin, SodacheEnum.BagType.Inside)

	if nowCoin < self.allPrice then
		GameFacade.showToast(ToastEnum.SodacheToastId373001, SodacheUtil.getCurrencyName())

		return
	end

	if #self.selectMo.curSelectGoods <= 0 then
		return
	end

	local shopItems = {}

	for i, v in ipairs(self.selectMo.curSelectGoods) do
		table.insert(shopItems, {
			id = v.shopMo.id,
			count = v.selectCount
		})
	end

	SodacheInsideRpc.instance:sendSodacheInsideBatchBuy(self.curShopUnitMo.uid, shopItems)
	AudioMgr.instance:trigger(AudioEnum3_7.Sodache.shop_buy)
end

function SodacheShopView:_editableInitView()
	UISpriteSetMgr.instance:setSodache2Sprite(self._imageCostIcon, SodacheUtil.getCurrencyIcon())
	MonoHelper.addNoUpdateLuaComOnceToGo(self._gocoin, SodacheCurrencyComp, {
		bagType = SodacheEnum.BagType.Inside
	})

	self.selectMo = SodacheShopSelectMo.New()
	self.cardInfoComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goSingleCard, SodacheCardInfoRight, SodacheCardInfoRight.ShowType.Shop)
	self.simpleListMult = MonoHelper.addNoUpdateLuaComOnceToGo(self._scrollMultiCard, SurvivalSimpleListPart)

	self.simpleListMult:setCellCls(SodacheShopMultiCardItem)
	self.simpleListMult:setCellParam(self.selectMo)

	self.shopType = SodacheEnum.ShopType.Normal
	self.allPrice = 0
end

local showTypes = {
	SodacheEnum.CardType.Ammo,
	SodacheEnum.CardType.Adventure
}

function SodacheShopView:onOpen()
	gohelper.setActive(self._goshopitem, false)
	gohelper.setActive(self._gosubtypeitem, false)

	self._shopitempool = {}
	self._subtypepool = {}
	self._usedshopitems = {}
	self._usedsubtypes = {}

	self:_btnShopOnClick()

	local types = {}

	for k, v in ipairs(showTypes) do
		if self.curShopUnitMo.shop.itemsByItemTypes[v] then
			table.insert(types, v)
		end
	end

	self._btns = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onCreateItemTypeBtn, types, nil, self._gobtntype)
	self:_onItemTypeClick(types[1])
	gohelper.setActive(self._btnBlackMarket, self.viewParam[SodacheEnum.ShopType.BlackMarket])

	if self.viewParam[SodacheEnum.ShopType.BlackMarket] then
		self:_btnBlackMarketOnClick()
	end
end

function SodacheShopView:_onCreateItemTypeBtn(obj, data, index)
	local btn = gohelper.findButtonWithAudio(obj)
	local name = gohelper.findChildTextMesh(obj, "#txt_name")
	local name2 = gohelper.findChildTextMesh(obj, "#go_Select/#txt_name")
	local goselect = gohelper.findChild(obj, "#go_Select")
	local imageType = gohelper.findChildImage(obj, "#txt_name/icon")
	local imageType2 = gohelper.findChildImage(obj, "#go_Select/#txt_name/icon")

	name.text = luaLang("sodache_cardtype_" .. data)
	name2.text = luaLang("sodache_cardtype_" .. data)

	UISpriteSetMgr.instance:setSodache2Sprite(imageType, "sodache_handbook_icon_" .. tostring(data))
	UISpriteSetMgr.instance:setSodache2Sprite(imageType2, "sodache_handbook_icon_" .. tostring(data))

	self._btns[data] = goselect

	self.addClickCb(self, btn, self.switchType, self, data)
end

function SodacheShopView:switchType(type)
	if self._curItemType == type then
		return
	end

	self._curItemType = type

	for k, v in pairs(self._btns) do
		gohelper.setActive(v, k == type)
	end

	self._leftAnim:Play("refresh", 0, 0)
	self._rightAnim:Play("refresh", 0, 0)
	UIBlockHelper.instance:startBlock("SodacheShopView_Shop_Switch", 0.1667)
	TaskDispatcher.runDelay(self._onItemTypeClick, self, 0.1667)
end

function SodacheShopView:_onItemTypeClick(type, isUpdate)
	type = type or self._curItemType

	for k, v in pairs(self._btns) do
		gohelper.setActive(v, k == type)
	end

	self._curItemType = type

	if type then
		if isUpdate and not self.selectMo.isMultSelect then
			for i = #self.selectMo.curSelectGoods, 1, -1 do
				local mo = self.selectMo.curSelectGoods[i]

				if mo.shopMo.count == 0 then
					table.remove(self.selectMo.curSelectGoods, i)
				else
					local maxSelectCount = mo.shopMo.count == -1 and 99 or mo.shopMo.count

					if not self.selectMo.isMultSelect then
						local fixrate = self:getFixRate()
						local price = math.floor(mo.shopMo.price * (1 + fixrate / 1000))
						local canBuyCount = math.floor(SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin, SodacheEnum.BagType.Inside) / price)

						maxSelectCount = math.min(canBuyCount, maxSelectCount)
						maxSelectCount = math.max(maxSelectCount, 1)
					end

					if maxSelectCount < mo.selectCount then
						mo.selectCount = maxSelectCount
					end
				end
			end
		else
			self.selectMo:clearAllGoodSelect()
		end

		local allSubTypes = self.curShopUnitMo.shop.itemsByItemTypes[type]

		if not self.selectMo.isMultSelect and not self.selectMo.curSelectGoods[1] then
			local find = false

			for i, v in ipairs(allSubTypes) do
				for _, shopItemMo in ipairs(v) do
					if shopItemMo.count ~= 0 then
						find = true

						self.selectMo:addGoodCount(shopItemMo, 1)

						break
					end
				end

				if find then
					break
				end
			end
		end

		for i, v in ipairs(self._usedshopitems) do
			table.insert(self._shopitempool, v)
			gohelper.setParent(v, self.viewGO, false)
		end

		tabletool.clear(self._usedshopitems)

		for i, v in ipairs(allSubTypes) do
			local grid = self._usedsubtypes[i]

			if not grid then
				grid = table.remove(self._subtypepool, 1) or gohelper.cloneInPlace(self._gosubtypeitem, "Grid_" .. i)
				self._usedsubtypes[i] = grid
			end

			gohelper.setActive(grid, true)

			local titleGo = gohelper.findChild(grid, "Title")

			if v[1].itemSubType > 0 then
				gohelper.setActive(titleGo, true)

				local txtTitle = gohelper.findChildTextMesh(grid, "Title/#txt_title")

				txtTitle.text = luaLang("sodache_cardsubtype_" .. v[1].itemSubType)
			else
				gohelper.setActive(titleGo, false)
			end

			if not isUpdate then
				table.sort(v, SodacheShopView.sortGoods)
			end

			for index, shopMo in ipairs(v) do
				local itemGo = table.remove(self._shopitempool, 1)

				if not itemGo then
					itemGo = gohelper.clone(self._goshopitem, grid, "ShopItem_" .. index)

					MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, SodacheGoodsItem, self.selectMo)
				else
					gohelper.setParent(itemGo, grid, false)
				end

				table.insert(self._usedshopitems, itemGo)
				gohelper.setActive(itemGo, true)

				local item = MonoHelper.getLuaComFromGo(itemGo, SodacheGoodsItem)

				item:updateMo(shopMo)
			end
		end

		for i, v in ipairs(self._shopitempool) do
			gohelper.setActive(v, false)
		end

		local curLen = #self._usedsubtypes
		local useLen = #allSubTypes

		for i = curLen, useLen + 1, -1 do
			local grid = table.remove(self._usedsubtypes, i)

			gohelper.setActive(grid, false)
			table.insert(self._subtypepool, 1, grid)
		end

		self:refreshRightInfo()
	end
end

function SodacheShopView.sortGoods(a, b)
	if a.count == 0 ~= (b.count == 0) then
		return a.count ~= 0
	end

	return a.id < b.id
end

function SodacheShopView:refreshRightInfo()
	if self.shopType == SodacheEnum.ShopType.BlackMarket then
		self:refreshMultiCard()
	elseif self.selectMo.isMultSelect then
		self:refreshMultiCard()
	else
		local selectMo = self.selectMo.curSelectGoods[1]

		if selectMo then
			self.cardInfoComp:setData(selectMo.shopMo.items[1])
			gohelper.setActive(self._goSingleCard, true)
			gohelper.setActive(self._goCount, true)
		else
			gohelper.setActive(self._goSingleCard, false)
			gohelper.setActive(self._goCount, false)
		end
	end

	self:refreshPrice()

	local isEmpty = #self.selectMo.curSelectGoods == 0

	gohelper.setActive(self._btnBuy, not isEmpty)
	gohelper.setActive(self._goempty, isEmpty)
end

function SodacheShopView:refreshMultiCard()
	local moList = {}

	for i, v in ipairs(self.selectMo.curSelectGoods) do
		for _, vv in ipairs(v.shopMo.items) do
			table.insert(moList, {
				cardMo = vv,
				count = v.selectCount * vv.serverMo.count,
				shopMo = v.shopMo
			})
		end
	end

	self.simpleListMult:setList(moList)
end

function SodacheShopView:getFixRate()
	return self.shopType == SodacheEnum.ShopType.Normal and SodacheUtil.getAttr(SodacheEnum.AttrId.ShopItemPriceFix) or SodacheUtil.getAttr(SodacheEnum.AttrId.BlackMarketPriceFix)
end

function SodacheShopView:refreshPrice()
	local price = 0
	local fixrate = self:getFixRate()

	for i, v in ipairs(self.selectMo.curSelectGoods) do
		price = price + v.selectCount * math.floor(v.shopMo.price * (1 + fixrate / 1000))
	end

	local coinCount = SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin, SodacheEnum.BagType.Inside)

	self._txtBuyCost.text = price <= coinCount and -price or string.format("<color=#C00017>%d</color>", -price)
	self.allPrice = price

	self._inputCount:SetText(tostring(self.selectMo:getGoodSelectCount()))
end

function SodacheShopView:onClose()
	TaskDispatcher.cancelTask(self._tickPlayChat, self)
	TaskDispatcher.cancelTask(self._btnShopOnClick, self)
	TaskDispatcher.cancelTask(self._onItemTypeClick, self)
end

return SodacheShopView
