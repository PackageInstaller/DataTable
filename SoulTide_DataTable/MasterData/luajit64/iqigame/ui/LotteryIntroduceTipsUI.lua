-- chunkname: @IQIGame\\UI\\LotteryIntroduceTipsUI.lua

local LotteryIntroduceTipsUI = Base:Extend("LotteryIntroduceTipsUI", "IQIGame.Onigao.UI.LotteryIntroduceTipsUI", {})

function LotteryIntroduceTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, LotteryIntroduceTipsUIApi:GetString("TitleText"))

	local descTexts = LotteryIntroduceTipsUIApi:GetString("DescTexts")

	for i = 1, #descTexts do
		local textItem = UnityEngine.Object.Instantiate(self.DescItemPrefab)

		textItem.transform:SetParent(self.DescItemContent.transform, false)
		UGUIUtil.SetTextInChildren(textItem, descTexts[i])
	end
end

function LotteryIntroduceTipsUI:GetPreloadAssetPaths()
	return nil
end

function LotteryIntroduceTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryIntroduceTipsUI:OnOpen(userData)
	return
end

function LotteryIntroduceTipsUI:OnClose(userData)
	return
end

function LotteryIntroduceTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function LotteryIntroduceTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function LotteryIntroduceTipsUI:OnPause()
	return
end

function LotteryIntroduceTipsUI:OnResume()
	return
end

function LotteryIntroduceTipsUI:OnCover()
	return
end

function LotteryIntroduceTipsUI:OnReveal()
	return
end

function LotteryIntroduceTipsUI:OnRefocus(userData)
	return
end

function LotteryIntroduceTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryIntroduceTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryIntroduceTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryIntroduceTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryIntroduceTipsUI:OnDestroy()
	return
end

function LotteryIntroduceTipsUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.LotteryIntroduceTipsUI)
end

return LotteryIntroduceTipsUI
