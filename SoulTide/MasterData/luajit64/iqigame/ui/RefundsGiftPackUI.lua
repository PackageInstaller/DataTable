-- chunkname: @IQIGame\\UI\\RefundsGiftPackUI.lua

local RefundsGiftPackUI = {
	RefundsGiftPackRenderCells = {}
}

RefundsGiftPackUI = Base:Extend("RefundsGiftPackUI", "IQIGame.Onigao.UI.RefundsGiftPackUI", RefundsGiftPackUI)

require("IQIGame.UIExternalApi.RefundsGiftPackUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local RefundsGiftPackRenderCell = require("IQIGame.UI.RefundsGiftPack.RefundsGiftPackRenderCell")

function RefundsGiftPackUI:OnInit()
	UGUIUtil.SetText(self.TitleText, RefundsGiftPackUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.BtnBack, RefundsGiftPackUIApi:GetString("BtnBackLabel"))
	UGUIUtil.SetTextInChildren(self.BtnReceive, RefundsGiftPackUIApi:GetString("BtnReceiveLabel"))

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateOnClickBtnReceive()
		self:OnClickBtnReceive()
	end

	function self.DelegateUpdateRefundsGiftPackEvent()
		self:OnUpdateRefundsGiftPack()
	end

	self.PackageMould:SetActive(false)

	self.RefundsGiftPackRenderPool = UIObjectPool.New(5, function()
		local cell = RefundsGiftPackRenderCell.New(UnityEngine.Object.Instantiate(self.PackageMould))

		return cell
	end, function(cell)
		cell:Dispose()
	end)
end

function RefundsGiftPackUI:GetPreloadAssetPaths()
	return nil
end

function RefundsGiftPackUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RefundsGiftPackUI:IsManualShowOnOpen(userData)
	return false
end

function RefundsGiftPackUI:GetBGM(userData)
	return nil
end

function RefundsGiftPackUI:OnOpen(userData)
	self:UpdateView()
end

function RefundsGiftPackUI:OnClose(userData)
	return
end

function RefundsGiftPackUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	self.BtnReceive:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnReceive)
	EventDispatcher.AddEventListener(EventID.UpdateRefundsGiftPackEvent, self.DelegateUpdateRefundsGiftPackEvent)
end

function RefundsGiftPackUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	self.BtnReceive:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnReceive)
	EventDispatcher.RemoveEventListener(EventID.UpdateRefundsGiftPackEvent, self.DelegateUpdateRefundsGiftPackEvent)
end

function RefundsGiftPackUI:OnPause()
	return
end

function RefundsGiftPackUI:OnResume()
	return
end

function RefundsGiftPackUI:OnCover()
	return
end

function RefundsGiftPackUI:OnReveal()
	return
end

function RefundsGiftPackUI:OnRefocus(userData)
	return
end

function RefundsGiftPackUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RefundsGiftPackUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RefundsGiftPackUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RefundsGiftPackUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RefundsGiftPackUI:OnDestroy()
	for i, v in pairs(self.RefundsGiftPackRenderCells) do
		self.RefundsGiftPackRenderPool:Release(v)
	end

	self.RefundsGiftPackRenderCells = {}

	self.RefundsGiftPackRenderPool:Dispose()
end

function RefundsGiftPackUI:OnUpdateRefundsGiftPack()
	self:UpdateView()
end

function RefundsGiftPackUI:UpdateView()
	for i, v in pairs(self.RefundsGiftPackRenderCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.RefundsGiftPackRenderPool:Release(v)
	end

	self.RefundsGiftPackRenderCells = {}

	local tab = PlayerModule.PlayerInfo.refundsGiftPacks

	for i, v in pairs(tab) do
		local cell = self.RefundsGiftPackRenderPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.PackageNode.transform, false)
		cell:SetData(i)
		table.insert(self.RefundsGiftPackRenderCells, cell)
	end

	local tab = RefundsGiftPackModule.CanGetReward()

	self.BtnReceive:GetComponent("GrayComponent"):SetGray(#tab == 0)
end

function RefundsGiftPackUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RefundsGiftPackUI:OnClickBtnBack()
	self:OnClickCloseBtn()
end

function RefundsGiftPackUI:OnClickBtnReceive()
	RefundsGiftPackModule.GetRefundsGiftPacks()
end

return RefundsGiftPackUI
