-- chunkname: @IQIGame\\UI\\UnlockNoticeUI.lua

local UnlockNoticeUI = Base:Extend("UnlockNoticeUI", "IQIGame.Onigao.UI.UnlockNoticeUI", {})

function UnlockNoticeUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnCloseBigFloatNoticeUI()
		self:OnCloseBigFloatNoticeUI()
	end

	self.TitleText:GetComponent("Text").text = UnlockNoticeUIApi:GetString("TitleText")
end

function UnlockNoticeUI:GetPreloadAssetPaths()
	return nil
end

function UnlockNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UnlockNoticeUI:OnOpen(userData)
	if userData.TitleText ~= nil then
		self.TitleText:GetComponent("Text").text = userData.TitleText
	else
		self.TitleText:GetComponent("Text").text = UnlockNoticeUIApi:GetString("TitleText")
	end

	local isShow = userData.typeText ~= nil and userData.typeText ~= ""

	self.TypeNode:SetActive(isShow)

	self.TypeText:GetComponent("Text").text = UnlockNoticeUIApi:GetString("TypeText", userData.typeText)
	isShow = userData.nameText ~= nil and userData.nameText ~= ""

	self.NameNode:SetActive(isShow)

	self.NameText:GetComponent("Text").text = UnlockNoticeUIApi:GetString("NameText", userData.nameText)
	isShow = userData.nameText1 ~= nil and userData.nameText1 ~= ""

	self.NameNode1:SetActive(isShow)

	self.NameText1:GetComponent("Text").text = UnlockNoticeUIApi:GetString("NameText1", userData.nameText1)

	self.MainPanel.transform:SetParent(self["Pos" .. userData.index].transform, false)

	self.DelayCloseTimer = Timer.New(function()
		self.DelayCloseTimer = nil

		UIModule.Close(Constant.UIControllerName.UnlockNoticeUI)
	end, 3)

	self.DelayCloseTimer:Start()
end

function UnlockNoticeUI:OnClose(userData)
	self:StopDelayCloseTimer()
end

function UnlockNoticeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.CloseBigFloatNoticeUI, self.DelegateOnCloseBigFloatNoticeUI)
end

function UnlockNoticeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.CloseBigFloatNoticeUI, self.DelegateOnCloseBigFloatNoticeUI)
end

function UnlockNoticeUI:OnPause()
	return
end

function UnlockNoticeUI:OnResume()
	return
end

function UnlockNoticeUI:OnCover()
	return
end

function UnlockNoticeUI:OnReveal()
	return
end

function UnlockNoticeUI:OnRefocus(userData)
	return
end

function UnlockNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UnlockNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UnlockNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UnlockNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UnlockNoticeUI:OnDestroy()
	return
end

function UnlockNoticeUI:StopDelayCloseTimer()
	if self.DelayCloseTimer ~= nil then
		self.DelayCloseTimer:Stop()

		self.DelayCloseTimer = nil
	end
end

function UnlockNoticeUI:OnClickCloseBtn()
	EventDispatcher.Dispatch(EventID.CloseBigFloatNoticeUI)
end

function UnlockNoticeUI:OnCloseBigFloatNoticeUI()
	self:StopDelayCloseTimer()
	UIModule.Close(Constant.UIControllerName.UnlockNoticeUI)
end

return UnlockNoticeUI
