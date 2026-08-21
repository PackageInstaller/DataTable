-- chunkname: @IQIGame\\UI\\BuyPanelUI.lua

local BuyPanelUI = Base:Extend("BuyPanelUI", "IQIGame.Onigao.UI.BuyPanelUI", {})
local ViewTypeOne = require("IQIGame.UI.BuyPanel.ViewTypeOne")
local ViewTypeTwo = require("IQIGame.UI.BuyPanel.ViewTypeTwo")

function BuyPanelUI:OnInit()
	self:Initialize()
end

function BuyPanelUI:GetPreloadAssetPaths()
	return nil
end

function BuyPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuyPanelUI:OnOpen(userData)
	self:Refresh(userData)
end

function BuyPanelUI:OnClose(userData)
	self:OnHide()
end

function BuyPanelUI:OnPause()
	return
end

function BuyPanelUI:OnResume()
	return
end

function BuyPanelUI:OnCover()
	return
end

function BuyPanelUI:OnReveal()
	return
end

function BuyPanelUI:OnRefocus(userData)
	return
end

function BuyPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuyPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuyPanelUI:Initialize()
	self.viewTypeOne = ViewTypeOne.New(self.goViewTypeOne, self)
	self.viewTypeTwo = ViewTypeTwo.New(self.goViewTypeTwo, self)

	function self.onPayOverDelegate(code)
		self:OnPayOver(code)
	end

	self.goTitle:GetComponent("Text").text = BuyPanelUIApi:GetString("goTitle")
	self.goWaitToPay.transform:Find("Text"):GetComponent("Text").text = BuyPanelUIApi:GetString("rechargeWaitTipTxt")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onBuyGoodsSuccessDelegate(id)
		self:OnBuyGoodsSuccess(id)
	end
end

function BuyPanelUI:Refresh(userData)
	self.cfgMallData = CfgMallTable[userData.mallCid]

	if self.cfgMallData.ShowItem == Constant.Mall_ShowItem.HouseItem then
		self.viewTypeTwo:Open(self.cfgMallData, userData.num, userData.type)
		self.viewTypeOne:Close()
	else
		self.viewTypeOne:Open(self.cfgMallData, userData.num, userData.type)
		self.viewTypeTwo:Close()
	end

	self.goWaitToPay:SetActive(false)
end

function BuyPanelUI:OnHide()
	self.viewTypeOne:OnHide()
	self.viewTypeTwo:OnHide()
end

function BuyPanelUI:OnDestroy()
	self.viewTypeOne:OnDestroy()
	self.viewTypeTwo:OnDestroy()
end

function BuyPanelUI:OnAddListeners()
	self.viewTypeOne:OnAddListener()
	self.viewTypeTwo:OnAddListener()
	EventDispatcher.AddEventListener(EventID.PayOver, self.onPayOverDelegate)
	self.goBtnClose1:GetComponent("Button").onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.BuyGoodsSuccess, self.onBuyGoodsSuccessDelegate)
end

function BuyPanelUI:OnRemoveListeners()
	self.viewTypeOne:OnRemoveListener()
	self.viewTypeTwo:OnRemoveListener()
	EventDispatcher.RemoveEventListener(EventID.PayOver, self.onPayOverDelegate)
	self.goBtnClose1:GetComponent("Button").onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.BuyGoodsSuccess, self.onBuyGoodsSuccessDelegate)
end

function BuyPanelUI:OnBuyGoodsSuccess(id)
	if self.cfgMallData.ShowItem == Constant.Mall_ShowItem.HouseItem then
		self.viewTypeTwo:OnBuyGoodsSuccess()
	else
		self.viewTypeOne:OnBuyGoodsSuccess()
	end
end

function BuyPanelUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function BuyPanelUI:OnPayOver(code)
	return
end

function BuyPanelUI:OnClickBtnBuy(cfgMallData, usedTimes)
	if cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		if cfgDateTimeToTimeStamp(cfgMallData.TimeLimitOpen, PlayerModule.TimeZone) > math.floor(PlayerModule.GetServerTime()) then
			NoticeModule.ShowNotice(21040055)

			return
		end

		if cfgDateTimeToTimeStamp(cfgMallData.TimeLimitEnd, PlayerModule.TimeZone) < math.floor(PlayerModule.GetServerTime()) then
			NoticeModule.ShowNotice(21040055)

			return
		end
	end

	if cfgMallData.ConditionId ~= 0 and not ConditionModule.Check(cfgMallData.ConditionId) then
		NoticeModule.ShowNotice(21040055)

		return
	end

	if usedTimes == 0 then
		NoticeModule.ShowNotice(21040055)

		return
	end

	if cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		if PlayerModule.PlayerInfo.baseInfo.payPoint < cfgMallData.PayPoint * usedTimes then
			NoticeModule.MoneyDeficitTip(2, cfgMallData.PayPoint * usedTimes - PlayerModule.PlayerInfo.baseInfo.payPoint)

			return
		end
	elseif cfgMallData.SellType == Constant.Mall_SellType.Item and cfgMallData.Price[2] * usedTimes > WarehouseModule.GetItemNumByCfgID(cfgMallData.Price[1]) then
		if cfgMallData.Price[1] == Constant.ItemID.TREASURE then
			NoticeModule.MoneyDeficitTip(1, cfgMallData.Price[2] * usedTimes - WarehouseModule.GetItemNumByCfgID(cfgMallData.Price[1]))
		else
			NoticeModule.ShowNoticeNoCallback(21045004, CfgItemTable[cfgMallData.Price[1]].Name)
		end

		return
	end

	if cfgMallData.SellType == Constant.Mall_SellType.RMB then
		MallModule.ReqPay(cfgMallData.PayMoney)
	else
		MallModule.BuyGoods(cfgMallData.Id, usedTimes)
	end

	self:OnClickBtnClose()
end

return BuyPanelUI
