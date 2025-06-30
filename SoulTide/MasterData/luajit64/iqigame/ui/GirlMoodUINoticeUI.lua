-- chunkname: @IQIGame\\UI\\GirlMoodUINoticeUI.lua

local GirlMoodUINoticeUI = Base:Extend("GirlMoodUINoticeUI", "IQIGame.Onigao.UI.GirlMoodUINoticeUI", {})

function GirlMoodUINoticeUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.TitleText:GetComponent("Text").text = GirlMoodUINoticeUIApi:GetString("TitleText")
end

function GirlMoodUINoticeUI:GetPreloadAssetPaths()
	return nil
end

function GirlMoodUINoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GirlMoodUINoticeUI:OnOpen(userData)
	local soulCid = userData[1]
	local nowMood = userData[2]
	local nowState = userData[3]
	local path = GirlMoodUINoticeUIApi:GetString("StatePath", nowState)

	AssetUtil.LoadImage(self, path, self.ImageIcon:GetComponent("Image"))

	local per = SoulModule.GetMoodPer(soulCid, nowMood)

	self.ImgBar.transform.anchoredPosition = Vector2(235 * per - 5, 0)

	local str = GirlMoodUINoticeUIApi:GetString("TextMoodChange", "", GirlMoodUINoticeUIApi:GetString("TextState", nowState))

	UGUIUtil.SetText(self.TextDes, str)

	self.DelayCloseTimer = Timer.New(function()
		self.DelayCloseTimer = nil

		UIModule.Close(Constant.UIControllerName.GirlMoodUINoticeUI)
	end, 3)

	self.DelayCloseTimer:Start()
end

function GirlMoodUINoticeUI:OnClose(userData)
	self:StopDelayCloseTimer()
end

function GirlMoodUINoticeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function GirlMoodUINoticeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function GirlMoodUINoticeUI:OnPause()
	return
end

function GirlMoodUINoticeUI:OnResume()
	return
end

function GirlMoodUINoticeUI:OnCover()
	return
end

function GirlMoodUINoticeUI:OnReveal()
	return
end

function GirlMoodUINoticeUI:OnRefocus(userData)
	return
end

function GirlMoodUINoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GirlMoodUINoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlMoodUINoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GirlMoodUINoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlMoodUINoticeUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GirlMoodUINoticeUI:StopDelayCloseTimer()
	if self.DelayCloseTimer ~= nil then
		self.DelayCloseTimer:Stop()

		self.DelayCloseTimer = nil
	end
end

function GirlMoodUINoticeUI:OnClickCloseBtn()
	self:StopDelayCloseTimer()
	UIModule.Close(Constant.UIControllerName.GirlMoodUINoticeUI)
end

return GirlMoodUINoticeUI
