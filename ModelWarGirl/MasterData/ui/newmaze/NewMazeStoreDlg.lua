-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeStoreDlg.lua

local ResNewMaze = require("ClientData/ResNewMaze")
local ResNewMazeShop = require("ClientData/ResNewMazeShop")
local NewMazeGridCard = require("UI/NewMaze/NewMazeGridCard")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local NewMazeLosderMixin = require("UI/NewMaze/NewMazeLosderMixin")
local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local ResNewMazeHalo = require("ClientData/ResNewMazeHalo")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResColor = require("ClientData/ResColor")
local strClassName = "StoreCell"
local StoreCell = Class(strClassName, UIControls.Child)

function StoreCell:ctor()
	self.saleHeroCellList = {}
	self.saleRelicsCellList = {}
	self.saleHaloCellList = {}
	self.actObj = self.mParent.actObj
end

function StoreCell:setHeroList(heroList, index)
	self.heroList = heroList

	for i, itemData in ipairs(self.heroList or {}) do
		if self.saleHeroCellList[index] == nil then
			self.saleHeroCellList[index] = {}
		end

		local item = self.saleHeroCellList[index][i]

		if item == nil then
			item = NewMazeGridCard(self, "", "System/Rogue/BtnGridRogueCard", 0, 0, true)
		end

		item:setData(itemData, Const.NEW_MAZE_SHOP_SALE_CARD)

		self.saleHeroCellList[index][i] = item
	end

	if #self.saleHeroCellList[index] > #self.heroList then
		for i = #self.heroList + 1, #self.saleHeroCellList[index] do
			self.saleHeroCellList[index][i]:destroy()

			self.saleHeroCellList[index][i] = nil
		end
	end
end

function StoreCell:setRelicsList(relicsList, index)
	self.relicsList = relicsList

	for i, itemData in ipairs(self.relicsList or {}) do
		if self.saleRelicsCellList[index] == nil then
			self.saleRelicsCellList[index] = {}
		end

		local item = self.saleRelicsCellList[index][i]

		if item == nil then
			item = NewMazeGridCard(self, "", "System/Rogue/BtnGridRogueCard", 0, 0, true)
		end

		item:setData(itemData, Const.NEW_MAZE_SHOP_SALE_CARD)

		self.saleRelicsCellList[index][i] = item
	end

	if #self.saleRelicsCellList[index] > #self.relicsList then
		for i = #self.relicsList + 1, #self.saleRelicsCellList[index] do
			self.saleRelicsCellList[index][i]:destroy()

			self.saleRelicsCellList[index][i] = nil
		end
	end
end

function StoreCell:setHaloList(haloList, index)
	self.haloList = haloList

	for i, itemData in ipairs(self.haloList or {}) do
		if self.saleHaloCellList[index] == nil then
			self.saleHaloCellList[index] = {}
		end

		local item = self.saleHaloCellList[index][i]

		if item == nil then
			item = NewMazeGridCard(self, "", "System/Rogue/BtnGridRogueCard", 0, 0, true)
		end

		item:setData(itemData, Const.NEW_MAZE_SHOP_SALE_CARD)

		self.saleHaloCellList[index][i] = item
	end

	if #self.saleHaloCellList[index] > #self.haloList then
		for i = #self.haloList + 1, #self.saleHaloCellList[index] do
			self.saleHaloCellList[index][i]:destroy()

			self.saleHaloCellList[index][i] = nil
		end
	end
end

local strClassName = "NewMazeStoreDlg"
local NewMazeStoreDlg = Class(strClassName, UIControls.Window)

MixinClass(NewMazeStoreDlg, NewMazeLosderMixin)

function NewMazeStoreDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function NewMazeStoreDlg:initUI()
	self.textLv = UIControls.Label(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnStoreLv/TextTltile/TextLv")
	self.icon = UIControls.Image(self, "MainInfoPanel/BtnGold/Icon")
	self.textLabelOdds1 = UIControls.Label(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnStoreLv/TextLabelOdds1")
	self.textLabelOdds2 = UIControls.Label(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnStoreLv/TextLabelOdds2")
	self.textLabelOdds3 = UIControls.Label(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnStoreLv/TextLabelOdds3")
	self.btnSale = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnSale")

	self.btnSale:addEventClick(self.onBtnSaleClick)

	self.btnRefresh = UIControls.Button(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnRefresh", "TextNum")

	self.btnRefresh:addEventClick(self.onBtnRefreshClick)

	self.btnGold = UIControls.Button(self, "MainInfoPanel/BtnGold", "TextNum")

	self.btnGold:addEventClick(self.onBtnGoldClick)

	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnBuy = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnBuy")

	self.btnBuy:addEventClick(self.onBtnBuyClick)

	self.btnStoreLv = UIControls.Button(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnStoreLv")

	self.btnStoreLv:addEventClick(self.onBtnStoreLvClick)

	self.buyInfo = UIControls.Panel(self, "MainInfoPanel/BuyInfo")
	self.saleInfoPanel = UIControls.Panel(self, "MainInfoPanel/SaleInfo")
	self.saleInfo = UIControls.ScrollViewLoopV(self, "MainInfoPanel/SaleInfo/SaleInfoList")
	self.saleInfoPath = "MainInfoPanel/SaleInfo/SaleInfoList"
	self.expSlider = UIControls.Slider(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnStoreLv/Slider")
	self.textExpProgress = UIControls.Label(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnStoreLv/Slider/TextProgress")
	self.hallowPanel = UIControls.Panel(self, self.saleInfoPath .. "/Content/HallowPanel")
	self.haloPanel = UIControls.Panel(self, self.saleInfoPath .. "/Content/HaloPanel")
	self.panelStoreLvEfx = UIControls.Panel(self, "MainInfoPanel/BuyInfo/StoreInfoPanel/BtnStoreLv/Slider/Efx")
	self.curPage = 1
	self.buyItemCellList = {}
	self.storeCellHeroList = {}
	self.storeCellRelicsList = {}
	self.storeCellHaloList = {}
end

function NewMazeStoreDlg:setData(items, isRefresh)
	self.items = items
	self.isRefresh = isRefresh
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	local preShopExp = 0

	for i, store in pairs(self.newMazeData.shopTableData) do
		if store.shop_level < self.newMazeData.curShopLv then
			preShopExp = preShopExp + store.shop_up_exp
		end

		if store.shop_level == self.newMazeData.curShopLv then
			self.eventId = store.shop_id
			self.shopData = store
		end
	end

	self.refreshCost = self.newMazeData.shopRefreshCost

	self.btnRefresh:setText(self.refreshCost)
	self:refreshCoinNum()

	if self.shopData.shop_up_exp == 999 then
		if Const.REVIEW_VERSION then
			self.textLv:setText(Lang.get(1699))
		else
			self.textLv:setText("Lv.MAX")
		end

		self.expSlider:setValue(1)
		self.textExpProgress:setVisible(false)
	else
		self.expSlider:setValue((self.newMazeData.curShopExp - preShopExp) / self.shopData.shop_up_exp)
		self.textExpProgress:setText(string.format("%d/%d", self.newMazeData.curShopExp - preShopExp, self.shopData.shop_up_exp))

		if Const.REVIEW_VERSION then
			self.textLv:setText(Lang.get(1203) .. self.shopData.shop_level)
		else
			self.textLv:setText("Lv." .. self.shopData.shop_level)
		end

		self.textExpProgress:setVisible(true)
	end

	self.textLabelOdds1:setText(self.shopData.label_rate1 .. "%")
	self.textLabelOdds2:setText(self.shopData.label_rate2 .. "%")
	self.textLabelOdds3:setText(self.shopData.label_rate3 .. "%")
	self.saleInfoPanel:setVisible(self.curPage == 2)
	self.buyInfo:setVisible(self.curPage == 1)
	self.btnBuy:setEnable(self.curPage == 2)
	self.btnSale:setEnable(self.curPage == 1)
	self:refreshFettersUI()
	self:refreshBuyItem(self.items, isRefresh)
end

function NewMazeStoreDlg:refreshCoinNum()
	self.coin = self.newMazeData:getCoin()

	self.btnGold:setText(self.coin)

	if self.coin < self.refreshCost then
		self.btnRefresh:setFontColor(ResColor.RED)
	else
		self.btnRefresh:setFontColor(ResColor.WHITE)
	end
end

function NewMazeStoreDlg:refreshBuyItem(buyItemList, isRefresh)
	self.buyItemList = buyItemList or self.items

	if buyItemList then
		self.items = buyItemList
	end

	for i, itemData in ipairs(self.buyItemList or {}) do
		local item = self.buyItemCellList[i]

		if self.buyItemCellList[i] == nil then
			item = NewMazeGridCard(self, "MainInfoPanel/BuyInfo/StoreCardPanel", "System/Rogue/BtnGridRogueCard", 0, 0, true)
		end

		item:setData(itemData, Const.NEW_MAZE_SHOP_BUY_CARD, nil, isRefresh)

		self.buyItemCellList[i] = item
	end

	if #self.buyItemCellList > #self.buyItemList then
		for i = #self.buyItemList + 1, #self.buyItemCellList do
			self.buyItemCellList[i]:destroy()

			self.buyItemCellList[i] = nil
		end
	end
end

function NewMazeStoreDlg:refreshSaleItem()
	self:refreshSaleHeroItem()
	self:refreshSaleRelicsItem()
	self:refreshSaleHaloItem()
end

function NewMazeStoreDlg:refreshSaleHeroItem()
	self.saleHeroList = self.newMazeData:getSaleHeroListExceptUp()

	local storeCellNum = math.ceil(#self.saleHeroList / 3)

	for i = 1, storeCellNum do
		local cell = self.storeCellHeroList[i]

		if cell == nil then
			cell = StoreCell(self, self.saleInfoPath .. "/Content/HeroPanel/InfoPanel", "System/Rogue/RogueStoreCell", 0, 0, true)
		end

		local heroList = {}

		for j = i * 3 - 2, i * 3 do
			if self.saleHeroList[j] then
				table.insert(heroList, self.saleHeroList[j])
			end
		end

		cell:setHeroList(heroList, i)

		self.storeCellHeroList[i] = cell
	end

	if storeCellNum < #self.storeCellHeroList then
		for i = storeCellNum + 1, #self.storeCellHeroList do
			self.storeCellHeroList[i]:destroy()

			self.storeCellHeroList[i] = nil
		end
	end
end

function NewMazeStoreDlg:refreshSaleRelicsItem()
	self.saleRelicsList = self.newMazeData:getSaleRelicsListExceptUp()

	self.hallowPanel:setVisible(#self.saleRelicsList > 0)

	local storeCellNum = math.ceil(#self.saleRelicsList / 3)

	for i = 1, storeCellNum do
		local cell = self.storeCellRelicsList[i]

		if cell == nil then
			cell = StoreCell(self, self.saleInfoPath .. "/Content/HallowPanel/InfoPanel", "System/Rogue/RogueStoreCell", 0, 0, true)
		end

		local relicsList = {}

		for j = i * 3 - 2, i * 3 do
			if self.saleRelicsList[j] then
				table.insert(relicsList, self.saleRelicsList[j])
			end
		end

		cell:setRelicsList(relicsList, i)

		self.storeCellRelicsList[i] = cell
	end

	if storeCellNum < #self.storeCellRelicsList then
		for i = storeCellNum + 1, #self.storeCellRelicsList do
			self.storeCellRelicsList[i]:destroy()

			self.storeCellRelicsList[i] = nil
		end
	end
end

function NewMazeStoreDlg:refreshSaleHaloItem()
	self.saleHaloList = self.newMazeData:getAllHaloList()

	self.haloPanel:setVisible(#self.saleHaloList > 0)

	local storeCellNum = math.ceil(#self.saleHaloList / 3)

	for i = 1, storeCellNum do
		local cell = self.storeCellHaloList[i]

		if cell == nil then
			cell = StoreCell(self, self.saleInfoPath .. "/Content/HaloPanel/InfoPanel", "System/Rogue/RogueStoreCell", 0, 0, true)
		end

		local haloList = {}

		for j = i * 3 - 2, i * 3 do
			if self.saleHaloList[j] then
				table.insert(haloList, self.saleHaloList[j])
			end
		end

		cell:setHaloList(haloList, i)

		self.storeCellHaloList[i] = cell
	end

	if storeCellNum < #self.storeCellHaloList then
		for i = storeCellNum + 1, #self.storeCellHaloList do
			self.storeCellHaloList[i]:destroy()

			self.storeCellHaloList[i] = nil
		end
	end
end

function NewMazeStoreDlg:flyImageToUI()
	local iconPath = "Atlas/CommonAtlas/IconAtlas/MazeBuffAtlas/03"
	local iconName = "4031"
	local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

	if mainDlg and self.curChooseItem then
		local targetUI

		if self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
			targetUI = mainDlg.btnHero

			local hero = BaseObject.GetObject(self.curChooseItem.id)
			local iconHeroPath = hero:getIconPath()

			iconPath = iconHeroPath[1]
			iconName = iconHeroPath[2]
		elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic then
			targetUI = mainDlg.btnHallow
			iconPath = ResNewMazeRelic[self.curChooseItem.id].icon_path
			iconName = ResNewMazeRelic[self.curChooseItem.id].icon_name
		elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo then
			targetUI = mainDlg.btnHalo
			iconPath = ResNewMazeHalo[self.curChooseItem.id].icon_path
			iconName = ResNewMazeHalo[self.curChooseItem.id].icon_name
		else
			if self.curChooseItem.iconPath then
				iconPath = self.curChooseItem.iconPath[1]
				iconName = self.curChooseItem.iconPath[2]
			end

			if self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Buff then
				targetUI = mainDlg.panelBuff
			elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Potion then
				targetUI = mainDlg.btnHalo
			elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.RedHeart then
				targetUI = mainDlg.btnBlood
			elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.ShopExp then
				self.panelStoreLvEfx:setVisible(false)
				self.panelStoreLvEfx:setVisible(true)

				return
			elseif self.curChooseItem.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Solder then
				targetUI = mainDlg.btnHero
			end
		end

		local originUI

		for i, itemData in ipairs(self.buyItemList or {}) do
			if self.curChooseItem.type == itemData.type and self.curChooseItem.id == itemData.id then
				originUI = self.buyItemCellList[i]
			end
		end

		FlyIconUtils.setFlyImagetoUI(originUI, targetUI, iconPath, iconName, 1)
	end
end

function NewMazeStoreDlg:flyCoinImageToUI()
	local iconPath = "Atlas/CommonAtlas/IconAtlas/MazeBuffAtlas/03"
	local iconName = "4031"
	local originUI = self.btnGold
	local targetUI = self.btnGold

	FlyIconUtils.setFlyImagetoUI(originUI, targetUI, iconPath, iconName, 1)
end

function NewMazeStoreDlg:onBtnBuyClick()
	self.curPage = 1

	self.saleInfoPanel:setVisible(false)
	self.buyInfo:setVisible(true)
	self.btnBuy:setEnable(false)
	self.btnSale:setEnable(true)

	for i, cell in ipairs(self.buyItemCellList or {}) do
		cell:setData(self.buyItemList[i], Const.NEW_MAZE_SHOP_BUY_CARD)
	end
end

function NewMazeStoreDlg:onBtnSaleClick()
	self.curPage = 2

	self:refreshSaleItem()
	self.saleInfoPanel:setVisible(true)
	self.buyInfo:setVisible(false)
	self.btnBuy:setEnable(true)
	self.btnSale:setEnable(false)
end

function NewMazeStoreDlg:onBtnRefreshClick()
	if self.newMazeData.coin < self.refreshCost then
		MsgManager.notice(ResNewMazeDisplay[13060014].desc)

		return
	end

	RPC.newMazeShopRefresh(self.actObj.opId)
end

function NewMazeStoreDlg:onBtnGoldClick()
	local itemId = self.newMazeData.miscData.coin_item_id
	local fakeItem = BaseObject.GetObject(itemId)

	UIManager.getUI("itemTips"):showObj(self, fakeItem)
end

function NewMazeStoreDlg:onBtnCloseClick()
	local function yesFunc()
		RPC.newMazeLayerNextReq(self.actObj.opId)
		self:setVisible(false)
	end

	local content = ResNewMazeDisplay[13060037].desc

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc)
end

function NewMazeStoreDlg:onBtnStoreLvClick()
	local storeLvDlg = UIManager.getUI("newMazeStoreLvDlg", true)

	storeLvDlg:setData(self.newMazeData.shopTableData, self.newMazeData.curShopLv)
end

return NewMazeStoreDlg
