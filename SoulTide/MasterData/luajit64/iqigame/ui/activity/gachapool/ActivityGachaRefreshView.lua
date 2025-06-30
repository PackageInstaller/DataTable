-- chunkname: @IQIGame\\UI\\Activity\\GachaPool\\ActivityGachaRefreshView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnRefresh()
		self:OnBtnRefresh()
	end

	function self.DelegateBtnTip()
		self:OnBtnTip()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnRefresh:GetComponent("Button").onClick:AddListener(self.DelegateBtnRefresh)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateBtnTip)
end

function m:RemoveListener()
	self.BtnRefresh:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRefresh)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnTip)
end

function m:UpDateView(operateEventID, canFresh, isRefresh)
	self.operateEventID = operateEventID

	self.BtnRefresh:SetActive(canFresh)
	self.ImgBG:SetActive(canFresh)
	self.BtnTip:SetActive(not isRefresh)

	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

	self.cfgGachaPoolGlobalData = CfgGachaPoolGlobalTable[eventPOD.dataCfgId]

	UGUIUtil.SetText(self.TextCost, self.cfgGachaPoolGlobalData.RefreshPayPoint)

	local iconPath = MoneyGridApi:GetString("MoneyCellIconPath", Constant.ItemID.ID_PAYPOINT_SHOW)

	if iconPath == "" then
		iconPath = UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon)
	end

	AssetUtil.LoadImage(self, iconPath, self.ImgCost:GetComponent("Image"))
end

function m:OnBtnRefresh()
	local hasCostItemNum = PlayerModule.PlayerInfo.baseInfo.payPoint

	if hasCostItemNum < self.cfgGachaPoolGlobalData.RefreshPayPoint then
		NoticeModule.MoneyDeficitTip(2, self.cfgGachaPoolGlobalData.RefreshPayPoint - hasCostItemNum)

		return
	end

	NoticeModule.ShowNoticeBuyConfirm(21045031, function()
		ActiveGachaModule.Refresh(self.operateEventID)
	end, nil, nil, {
		Constant.ItemID.ID_PAYPOINT_SHOW
	}, {
		self.cfgGachaPoolGlobalData.RefreshPayPoint
	})
end

function m:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.GachaPoolPanelUI, Constant.UILayer.UI, self.cfgGachaPoolGlobalData)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
