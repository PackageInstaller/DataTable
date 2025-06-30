-- chunkname: @IQIGame\\UI\\AchievementNoticeUI.lua

local AchievementNoticeUI = {}

AchievementNoticeUI = Base:Extend("AchievementNoticeUI", "IQIGame.Onigao.UI.AchievementNoticeUI", AchievementNoticeUI)

function AchievementNoticeUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
end

function AchievementNoticeUI:InitMembers()
	self.achievementName = "null"
end

function AchievementNoticeUI:InitDelegate()
	function self.UIRefreshDelegate(content)
		self:Refresh(content)
	end

	function self.UIHideDelegate()
		self:HideContent()
	end
end

function AchievementNoticeUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.AchievementNoticeUIRefresh, self.UIRefreshDelegate)
	EventDispatcher.AddEventListener(EventID.AchievementNoticeUIHide, self.UIHideDelegate)
end

function AchievementNoticeUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.AchievementNoticeUIRefresh, self.UIRefreshDelegate)
	EventDispatcher.RemoveEventListener(EventID.AchievementNoticeUIHide, self.UIHideDelegate)
end

function AchievementNoticeUI:OnOpen(userData)
	if userData then
		self:Refresh(userData.content)
	end
end

function AchievementNoticeUI:OnClose(userData)
	return
end

function AchievementNoticeUI:OnDestroy()
	return
end

function AchievementNoticeUI:GetPreloadAssetPaths()
	return nil
end

function AchievementNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AchievementNoticeUI:IsManualShowOnOpen(userData)
	return false
end

function AchievementNoticeUI:GetBGM(userData)
	return nil
end

function AchievementNoticeUI:OnPause()
	return
end

function AchievementNoticeUI:OnResume()
	return
end

function AchievementNoticeUI:OnCover()
	return
end

function AchievementNoticeUI:OnReveal()
	return
end

function AchievementNoticeUI:OnRefocus(userData)
	return
end

function AchievementNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AchievementNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AchievementNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AchievementNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AchievementNoticeUI:Refresh(content)
	self.achievementName = content

	self:ShowAchievementGet()
end

function AchievementNoticeUI:ShowAchievementGet()
	LuaUtility.SetText(self.textAchievementName, self.achievementName)
	LuaUtility.SetGameObjectShow(self.objectNoticeContent, true)
end

function AchievementNoticeUI:HideContent()
	LuaUtility.SetGameObjectShow(self.objectNoticeContent, false)
end

return AchievementNoticeUI
