-- chunkname: @IQIGame\\UI\\FishingActivityAchievementTipUI.lua

local FishingActivityAchievementTipUI = {}

FishingActivityAchievementTipUI = Base:Extend("FishingActivityAchievementTipUI", "IQIGame.Onigao.UI.FishingActivityAchievementTipUI", FishingActivityAchievementTipUI)

function FishingActivityAchievementTipUI:OnInit()
	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end
end

function FishingActivityAchievementTipUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivityAchievementTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivityAchievementTipUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivityAchievementTipUI:GetBGM(userData)
	return nil
end

function FishingActivityAchievementTipUI:OnOpen(userData)
	self.taskCid = userData

	self:UpdateView()

	self.closeTime = Timer.New(function()
		self:OnBtnClose()
	end, 3)

	self.closeTime:Start()
end

function FishingActivityAchievementTipUI:OnClose(userData)
	if self.closeTime then
		self.closeTime:Stop()
	end

	self.closeTime = nil
end

function FishingActivityAchievementTipUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
end

function FishingActivityAchievementTipUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
end

function FishingActivityAchievementTipUI:OnPause()
	return
end

function FishingActivityAchievementTipUI:OnResume()
	return
end

function FishingActivityAchievementTipUI:OnCover()
	return
end

function FishingActivityAchievementTipUI:OnReveal()
	return
end

function FishingActivityAchievementTipUI:OnRefocus(userData)
	return
end

function FishingActivityAchievementTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FishingActivityAchievementTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivityAchievementTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivityAchievementTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivityAchievementTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function FishingActivityAchievementTipUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function FishingActivityAchievementTipUI:UpdateView()
	local cfgMainQuest = CfgMainQuestTable[self.taskCid]

	UGUIUtil.SetText(self.TextTaskName, cfgMainQuest.Name)

	local cid = cfgMainQuest.Reward[1]
	local num = cfgMainQuest.Reward[2]

	if cid > 0 then
		local path = UIGlobalApi.GetIconPath(CfgItemTable[cid].Icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end

	UGUIUtil.SetText(self.TextNum, num)
end

return FishingActivityAchievementTipUI
