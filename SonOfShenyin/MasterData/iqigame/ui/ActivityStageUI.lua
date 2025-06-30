-- chunkname: @IQIGame\\UI\\ActivityStageUI.lua

local ActivityStageUI = {}

ActivityStageUI = Base:Extend("ActivityStageUI", "IQIGame.Onigao.UI.ActivityStageUI", ActivityStageUI)

local stagePanelView = require("IQIGame/UI/ActivityStage/ActivityStageUI_stagePanel")
local rewardPanelView = require("IQIGame/UI/ActivityStage/ActivityStageUI_rewardPanel")

function ActivityStageUI:OnInit()
	self:InitComponent()
end

function ActivityStageUI:InitComponent()
	self.stagePanel = stagePanelView.New(self.stagePanel, self)

	self.stagePanel:Hide()

	self.rewardPanel = rewardPanelView.New(self.rewardPanel, self)

	self.rewardPanel:Hide()

	self.buttonReturn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function ActivityStageUI:OnOpen(userData)
	self.chapterData = userData.ActivityChapterPOD

	self:SetViewShow(Constant.ActivityStageUI_stagePanelViewType.stage)
end

function ActivityStageUI:OnClose(userData)
	return
end

function ActivityStageUI:GetPreloadAssetPaths()
	return nil
end

function ActivityStageUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityStageUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityStageUI:GetBGM(userData)
	return nil
end

function ActivityStageUI:OnAddListeners()
	return
end

function ActivityStageUI:OnRemoveListeners()
	return
end

function ActivityStageUI:OnPause()
	return
end

function ActivityStageUI:OnResume()
	return
end

function ActivityStageUI:OnCover()
	return
end

function ActivityStageUI:OnReveal()
	return
end

function ActivityStageUI:OnRefocus(userData)
	return
end

function ActivityStageUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityStageUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityStageUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityStageUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityStageUI:SetViewShow(type)
	self.stagePanel:Hide()
	self.rewardPanel:Hide()

	if type == Constant.ActivityStageUI_stagePanelViewType.stage then
		self.stagePanel:Show()
		self.stagePanel:Refresh(self.chapterData)
		self.stagePanel:SelectFirst()
	elseif type == Constant.ActivityStageUI_stagePanelViewType.reward then
		self.rewardPanel:Show()
		self.rewardPanel:Refresh()
	end
end

function ActivityStageUI:RewardPanelSelect(chapterId)
	self.rewardPanel:SelectStageWithChapterID(chapterId)
end

function ActivityStageUI:OnDestroy()
	self.rewardPanel:OnDestroy()
	self.buttonReturn:Dispose()
	AssetUtil.UnloadAsset(self)
end

return ActivityStageUI
