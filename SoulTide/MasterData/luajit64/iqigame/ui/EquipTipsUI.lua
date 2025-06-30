-- chunkname: @IQIGame\\UI\\EquipTipsUI.lua

local EquipTipsUI = Base:Extend("EquipTipsUI", "IQIGame.Onigao.UI.EquipTipsUI", {})
local EquipTipContent = require("IQIGame.UI.Tips.EquipTipContent")
local EquipInfoCell = require("IQIGame.UI.Tips.EquipInfoCell")

function EquipTipsUI:OnInit()
	self:Initialize()
end

function EquipTipsUI:GetPreloadAssetPaths()
	return nil
end

function EquipTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipTipsUI:OnOpen(userData)
	self:RefreshView(userData)
end

function EquipTipsUI:OnClose(userData)
	self:OnHide()
end

function EquipTipsUI:OnAddListeners()
	self.btnUp.onClick:AddListener(self.onClickBtnUpDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function EquipTipsUI:OnRemoveListeners()
	self.btnUp.onClick:RemoveListener(self.onClickBtnUpDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function EquipTipsUI:OnPause()
	return
end

function EquipTipsUI:OnResume()
	return
end

function EquipTipsUI:OnCover()
	return
end

function EquipTipsUI:OnReveal()
	return
end

function EquipTipsUI:OnRefocus(userData)
	return
end

function EquipTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipTipsUI:OnDestroy()
	self.contentView:OnDestroy()
	self.infoCell:OnDestroy()
end

function EquipTipsUI:Initialize()
	local scrollRect = self.goScrollRect:GetComponent("ScrollRect")
	local goView = scrollRect.viewport:GetChild(0).gameObject

	scrollRect.content = goView:GetComponent("RectTransform")
	self.infoCell = EquipInfoCell.New(self.goSlotParent.transform:GetChild(0).gameObject)
	self.contentView = EquipTipContent.New(goView)
	self.btnUp = self.goBtnUp:GetComponent("Button")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnUpDelegate()
		self:OnClickBtnUp()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goViewTitle:GetComponent("Text").text = EquipTipApi:GetString("goViewTitle")
end

function EquipTipsUI:RefreshView(userData)
	self.itemData = userData[1]
	self.forShow = userData[2]

	if self.itemData.classType ~= "ItemData" then
		self.itemData = ItemData.CreateByCIDAndNumber(self.itemData.Id, 1)
	end

	self.goBtnUp:SetActive(not self.forShow and not self.itemData.IsMazeItem)
	self.infoCell:RefreshView(self.itemData, self)
	self.contentView:RefreshView(self.itemData)
end

function EquipTipsUI:OnHide()
	self.infoCell:OnHide()
end

function EquipTipsUI:OnClickBtnUp()
	UIModule.Open(Constant.UIControllerName.EquipBuildUI, Constant.UILayer.UI, self.itemData)
	self:OnClickBtnClose()
end

function EquipTipsUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.EquipTipsUI)
end

return EquipTipsUI
