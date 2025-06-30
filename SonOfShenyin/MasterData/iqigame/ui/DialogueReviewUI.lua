-- chunkname: @IQIGame\\UI\\DialogueReviewUI.lua

local DialogueReviewUI = {}

DialogueReviewUI = Base:Extend("DialogueReviewUI", "IQIGame.Onigao.UI.DialogueReviewUI", DialogueReviewUI)

local DialogueReviewChatItemClass = require("IQIGame.UI.DialogueReview.DialogueReviewChatItem")

function DialogueReviewUI:OnInit()
	self:InitDelegate()
	self:InitMembers()
	self:InitComponent()
end

function DialogueReviewUI:InitDelegate()
	function self.buttonToNewDelegate()
		self:OnButtonToNewClick()
	end
end

function DialogueReviewUI:InitMembers()
	self.chatViewList = {}
end

function DialogueReviewUI:InitComponent()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.ChatScrollRect = self.ChatScrollRect:GetComponent("OptimizedScrollRect")

	self.ChatScrollRect:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateChatScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function DialogueReviewUI:OnAddListeners()
	return
end

function DialogueReviewUI:OnRemoveListeners()
	return
end

function DialogueReviewUI:OnOpen(userData)
	self.ChatScrollRect:SetEnableSizeControl(true)
	self:Refresh()
	StoryModule.PauseStory()
	self:OnButtonToNewClick()
end

function DialogueReviewUI:OnClose(userData)
	self.ChatScrollRect:SetEnableSizeControl(false)
	StoryModule.ContinueStory()
end

function DialogueReviewUI:OnDestroy()
	self.commonReturnBtn:Dispose()

	for i = 1, #self.chatViewList do
		self.chatViewList[i]:OnDestroy()
	end

	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function DialogueReviewUI:OnButtonToNewClick()
	self.ChatScrollRect:ScrollTo(#self.chatDataModule - 1)
end

function DialogueReviewUI:GetPreloadAssetPaths()
	return nil
end

function DialogueReviewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DialogueReviewUI:IsManualShowOnOpen(userData)
	return false
end

function DialogueReviewUI:GetBGM(userData)
	return nil
end

function DialogueReviewUI:OnPause()
	return
end

function DialogueReviewUI:OnResume()
	return
end

function DialogueReviewUI:OnCover()
	return
end

function DialogueReviewUI:OnReveal()
	return
end

function DialogueReviewUI:OnRefocus(userData)
	return
end

function DialogueReviewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DialogueReviewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DialogueReviewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DialogueReviewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DialogueReviewUI:Refresh()
	self:RefreshChatScroll()
end

function DialogueReviewUI:RefreshChatScroll()
	self.chatDataModule = StoryModule.GetDialogueReviewData()

	if not self.chatDataModule then
		self.chatDataModule = {}
	end

	self.ChatScrollRect:RefreshByItemCount(#self.chatDataModule)
end

function DialogueReviewUI:UpdateChatScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.chatDataModule[index + 1]

	if not self.chatViewList[instanceID] then
		self.chatViewList[instanceID] = DialogueReviewChatItemClass.New(viewGameObject)
	end

	self.chatViewList[instanceID]:Refresh(data, OptimizedViewsHolder)
end

return DialogueReviewUI
