-- chunkname: @IQIGame\\UI\\CommonEquipTipsUI.lua

local EquipTipsContent = require("IQIGame.UI.CommonTips.EquipTipsContent.EquipTipsContent")
local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local CommonEquipTipsUI = {}

CommonEquipTipsUI = Base:Extend("CommonEquipTipsUI", "IQIGame.Onigao.UI.CommonEquipTipsUI", CommonEquipTipsUI)

function CommonEquipTipsUI:OnInit()
	self.tipsContent = EquipTipsContent.New(self.EquipTipsContent)

	function self.__closeButtonClickProxy()
		self:__OnCloseButtonClickEventHandler()
	end
end

function CommonEquipTipsUI:GetPreloadAssetPaths()
	return nil
end

function CommonEquipTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonEquipTipsUI:IsManualShowOnOpen(userData)
	return false
end

function CommonEquipTipsUI:GetBGM(userData)
	return nil
end

function CommonEquipTipsUI:OnOpen(userData)
	self.tipsContent:SetData(userData)

	local contentRectTrans = self.tipsContent.gameObject:GetComponent("RectTransform")

	if userData.itemCell ~= nil then
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPositionByCell(self.Root:GetComponent("RectTransform"), userData.itemCell, contentRectTrans)
	else
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPosition(self.Root:GetComponent("RectTransform"), contentRectTrans)
	end
end

function CommonEquipTipsUI:OnClose(userData)
	return
end

function CommonEquipTipsUI:OnAddListeners()
	self.CloseBackground:GetComponent("Button").onClick:AddListener(self.__closeButtonClickProxy)
end

function CommonEquipTipsUI:OnRemoveListeners()
	self.CloseBackground:GetComponent("Button").onClick:RemoveListener(self.__closeButtonClickProxy)
end

function CommonEquipTipsUI:OnPause()
	return
end

function CommonEquipTipsUI:OnResume()
	return
end

function CommonEquipTipsUI:OnCover()
	return
end

function CommonEquipTipsUI:OnReveal()
	return
end

function CommonEquipTipsUI:OnRefocus(userData)
	return
end

function CommonEquipTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommonEquipTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonEquipTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonEquipTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonEquipTipsUI:OnDestroy()
	self.tipsContent:Dispose()
end

function CommonEquipTipsUI:__OnCloseButtonClickEventHandler()
	UIModule.Close(Constant.UIControllerName.CommonEquipTipsUI)
end

return CommonEquipTipsUI
