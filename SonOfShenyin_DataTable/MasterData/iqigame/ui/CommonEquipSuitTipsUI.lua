-- chunkname: @IQIGame\\UI\\CommonEquipSuitTipsUI.lua

local EquipPreviewTipsContent = require("IQIGame.UI.CommonTips.EquipPreviewTipsContent.EquipPreviewTipsContent")
local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local CommonEquipSuitTipsUI = Base:Extend("CommonEquipSuitTipsUI", "IQIGame.Onigao.UI.CommonEquipSuitTipsUI", {})

function CommonEquipSuitTipsUI:OnInit()
	self.tipsContent = EquipPreviewTipsContent.New(self.EquipSuitTipsContent)

	function self.__closeButtonClickProxy()
		self:__OnCloseButtonClickEventHandler()
	end
end

function CommonEquipSuitTipsUI:GetPreloadAssetPaths()
	return nil
end

function CommonEquipSuitTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonEquipSuitTipsUI:IsManualShowOnOpen(userData)
	return false
end

function CommonEquipSuitTipsUI:GetBGM(userData)
	return nil
end

function CommonEquipSuitTipsUI:OnOpen(userData)
	local contentRectTrans = self.tipsContent.gameObject:GetComponent("RectTransform")

	if userData.itemCell ~= nil then
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPositionByCell(self.Root:GetComponent("RectTransform"), userData.itemCell, contentRectTrans)
	else
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPosition(self.Root:GetComponent("RectTransform"), contentRectTrans)
	end

	self.tipsContent:SetData(userData)
end

function CommonEquipSuitTipsUI:OnClose(userData)
	return
end

function CommonEquipSuitTipsUI:OnAddListeners()
	self.CloseBackground:GetComponent("Button").onClick:AddListener(self.__closeButtonClickProxy)
end

function CommonEquipSuitTipsUI:OnRemoveListeners()
	self.CloseBackground:GetComponent("Button").onClick:RemoveListener(self.__closeButtonClickProxy)
end

function CommonEquipSuitTipsUI:OnPause()
	return
end

function CommonEquipSuitTipsUI:OnResume()
	return
end

function CommonEquipSuitTipsUI:OnCover()
	return
end

function CommonEquipSuitTipsUI:OnReveal()
	return
end

function CommonEquipSuitTipsUI:OnRefocus(userData)
	return
end

function CommonEquipSuitTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommonEquipSuitTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonEquipSuitTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonEquipSuitTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonEquipSuitTipsUI:OnDestroy()
	return
end

function CommonEquipSuitTipsUI:__OnCloseButtonClickEventHandler()
	UIModule.Close(Constant.UIControllerName.CommonEquipSuitTipsUI)
end

return CommonEquipSuitTipsUI
