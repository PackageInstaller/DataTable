-- chunkname: @IQIGame\\UI\\CommonDialogPanel.lua

local LRHeadDialogElement = require("IQIGame/UI/Common/Dialog/LRHeadDialogElement")
local bubbleDialogElementClass = require("IQIGame/UI/Common/Dialog/BubbleDialogElement")
local standPaintElementClass = require("IQIGame/UI/Common/Dialog/StandPaintDialogElement")
local dialogSelectPanelClass = require("IQIGame/UI/Main/MainUI_HudPanel_DialogSelectPanel")
local CommonDialogPanel = {
	doNotClose = true
}

CommonDialogPanel = Base:Extend("CommonDialogPanel", "IQIGame.Onigao.UI.CommonDialogPanel", CommonDialogPanel)

function CommonDialogPanel:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function CommonDialogPanel:OnOpen(userData)
	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid)
	end

	self.userData = userData

	self.lrHeadDialogElement:Hide()
	self.dialogSelectElement:Hide()
	self:SetConfirmButtonShow(false)
	self:SetDialogButtonsShow(false)

	self.dialogCallback = userData.Callback
	self.callbackArgs = userData.CallbackArgs
	self.doNotClose = userData.DoNotClose == true

	local dialogCid = userData.DialogCid

	self:RefreshAutoSpeakShow()

	if userData.DialogType == Constant.CommonDialogPanelType.LRDialog then
		self.standPaintElement:Hide()
		self:__ShowLRHeadDialog(dialogCid)
	elseif userData.DialogType == Constant.CommonDialogPanelType.Bubble then
		self.standPaintElement:Hide()
		self.bubbleDialogElement:Show()
		self:showBubble(userData.mountPoint, userData.name, userData.text, userData.duration, userData.uiPoint, userData.notUseAuto)
	elseif userData.DialogType == Constant.CommonDialogPanelType.StandPaint then
		self.bubbleDialogElement:Hide()
		self.standPaintElement:Show()
		self.standPaintElement:Refresh(userData.name, userData.text, userData.duration)
	elseif userData.DialogType == Constant.CommonDialogPanelType.DialogSelect then
		self.bubbleDialogElement:Hide()
		self.standPaintElement:Hide()
		self.dialogSelectElement:Show()
		self.dialogSelectElement:Refresh(userData.mountPoint, userData.headText, userData.actionList, userData.clickCallBack)
	end

	if userData.showDialogButtons then
		if userData.DialogType == Constant.CommonDialogPanelType.Bubble then
			if not LuaUtility.StrIsNullOrEmpty(userData.text) then
				self:SetDialogButtonsShow(true)
			end
		elseif userData.DialogType ~= Constant.CommonDialogPanelType.Bubble then
			self:SetDialogButtonsShow(true)
		end
	end

	if userData.pictureId and userData.pictureId ~= 0 then
		self:SetDialogueImageShow(userData.pictureId)
	else
		LuaUtility.SetGameObjectShow(self.dialogueImage, false)
	end

	if self.userData.DialogType ~= Constant.CommonDialogPanelType.DialogSelect and self.userData.showDialogButtons then
		Time.timeScale = ConversationModule.multipleSpeed
	else
		Time.timeScale = 1
	end

	EventDispatcher.Dispatch(EventID.MainUI_SetJoyStickViewEnabledEvent, false)
	WorldMapModule.BanNpcNameShow()
end

function CommonDialogPanel:OnClose(userData)
	self.lrHeadDialogElement:Hide()
	self.standPaintElement:Hide()
	self.dialogSelectElement:Hide()
	self.bubbleDialogElement:Hide()
	LuaUtility.SetGameObjectShow(self.dialogueImage, false)

	Time.timeScale = 1

	EventDispatcher.Dispatch(EventID.MainUI_SetJoyStickViewEnabledEvent, true)
	WorldMapModule.EnabledNpcNameShow()
end

function CommonDialogPanel:InitMembers()
	self.isObjectExpandShow = false
end

function CommonDialogPanel:InitComponent()
	self.lrHeadDialogElement = LRHeadDialogElement.New(self.lrDialogElement)
	self.bubbleDialogElement = bubbleDialogElementClass.New(self.bubbleViewsRoot, self)
	self.standPaintElement = standPaintElementClass.New(self.standPaintViewRoot, self)
	self.dialogSelectElement = dialogSelectPanelClass.New(self.dialogueSelectRoot, self)

	self.dialogSelectElement:Hide()
end

function CommonDialogPanel:InitDelegate()
	function self.showDialogSelectEvent(mountPoint, headText, actionList)
		self:ShowDialogSelect(mountPoint, headText, actionList)
	end

	function self.hideStandPaintDialogEvent()
		self.standPaintElement:Hide()
	end

	function self.delegateOnClickButtonAutoDialogue()
		self:OnClickButtonAutoDialogue()
	end

	function self.delegateOnClickButtonBox()
		self:OnClickButtonBox()
	end

	function self.delegateOnClickButtonDialogueReview()
		self:OnClickButtonDialogueReview()
	end

	function self.delegateOnClickButtonSkip()
		self:OnClickButtonSkip()
	end
end

function CommonDialogPanel:OnAddListeners()
	self.buttonAutoDialogue:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonAutoDialogue)
	self.buttonBox:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonBox)
	self.buttonDialogueReview:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonDialogueReview)
	self.buttonSkip:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSkip)
	EventDispatcher.AddEventListener(EventID.MainUI_ShowDialogSelectEvent, self.showDialogSelectEvent)
	EventDispatcher.AddEventListener(EventID.CommonDialogPanel_HideStandPaintDialogEvent, self.hideStandPaintDialogEvent)
	EventUtil.AddEventListener(self, EventID.CommonDialogPanel_SetDialogueImageShowEvent, self.SetDialogueImageShow)
	EventUtil.AddEventListener(self, EventID.CommonDialogPanel_RefreshShowEvent)
end

function CommonDialogPanel:OnRemoveListeners()
	self.buttonAutoDialogue:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonAutoDialogue)
	self.buttonBox:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonBox)
	self.buttonDialogueReview:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonDialogueReview)
	self.buttonSkip:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSkip)
	EventDispatcher.RemoveEventListener(EventID.MainUI_ShowDialogSelectEvent, self.showDialogSelectEvent)
	EventDispatcher.RemoveEventListener(EventID.CommonDialogPanel_HideStandPaintDialogEvent, self.hideStandPaintDialogEvent)
	EventUtil.ClearEventListener(self)
end

function CommonDialogPanel:__OnCommonDialogPanel_RefreshShowEventHandler(userData)
	self:OnOpen(userData)
end

function CommonDialogPanel:SetDialogueImageShow(resourceId)
	local path = CfgUtil.GetStoryResourceWithID(resourceId)

	LuaUtility.SetGameObjectShow(self.dialogueImage, true)
	AssetUtil.LoadImage_SetNativeSize(self, path, self.dialogueImage:GetComponent("Image"))
end

function CommonDialogPanel:OnClickButtonSkip()
	EventDispatcher.Dispatch(EventID.CommonDialogControl_SkipEvent)
end

function CommonDialogPanel:OnClickButtonDialogueReview()
	UIModule.Open(Constant.UIControllerName.DialogueReviewUI, Constant.UILayer.UI)
	StoryUIApi:PlayCommonButtonSound()
end

function CommonDialogPanel:OnClickButtonBox()
	if self.isObjectExpandShow then
		LuaUtility.ReversePlayAnimation(self.buttonCollection, "buttonCollection_In")
	else
		LuaUtility.PlayAnimation(self.buttonCollection, "buttonCollection_In")
	end

	self.isObjectExpandShow = not self.isObjectExpandShow

	StoryUIApi:PlayCommonButtonSound()
end

local autoDialogueStateArray = {
	"手动",
	"自动",
	"倍速1",
	"倍速2"
}

function CommonDialogPanel:OnClickButtonAutoDialogue()
	local index = ConversationModule.autoDialogueStateIndex

	index = index + 1

	if index > #autoDialogueStateArray then
		index = 1
	end

	ConversationModule.autoDialogueStateIndex = index

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.autoDialogueStateIndex, index)
	self:RefreshAutoSpeakShow()
end

function CommonDialogPanel:RefreshAutoSpeakShow()
	if autoDialogueStateArray[ConversationModule.autoDialogueStateIndex] == "手动" then
		ConversationModule.isAuto = false

		ConversationModule.SetMultipleSpeed(1)
	elseif autoDialogueStateArray[ConversationModule.autoDialogueStateIndex] == "自动" then
		ConversationModule.isAuto = true

		ConversationModule.SetMultipleSpeed(1)
	elseif autoDialogueStateArray[ConversationModule.autoDialogueStateIndex] == "倍速1" then
		ConversationModule.isAuto = true

		ConversationModule.SetMultipleSpeed(2)
	elseif autoDialogueStateArray[ConversationModule.autoDialogueStateIndex] == "倍速2" then
		ConversationModule.isAuto = true

		ConversationModule.SetMultipleSpeed(3)
	end

	LuaUtility.SetGameObjectShow(self.autoSpeakOn, ConversationModule.isAuto)
	LuaUtility.SetGameObjectShow(self.autoSpeakOff, not ConversationModule.isAuto)
	LuaUtility.SetGameObjectShow(self.multipleSpeed1, autoDialogueStateArray[ConversationModule.autoDialogueStateIndex] == "倍速1")
	LuaUtility.SetGameObjectShow(self.multipleSpeed2, autoDialogueStateArray[ConversationModule.autoDialogueStateIndex] == "倍速2")

	Time.timeScale = ConversationModule.multipleSpeed
end

function CommonDialogPanel:GetPreloadAssetPaths()
	return nil
end

function CommonDialogPanel:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommonDialogPanel:IsManualShowOnOpen(userData)
	return false
end

function CommonDialogPanel:GetBGM(userData)
	return nil
end

function CommonDialogPanel:OnPause()
	return
end

function CommonDialogPanel:OnResume()
	return
end

function CommonDialogPanel:OnCover()
	return
end

function CommonDialogPanel:OnReveal()
	return
end

function CommonDialogPanel:OnRefocus(userData)
	return
end

function CommonDialogPanel:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.userData then
		return
	end
end

function CommonDialogPanel:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommonDialogPanel:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommonDialogPanel:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommonDialogPanel:OnDestroy()
	Time.timeScale = 1

	WorldMapModule.EnabledNpcNameShow()
	self.bubbleDialogElement:OnDestroy()
	self.lrHeadDialogElement:Dispose()
	self.standPaintElement:OnDestroy()
	self.dialogSelectElement:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function CommonDialogPanel:__OnDialogComplete()
	if self.dialogCallback ~= nil then
		self.dialogCallback(self.callbackArgs)
	end

	if self.doNotClose then
		return
	end

	UIModule.Close(Constant.UIControllerName.CommonDialogPanel)
end

function CommonDialogPanel:__ShowLRHeadDialog(dialogCid)
	local function callback()
		self.lrHeadDialogElement:Hide()
		self:__OnDialogComplete()
	end

	self.lrHeadDialogElement:ShowDialog(dialogCid, callback)
end

function CommonDialogPanel:showBubble(mountPoint, name, text, duration, uiPoint, notUseAuto)
	text = LuaUtility.GetDialogText(text)

	self.bubbleDialogElement:ShowBubble(mountPoint, name, text, duration, uiPoint, notUseAuto)
end

function CommonDialogPanel:SetConfirmButtonShow(show)
	LuaUtility.SetGameObjectShow(self.buttonConfirm, show)
end

function CommonDialogPanel:SetDialogButtonsShow(show)
	LuaUtility.SetGameObjectShow(self.AutoDialogueRoot, show)
	LuaUtility.SetGameObjectShow(self.buttonSkip, show)
	LuaUtility.SetGameObjectShow(self.buttonCollection, show)
end

return CommonDialogPanel
