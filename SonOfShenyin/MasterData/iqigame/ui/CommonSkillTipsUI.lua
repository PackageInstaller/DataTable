-- chunkname: @IQIGame\\UI\\CommonSkillTipsUI.lua

local SkillTipsContent = require("IQIGame.UI.CommonTips.SkillTipsContent.SkillTipsContent")
local CommonTipsHelper = require("IQIGame.UI.CommonTips.CommonTipsHelper")
local CommonSkillTipsUI = {}

CommonSkillTipsUI = Base:Extend("CommonSkillTipsUI", "IQIGame.Onigao.UI.CommonSkillTipsUI", CommonSkillTipsUI)

function CommonSkillTipsUI:OnInit()
	self.tipsContent = SkillTipsContent.New(self.SkillTipsContent)

	function self.__closeButtonClickProxy()
		self:__OnCloseButtonClickEventHandler()
	end
end

function CommonSkillTipsUI:GetPreloadAssetPaths()
	return nil
end

function CommonSkillTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonSkillTipsUI:IsManualShowOnOpen(userData)
	return false
end

function CommonSkillTipsUI:GetBGM(userData)
	return nil
end

function CommonSkillTipsUI:OnOpen(userData)
	self.tipsContent:SetData(userData)

	local contentRectTrans = self.tipsContent.gameObject:GetComponent("RectTransform")

	if userData.itemCell ~= nil then
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPositionByCell(self.Root:GetComponent("RectTransform"), userData.itemCell, contentRectTrans)
	else
		contentRectTrans.localPosition = CommonTipsHelper.CalculationTipsContentPosition(self.Root:GetComponent("RectTransform"), contentRectTrans)
	end
end

function CommonSkillTipsUI:OnClose(userData)
	return
end

function CommonSkillTipsUI:OnAddListeners()
	self.CloseBackground:GetComponent("Button").onClick:AddListener(self.__closeButtonClickProxy)
end

function CommonSkillTipsUI:OnRemoveListeners()
	self.CloseBackground:GetComponent("Button").onClick:RemoveListener(self.__closeButtonClickProxy)
end

function CommonSkillTipsUI:OnPause()
	return
end

function CommonSkillTipsUI:OnResume()
	return
end

function CommonSkillTipsUI:OnCover()
	return
end

function CommonSkillTipsUI:OnReveal()
	return
end

function CommonSkillTipsUI:OnRefocus(userData)
	return
end

function CommonSkillTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommonSkillTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonSkillTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonSkillTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonSkillTipsUI:OnDestroy()
	self.tipsContent:Dispose()
end

function CommonSkillTipsUI:__OnCloseButtonClickEventHandler()
	UIModule.Close(Constant.UIControllerName.CommonSkillTipsUI)
end

return CommonSkillTipsUI
