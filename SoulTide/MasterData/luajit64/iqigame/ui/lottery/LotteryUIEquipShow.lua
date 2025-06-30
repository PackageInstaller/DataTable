-- chunkname: @IQIGame\\UI\\Lottery\\LotteryUIEquipShow.lua

local m = {
	BgEffectPlayId = 0
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.EquipCell = EquipCell.New(self.EquipCellGo, false)

	UGUIUtil.SetTextInChildren(self.CloseBtn, LotteryUIApi:GetString("EquipShowCloseBtnText"))
end

function m:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function m:Show(userData)
	self.OnCloseCallback = userData.onClose

	self.View:SetActive(true)
	self.PanelNode:SetActive(false)

	local cfgItemData = userData.cfgItemData

	AssetUtil.LoadAsset(self, UIGlobalApi.GetImagePath(cfgItemData.Drawing), self.OnLoadSuccess, self.OnLoadFail)
	self.NewIcon:SetActive(userData.isNew)
	UGUIUtil.SetText(self.QualityText, LotteryUIApi:GetString("EquipShowQualityText", cfgItemData.Quality))
	UGUIUtil.SetText(self.NameText, LotteryUIApi:GetString("EquipShowNameText", cfgItemData.Name, cfgItemData.Quality))
	UGUIUtil.SetText(self.DescText, LotteryUIApi:GetString("EquipShowDescText", cfgItemData.Describe, cfgItemData.Quality))
	self.EquipCell:RefreshByCID(cfgItemData.Id, nil, true)

	self.Bg1:GetComponent("Image").sprite = self.Host.UIController:GetPreloadedAsset(LotteryUIApi:GetString("EquipShowBg1", cfgItemData.Quality))
	self.Bg2:GetComponent("Image").sprite = self.Host.UIController:GetPreloadedAsset(LotteryUIApi:GetString("EquipShowBg2", cfgItemData.Quality))
	self.BgEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(LotteryUIApi:GetString("EquipShowEffect", cfgItemData.Quality), 50000, 0, self.BgEffectNode, 0)
end

function m:OnLoadSuccess(assetName, asset, duration, userData)
	self.ItemDrawingImg:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(asset)

	self.PanelNode:SetActive(true)
end

function m:OnLoadFail(assetName, status, errorMessage, userData)
	return
end

function m:Hide()
	self.View:SetActive(false)

	if self.BgEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.BgEffectPlayId)

		self.BgEffectPlayId = 0
	end
end

function m:OnClickCloseBtn()
	self:Hide()

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback()
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.EquipCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
