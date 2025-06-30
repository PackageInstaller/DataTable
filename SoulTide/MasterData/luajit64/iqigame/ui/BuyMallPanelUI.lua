-- chunkname: @IQIGame\\UI\\BuyMallPanelUI.lua

local BuyMallPanelUI = Base:Extend("BuyMallPanelUI", "IQIGame.Onigao.UI.BuyMallPanelUI", {
	longCount = 0,
	mallCid = 1010501001,
	count = 1
})

function BuyMallPanelUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, BuyMallPanelUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextBtnTitle, BuyMallPanelUIApi:GetString("TextBtnTitle"))
	UGUIUtil.SetText(self.TextBtnCancel, BuyMallPanelUIApi:GetString("TextBtnCancel"))
	UGUIUtil.SetText(self.TextBtnMin, BuyMallPanelUIApi:GetString("TextBtnMin"))
	UGUIUtil.SetText(self.TextBtnMax, BuyMallPanelUIApi:GetString("TextBtnMax"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateClickBtnCancel()
		self:OnBtnClose()
	end

	function self.delegateClickBtnReward()
		self:OnClickBtnReward()
	end

	function self.delegateClickBtnMin()
		self:OnClickBtnMin()
	end

	function self.delegateClickBtnReduce()
		self:OnClickBtnReduce()
	end

	function self.delegateClickBtnAdd()
		self:OnClickBtnAdd()
	end

	function self.delegateClickBtnMax()
		self:OnClickBtnMax()
	end

	function self.onBuyGoodsSuccessDelegate(cid)
		self:OnBuyGoodsSuccess(cid)
	end

	function self.delegatePlayerInfoChanged()
		self:OnPlayerInfoChanged()
	end

	function self.delegateLonBtnAdd()
		self:OnLongBtnAdd()
	end

	function self.delegateLonBtnReduce()
		self:OnLongBtnReduce()
	end

	self.BtnAdd:GetComponent("LongButton").onLongDownEnd = function()
		self:OnLongAddEnd()
	end
	self.BtnReduce:GetComponent("LongButton").onLongDownEnd = function()
		self:OnLongReduceEnd()
	end
end

function BuyMallPanelUI:GetPreloadAssetPaths()
	return nil
end

function BuyMallPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuyMallPanelUI:IsManualShowOnOpen(userData)
	return false
end

function BuyMallPanelUI:GetBGM(userData)
	return nil
end

function BuyMallPanelUI:OnOpen(userData)
	self.Effect:SetActive(false)

	self.cfgMall = CfgMallTable[self.mallCid]
	self.count = 1

	if userData and userData > 0 then
		self.count = math.ceil(userData / self.cfgMall.ItemNum[1])
	end

	self.max = PlayerModule.PlayerInfo.baseInfo.payPoint > self.cfgMall.SingleBuyLimits and self.cfgMall.SingleBuyLimits or PlayerModule.PlayerInfo.baseInfo.payPoint

	self:UpDateView()
end

function BuyMallPanelUI:OnClose(userData)
	return
end

function BuyMallPanelUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.delegateClickBtnCancel)
	self.BtnReward:GetComponent("Button").onClick:AddListener(self.delegateClickBtnReward)
	self.BtnMin:GetComponent("Button").onClick:AddListener(self.delegateClickBtnMin)
	self.BtnReduce:GetComponent("LongButton").onClick:AddListener(self.delegateClickBtnReduce)
	self.BtnAdd:GetComponent("LongButton").onClick:AddListener(self.delegateClickBtnAdd)
	self.BtnMax:GetComponent("Button").onClick:AddListener(self.delegateClickBtnMax)
	self.BtnAdd:GetComponent("LongButton").onLongDownClick:AddListener(self.delegateLonBtnAdd)
	self.BtnReduce:GetComponent("LongButton").onLongDownClick:AddListener(self.delegateLonBtnReduce)
	EventDispatcher.AddEventListener(EventID.BuyGoodsSuccess, self.onBuyGoodsSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
end

function BuyMallPanelUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnCancel)
	self.BtnReward:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnReward)
	self.BtnMin:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnMin)
	self.BtnReduce:GetComponent("LongButton").onClick:RemoveListener(self.delegateClickBtnReduce)
	self.BtnAdd:GetComponent("LongButton").onClick:RemoveListener(self.delegateClickBtnAdd)
	self.BtnMax:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnMax)
	self.BtnAdd:GetComponent("LongButton").onLongDownClick:RemoveListener(self.delegateLonBtnAdd)
	self.BtnReduce:GetComponent("LongButton").onLongDownClick:RemoveListener(self.delegateLonBtnReduce)
	EventDispatcher.RemoveEventListener(EventID.BuyGoodsSuccess, self.onBuyGoodsSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
end

function BuyMallPanelUI:OnPause()
	return
end

function BuyMallPanelUI:OnResume()
	return
end

function BuyMallPanelUI:OnCover()
	return
end

function BuyMallPanelUI:OnReveal()
	return
end

function BuyMallPanelUI:OnRefocus(userData)
	return
end

function BuyMallPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuyMallPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuyMallPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuyMallPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuyMallPanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function BuyMallPanelUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.BuyMallPanelUI)
end

function BuyMallPanelUI:OnPlayerInfoChanged()
	if self.cfgMall then
		self.max = PlayerModule.PlayerInfo.baseInfo.payPoint > self.cfgMall.SingleBuyLimits and self.cfgMall.SingleBuyLimits or PlayerModule.PlayerInfo.baseInfo.payPoint
	end
end

function BuyMallPanelUI:UpDateView()
	self.TextDes:GetComponent("Text").text = ""

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.ImgGood1:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.cfgMall.Item[1]].Icon), self.ImgGood2:GetComponent("Image"))
	self:ShowMsg()
end

function BuyMallPanelUI:ShowMsg()
	UGUIUtil.SetText(self.TextGood1, tostring(self.cfgMall.PayPoint * self.count))
	UGUIUtil.SetText(self.TextGood2, tostring(self.cfgMall.ItemNum[1] * self.count))
	UGUIUtil.SetText(self.TextNum, BuyMallPanelUIApi:GetString("TextBuyCount", self.count, self.max))

	local needName = CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Name
	local needNum = self.cfgMall.PayPoint * self.count
	local getName = CfgItemTable[self.cfgMall.Item[1]].Name
	local getNum = self.cfgMall.ItemNum[1] * self.count

	UGUIUtil.SetText(self.TextMsg, BuyMallPanelUIApi:GetString("TextMsg", needName, needNum, getName, getNum, PlayerModule.PlayerInfo.baseInfo.payPoint))
end

function BuyMallPanelUI:OnBuyGoodsSuccess(id)
	if id == self.mallCid then
		self.Effect:SetActive(false)
		self.Effect:SetActive(true)

		if self.count > self.max then
			self.count = self.max
		end

		if self.count <= 0 then
			self.count = 1
		end

		self:ShowMsg()
	end
end

function BuyMallPanelUI:OnClickBtnReduce()
	if self.count > 1 then
		self.count = self.count - 1
	end

	if self.count > self.max then
		self.count = self.max
		self.count = self.count == 0 and 1 or self.count
	end

	self:ShowMsg()
end

function BuyMallPanelUI:OnClickBtnMin()
	self.count = 1

	self:ShowMsg()
end

function BuyMallPanelUI:OnClickBtnAdd()
	if self.count < self.max then
		self.count = self.count + 1
	end

	if self.count > self.max then
		self.count = self.max
		self.count = self.count == 0 and 1 or self.count
	end

	self:ShowMsg()
end

function BuyMallPanelUI:OnClickBtnMax()
	self.count = self.max

	if self.count <= 0 then
		self.count = 1
	end

	self:ShowMsg()
end

function BuyMallPanelUI:OnClickBtnReward()
	local needNum = self.count * self.cfgMall.PayPoint

	if needNum > PlayerModule.PlayerInfo.baseInfo.payPoint then
		NoticeModule.MoneyDeficitTip(2, needNum - PlayerModule.PlayerInfo.baseInfo.payPoint)
	else
		MallModule.BuyGoods(self.mallCid, self.count)
		self:OnBtnClose()
	end
end

function BuyMallPanelUI:OnLongBtnAdd()
	local speed = self.longCount + 1

	if speed > 20 then
		speed = 20
	end

	self.count = self.count + speed

	if self.count >= self.max then
		self.count = self.max
		self.count = self.count == 0 and 1 or self.count
	end

	self:ShowMsg()

	self.longCount = self.longCount + 1
end

function BuyMallPanelUI:OnLongBtnReduce()
	local speed = self.longCount + 1

	if speed > 20 then
		speed = 20
	end

	self.count = self.count - speed

	if self.count <= 0 then
		self.count = 1
	end

	self:ShowMsg()

	self.longCount = self.longCount + 1
end

function BuyMallPanelUI:OnLongAddEnd()
	self.longCount = 0
end

function BuyMallPanelUI:OnLongReduceEnd()
	self.longCount = 0
end

return BuyMallPanelUI
