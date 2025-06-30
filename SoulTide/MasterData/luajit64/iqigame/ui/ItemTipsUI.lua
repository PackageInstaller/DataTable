-- chunkname: @IQIGame\\UI\\ItemTipsUI.lua

local ItemTipsUI = Base:Extend("ItemTipsUI", "IQIGame.Onigao.UI.ItemTipsUI", {})
local ItemTipController = require("IQIGame.UI.Tips.ItemTipController")
local PlaceGameEquipDetailView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseEquip.PlaceGameEquipDetailView")

function ItemTipsUI:OnInit()
	function self.DelegateOnClickGoBtnClose()
		self:OnClickGoBtnClose()
	end

	self.ItemTipController = ItemTipController.New(self.TipContent, function()
		self:Close()
	end)
	self.PlaceGameEquipController = PlaceGameEquipDetailView.New(self.TipPlaceGameEquip)
end

function ItemTipsUI:GetPreloadAssetPaths()
	return nil
end

function ItemTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ItemTipsUI:OnOpen(userData)
	self:RefreshView(userData)
end

function ItemTipsUI:OnClose(userData)
	return
end

function ItemTipsUI:OnAddListeners()
	self.ItemTipController:AddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGoBtnClose)
end

function ItemTipsUI:OnRemoveListeners()
	self.ItemTipController:RemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGoBtnClose)
end

function ItemTipsUI:OnPause()
	return
end

function ItemTipsUI:OnResume()
	return
end

function ItemTipsUI:OnCover()
	return
end

function ItemTipsUI:OnReveal()
	return
end

function ItemTipsUI:OnRefocus(userData)
	return
end

function ItemTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ItemTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ItemTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ItemTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ItemTipsUI:OnDestroy()
	self.ItemTipController:Dispose()
	self.PlaceGameEquipController:Dispose()
end

function ItemTipsUI:RefreshView(userData)
	if userData.data.placeGameEquipData then
		self.TipPlaceGameEquip:SetActive(true)
		self.TipContent:SetActive(false)
		self.PlaceGameEquipController:Refresh(userData.data, nil, 0)
	else
		self.TipContent:SetActive(true)
		self.TipPlaceGameEquip:SetActive(false)
		self.ItemTipController:SetData(userData.data, userData.forShow, userData.hideSource)
	end
end

function ItemTipsUI:OnClickGoBtnClose()
	self:Close()
end

function ItemTipsUI:Close()
	UIModule.CloseSelf(self)
end

return ItemTipsUI
