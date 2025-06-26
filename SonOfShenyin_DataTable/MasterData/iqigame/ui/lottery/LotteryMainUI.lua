-- chunkname: @IQIGame\\UI\\Lottery\\LotteryMainUI.lua

local m = {
	LastTabIndex = -1,
	CurTabIndex = 0,
	TabsList = {}
}
local lotteryTabView = require("IQIGame.UI.Lottery.LotteryTabView")
local lotteryShowClickController = require("IQIGame.UI.Lottery.LotteryShowClickController")
local LotteryPoolItemClass = require("IQIGame.UI.Lottery.LotteryPoolItem")

function m.New(view, uiController, mainView)
	local obj = Clone(m)

	obj:Init(view, uiController, mainView)

	return obj
end

function m:Init(view, uiController, mainView)
	self.View = view
	self.UIController = uiController
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitMembers()
	self:InitComponents()
	self:InitDelegate()
	self:AddListeners()
	self:OnInit()
	UGUIUtil.SetText(self.OnceTitle, LotteryUIApi:GetOnceBtnTitle())
	UGUIUtil.SetText(self.TenTitle, LotteryUIApi:GetTenBtnTitle())
end

function m:InitMembers()
	self.poolControllers = {}
	self.poolViewList = {}
end

function m:InitComponents()
	self.topTabViewsList = {}

	local topParentTrans = self.topParent.transform

	for i = 1, LuaUtility.GetChildCount(topParentTrans) do
		local transView = LuaUtility.GetChild(topParentTrans, i - 1)
		local toggle = transView:GetComponent("Toggle")

		table.insert(self.topTabViewsList, toggle)
	end

	self.moneyCell = CurrencyCell.New(self.MoneyGrid)
	self.poolScrollRectExt = self.poolScrollRect:GetComponent(typeof(ScrollRectPageExt))

	function self.poolScrollRectExt.OnDrageEnd(index)
		self:SetPoolChose(index + 1)
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function m:InitDelegate()
	function self.DelegateOnceBtn()
		self:OnceDrawBtnClick()
	end

	function self.DelegateTenBtn()
		self:TenDrawBtnClick()
	end

	function self.DelegateRewardListBtn()
		self:RewardListBtnClick()
	end

	function self.DelegateRecordBtn()
		self:OnOpenRecordView()
	end

	function self.DelegateOnClickTokenExchangeBtn()
		self:OnClickTokenExchangeBtn()
	end

	function self.DelegateLotteryUpdate()
		self:LotteryNotifyUpdateCallBack()
	end

	function self.DelegateLotteryAddOrRemove()
		self:LotteryAddOrRemoveCallBack()
	end

	function self.DelegateLotteryResult()
		self:LotteryResult()
	end

	function self.buyDrawingDelegate()
		self:BuyDrawingEvent()
	end

	function self.DelegateUpdateItem()
		self:UpdateItem()
	end

	function self.changeLeftBtnDelegate()
		self:OnChangeLeftBtnClick()
	end

	function self.changeRightBtnDelegate()
		self:OnChangeRightBtnClick()
	end

	function self.DelegateOnClickViewResultsBtn()
		self:OnClickViewResultsBtn()
	end
end

function m:AddListeners()
	self.OnceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnceBtn)
	self.TenBtn:GetComponent("Button").onClick:AddListener(self.DelegateTenBtn)
	self.RewardListBtn:GetComponent("Button").onClick:AddListener(self.DelegateRewardListBtn)
	self.RecordListBtn:GetComponent("Button").onClick:AddListener(self.DelegateRecordBtn)
	self.TokenExchangeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTokenExchangeBtn)
	self.changeLeftBtn:GetComponent("Button").onClick:AddListener(self.changeLeftBtnDelegate)
	self.changeRightBtn:GetComponent("Button").onClick:AddListener(self.changeRightBtnDelegate)
	self.ViewResultsBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickViewResultsBtn)
	EventDispatcher.AddEventListener(EventID.LotteryNotifyUpdate, self.DelegateLotteryUpdate)
	EventDispatcher.AddEventListener(EventID.LotteryAddOrRemove, self.DelegateLotteryAddOrRemove)
	EventDispatcher.AddEventListener(EventID.LotteryResultEvent, self.DelegateLotteryResult)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.DelegateLotteryResult)
	EventDispatcher.AddEventListener(EventID.LotteryMainBuyDrawing, self.buyDrawingDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function m:RemoveListeners()
	self.OnceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnceBtn)
	self.TenBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateTenBtn)
	self.RewardListBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateRewardListBtn)
	self.RecordListBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateRecordBtn)
	self.TokenExchangeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTokenExchangeBtn)
	self.changeLeftBtn:GetComponent("Button").onClick:RemoveListener(self.changeLeftBtnDelegate)
	self.changeRightBtn:GetComponent("Button").onClick:RemoveListener(self.changeRightBtnDelegate)
	self.ViewResultsBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickViewResultsBtn)
	EventDispatcher.RemoveEventListener(EventID.LotteryNotifyUpdate, self.DelegateLotteryUpdate)
	EventDispatcher.RemoveEventListener(EventID.LotteryAddOrRemove, self.DelegateLotteryAddOrRemove)
	EventDispatcher.RemoveEventListener(EventID.LotteryResultEvent, self.DelegateLotteryResult)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.DelegateLotteryResult)
	EventDispatcher.RemoveEventListener(EventID.LotteryMainBuyDrawing, self.buyDrawingDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function m:Show()
	self:LoadAllPoolPrefabs()

	LotteryModule.isExchangedDrawing = false

	LuaUtility.SetGameObjectShow(self.View, true)
	self.poolScrollRectExt:ResetHorizontalPos()
	self:OnOpen()
end

function m:Hide()
	self:UnLoadAllPoolPrefabs()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:OnInit()
	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.Timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.Timer:Start()
end

function m:OnOpen()
	self:SetData()
	self.poolScrollRectExt:SetHorizontalPos(0)
	self:SetPoolChose(1)
end

function m:SetData()
	self.PoolDataList = LotteryModule.GetIsOpenPool()
end

function m:LoadAllPoolPrefabs()
	self.PoolDataList = LotteryModule.GetIsOpenPool()

	for i = 1, #self.PoolDataList do
		local poolObject = GameObject.Instantiate(self.poolPrefab, self.poolCotent.transform)
		local poolItem = LotteryPoolItemClass.New(poolObject.gameObject, self)

		poolItem:Refresh(self.PoolDataList[i])

		self.poolViewList[self.PoolDataList[i].id] = poolItem
	end

	self:InitPoolScrollPage()
end

function m:UnLoadAllPoolPrefabs()
	for _, v in pairs(self.poolViewList) do
		v:Destroy()

		v = nil
	end

	self.poolViewList = {}
end

function m:InitPoolScrollPage()
	self.poolScrollRectExt.allPageCount = #self.PoolDataList

	self.poolScrollRectExt:ListPageValueInit()
end

function m:SetPoolChose(index)
	LotteryModule.curSelectPoolIndex = index
	self.PoolType = self.PoolDataList[index].id
	LotteryModule.curSelectPoolType = self.PoolDataList[index].id
	self.PoolData = self.PoolDataList[index]
	self.CurTabIndex = index
	self.cardCfg = CfgCardJackpotTable[self.PoolType]
	self.topTabViewsList[index].isOn = true

	self:Refresh()
	self:RefreshTopMoney()
end

function m:Refresh()
	self.PoolDataList = LotteryModule.GetIsOpenPool()
	self.PoolData = self.PoolDataList[LotteryModule.curSelectPoolIndex]

	self:RefreshTabs()
	self:RefreshTime()
	self:SetBasicInfo()
	self:RefreshChangeButton()
end

function m:RefreshTopMoney()
	local cfgPool = CfgUtil.GetCardJackpotWithID(self.PoolType)

	self.moneyCell:RefreshItem(cfgPool.TopMoneyID)
end

function m:RefreshTabs()
	for i = 1, #self.topTabViewsList do
		if i <= #self.PoolDataList then
			LuaUtility.SetGameObjectShow(self.topTabViewsList[i].gameObject, true)
		else
			LuaUtility.SetGameObjectShow(self.topTabViewsList[i].gameObject, false)
		end
	end
end

function m:RefreshTime()
	local currentPool = self.PoolDataList[LotteryModule.curSelectPoolIndex]

	if currentPool.endTime and tonumber(currentPool.endTime) > 0 then
		LuaUtility.SetGameObjectShow(self.timeParent, true)

		local span = tonumber(currentPool.endTime) - tonumber(PlayerModule.GetServerTimeByMs())
		local time = span / 1000

		LuaUtility.SetText(self.timeText, DateStandardFormation(time))
	else
		LuaUtility.SetGameObjectShow(self.timeParent, false)
	end
end

function m:LotteryAddOrRemoveCallBack()
	self:SetData()
	self:UnLoadAllPoolPrefabs()
	self:LoadAllPoolPrefabs()
	self:SetPoolChose(1)
end

function m:LotteryNotifyUpdateCallBack()
	self.PoolDataList = LotteryModule.GetIsOpenPool()
	self.PoolData = self.PoolDataList[LotteryModule.curSelectPoolIndex]

	self:SetBasicInfo()
end

function m:Dispose()
	self:UnLoadAllPoolPrefabs()
	AssetUtil.UnloadAsset(self)
	self.moneyCell:Dispose()

	for _, v in pairs(self.TabsList) do
		v:Dispose()
	end

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil

	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.commonReturnBtn:Dispose()
end

function m:ShowTab(index)
	return
end

function m:RefreshPool(data)
	return
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	local object = GameObject.Instantiate(asset, self.PoolShowParent.transform)

	UIUtil.InitSortedComponents(self.UIController:GetComponent("Canvas"), object)

	local controller = lotteryShowClickController.New(object)

	controller:Hide()

	self.poolControllers[userData.poolType] = controller
end

function m:SetBasicInfo()
	local noviceAndDrawed = CfgCardJackpotTable[self.PoolData.id].RookieCard == true and #self.PoolData.historyItems > 0

	LuaUtility.SetGameObjectShow(self.LotteryButtonsParent, not noviceAndDrawed)
	LuaUtility.SetGameObjectShow(self.ViewResultsBtn, noviceAndDrawed)

	local itemId, needItemCount, enough = self:GetMoneyType(1)

	self.OnceMoneyEnough = enough
	self.OnceitemCid = itemId
	self.OnceNeedMoney = needItemCount

	UGUIUtil.SetText(self.OnceConsumeText, LotteryUIApi:SetOneMoneyTextColor(needItemCount, enough))
	self:LoadImg(UIGlobalApi.GetIconPath(CfgItemTable[itemId].Icon), self.OnceConsumImg)

	itemId, needItemCount, enough = self:GetMoneyType(10)
	self.TenMoneyEnough = enough
	self.TenitemCid = itemId
	self.TenNeedMoney = needItemCount

	UGUIUtil.SetText(self.TenConsumeText, LotteryUIApi:SetTenMoneyTextColor(needItemCount, enough))
	self:LoadImg(LotteryUIApi:GetImgPath(CfgItemTable[itemId].Icon), self.TenConsumImg)
	LuaUtility.SetGameObjectShow(self.OnceBtn, self.PoolType ~= Constant.LotteryType.Novice)
	UGUIUtil.SetText(self.numText, self.cardCfg.MustGuarantee - self.PoolData.mustGuarantee)
	UGUIUtil.SetText(self.bigShowText, self.cardCfg.ShowText)
	UGUIUtil.SetText(self.smallShowText, self.cardCfg.ShowText)
	LuaUtility.SetGameObjectShow(self.tipsParent1, self.cardCfg.IsShow)
	LuaUtility.SetGameObjectShow(self.tipsParent2, self.cardCfg.IsShow)
end

function m:GetMoneyType(count)
	local needItem = count

	if needItem <= WarehouseModule.GetItemNumByCfgID(self.cardCfg.OneTime[1]) then
		return self.cardCfg.OneTime[1], needItem, true
	end

	return self.cardCfg.OneTime[1], needItem, false
end

function m:OnceDrawBtnClick()
	if self:PoolHasMaxDraw(1) then
		NoticeModule.ShowNotice(51010)

		return
	end

	self.currentDrawCount = 1

	if self.PoolType == Constant.LotteryType.Novice then
		return
	end

	if not self.OnceMoneyEnough then
		self:ExChangeItem(self.OnceitemCid, self.OnceNeedMoney)

		return
	end

	local data = {
		self.OnceitemCid,
		self.OnceNeedMoney,
		function()
			LotteryModule.SendDraw(self.PoolType, self.currentDrawCount)
		end
	}

	UIModule.Open(Constant.UIControllerName.UseMoneyUI, Constant.UILayer.Top, data)
end

function m:TenDrawBtnClick()
	if self:PoolHasMaxDraw(10) then
		NoticeModule.ShowNotice(51010)

		return
	end

	self.currentDrawCount = 10

	if self.PoolType == Constant.LotteryType.Novice then
		if not self.OnceMoneyEnough then
			NoticeModule.ShowCurrencyNotEnoughTips(self.TenitemCid)

			return
		end

		self:NewHandPoolDraw(self.currentDrawCount)

		return
	end

	if not self.TenMoneyEnough then
		self:ExChangeItem(self.TenitemCid, self.TenNeedMoney)

		return
	end

	local data = {
		self.TenitemCid,
		self.TenNeedMoney,
		function()
			LotteryModule.SendDraw(self.PoolType, self.currentDrawCount)
		end
	}

	UIModule.Open(Constant.UIControllerName.UseMoneyUI, Constant.UILayer.Top, data)
end

function m:NewHandPoolDraw(drawCount)
	LotteryModule.SendDraw(self.PoolType, drawCount)
end

function m:ExChangeItem(itemCid, needNum)
	local commodityData = ShopModule.GetCommodityDataByShopAndCommodityID(self.cardCfg.Access[1], self.cardCfg.Access[2])

	if not commodityData then
		logError(string.format("【抽卡】没有找到商品数据，卡池id = %s,商城id = %s,商品id = %s", tostring(self.cardCfg.Id), tostring(self.cardCfg.Access[1]), tostring(self.cardCfg.Access[2])))

		return
	end

	local cfgItemData = CfgUtil.GetItemCfgDataWithID(itemCid)
	local hasItemNum = WarehouseModule.GetItemNumByCfgID(itemCid)
	local buyNum = needNum - hasItemNum
	local needMoney = buyNum * commodityData:GetPrice()
	local needMoneyItemCid = commodityData:GetPriceIconId()
	local tips = LotteryUIApi:GetItemNotEnoughTips(buyNum, cfgItemData.Name, needMoney, CfgUtil.GetItemCfgDataWithID(needMoneyItemCid).Name)

	NoticeModule.ShowNoticeByType(5, tips, function()
		local moneyAllNum = WarehouseModule.GetItemNumByCfgID(needMoneyItemCid)

		if moneyAllNum < needMoney then
			UIModule.Open(Constant.UIControllerName.ConvertUI, Constant.UILayer.UI, needMoney - moneyAllNum)
		else
			ShopModule.BuyItemRequest(commodityData.cid, buyNum)

			LotteryModule.isExchangedDrawing = true
		end
	end, function()
		LotteryModule.isExchangedDrawing = false
	end)
end

function m:PoolHasMaxDraw(count)
	if CfgCardJackpotTable[self.PoolType].FullTimes == nil or CfgCardJackpotTable[self.PoolType].FullTimes == 0 then
		return false
	end

	if count > CfgCardJackpotTable[self.PoolType].FullTimes - LotteryModule.DrawPodList[self.PoolType].drawTime then
		return true
	else
		return false
	end
end

function m:OnOpenRecordView()
	UIModule.Open(Constant.UIControllerName.LotteryRecordsUI, Constant.UILayer.UI, self.PoolType)
end

function m:OnClickTokenExchangeBtn()
	UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
		enterType = Constant.ShopEnterType.Normal
	})
end

function m:RewardListBtnClick()
	UIModule.Open(Constant.UIControllerName.LotteryRewardListUI, Constant.UILayer.UI, self.PoolType)
end

function m:LotteryResult()
	self:ShowTab(LotteryModule.curSelectPoolIndex)
end

function m:BuyDrawingEvent()
	if not LotteryModule.isExchangedDrawing then
		return
	end

	LotteryModule.SendDraw(self.PoolType, self.currentDrawCount)
end

function m:OnChangeLeftBtnClick()
	if LotteryModule.curSelectPoolIndex <= 1 then
		return
	end

	self.poolScrollRectExt:SetHorizontalPos(LotteryModule.curSelectPoolIndex - 1 - 1)
end

function m:OnChangeRightBtnClick()
	if LotteryModule.curSelectPoolIndex >= #self.PoolDataList then
		return
	end

	self.poolScrollRectExt:SetHorizontalPos(LotteryModule.curSelectPoolIndex - 1 + 1)
end

function m:RefreshChangeButton()
	LuaUtility.SetGameObjectShow(self.changeLeftBtn, LotteryModule.curSelectPoolIndex > 1)
	LuaUtility.SetGameObjectShow(self.changeRightBtn, LotteryModule.curSelectPoolIndex < #self.PoolDataList)
end

function m:OnClickViewResultsBtn()
	self.mainView.RewardShowView:SetData(self.PoolData.currentItems)
	self.mainView.RewardShowView:Show()
end

function m:UpdateItem()
	self:SetBasicInfo()
end

function m:LoadImg(path, Obj)
	AssetUtil.LoadImage(self, path, Obj:GetComponent("Image"))
end

return m
