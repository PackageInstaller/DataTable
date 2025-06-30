-- chunkname: @IQIGame\\UI\\RestaurantOperationAchievementTipUI.lua

local RestaurantOperationAchievementTipUI = {}

RestaurantOperationAchievementTipUI = Base:Extend("RestaurantOperationAchievementTipUI", "IQIGame.Onigao.UI.RestaurantOperationAchievementTipUI", RestaurantOperationAchievementTipUI)

function RestaurantOperationAchievementTipUI:OnInit()
	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end
end

function RestaurantOperationAchievementTipUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationAchievementTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationAchievementTipUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationAchievementTipUI:GetBGM(userData)
	return nil
end

function RestaurantOperationAchievementTipUI:OnOpen(userData)
	self.taskCid = userData

	self:UpdateView()

	self.closeTime = Timer.New(function()
		self:OnBtnClose()
	end, 3)

	self.closeTime:Start()
end

function RestaurantOperationAchievementTipUI:OnClose(userData)
	if self.closeTime then
		self.closeTime:Stop()
	end

	self.closeTime = nil
end

function RestaurantOperationAchievementTipUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
end

function RestaurantOperationAchievementTipUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
end

function RestaurantOperationAchievementTipUI:OnPause()
	return
end

function RestaurantOperationAchievementTipUI:OnResume()
	return
end

function RestaurantOperationAchievementTipUI:OnCover()
	return
end

function RestaurantOperationAchievementTipUI:OnReveal()
	return
end

function RestaurantOperationAchievementTipUI:OnRefocus(userData)
	return
end

function RestaurantOperationAchievementTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationAchievementTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationAchievementTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationAchievementTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationAchievementTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RestaurantOperationAchievementTipUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantOperationAchievementTipUI:UpdateView()
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

return RestaurantOperationAchievementTipUI
