-- chunkname: @IQIGame\\UI\\RpgIntroduceTipsUI.lua

local RpgIntroduceTipsUI = {}

RpgIntroduceTipsUI = Base:Extend("RpgIntroduceTipsUI", "IQIGame.Onigao.UI.RpgIntroduceTipsUI", RpgIntroduceTipsUI)

function RpgIntroduceTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, RpgIntroduceTipsUIApi:GetString("TitleText", RpgMazeModule.DailyDupPOD.common.openCount))

	local descTexts = RpgIntroduceTipsUIApi:GetString("DescTexts", RpgMazeModule.DailyDupPOD.common.openCount)

	if descTexts ~= nil then
		for i = 1, #descTexts do
			local go = UnityEngine.Object.Instantiate(self.DescItemPrefab)

			UGUIUtil.SetTextInChildren(go, descTexts[i])
			go.transform:SetParent(self.DescItemContent.transform, false)
		end
	end
end

function RpgIntroduceTipsUI:GetPreloadAssetPaths()
	return nil
end

function RpgIntroduceTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RpgIntroduceTipsUI:IsManualShowOnOpen(userData)
	return false
end

function RpgIntroduceTipsUI:GetBGM(userData)
	return nil
end

function RpgIntroduceTipsUI:OnOpen(userData)
	return
end

function RpgIntroduceTipsUI:OnClose(userData)
	return
end

function RpgIntroduceTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function RpgIntroduceTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function RpgIntroduceTipsUI:OnPause()
	return
end

function RpgIntroduceTipsUI:OnResume()
	return
end

function RpgIntroduceTipsUI:OnCover()
	return
end

function RpgIntroduceTipsUI:OnReveal()
	return
end

function RpgIntroduceTipsUI:OnRefocus(userData)
	return
end

function RpgIntroduceTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RpgIntroduceTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RpgIntroduceTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RpgIntroduceTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RpgIntroduceTipsUI:OnDestroy()
	return
end

function RpgIntroduceTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return RpgIntroduceTipsUI
