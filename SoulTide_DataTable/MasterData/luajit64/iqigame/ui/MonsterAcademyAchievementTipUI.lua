-- chunkname: @IQIGame\\UI\\MonsterAcademyAchievementTipUI.lua

local MonsterAcademyAchievementTipUI = {}

MonsterAcademyAchievementTipUI = Base:Extend("MonsterAcademyAchievementTipUI", "IQIGame.Onigao.UI.MonsterAcademyAchievementTipUI", MonsterAcademyAchievementTipUI)

require("IQIGame.UIExternalApi.MonsterAcademyAchievementTipUIApi")

function MonsterAcademyAchievementTipUI:OnInit()
	UGUIUtil.SetText(self.goTitle, MonsterAcademyAchievementTipUIApi:GetString("goTitle"))

	function self.DelegateOnBtnClose()
		self:OnBtnClose()
	end
end

function MonsterAcademyAchievementTipUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyAchievementTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyAchievementTipUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyAchievementTipUI:GetBGM(userData)
	return nil
end

function MonsterAcademyAchievementTipUI:OnOpen(userData)
	self.taskCid = userData

	self:UpdateView()

	self.closeTime = Timer.New(function()
		self:OnBtnClose()
	end, 3)

	self.closeTime:Start()
end

function MonsterAcademyAchievementTipUI:OnClose(userData)
	if self.closeTime then
		self.closeTime:Stop()
	end

	self.closeTime = nil
end

function MonsterAcademyAchievementTipUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClose)
end

function MonsterAcademyAchievementTipUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClose)
end

function MonsterAcademyAchievementTipUI:OnPause()
	return
end

function MonsterAcademyAchievementTipUI:OnResume()
	return
end

function MonsterAcademyAchievementTipUI:OnCover()
	return
end

function MonsterAcademyAchievementTipUI:OnReveal()
	return
end

function MonsterAcademyAchievementTipUI:OnRefocus(userData)
	return
end

function MonsterAcademyAchievementTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyAchievementTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyAchievementTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyAchievementTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyAchievementTipUI:OnDestroy()
	return
end

function MonsterAcademyAchievementTipUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function MonsterAcademyAchievementTipUI:UpdateView()
	local cfgMainQuest = CfgMainQuestTable[self.taskCid]

	UGUIUtil.SetText(self.TextTaskName, cfgMainQuest.Name)
end

return MonsterAcademyAchievementTipUI
