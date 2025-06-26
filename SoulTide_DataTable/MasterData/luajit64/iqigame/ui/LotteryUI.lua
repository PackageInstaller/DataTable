-- chunkname: @IQIGame\\UI\\LotteryUI.lua

local LotteryUI = Base:Extend("LotteryUI", "IQIGame.Onigao.UI.LotteryUI", {
	LotteryCidWaitBuyItem = 0,
	LotteryShowCidWaitBuyItem = 0,
	BuyItemMallCid = 0,
	PanelControllerMap = {},
	SubPanels = {}
})
local LotteryPanelName = require("IQIGame.UI.Lottery.LotteryPanelName")
local LotteryUIMainUI = require("IQIGame.UI.Lottery.LotteryUIMainUI")
local LotteryUIVideoUI = require("IQIGame.UI.Lottery.LotteryUIVideoUI")
local LotteryUIRewardShow = require("IQIGame.UI.Lottery.LotteryUIRewardShow")
local LotteryUISoulShow = require("IQIGame.UI.Lottery.LotteryUISoulShow")
local LotteryUIEquipShow = require("IQIGame.UI.Lottery.LotteryUIEquipShow")

function LotteryUI:OnInit()
	function self.DelegateOnShowDrawResult(baseShowItems, showItems, lotteryShowCid, lotteryCid)
		self:OnShowDrawResult(baseShowItems, showItems, lotteryShowCid, lotteryCid)
	end

	function self.DelegateOnAutoBuyItem(lotteryShowCid, lotteryCid, mallCid)
		self:OnAutoBuyItem(lotteryShowCid, lotteryCid, mallCid)
	end

	function self.DelegateOnBuyGoodsSuccess(mallCid)
		self:OnBuyGoodsSuccess(mallCid)
	end

	self:CreateSubPanel(LotteryPanelName.MainUI, LotteryUIMainUI, self.MainUI)
	self:CreateSubPanel(LotteryPanelName.VideoUI, LotteryUIVideoUI, self.VideoUI)
	self:CreateSubPanel(LotteryPanelName.RewardShow, LotteryUIRewardShow, self.RewardShow)
	self:CreateSubPanel(LotteryPanelName.EquipShow, LotteryUIEquipShow, self.EquipShow)
	self:CreateSubPanel(LotteryPanelName.SoulShow, LotteryUISoulShow, self.SoulShow)
end

function LotteryUI:GetPreloadAssetPaths()
	local paths = {}
	local bgList = LotteryUIApi:GetString("EquipShowBg1List")

	for i = 1, #bgList do
		table.insert(paths, bgList[i])
	end

	bgList = LotteryUIApi:GetString("EquipShowBg2List")

	for i = 1, #bgList do
		table.insert(paths, bgList[i])
	end

	return paths
end

function LotteryUI:GetOpenPreloadAssetPaths(userData)
	local paths = {}
	local firstData
	local cfgLotteryShowDataList = {}

	for id, cfgLotteryShowData in pairsCfg(CfgLotteryShowTable) do
		if cfgLotteryShowData.LotteryType == Constant.LotteryType.Lottery_Soul then
			table.insert(cfgLotteryShowDataList, cfgLotteryShowData)
		end
	end

	table.sort(cfgLotteryShowDataList, function(cfgLotteryShowData1, cfgLotteryShowData2)
		return cfgLotteryShowData1.Id < cfgLotteryShowData2.Id
	end)

	for i = 1, #cfgLotteryShowDataList do
		local cfgLotteryShowData = cfgLotteryShowDataList[i]
		local isInOpenTime = LotteryModule.CheckInOpenTime(cfgLotteryShowData)

		if isInOpenTime then
			firstData = cfgLotteryShowData

			break
		end
	end

	table.insert(paths, UIGlobalApi.GetUIPrefab(firstData.ShowImage))
	table.insert(paths, UIGlobalApi.GetMoneyCellAssetPath())

	return paths
end

function LotteryUI:GetBGM(userData)
	return 4
end

function LotteryUI:OnOpen(userData)
	for i = 1, #self.SubPanels do
		if self.SubPanels[i].OnRootUIOpen ~= nil then
			self.SubPanels[i]:OnRootUIOpen()
		end
	end

	if userData == nil or not userData.isSimulateDraw then
		self:UpdateView()
	else
		self:ShowDrawResult({}, userData.simulateDrawShowItems, 0, 0, true, userData.simulateDrawCallback)
	end
end

function LotteryUI:OnClose(userData)
	self.LotteryShowCidWaitBuyItem = 0
	self.LotteryCidWaitBuyItem = 0
	self.BuyItemMallCid = 0

	for i = 1, #self.SubPanels do
		if self.SubPanels[i].OnRootUIClose ~= nil then
			self.SubPanels[i]:OnRootUIClose()
		end
	end

	ModuleTimerUtil.Stop(Constant.UIControllerName.LotteryUI)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseLotteryUI")
	LotteryModule.DrawComplete()
end

function LotteryUI:OnAddListeners()
	for i = 1, #self.SubPanels do
		self.SubPanels[i]:OnAddListeners()
	end

	EventDispatcher.AddEventListener(EventID.LotteryResult, self.DelegateOnShowDrawResult)
	EventDispatcher.AddEventListener(EventID.LotteryAutoBuyItem, self.DelegateOnAutoBuyItem)
	EventDispatcher.AddEventListener(EventID.BuyGoodsSuccess, self.DelegateOnBuyGoodsSuccess)
end

function LotteryUI:OnRemoveListeners()
	for i = 1, #self.SubPanels do
		self.SubPanels[i]:OnRemoveListeners()
	end

	EventDispatcher.RemoveEventListener(EventID.LotteryResult, self.DelegateOnShowDrawResult)
	EventDispatcher.RemoveEventListener(EventID.LotteryAutoBuyItem, self.DelegateOnAutoBuyItem)
	EventDispatcher.RemoveEventListener(EventID.BuyGoodsSuccess, self.DelegateOnBuyGoodsSuccess)
end

function LotteryUI:OnPause()
	return
end

function LotteryUI:OnResume()
	return
end

function LotteryUI:OnCover()
	return
end

function LotteryUI:OnReveal()
	return
end

function LotteryUI:OnRefocus(userData)
	return
end

function LotteryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for i = 1, #self.SubPanels do
		if self.SubPanels[i].View.activeSelf then
			self.SubPanels[i]:OnUpdate(elapseSeconds, realElapseSeconds)
		end
	end
end

function LotteryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryUI:OnDestroy()
	for i = 1, #self.SubPanels do
		self.SubPanels[i]:Dispose()
	end
end

function LotteryUI:CreateSubPanel(subPanelName, subPanelClass, gameObject)
	local subPanel = subPanelClass.New(gameObject, self)

	table.insert(self.SubPanels, subPanel)

	self.PanelControllerMap[subPanelName] = subPanel
end

function LotteryUI:UpdateView()
	self:ShowPanel(LotteryPanelName.MainUI, {
		tab = 1,
		type = Constant.LotteryType.Lottery_Soul
	}, true)
end

function LotteryUI:ShowPanel(panelName, userData, exclusive)
	local panelController = self.PanelControllerMap[panelName]

	if exclusive then
		for i = 1, #self.SubPanels do
			if self.SubPanels[i] ~= panelController then
				self.SubPanels[i]:Hide()
			end
		end
	end

	panelController:Show(userData)
end

function LotteryUI:OnShowDrawResult(baseShowItems, showItems, lotteryShowCid, lotteryCid)
	self:ShowDrawResult(baseShowItems, showItems, lotteryShowCid, lotteryCid, false)
end

function LotteryUI:ShowDrawResult(baseShowItems, showItems, lotteryShowCid, lotteryCid, isSimulateDraw, simulateDrawCallback)
	self:ShowPanel(LotteryPanelName.VideoUI, {
		autoClickDelay = -1,
		base = baseShowItems,
		list = showItems,
		onClose = function(base, list, isSkip)
			self:ShowPanel(LotteryPanelName.RewardShow, {
				base = base,
				list = list,
				isSkip = isSkip,
				lotteryShowCid = lotteryShowCid,
				lotteryCid = lotteryCid,
				isSimulateDraw = isSimulateDraw,
				simulateDrawCallback = simulateDrawCallback
			}, true)
		end
	}, true)
end

function LotteryUI:OnAutoBuyItem(lotteryShowCid, lotteryCid, mallCid)
	self.LotteryShowCidWaitBuyItem = lotteryShowCid
	self.LotteryCidWaitBuyItem = lotteryCid
	self.BuyItemMallCid = mallCid
end

function LotteryUI:OnBuyGoodsSuccess(mallCid)
	if self.LotteryShowCidWaitBuyItem ~= 0 and self.LotteryCidWaitBuyItem ~= 0 and self.BuyItemMallCid == mallCid then
		local cfgLotteryData = CfgLotteryTable[self.LotteryCidWaitBuyItem]
		local costItemCid, costItemNum, isPayPoint = LotteryModule.GetCostItem(cfgLotteryData)
		local hasCostItemNum = WarehouseModule.GetItemNumByCfgID(costItemCid)

		if costItemNum <= hasCostItemNum then
			LotteryModule.Draw(CfgLotteryShowTable[self.LotteryShowCidWaitBuyItem], CfgLotteryTable[self.LotteryCidWaitBuyItem], true)
		end

		self.LotteryShowCidWaitBuyItem = 0
		self.LotteryCidWaitBuyItem = 0
		self.BuyItemMallCid = 0
	end
end

return LotteryUI
