-- chunkname: @IQIGame\\UI\\MazeShopUI.lua

local MazeShopUI = Base:Extend("MazeShopUI", "IQIGame.Onigao.UI.MazeShopUI", {
	itemCellDic = {}
})
local MazeShopItemCell = require("IQIGame.UI.Shop.MazeShopItemCell")
local NPCActionView = require("IQIGame.UI.NPCAction.NPCActionView")

function MazeShopUI:OnInit()
	self:Initialize()
end

function MazeShopUI:GetPreloadAssetPaths()
	return nil
end

function MazeShopUI:GetOpenPreloadAssetPaths(userData)
	local ret = {}

	self.shopIds = {
		userData
	}
	self.npcGroupId = CfgShopTable[self.shopIds[1]].npcGroupId

	local cfgActionData = NPCActionModule.GetAction(self.npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)

	self.npcPath = UIGlobalApi.GetPrefabRoot(cfgActionData.NPC)
	self.bgPath = UIGlobalApi.ImagePath .. "/" .. cfgActionData.Background
	ret[#ret + 1] = self.npcPath
	ret[#ret + 1] = self.bgPath

	return ret
end

function MazeShopUI:OnOpen(userData)
	self:Refresh(userData)
end

function MazeShopUI:OnClose(userData)
	self:OnHide()
end

function MazeShopUI:OnPause()
	return
end

function MazeShopUI:OnResume()
	return
end

function MazeShopUI:OnCover()
	return
end

function MazeShopUI:OnReveal()
	return
end

function MazeShopUI:OnRefocus(userData)
	return
end

function MazeShopUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.curShopData ~= nil then
		local countDownTime = self.curShopData.nextRefreshTime - PlayerModule.GetServerTime()

		self.goCountDownTime:SetActive(countDownTime >= 0)

		if countDownTime >= 0 then
			self.tfCountDownTime.text = ShopUIApi:GetString("goRefreshTime", countDownTime)
		end
	end

	if self.npcView ~= nil then
		self.npcView:Update(elapseSeconds, realElapseSeconds)
	end
end

function MazeShopUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeShopUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeShopUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeShopUI:Initialize()
	self.moneyCellBuilder = MoneyCellsBuilder.New(self.goMoneyParent)
	self.npcView = NPCActionView.New(self.goNpcView)
	self.costIcon = self.goPayRefreshBlock.transform:Find("Image_02"):GetComponent("Image")
	self.tfCostNum = self.goPayRefreshBlock.transform:Find("Text_02"):GetComponent("Text")
	self.tfCountDownTime = self.goCountDownTime:GetComponent("Text")
	self.tfShopName = self.goBtnClose.transform:Find("Text"):GetComponent("Text")
	self.imgBg = self.goBg:GetComponent("Image")
	self.btnRefresh = self.goBtnRefresh:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnRefreshDelegate()
		self:OnClickBtnRefresh()
	end

	function self.onRefreshShopDelegate(shopId)
		self:OnRefreshShop(shopId)
	end

	function self.onBuySuccessDelegate(shopId)
		self:OnBuySuccess(shopId)
	end

	self.tabList = self.goTabList:GetComponent("ScrollAreaList")

	function self.tabList.onRenderCell(cell)
		self:OnRenderTab(cell)
	end

	function self.tabList.onSelectedCell(cell)
		self:OnSelectTab(cell)
	end

	self.itemList = self.goItemList:GetComponent("ScrollAreaList")

	function self.itemList.onRenderCell(cell)
		self:OnRenderItemCll(cell)
	end

	function self.itemList.onSelectedCell(cell)
		self:OnSelectItemCell(cell)
	end

	self.goMoneyOver.transform:Find("Text_02"):GetComponent("Text").text = ShopUIApi:GetString("MoneyOverLabTxt")
	self.goMoneyFree.transform:Find("Text_02"):GetComponent("Text").text = ShopUIApi:GetString("MoneyFreeTxt")
	self.goPayRefreshBlock.transform:Find("Text_01"):GetComponent("Text").text = ShopUIApi:GetString("RefreshCostTitleTxt")
	self.goBtnRefresh.transform:Find("Text"):GetComponent("Text").text = ShopUIApi:GetString("goBtnRefreshTxt")

	UGUIUtil.SetText(self.goRefreshTimeDesc, ShopUIApi:GetString("goRefreshTimeDesc"))
end

function MazeShopUI:Refresh(userData)
	self.hasRefreshed = false

	self:RefreshMisc()
	self:RefreshTabs()
	self:RefreshNpc()

	self.hasRefreshed = true
end

function MazeShopUI:OnDestroy()
	self.moneyCellBuilder:Dispose()
	self.npcView:OnDestroy()

	for i, v in pairs(self.itemCellDic) do
		v:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
end

function MazeShopUI:OnHide()
	self.npcView:OnHide()
end

function MazeShopUI:RefreshMisc()
	self.tfShopName.text = ShopUIApi:GetString("ShopNameTxt", self.curShopData.Name)
end

function MazeShopUI:RefreshTabs()
	self.tabList:Refresh(#self.shopIds)
end

function MazeShopUI:RefreshNpc()
	local cfgActionData = NPCActionModule.GetAction(self.npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)
	local pos = cfgActionData.Position
	local scale = cfgActionData.Scale
	local talkOffset = cfgActionData.TalkPosition
	local goNpc = UnityEngine.GameObject.Instantiate(self.UIController:GetPreloadedAsset(self.npcPath))

	self.npcView:Refresh(cfgActionData, goNpc, self.npcPath, self.goNpcRoot.transform, pos, scale, talkOffset)

	if self.bgPath ~= nil then
		local asset = self.UIController:GetPreloadedAsset(self.bgPath)

		self.imgBg.sprite = LuaCodeInterface.ToSprite(asset)
	end
end

function MazeShopUI:ShowTab(index)
	self.curTabIndex = index
	self.curShopData = MazeShopModule.GetShopDataByShopId(self.shopIds[self.curTabIndex])

	self:RefreshMoneyCells()
	self:RefreshItems()
	self:RefreshBottom()
end

function MazeShopUI:RefreshMoneyCells()
	self.moneyCellBuilder:RefreshView(CfgShopTable[self.curShopData.cid].ShowCost)
end

function MazeShopUI:RefreshItems()
	if self.curShopData ~= nil then
		local canOpen, limitResult = self:CheckIsShopUnlock(self.curShopData)

		if canOpen then
			self.itemList:Refresh(#self.curShopData.goodsList)
		end
	else
		self.itemList:Refresh(0)
	end
end

function MazeShopUI:RefreshBottom()
	if self.curShopData == nil then
		return
	end

	local cfgShopData = CfgShopTable[self.curShopData.cid]
	local freeRefreshNum = cfgShopData.FreeRefreshNumber - self.curShopData.freeRefreshCnt
	local itemRefreshNum = cfgShopData.ItemRefreshNumber - self.curShopData.itemRefreshCnt

	self.goPayRefreshBlock:SetActive(false)
	self.goMoneyFree:SetActive(false)
	self.goMoneyOver:SetActive(false)
	self.goBtnRefresh:SetActive(true)

	self.curRefreshType = nil

	if freeRefreshNum > 0 then
		self.curRefreshType = 1

		self.goMoneyFree:SetActive(true)
	elseif itemRefreshNum > 0 then
		local index = (self.curShopData.itemRefreshCnt + 1) * 2 - 1

		if index > #cfgShopData.ItemRefreshCost - 1 then
			index = #cfgShopData.ItemRefreshCost - 1
		end

		local itemId = cfgShopData.ItemRefreshCost[index]
		local costNum = cfgShopData.ItemRefreshCost[index + 1]
		local ownNum = WarehouseModule.GetItemNumByCfgID(itemId)
		local cfgItemData = CfgItemTable[itemId]

		if costNum <= ownNum then
			self.curRefreshType = 2
			self.tfCostNum.text = ShopUIApi:GetString("goCostNum", costNum, ownNum)

			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.costIcon)
		else
			self.goBtnRefresh:SetActive(false)
		end
	end

	if freeRefreshNum == 0 and itemRefreshNum == 0 then
		self.goMoneyOver:SetActive(true)
		self.goMoneyFree:SetActive(false)
		self.goBtnRefresh:SetActive(false)
	end

	if self.curShopData.freeRefreshCnt == 0 and self.curShopData.itemRefreshCnt == 0 and self.curShopData.payRefreshCnt == 0 then
		self.goMoneyOver:SetActive(false)
	end
end

function MazeShopUI:CheckIsShopUnlock(curShopData)
	return true, nil
end

function MazeShopUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnRefresh.onClick:AddListener(self.onClickBtnRefreshDelegate)
	EventDispatcher.AddEventListener(EventID.MazeShopUpdate, self.onRefreshShopDelegate)
	EventDispatcher.AddEventListener(EventID.BuyShopItemEvent, self.onBuySuccessDelegate)
end

function MazeShopUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnRefresh.onClick:RemoveListener(self.onClickBtnRefreshDelegate)
	EventDispatcher.RemoveEventListener(EventID.MazeShopUpdate, self.onRefreshShopDelegate)
	EventDispatcher.RemoveEventListener(EventID.BuyShopItemEvent, self.onBuySuccessDelegate)
end

function MazeShopUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.MazeShopUI)
end

function MazeShopUI:OnClickBtnRefresh()
	if self.curShopData == nil then
		return
	end

	local cfgShopData = CfgShopTable[self.curShopData.cid]

	if self.curRefreshType == 1 then
		MazeShopModule.SendRefreshMsg(self.curShopData.cid, 1)
	elseif self.curRefreshType == 2 then
		MazeShopModule.SendRefreshMsg(self.curShopData.cid, 2)
	elseif self.curRefreshType == 3 then
		local index = (self.curShopData.payRefreshCnt + 1) * 2 - 1

		if index > #cfgShopData.PayRefreshCost - 1 then
			index = #cfgShopData.PayRefreshCost - 1
		end

		local itemId = cfgShopData.PayRefreshCost[index]
		local costNum = cfgShopData.PayRefreshCost[index + 1]

		if itemId == Constant.ItemID.CRYSTAL then
			if costNum <= WarehouseModule.GetNumAttrValue(itemId) then
				MazeShopModule.SendRefreshMsg(self.curShopData.cid, 3)
			else
				NoticeModule.ShowNoticeNoCallback(21040014)
			end
		elseif itemId == Constant.ItemID.TREASURE then
			if costNum <= WarehouseModule.GetNumAttrValue(itemId) then
				MazeShopModule.SendRefreshMsg(self.curShopData.cid, 3)
			else
				NoticeModule.ShowNoticeNoCallback(21040015)
			end
		end
	else
		NoticeModule.ShowNoticeNoCallback(21040016)
	end
end

function MazeShopUI:OnRefreshShop(shopId)
	for i, v in ipairs(self.shopIds) do
		if shopId == v then
			self:ShowTab(i)

			break
		end
	end
end

function MazeShopUI:OnBuySuccess(shopId)
	local actionData = NPCActionModule.GetAction(self.npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.BuyOnShop, self.curShopData.cid)

	self.npcView:ShowCV(actionData.CVid)
end

function MazeShopUI:OnRenderTab(cell)
	local luaIndex = cell.index + 1
	local id = self.shopIds[luaIndex]
	local cfgShopData = CfgShopTable[id]
	local toggle = cell.gameObject:GetComponent("Toggle")

	toggle.transform:Find("goUp/Text_Name_01"):GetComponent("Text").text = ShopUIApi:GetString("goTabName", cfgShopData.Name)
	toggle.transform:Find("goDown/Text_Name_01"):GetComponent("Text").text = ShopUIApi:GetString("goTabName", cfgShopData.Name)

	if self.hasRefreshed == false then
		toggle.isOn = luaIndex == 1
	end
end

function MazeShopUI:OnSelectTab(cell)
	local luaIndex = cell.index + 1

	self:ShowTab(luaIndex)
end

function MazeShopUI:OnRenderItemCll(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local goodsId = self.curShopData.goodsList[luaIndex]

	cell.gameObject.name = "ShopGrid_Mould" .. luaIndex

	local itemCell = self.itemCellDic[insID]

	if itemCell == nil then
		itemCell = MazeShopItemCell.New(cell.gameObject)
		self.itemCellDic[insID] = itemCell
	end

	itemCell:Refresh(CfgGoodsTable[goodsId], luaIndex, self.curShopData.cid)
end

function MazeShopUI:OnSelectItemCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local cell = self.itemCellDic[insID]

	cell:OnClickBtnBuy()
end

return MazeShopUI
