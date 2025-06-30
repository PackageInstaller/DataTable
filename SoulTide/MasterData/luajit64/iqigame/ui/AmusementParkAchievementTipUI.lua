-- chunkname: @IQIGame\\UI\\AmusementParkAchievementTipUI.lua

local AmusementParkAchievementTipUI = {}

AmusementParkAchievementTipUI = Base:Extend("AmusementParkAchievementTipUI", "IQIGame.Onigao.UI.AmusementParkAchievementTipUI", AmusementParkAchievementTipUI)

function AmusementParkAchievementTipUI:OnInit()
	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end
end

function AmusementParkAchievementTipUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkAchievementTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkAchievementTipUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkAchievementTipUI:GetBGM(userData)
	return nil
end

function AmusementParkAchievementTipUI:OnOpen(userData)
	self.taskCid = userData

	self:UpdateView()

	self.closeTime = Timer.New(function()
		self:OnBtnClose()
	end, 3)

	self.closeTime:Start()
end

function AmusementParkAchievementTipUI:OnClose(userData)
	if self.closeTime then
		self.closeTime:Stop()
	end

	self.closeTime = nil
end

function AmusementParkAchievementTipUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
end

function AmusementParkAchievementTipUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
end

function AmusementParkAchievementTipUI:OnPause()
	return
end

function AmusementParkAchievementTipUI:OnResume()
	return
end

function AmusementParkAchievementTipUI:OnCover()
	return
end

function AmusementParkAchievementTipUI:OnReveal()
	return
end

function AmusementParkAchievementTipUI:OnRefocus(userData)
	return
end

function AmusementParkAchievementTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkAchievementTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkAchievementTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkAchievementTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkAchievementTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function AmusementParkAchievementTipUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function AmusementParkAchievementTipUI:UpdateView()
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

return AmusementParkAchievementTipUI
