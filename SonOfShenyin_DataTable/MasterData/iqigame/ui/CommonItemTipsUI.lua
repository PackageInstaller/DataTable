-- chunkname: @IQIGame\\UI\\CommonItemTipsUI.lua

local ItemTipsContent = require("IQIGame.UI.CommonTips.ItemTipsContent.ItemTipsContent")
local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local CommonItemTipsUI = {}

CommonItemTipsUI = Base:Extend("CommonItemTipsUI", "IQIGame.Onigao.UI.CommonItemTipsUI", CommonItemTipsUI)

function CommonItemTipsUI:OnInit()
	self.tipsContent = ItemTipsContent.New(self.ItemTipsContent)

	function self.__closeBtnClickProxy()
		self:__OnCloseBtnClickHandler()
	end
end

function CommonItemTipsUI:GetPreloadAssetPaths()
	return nil
end

function CommonItemTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonItemTipsUI:IsManualShowOnOpen(userData)
	return false
end

function CommonItemTipsUI:GetBGM(userData)
	return nil
end

function CommonItemTipsUI:OnOpen(userData)
	local contentRectTrans = self.tipsContent.gameObject:GetComponent("RectTransform")

	if userData.itemCell ~= nil then
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPositionByCell(self.Root:GetComponent("RectTransform"), userData.itemCell, contentRectTrans)
	else
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPosition(self.Root:GetComponent("RectTransform"), contentRectTrans)
	end

	self.tipsContent:SetData(userData)
end

function CommonItemTipsUI:OnClose(userData)
	return
end

function CommonItemTipsUI:OnAddListeners()
	self.CloseBg:GetComponent("Button").onClick:AddListener(self.__closeBtnClickProxy)
end

function CommonItemTipsUI:OnRemoveListeners()
	self.CloseBg:GetComponent("Button").onClick:RemoveListener(self.__closeBtnClickProxy)
end

function CommonItemTipsUI:OnPause()
	return
end

function CommonItemTipsUI:OnResume()
	return
end

function CommonItemTipsUI:OnCover()
	return
end

function CommonItemTipsUI:OnReveal()
	return
end

function CommonItemTipsUI:OnRefocus(userData)
	return
end

function CommonItemTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommonItemTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonItemTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonItemTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonItemTipsUI:OnDestroy()
	self.tipsContent:Dispose()
end

function CommonItemTipsUI:__OnCloseBtnClickHandler()
	UIModule.Close(Constant.UIControllerName.CommonItemTipsUI)
end

return CommonItemTipsUI
