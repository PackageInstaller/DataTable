-- chunkname: @IQIGame\\UI\\HorizontalRpgIntroduceTipsUI.lua

local HorizontalRpgIntroduceTipsUI = {}

HorizontalRpgIntroduceTipsUI = Base:Extend("HorizontalRpgIntroduceTipsUI", "IQIGame.Onigao.UI.HorizontalRpgIntroduceTipsUI", HorizontalRpgIntroduceTipsUI)

require("IQIGame.UIExternalApi.HorizontalRpgIntroduceTipsUIApi")

function HorizontalRpgIntroduceTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn1()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, HorizontalRpgIntroduceTipsUIApi:GetString("TitleText", HorizontalRPGModule.globalCid))

	local descTexts = HorizontalRpgIntroduceTipsUIApi:GetString("DescTexts", HorizontalRPGModule.globalCid)

	if descTexts ~= nil then
		for i = 1, #descTexts do
			local go = UnityEngine.Object.Instantiate(self.DescItemPrefab)

			UGUIUtil.SetTextInChildren(go, descTexts[i])
			go.transform:SetParent(self.DescItemContent.transform, false)
		end
	end
end

function HorizontalRpgIntroduceTipsUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRpgIntroduceTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRpgIntroduceTipsUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRpgIntroduceTipsUI:GetBGM(userData)
	return nil
end

function HorizontalRpgIntroduceTipsUI:OnOpen(userData)
	return
end

function HorizontalRpgIntroduceTipsUI:OnClose(userData)
	return
end

function HorizontalRpgIntroduceTipsUI:OnAddListeners()
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn1)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function HorizontalRpgIntroduceTipsUI:OnRemoveListeners()
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn1)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function HorizontalRpgIntroduceTipsUI:OnPause()
	return
end

function HorizontalRpgIntroduceTipsUI:OnResume()
	return
end

function HorizontalRpgIntroduceTipsUI:OnCover()
	return
end

function HorizontalRpgIntroduceTipsUI:OnReveal()
	return
end

function HorizontalRpgIntroduceTipsUI:OnRefocus(userData)
	return
end

function HorizontalRpgIntroduceTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRpgIntroduceTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRpgIntroduceTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRpgIntroduceTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRpgIntroduceTipsUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function HorizontalRpgIntroduceTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return HorizontalRpgIntroduceTipsUI
