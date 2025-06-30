-- chunkname: @IQIGame\\UI\\CommonGiftTipsUI.lua

local GiftTipsContent = require("IQIGame.UI.CommonTips.GiftTipsContent.GiftTipsContent")
local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local CommonGiftTipsUI = Base:Extend("CommonGiftTipsUI", "IQIGame.Onigao.UI.CommonGiftTipsUI", {})

function CommonGiftTipsUI:OnInit()
	self.tipsContent = GiftTipsContent.New(self.GiftTipsContent)

	function self.__closeBtnClickProxy()
		self:__OnCloseBtnClickHandler()
	end
end

function CommonGiftTipsUI:GetPreloadAssetPaths()
	return nil
end

function CommonGiftTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonGiftTipsUI:IsManualShowOnOpen(userData)
	return false
end

function CommonGiftTipsUI:GetBGM(userData)
	return nil
end

function CommonGiftTipsUI:OnOpen(userData)
	local contentRectTrans = self.tipsContent.gameObject:GetComponent("RectTransform")

	if userData.itemCell ~= nil then
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPositionByCell(self.Root:GetComponent("RectTransform"), userData.itemCell, contentRectTrans)
	else
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPosition(self.Root:GetComponent("RectTransform"), contentRectTrans)
	end

	self.tipsContent:SetData(userData)
end

function CommonGiftTipsUI:OnClose(userData)
	return
end

function CommonGiftTipsUI:OnAddListeners()
	self.CloseBackground:GetComponent("Button").onClick:AddListener(self.__closeBtnClickProxy)
end

function CommonGiftTipsUI:OnRemoveListeners()
	self.CloseBackground:GetComponent("Button").onClick:RemoveListener(self.__closeBtnClickProxy)
end

function CommonGiftTipsUI:OnPause()
	return
end

function CommonGiftTipsUI:OnResume()
	return
end

function CommonGiftTipsUI:OnCover()
	return
end

function CommonGiftTipsUI:OnReveal()
	return
end

function CommonGiftTipsUI:OnRefocus(userData)
	return
end

function CommonGiftTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommonGiftTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonGiftTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonGiftTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonGiftTipsUI:OnDestroy()
	self.tipsContent:Dispose()
end

function CommonGiftTipsUI:__OnCloseBtnClickHandler()
	UIModule.Close(Constant.UIControllerName.CommonGiftTipsUI)
end

return CommonGiftTipsUI
