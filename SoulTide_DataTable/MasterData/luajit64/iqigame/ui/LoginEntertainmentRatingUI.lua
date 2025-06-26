-- chunkname: @IQIGame\\UI\\LoginEntertainmentRatingUI.lua

local LoginEntertainmentRatingUI = {}

LoginEntertainmentRatingUI = Base:Extend("LoginEntertainmentRatingUI", "IQIGame.Onigao.UI.LoginEntertainmentRatingUI", LoginEntertainmentRatingUI)

function LoginEntertainmentRatingUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, LoginEntertainmentRatingUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.DescText, LoginEntertainmentRatingUIApi:GetString("DescText"))
end

function LoginEntertainmentRatingUI:GetPreloadAssetPaths()
	return nil
end

function LoginEntertainmentRatingUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LoginEntertainmentRatingUI:IsManualShowOnOpen(userData)
	return false
end

function LoginEntertainmentRatingUI:GetBGM(userData)
	return nil
end

function LoginEntertainmentRatingUI:OnOpen(userData)
	return
end

function LoginEntertainmentRatingUI:OnClose(userData)
	return
end

function LoginEntertainmentRatingUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function LoginEntertainmentRatingUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function LoginEntertainmentRatingUI:OnPause()
	return
end

function LoginEntertainmentRatingUI:OnResume()
	return
end

function LoginEntertainmentRatingUI:OnCover()
	return
end

function LoginEntertainmentRatingUI:OnReveal()
	return
end

function LoginEntertainmentRatingUI:OnRefocus(userData)
	return
end

function LoginEntertainmentRatingUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LoginEntertainmentRatingUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoginEntertainmentRatingUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoginEntertainmentRatingUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoginEntertainmentRatingUI:OnDestroy()
	return
end

function LoginEntertainmentRatingUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return LoginEntertainmentRatingUI
