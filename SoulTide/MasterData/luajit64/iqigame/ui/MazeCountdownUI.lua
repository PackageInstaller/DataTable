-- chunkname: @IQIGame\\UI\\MazeCountdownUI.lua

require("IQIGame.UIExternalApi.MazeCountdownUIApi")

local MazeCountdownUI = {
	TotalTime = 0,
	RefreshElapsedTime = 0
}

MazeCountdownUI = Base:Extend("MazeCountdownUI", "IQIGame.Onigao.UI.MazeCountdownUI", MazeCountdownUI)

function MazeCountdownUI:OnInit()
	self.MinuteTextCom = self.MinuteText:GetComponent("Text")
	self.SecondTextCom = self.SecondText:GetComponent("Text")
	self.NormalProgressBarCom = self.NormalProgressBar:GetComponent("Image")
	self.UrgentProgressBarCom = self.UrgentProgressBar:GetComponent("Image")

	UGUIUtil.SetText(self.LeftTimeLabel, MazeCountdownUIApi:GetString("LeftTimeLabel"))
end

function MazeCountdownUI:GetPreloadAssetPaths()
	return nil
end

function MazeCountdownUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeCountdownUI:IsManualShowOnOpen(userData)
	return false
end

function MazeCountdownUI:GetBGM(userData)
	return nil
end

function MazeCountdownUI:OnOpen(userData)
	self:UpdateView(userData.cid)
end

function MazeCountdownUI:OnClose(userData)
	return
end

function MazeCountdownUI:OnAddListeners()
	return
end

function MazeCountdownUI:OnRemoveListeners()
	return
end

function MazeCountdownUI:OnPause()
	return
end

function MazeCountdownUI:OnResume()
	return
end

function MazeCountdownUI:OnCover()
	return
end

function MazeCountdownUI:OnReveal()
	return
end

function MazeCountdownUI:OnRefocus(userData)
	return
end

function MazeCountdownUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.RefreshElapsedTime = self.RefreshElapsedTime + realElapseSeconds

	if self.RefreshElapsedTime > 0.1 then
		self.RefreshElapsedTime = 0

		self:RefreshCountdown()
	end
end

function MazeCountdownUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeCountdownUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeCountdownUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeCountdownUI:OnDestroy()
	self.MinuteTextCom = nil
	self.SecondTextCom = nil
	self.NormalProgressBarCom = nil
	self.UrgentProgressBarCom = nil
end

function MazeCountdownUI:UpdateView(cid)
	local cfgMazeCountdownData = CfgMazeCountdownTable[cid]

	UGUIUtil.SetText(self.DescText, cfgMazeCountdownData.Describe)

	self.TotalTime = cfgMazeCountdownData.TimeLimit

	self:RefreshCountdown()
end

function MazeCountdownUI:RefreshCountdown()
	local leftTimeValue = MazeModule.GetCommandCountdownValue()
	local minute = math.floor(leftTimeValue / 60)
	local second = math.floor(leftTimeValue % 60)
	local minuteStr = tostring(minute)

	if minute < 10 then
		minuteStr = "0" .. minuteStr
	end

	local secondStr = tostring(second)

	if second < 10 then
		secondStr = "0" .. secondStr
	end

	self.MinuteTextCom.text = minuteStr
	self.SecondTextCom.text = secondStr

	local ratio = leftTimeValue / self.TotalTime

	self.NormalProgressBar:SetActive(ratio > 0.2)
	self.UrgentProgressBar:SetActive(ratio <= 0.2)

	self.NormalProgressBarCom.fillAmount = ratio
	self.UrgentProgressBarCom.fillAmount = ratio
end

return MazeCountdownUI
