-- chunkname: @IQIGame\\UI\\TransformUI.lua

local TransformUI = {}

TransformUI = Base:Extend("TransformUI", "IQIGame.Onigao.UI.TransformUI", TransformUI)

local TransformUIItemBagPanelClass = require("IQIGame.UI.TransformUI.TransformUIItemBagPanel")
local TransformUIChangeBagPanelClass = require("IQIGame.UI.TransformUI.TransformUIChangeBagPanel")
local TransformUICompoundContentClass = require("IQIGame.UI.TransformUI.TransformUICompoundContent")
local TransformUITransContentClass = require("IQIGame.UI.TransformUI.TransformUITransContent")
local TransformUIConfirmPanelClass = require("IQIGame.UI.TransformUI.TransformUIConfirmPanel")

function TransformUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function TransformUI:InitComponent()
	self.toggleCompound = self.compoundTab:GetComponent("Toggle")
	self.toggleTransform = self.transformTab:GetComponent("Toggle")
	self.toggleAdjust = self.adjustTab:GetComponent("Toggle")
	self.ItemBagPanel = TransformUIItemBagPanelClass.New(self.ItemBagParent, self)

	self.ItemBagPanel:Close()

	self.ChangeBagPanel = TransformUIChangeBagPanelClass.New(self.changeBagParent, self)

	self.ChangeBagPanel:Close()

	self.CompoundContent = TransformUICompoundContentClass.New(self.compoundContent, self)

	self.CompoundContent:Close()

	self.TransContent = TransformUITransContentClass.New(self.transformContent, self)

	self.TransContent:Close()

	self.ConfirmPanel = TransformUIConfirmPanelClass.New(self.confirmWindow, self)

	self.ConfirmPanel:Close()

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.toggleAdjust.enabled = false
end

function TransformUI:InitDelegate()
	function self.DelegateOncompoundTabValueChanged(isOn)
		self:OncompoundTabValueChanged(isOn)
	end

	function self.DelegateOntransformTabValueChanged(isOn)
		self:OntransformTabValueChanged(isOn)
	end

	function self.DelegateOnadjustTabValueChanged(isOn)
		self:OnadjustTabValueChanged(isOn)
	end

	function self.CompoundSelectItemEvent(CfgCombinationID, itemCell)
		self:CompoundSelectItem(CfgCombinationID, itemCell)
	end

	function self.TransSelectItemEvent(CfgCombinationID, itemCell)
		self:TransSelectItem(CfgCombinationID, itemCell)
	end

	function self.ShowRecipeDelegate(CfgCombinationID, type, itemID)
		self:ShowChangeRecipe(CfgCombinationID, type, itemID)
	end

	function self.ShowConfirmPanelDelegate(CfgCombinationID, consume)
		self:ShowConfirmPanel(CfgCombinationID, consume)
	end
end

function TransformUI:OnAddListeners()
	self.compoundTab:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOncompoundTabValueChanged)
	self.transformTab:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOntransformTabValueChanged)
	self.adjustTab:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnadjustTabValueChanged)
	EventDispatcher.AddEventListener(EventID.TransformUICompoundSelectItemEvent, self.CompoundSelectItemEvent)
	EventDispatcher.AddEventListener(EventID.TransformUITransSelectItemEvent, self.TransSelectItemEvent)
	EventDispatcher.AddEventListener(EventID.TransformUIShowChangeRecipe, self.ShowRecipeDelegate)
	EventDispatcher.AddEventListener(EventID.TransformUIShowConfirmPanel, self.ShowConfirmPanelDelegate)
end

function TransformUI:OnRemoveListeners()
	self.compoundTab:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOncompoundTabValueChanged)
	self.transformTab:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOntransformTabValueChanged)
	self.adjustTab:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnadjustTabValueChanged)
	EventDispatcher.RemoveEventListener(EventID.TransformUICompoundSelectItemEvent, self.CompoundSelectItemEvent)
	EventDispatcher.RemoveEventListener(EventID.TransformUITransSelectItemEvent, self.TransSelectItemEvent)
	EventDispatcher.RemoveEventListener(EventID.TransformUIShowChangeRecipe, self.ShowRecipeDelegate)
	EventDispatcher.RemoveEventListener(EventID.TransformUIShowConfirmPanel, self.ShowConfirmPanelDelegate)
end

function TransformUI:OnOpen(userData)
	self.toggleCompound.isOn = true

	self:OncompoundTabValueChanged(true)
end

function TransformUI:OnClose(userData)
	return
end

function TransformUI:GetPreloadAssetPaths()
	return nil
end

function TransformUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TransformUI:IsManualShowOnOpen(userData)
	return false
end

function TransformUI:GetBGM(userData)
	return nil
end

function TransformUI:OnPause()
	return
end

function TransformUI:OnResume()
	return
end

function TransformUI:OnCover()
	return
end

function TransformUI:OnReveal()
	return
end

function TransformUI:OnRefocus(userData)
	return
end

function TransformUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TransformUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TransformUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TransformUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TransformUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.ItemBagPanel:OnDestroy()
	self.ChangeBagPanel:OnDestroy()
	self.CompoundContent:OnDestroy()
	self.TransContent:OnDestroy()
	self.ConfirmPanel:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function TransformUI:OncompoundTabValueChanged(isOn)
	if isOn then
		self.ItemBagPanel:Open()
		self.ItemBagPanel:RefreshCompoundItem()
		self.ItemBagPanel:SelectTheFirst()
	else
		self.ItemBagPanel:Close()
	end
end

function TransformUI:OntransformTabValueChanged(isOn)
	if isOn then
		self.ItemBagPanel:Open()
		self.ItemBagPanel:RefreshChangeItem()
		self.ItemBagPanel:SelectTheFirst()
	else
		self.ItemBagPanel:Close()
	end
end

function TransformUI:OnadjustTabValueChanged(isOn)
	NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, "功能未开放")
end

function TransformUI:CompoundSelectItem(CfgCombinationID, itemCell)
	self.TransContent:Close()
	self.CompoundContent:Open()
	self.CompoundContent:Refresh(CfgCombinationID, itemCell)
end

function TransformUI:TransSelectItem(CfgCombinationID, itemCell)
	self.CompoundContent:Close()
	self.TransContent:Open()
	self.TransContent:Refresh(CfgCombinationID, itemCell)
end

function TransformUI:ShowChangeRecipe(CfgCombinationID, type, itemID)
	self.ChangeBagPanel:Open()
	self.ChangeBagPanel:Refresh(CfgCombinationID, type, itemID)
end

function TransformUI:ShowConfirmPanel(CfgCombinationID, consume)
	self.ConfirmPanel:Open()
	self.ConfirmPanel:Refresh(CfgCombinationID, consume)
end

return TransformUI
