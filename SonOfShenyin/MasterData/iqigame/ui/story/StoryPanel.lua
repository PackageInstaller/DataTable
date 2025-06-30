-- chunkname: @IQIGame\\UI\\Story\\StoryPanel.lua

local StoryPanel = {}
local StoryJoystickView = require("IQIGame.UI.Story.StoryJoystickView")
local StoryNPCNameItemClass = require("IQIGame.UI.Story.StoryNPCNameItem")
local StoryGetClueTipPanelClass = require("IQIGame.UI.Story.StoryGetClueTipPanel")
local MoviePanelClass = require("IQIGame.UI.Story.StoryUIMoviePanel")
local PicturePanelClass = require("IQIGame.UI.Story.StoryUIPicturePanel")
local StoryUIPuzzleSelectPanelClass = require("IQIGame.UI.Story.StoryUIPuzzleSelectPanel")
local StoryUIDialogueSelectPanelClass = require("IQIGame.UI.Story.StoryUIDialogueSelectPanel")
local StoryUIDialoguePanelClass = require("IQIGame.UI.Story.StoryUIDialoguePanel")
local judgmentCheckersPanelClass = require("IQIGame/UI/Story/JudgmentCheckers/JudgmentCheckersPanel")

function StoryPanel.New(go, mainView)
	local o = Clone(StoryPanel)

	o:Initialize(go, mainView)

	return o
end

function StoryPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()

	if not StoryModule.isDebugMod then
		UnlockFunctionModule.FuncSwitchHandler({
			[Constant.UnlockType.FUNC_GM_TOOL] = self.GMChangeTimeScaleButton
		})
	end
end

function StoryPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function StoryPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function StoryPanel:InitMembers()
	self.isObjectExpandShow = false
	self.timeScaleIndex = 1
	self.hideUICheckQueue = {}
	self.isHideUIState = false
end

function StoryPanel:InitComponent()
	self.getClueTipPanel = StoryGetClueTipPanelClass.New(self.GetClueTipPanel, self)

	self.getClueTipPanel:Close()

	self.MoviePanel = MoviePanelClass.New(self.MoviePanel, self)

	self.MoviePanel:Close()

	self.PicturePanel = PicturePanelClass.New(self.PicturePanel, self)

	self.PicturePanel:Close()

	self.PuzzleSelectPanel = StoryUIPuzzleSelectPanelClass.New(self.PuzzleSelectPanel, self)

	self.PuzzleSelectPanel:Close()

	self.DialogueSelectPanel = StoryUIDialogueSelectPanelClass.New(self.DialogueSelectPanel, self)

	self.DialogueSelectPanel:Close()

	self.StoryDialoguePanel = StoryUIDialoguePanelClass.New(self.DialoguePanel, self)

	self.StoryDialoguePanel:Open()

	self.storyJoystickView = StoryJoystickView.New(self.JoystickPanel)
	self.judgmentCheckersPanel = judgmentCheckersPanelClass.New(self.judgmentCheckersPanel, self)

	self.judgmentCheckersPanel:Hide()

	self.NPCNameList = {}

	for i = 1, LuaUtility.GetChildCount(self.NPCNamePanel.transform) do
		local NPCNameTrans = LuaUtility.GetChild(self.NPCNamePanel.transform, i - 1)
		local NPCNameItem = StoryNPCNameItemClass.New(NPCNameTrans.gameObject, self)

		NPCNameItem:Show(false)
		table.insert(self.NPCNameList, NPCNameItem)
	end

	LuaUtility.SetGameObjectShow(self.speakPanelPrefab, false)
	LuaUtility.SetGameObjectShow(self.asidePanelPrefab, false)

	self.toggleRegular = self.toggleRegular:GetComponent("Toggle")
	self.buttonAutoDialogue = self.buttonAutoDialogue:GetComponent("Button")
	self.TextTimeBgSource = self.TextTime:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.TextMainSiteBgSource = self.TextMainSite:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.TextBranchSiteBgSource = self.TextBranchSite:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
end

function StoryPanel:InitDelegate()
	function self.delegateStartConversation(ShowSpeakViewParam)
		self.StoryDialoguePanel:StartConversation(ShowSpeakViewParam)
	end

	function self.delegateAddSpeak(npcID, npcName, storyDialogueCid, dialogueContent)
		self.StoryDialoguePanel:AddSpeak(npcID, npcName, storyDialogueCid, dialogueContent)
	end

	function self.delegateRemoveSpeak(dialogueType, npcID)
		self.StoryDialoguePanel:RemoveSpeak(dialogueType, npcID)
	end

	function self.delegateUpdateSpeak(dialogueType, npcID, progress)
		self.StoryDialoguePanel:UpdateSpeak(dialogueType, npcID, progress)
	end

	function self.buttonAutoDialogueDelegate()
		self:OnButtonAutoDialogueClick()
	end

	function self.StopMultipleSpeedEvent()
		self.StoryDialoguePanel:OnConfirmLongClickEnd()
	end

	function self.buttonPuzzleDelegate()
		self:OnButtonPuzzleClick()
	end

	function self.delegateOnClickReturnButton()
		StoryModule.PauseStory()
		NoticeModule.ShowNoticeByType(Constant.NoticeType.BoxDoubleButton, StoryUIApi:GetQuitDescriptionTips(), function()
			EventDispatcher.Dispatch(EventID.QuitStageLevel)
		end, function()
			StoryModule.ContinueStory()
		end)
	end

	function self.StoryUIRefreshDelegate(clueID, needTip, clueGetType)
		self:OnStoryUIRefreshEvent(clueID, needTip, clueGetType)
	end

	function self.delegateOpenJoystickPanel()
		self.storyJoystickView:Open()
		StoryModule.AddOrSetStoryUIState(Constant.StoryUI.Joystick, true)
	end

	function self.delegateCloseJoystickPanel()
		self.storyJoystickView:Close()
		StoryModule.AddOrSetStoryUIState(Constant.StoryUI.Joystick, false)
	end

	function self.delegateChangeTimeScale()
		self:ChangeTimeScale()
	end

	function self.setButtonPuzzleShowDelegate(show)
		self:SetButtonPuzzleShow(show)
	end

	function self.ShowNPCNameDelegate(NPCNameList)
		self:ShowNPCName(NPCNameList)
	end

	function self.HideNPCNameDelegate()
		self:HideNPCName()
	end

	function self.setJoyStickSpeedDelegate(speed)
		self:SetJoyStickSpeed(speed)
	end

	function self.playMovieDelegate(resourceID, PlayMovieTask)
		self:PlayMovie(resourceID, PlayMovieTask)
	end

	function self.showPictureDelegate(resourceID, posParam, ShowPictureTask)
		self:ShowPicture(resourceID, posParam, ShowPictureTask)
	end

	function self.closePictureDelegate()
		self:ClosePicture()
	end

	function self.GMStartFightDelegate()
		self:OnGMStartFightClick()
	end

	function self.SetSurveyTargetShowDelegate(show)
		self:SetSurveyTargetShow(show)
	end

	function self.SetSurveyTargetTextDelegate(CfgTextID)
		self:SetSurveyTargetText(CfgTextID)
	end

	function self.SetSurveyTargetProgressDelegate(numProgress, playAnimate)
		self:SetSurveyTargetProgress(numProgress, playAnimate)
	end

	function self.ShowClueTriggerDelegate(npcID, selectCfgID, ShowCluesTask)
		self:ShowClueTrigger(npcID, selectCfgID, ShowCluesTask)
	end

	function self.showDialogueSelectDelegate(npcID, selectCfgID, ShowDialogueSelectionTask)
		self:ShowDialogueSelect(npcID, selectCfgID, ShowDialogueSelectionTask)
	end

	function self.setCanGoNextShowDelegate(dialogueType, npcID, show)
		self.StoryDialoguePanel:SetSpeakCanGoNextShow(dialogueType, npcID, show)
	end

	function self.buttonBoxDelegate()
		self:OnButtonBoxClick()
	end

	function self.buttonDialogueReviewDelegate()
		self:OnButtonDialogueReviewClick()
	end

	function self.buttonChatDelegate()
		self:OnButtonChatClick()
	end

	function self.toggleRegularClickDelegate(isOn)
		self:OnToggleRegularClick(isOn)
	end

	function self.setRegularShowDelegate(show)
		self:SetRegularShow(show)
	end

	function self.regularEnableDelegate(enabled)
		self:RegularToggleEnabled(enabled)
	end

	function self.SetReturnButtonShowEvent(show)
		self:SetReturnButtonShow(show)
	end

	function self.SetButtonCollectionShowEvent(show)
		self:SetButtonCollectionShow(show)
	end

	function self.SetAutoDialogueShowEvent(show)
		self:SetAutoDialogueShow(show)
	end

	function self.SetStoryDescriptionDelegate(isShow, timeID, mainSiteID, branchSiteID, duration, SetStorySiteShow)
		self:SetStoryDescription(isShow, timeID, mainSiteID, branchSiteID, duration, SetStorySiteShow)
	end

	function self.delegateOnClickGMButtonHideUI_1()
		table.insert(self.hideUICheckQueue, 1)
		self:CheckGMHideUI()
	end

	function self.delegateOnClickGMButtonHideUI_2()
		table.insert(self.hideUICheckQueue, 2)
		self:CheckGMHideUI()
	end

	function self.delegateOnClickGMButtonHideUI_3()
		table.insert(self.hideUICheckQueue, 3)
		self:CheckGMHideUI()
	end

	function self.delegateOnClickGMButtonHideDialogue()
		self:OnClickGMButtonHideDialogue()
	end

	function self.delegateOnClickButtonSkip()
		self:OnClickButtonSkip()
	end

	function self.setButtonSkipShowEvent(show)
		self:SetButtonSkipShow(show)
	end

	function self.setStoryUIShowEvent(show)
		self:SetStoryUIShow(show)
	end

	function self.storyUIRefreshEvent()
		self:Refresh()
	end

	function self.startJudgmentCheckers(resourceId, playerIndex, StartJudgmentCheckersTask)
		self.judgmentCheckersPanel:Show()
		self.judgmentCheckersPanel:Refresh(resourceId, playerIndex, StartJudgmentCheckersTask)
	end

	function self.closeJudgmentCheckers()
		self.judgmentCheckersPanel:Hide()
	end

	function self.delegateOnClickGMButtonSkip()
		StoryModule.SkipGM()
	end
end

function StoryPanel:AddListener()
	EventDispatcher.AddEventListener(EventID.BehaviorTreeNPCAddSpeak, self.delegateAddSpeak)
	EventDispatcher.AddEventListener(EventID.BehaviorTreeNPCRemoveSpeak, self.delegateRemoveSpeak)
	EventDispatcher.AddEventListener(EventID.BehaviorTreeNPCUpdateSpeak, self.delegateUpdateSpeak)
	EventDispatcher.AddEventListener(EventID.Story_OpenJoystickPanel, self.delegateOpenJoystickPanel)
	EventDispatcher.AddEventListener(EventID.Story_CloseJoystickPanel, self.delegateCloseJoystickPanel)
	EventDispatcher.AddEventListener(EventID.BehaviorTreeNPCStartConversation, self.delegateStartConversation)
	EventDispatcher.AddEventListener(EventID.BehaviourTreeStoryUIRefreshEvent, self.StoryUIRefreshDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUIButtonPuzzleShowEvent, self.setButtonPuzzleShowDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUIShowNPCNameEvent, self.ShowNPCNameDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUIHideNPCNameEvent, self.HideNPCNameDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUISetJoyStickSpeedEvent, self.setJoyStickSpeedDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUIPlayMovie, self.playMovieDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUIShowPicture, self.showPictureDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUIClosePicture, self.closePictureDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUISurveyTargetUIShow, self.SetSurveyTargetShowDelegate)
	EventDispatcher.AddEventListener(EventID.SetStoryUISurveyTargetText, self.SetSurveyTargetTextDelegate)
	EventDispatcher.AddEventListener(EventID.SetStoryUISurveyTargetProgress, self.SetSurveyTargetProgressDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUIShowCluesTrigger, self.ShowClueTriggerDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUIShowDialogueSelect, self.showDialogueSelectDelegate)
	EventDispatcher.AddEventListener(EventID.StoryUICanGoNextShow, self.setCanGoNextShowDelegate)
	EventDispatcher.AddEventListener(EventID.SetRegularShowEvent, self.setRegularShowDelegate)
	EventDispatcher.AddEventListener(EventID.SetRegularEnableEvent, self.regularEnableDelegate)
	EventDispatcher.AddEventListener(EventID.StopMultipleSpeedEvent, self.StopMultipleSpeedEvent)
	EventDispatcher.AddEventListener(EventID.SetReturnButtonShowEvent, self.SetReturnButtonShowEvent)
	EventDispatcher.AddEventListener(EventID.SetButtonCollectionShowEvent, self.SetButtonCollectionShowEvent)
	EventDispatcher.AddEventListener(EventID.SetAutoDialogueShowEvent, self.SetAutoDialogueShowEvent)
	EventDispatcher.AddEventListener(EventID.SetStoryDescriptionEvent, self.SetStoryDescriptionDelegate)
	EventDispatcher.AddEventListener(EventID.SetStoryButtonSkipShowEvent, self.setButtonSkipShowEvent)
	EventDispatcher.AddEventListener(EventID.SetStoryUIShowEvent, self.setStoryUIShowEvent)
	EventDispatcher.AddEventListener(EventID.StoryUIRefreshEvent, self.storyUIRefreshEvent)
	EventDispatcher.AddEventListener(EventID.StoryUI_JudgmentCheckersOpen, self.startJudgmentCheckers)
	EventDispatcher.AddEventListener(EventID.JudgmentCheckersPanel_CloseEvent, self.closeJudgmentCheckers)
	self.buttonAutoDialogue.onClick:AddListener(self.buttonAutoDialogueDelegate)
	self.GMStartFight:GetComponent("Button").onClick:AddListener(self.GMStartFightDelegate)
	self.buttonBox:GetComponent("Button").onClick:AddListener(self.buttonBoxDelegate)
	self.buttonDialogueReview:GetComponent("Button").onClick:AddListener(self.buttonDialogueReviewDelegate)
	self.buttonChat:GetComponent("Button").onClick:AddListener(self.buttonChatDelegate)
	self.buttonPuzzle:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.buttonPuzzleDelegate)
	self.returnButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateOnClickReturnButton)
	self.GMChangeTimeScaleButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateChangeTimeScale)
	self.toggleRegular.onValueChanged:AddListener(self.toggleRegularClickDelegate)
	self.GMButtonHideUI_1:GetComponent("Button").onClick:AddListener(self.delegateOnClickGMButtonHideUI_1)
	self.GMButtonHideUI_2:GetComponent("Button").onClick:AddListener(self.delegateOnClickGMButtonHideUI_2)
	self.GMButtonHideUI_3:GetComponent("Button").onClick:AddListener(self.delegateOnClickGMButtonHideUI_3)
	self.GMButtonHideDialogue:GetComponent("Button").onClick:AddListener(self.delegateOnClickGMButtonHideDialogue)
	self.buttonSkip:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSkip)
	self.GMButtonSkip:GetComponent("Button").onClick:AddListener(self.delegateOnClickGMButtonSkip)
	UIEventUtil.AddClickEventListener_Button(self, "RepairBtn", self.__OnRepairBtnClick)
end

function StoryPanel:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.BehaviorTreeNPCAddSpeak, self.delegateAddSpeak)
	EventDispatcher.RemoveEventListener(EventID.BehaviorTreeNPCRemoveSpeak, self.delegateRemoveSpeak)
	EventDispatcher.RemoveEventListener(EventID.BehaviorTreeNPCUpdateSpeak, self.delegateUpdateSpeak)
	EventDispatcher.RemoveEventListener(EventID.Story_OpenJoystickPanel, self.delegateOpenJoystickPanel)
	EventDispatcher.RemoveEventListener(EventID.Story_CloseJoystickPanel, self.delegateCloseJoystickPanel)
	EventDispatcher.RemoveEventListener(EventID.BehaviorTreeNPCStartConversation, self.delegateStartConversation)
	EventDispatcher.RemoveEventListener(EventID.BehaviourTreeStoryUIRefreshEvent, self.StoryUIRefreshDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUIButtonPuzzleShowEvent, self.setButtonPuzzleShowDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUIShowNPCNameEvent, self.ShowNPCNameDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUIHideNPCNameEvent, self.HideNPCNameDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUISetJoyStickSpeedEvent, self.setJoyStickSpeedDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUIPlayMovie, self.playMovieDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUIShowPicture, self.showPictureDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUIClosePicture, self.closePictureDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUISurveyTargetUIShow, self.SetSurveyTargetShowDelegate)
	EventDispatcher.RemoveEventListener(EventID.SetStoryUISurveyTargetText, self.SetSurveyTargetTextDelegate)
	EventDispatcher.RemoveEventListener(EventID.SetStoryUISurveyTargetProgress, self.SetSurveyTargetProgressDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUIShowCluesTrigger, self.ShowClueTriggerDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUIShowDialogueSelect, self.showDialogueSelectDelegate)
	EventDispatcher.RemoveEventListener(EventID.StoryUICanGoNextShow, self.setCanGoNextShowDelegate)
	EventDispatcher.RemoveEventListener(EventID.SetRegularShowEvent, self.setRegularShowDelegate)
	EventDispatcher.RemoveEventListener(EventID.SetRegularEnableEvent, self.regularEnableDelegate)
	EventDispatcher.RemoveEventListener(EventID.StopMultipleSpeedEvent, self.StopMultipleSpeedEvent)
	EventDispatcher.RemoveEventListener(EventID.SetReturnButtonShowEvent, self.SetReturnButtonShowEvent)
	EventDispatcher.RemoveEventListener(EventID.SetButtonCollectionShowEvent, self.SetButtonCollectionShowEvent)
	EventDispatcher.RemoveEventListener(EventID.SetAutoDialogueShowEvent, self.SetAutoDialogueShowEvent)
	EventDispatcher.RemoveEventListener(EventID.SetStoryDescriptionEvent, self.SetStoryDescriptionDelegate)
	EventDispatcher.RemoveEventListener(EventID.SetStoryButtonSkipShowEvent, self.setButtonSkipShowEvent)
	EventDispatcher.RemoveEventListener(EventID.SetStoryUIShowEvent, self.setStoryUIShowEvent)
	EventDispatcher.RemoveEventListener(EventID.StoryUIRefreshEvent, self.storyUIRefreshEvent)
	EventDispatcher.RemoveEventListener(EventID.StoryUI_JudgmentCheckersOpen, self.startJudgmentCheckers)
	EventDispatcher.RemoveEventListener(EventID.JudgmentCheckersPanel_CloseEvent, self.closeJudgmentCheckers)
	self.buttonAutoDialogue.onClick:RemoveListener(self.buttonAutoDialogueDelegate)
	self.GMStartFight:GetComponent("Button").onClick:RemoveListener(self.GMStartFightDelegate)
	self.buttonBox:GetComponent("Button").onClick:RemoveListener(self.buttonBoxDelegate)
	self.buttonDialogueReview:GetComponent("Button").onClick:RemoveListener(self.buttonDialogueReviewDelegate)
	self.buttonChat:GetComponent("Button").onClick:RemoveListener(self.buttonChatDelegate)
	self.buttonPuzzle:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.buttonPuzzleDelegate)
	self.returnButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateOnClickReturnButton)
	self.GMChangeTimeScaleButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateChangeTimeScale)
	self.toggleRegular.onValueChanged:RemoveListener(self.toggleRegularClickDelegate)
	self.GMButtonHideUI_1:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGMButtonHideUI_1)
	self.GMButtonHideUI_2:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGMButtonHideUI_2)
	self.GMButtonHideUI_3:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGMButtonHideUI_3)
	self.GMButtonHideDialogue:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGMButtonHideDialogue)
	self.buttonSkip:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSkip)
	self.GMButtonSkip:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGMButtonSkip)
	UIEventUtil.ClearEventListener(self)
end

function StoryPanel:__OnRepairBtnClick()
	SceneTransferModule.ReEnterStory()
end

function StoryPanel:GetCanvas()
	return self.gameObject:GetComponent(typeof(UnityEngine.Canvas))
end

function StoryPanel:SetButtonSkipShow(show)
	return
end

function StoryPanel:OnClickButtonSkip()
	StoryModule.StartSkip()
end

function StoryPanel:IsManualShowOnOpen(userData)
	return false
end

function StoryPanel:OnOpen(userData)
	if IQIGame.Onigao.Game.Device.isMobile then
		LuaUtility.SetGameObjectShow(self.GMChangeTimeScaleButton, PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.StoryMultipleSpeed) == "true")
		LuaUtility.SetGameObjectShow(self.GMStartFight, PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.StoryGMFight) == "true")
	end

	LuaUtility.SetGameObjectShow(self.GMButtonSkip, PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.StoryGMFight) == "true")
	LuaUtility.SetCanvasGroupShowWithGameObject(self.DescriptionPanel, false)
	self:RestoreUI()
	self:Refresh()
	EventDispatcher.Dispatch(EventID.StoryUIInitOverEvent)

	StoryModule.isStoryUIInitOver = true
end

function StoryPanel:OnClose(userData)
	self.PicturePanel:Close()
	self.MoviePanel:Close()
	self.PuzzleSelectPanel:Close()
	self.DialogueSelectPanel:Close()
	self:SetSurveyTargetShow(false)
	ConversationModule.ClearConversation()
	self.StoryDialoguePanel:DisposeSpeaks()
	self:ChangeTimeScale(1)

	if self.StoryMazePanel then
		self.StoryMazePanel:OnDestroy()

		self.StoryMazePanel = nil
	end
end

function StoryPanel:OnPause()
	return
end

function StoryPanel:OnDestroy()
	self:RemoveListener()
	self.storyJoystickView:Dispose()
	self.MoviePanel:OnDestroy()
	self.PicturePanel:OnDestroy()
	self.PuzzleSelectPanel:OnDestroy()
	self.DialogueSelectPanel:OnDestroy()
	self.judgmentCheckersPanel:OnDestroy()

	self.storyJoystickView = nil
	self.interacts = nil

	self.getClueTipPanel:Dispose()

	for _, v in pairsCfg(self.NPCNameList) do
		v:OnDestroy()
	end

	if self.StoryMazePanel then
		self.StoryMazePanel:OnDestroy()
	end

	self.StoryDialoguePanel:OnDestroy()
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

local autoDialogueStateArray = {
	"手动",
	"自动",
	"倍速1",
	"倍速2"
}

function StoryPanel:OnButtonAutoDialogueClick()
	local index = ConversationModule.autoDialogueStateIndex

	index = index + 1

	if index > #autoDialogueStateArray then
		index = 1
	end

	ConversationModule.autoDialogueStateIndex = index

	PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.autoDialogueStateIndex, index)
	self:RefreshAutoSpeakShow()
end

function StoryPanel:OnButtonPuzzleClick()
	UIModule.Open(Constant.UIControllerName.PuzzleUI, Constant.UILayer.UI)
end

function StoryPanel:OnStoryUIRefreshEvent(clueID, needTip, clueGetType)
	self:Refresh()

	if clueID and needTip then
		self.getClueTipPanel:Show()
		self.getClueTipPanel:Refresh(clueID, clueGetType)
	end
end

function StoryPanel:SetButtonPuzzleShow(isShow)
	if isShow and PuzzleModule.GetCurrentStoryCluesCount() > 0 then
		LuaUtility.SetCanvasGroupShowWithGameObject(self.buttonPuzzle, true)
		StoryModule.AddOrSetStoryUIState(Constant.StoryUI.Puzzle, true)
	else
		LuaUtility.SetCanvasGroupShowWithGameObject(self.buttonPuzzle, false)
		StoryModule.AddOrSetStoryUIState(Constant.StoryUI.Puzzle, false)
	end
end

function StoryPanel:Refresh()
	LuaUtility.SetGameObjectShow(self.RegularCheckMark, false)
	self:RefreshAutoSpeakShow()
	self.StoryDialoguePanel:Open()
	self:RefreshSurveyedEffect()

	local hideUIControl = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.HideUIControl) == "true"

	LuaUtility.SetGameObjectShow(self.GMHideUI, hideUIControl)
end

function StoryPanel:RefreshAutoSpeakShow()
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
end

function StoryPanel:ShowNPCName(NPCList)
	if not NPCList then
		return
	end

	local index = 1

	for i = 1, #self.NPCNameList do
		if i <= #NPCList then
			local StoryNPC = NPCList[i]

			if StoryNPC.canShowName then
				self.NPCNameList[i]:Refresh(StoryNPC:GetName(), StoryNPC.npcID, StoryNPC.NameFollower)
				self.NPCNameList[i]:Show(true)

				StoryNPC.NPCNameItem = self.NPCNameList[i]
				index = index + 1
			end
		end
	end

	for i = index, #NPCList do
		local StoryNPC = NPCList[i]

		if StoryNPC.canShowName then
			local NPCNamePrefabObj = GameObject.Instantiate(self.NPCNamePrefab, self.NPCNamePanel.transform)
			local NPCNameItem = StoryNPCNameItemClass.New(NPCNamePrefabObj, self)

			NPCNameItem:Refresh(StoryNPC:GetName(), StoryNPC.npcID, StoryNPC.NameFollower)
			NPCNameItem:Show(true)

			StoryNPC.NPCNameItem = NPCNameItem

			table.insert(self.NPCNameList, NPCNameItem)

			index = index + 1
		end
	end

	for i = index, #self.NPCNameList do
		self.NPCNameList[i]:Show(false)
	end
end

function StoryPanel:HideNPCName()
	for i = 1, #self.NPCNameList do
		self.NPCNameList[i]:Show(false)
	end
end

function StoryPanel:SetJoyStickSpeed(speed)
	self.storyJoystickView:OnSetMoveSpeed(speed)
end

function StoryPanel:PlayMovie(resourceID, PlayMovieTask)
	self.MoviePanel:Open()
	self.MoviePanel:PlayMovie(resourceID, PlayMovieTask)
end

function StoryPanel:ShowPicture(resourceID, posParam, ShowPictureTask)
	self.PicturePanel:Open()
	self.PicturePanel:Refresh(resourceID, posParam, ShowPictureTask)
end

function StoryPanel:ClosePicture()
	self.PicturePanel:Close()
end

function StoryPanel:HideReturnButton()
	LuaUtility.SetGameObjectShow(self.returnButton, false)
end

function StoryPanel:ShowReturnButton()
	LuaUtility.SetGameObjectShow(self.returnButton, true)
end

local timeScales = {
	1,
	3,
	10
}

function StoryPanel:ChangeTimeScale(timeScale)
	if timeScale then
		UnityEngine.Time.timeScale = timeScale
		self.timeScaleIndex = 1
	else
		self.timeScaleIndex = self.timeScaleIndex + 1

		if self.timeScaleIndex > #timeScales then
			self.timeScaleIndex = 1
		end
	end

	UnityEngine.Time.timeScale = timeScales[self.timeScaleIndex]
	self.GMChangeTimeScaleButton:GetComponentInChildren(typeof(UnityEngine.UI.Text)).text = string.format("timescale x%d", UnityEngine.Time.timeScale)
end

function StoryPanel:SetTopRootShow(show)
	LuaUtility.SetGameObjectShow(self.TopRoot, show)
end

function StoryPanel:OnGMStartFightClick()
	BehaviorTreeUtility.DebugStartFight()
end

function StoryPanel:SetSurveyTargetShow(show)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.objectSurveyTarget, show)
	StoryModule.AddOrSetStoryUIState(Constant.StoryUI.SurveyTarget, show)

	if StoryModule.isFirstShowSurvey and show then
		LuaUtility.PlayTweenAnimation(self.objectSurveyTarget, 1)

		StoryModule.isFirstShowSurvey = false
	end
end

function StoryPanel:SetSurveyTargetText(CfgTextID)
	local targetText = CfgUtil.GetCfgStoryTextDataWithID(CfgTextID)

	LuaUtility.SetText(self.textSurveyTarget, targetText)

	if not StoryModule.isFirstShowSurvey then
		LuaUtility.PlayTweenAnimation(self.objectSurveyTarget, 2)
	end
end

function StoryPanel:SetSurveyTargetProgress(numProgress, playAnimate)
	LuaUtility.SetRollingNumberValue(self.Com_RollingNumber, numProgress, playAnimate)
end

function StoryPanel:RefreshSurveyedEffect()
	local cfgCanCompose = PuzzleModule.GetTheFirstCanCompose()

	LuaUtility.SetGameObjectShow(self.puzzleMark, cfgCanCompose and true or false)
end

function StoryPanel:ShowClueTrigger(npcID, selectCfgID, ShowCluesTask)
	self.PuzzleSelectPanel:Open()
	self.PuzzleSelectPanel:Refresh(npcID, selectCfgID, ShowCluesTask)
end

function StoryPanel:ShowDialogueSelect(npcID, selectCfgID, ShowDialogueSelectionTask)
	self.DialogueSelectPanel:Open()
	self.DialogueSelectPanel:Refresh(npcID, selectCfgID, ShowDialogueSelectionTask)
end

function StoryPanel:OnButtonBoxClick()
	if self.isObjectExpandShow then
		LuaUtility.ReversePlayAnimation(self.buttonCollection, "buttonCollection_In")
	else
		LuaUtility.PlayAnimation(self.buttonCollection, "buttonCollection_In")
	end

	self.isObjectExpandShow = not self.isObjectExpandShow

	StoryUIApi:PlayCommonButtonSound()
end

function StoryPanel:OnButtonDialogueReviewClick()
	UIModule.Open(Constant.UIControllerName.DialogueReviewUI, Constant.UILayer.UI)
	StoryUIApi:PlayCommonButtonSound()
end

function StoryPanel:OnButtonChatClick()
	local data = StoryModule.GetSavedCommunicationData()

	if not data or #data <= 0 then
		NoticeModule.ShowNotice(70006)

		return
	end

	UIModule.Open(Constant.UIControllerName.StoryChatUI, Constant.UILayer.UI)
	StoryUIApi:PlayCommonButtonSound()
end

function StoryPanel:OnToggleRegularClick(isOn)
	LuaUtility.SetGameObjectShow(self.RegularCheckMark, isOn)

	if isOn then
		LuaUtility.SetLvFilterVolumeEnable(true)
		LuaUtility.DoTweenTo_Float(0, 1, LuaUtility.GetBehaviorGlobalFloatVariables(Constant.BehaviorGlobalDefine.RegularFilterDuration), function(v)
			LuaUtility.SetLvFilterVolumeControl(v)

			if v >= 1 then
				self.toggleRegular.interactable = true

				BehaviorTreeUtility.TriggerRegularShowBehaviorTree()
			end
		end)
	else
		LuaUtility.DoTweenTo_Float(1, 0, LuaUtility.GetBehaviorGlobalFloatVariables(Constant.BehaviorGlobalDefine.RegularFilterDuration), function(v)
			LuaUtility.SetLvFilterVolumeControl(v)

			if v <= 0 then
				LuaUtility.SetLvFilterVolumeEnable(false)

				self.toggleRegular.interactable = true

				BehaviorTreeUtility.TriggerRegularCloseBehaviorTree()
			end
		end)
		StoryUIApi:CloseLvXiangEffectSound()
	end

	self.toggleRegular.interactable = false
end

function StoryPanel:SetRegularShow(show)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.toggleRegular.gameObject, show)
	StoryModule.AddOrSetStoryUIState(Constant.StoryUI.Regular, show)
end

function StoryPanel:RegularToggleEnabled(enabled)
	self.toggleRegular.isOn = enabled
end

function StoryPanel:SetReturnButtonShow(show)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.Com_ReturnBtn, show)
	StoryModule.AddOrSetStoryUIState(Constant.StoryUI.Return, show)
end

function StoryPanel:SetButtonCollectionShow(show)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.buttonCollectionRoot, show)
	StoryModule.AddOrSetStoryUIState(Constant.StoryUI.ButtonCollection, show)
end

function StoryPanel:SetAutoDialogueShow(show)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.AutoDialogueRoot, show)
	StoryModule.AddOrSetStoryUIState(Constant.StoryUI.AutoDialogue, show)
end

function StoryPanel:SetStoryDescription(isShow, timeID, mainSiteID, branchSiteID, duration, SetStorySiteShow)
	if not isShow then
		LuaUtility.SetCanvasGroupShowWithGameObject(self.DescriptionPanel, false)

		return
	end

	LuaUtility.SetText(self.TextTime, timeID ~= 0 and CfgUtil.GetCfgStoryTextDataWithID(timeID) or "")
	LuaUtility.SetText(self.TextMainSite, mainSiteID ~= 0 and CfgUtil.GetCfgStoryTextDataWithID(mainSiteID) or "")
	LuaUtility.SetText(self.TextBranchSite, branchSiteID ~= 0 and CfgUtil.GetCfgStoryTextDataWithID(branchSiteID) or "")
	self.TextTimeBgSource:SetProgress(1)
	self.TextMainSiteBgSource:SetProgress(1)
	self.TextBranchSiteBgSource:SetProgress(1)
	LuaUtility.PlayAnimation(self.DescriptionPanel, "StoryUI_01", nil, function()
		LuaUtility.SetCanvasGroupShowWithGameObject(self.DescriptionPanel, false)
		SetStorySiteShow:SetComplete()
	end)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.DescriptionPanel, true)
end

function StoryPanel:EnterStoryMod()
	LuaUtility.SetCanvasGroupShowWithGameObject(self.buttonCollectionRoot, true)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.Com_ReturnBtn, true)
end

function StoryPanel:RestoreUI()
	local uiState = StoryModule.GetUiStateDic()

	for i, v in pairs(uiState) do
		if i == Constant.StoryUI.Puzzle then
			self:SetButtonPuzzleShow(v)
		elseif i == Constant.StoryUI.Return then
			self:SetReturnButtonShow(v)
		elseif i == Constant.StoryUI.Regular then
			self:SetRegularShow(v)
		elseif i == Constant.StoryUI.Joystick then
			if v then
				self.storyJoystickView:Open()
			else
				self.storyJoystickView:Close()
			end
		elseif i == Constant.StoryUI.SurveyTarget then
			self:SetSurveyTargetShow(v)
		end
	end
end

function StoryPanel:CheckGMHideUI()
	local len = #self.hideUICheckQueue

	if len > 3 then
		self.hideUICheckQueue = {}

		return
	end

	if len ~= 3 then
		return
	end

	for i = 1, len do
		if self.hideUICheckQueue[i] ~= i then
			return
		end
	end

	self.isHideUIState = not self.isHideUIState
	self.gameObject:GetComponent("CanvasGroup").alpha = self.isHideUIState and 0 or 1
	self.hideUICheckQueue = {}
end

function StoryPanel:OnClickGMButtonHideDialogue()
	if self.StoryDialoguePanel:GetIsShow() then
		self.StoryDialoguePanel:Close()
	else
		self.StoryDialoguePanel:Open()
	end
end

function StoryPanel:SetStoryUIShow(show)
	if show then
		LuaUtility.SetStateController(self.gameObject, "HideOnGuide", "Show")
	else
		LuaUtility.SetStateController(self.gameObject, "HideOnGuide", "Hide")
	end
end

function StoryPanel:SetUIStateOnImagePuzzleOpen()
	LuaUtility.SetCanvasGroupShowWithGameObject(self.Com_ReturnBtn, false)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.buttonCollectionRoot, false)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.AutoDialogueRoot, false)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.toggleRegular.gameObject, false)
end

function StoryPanel:SetUIStateOnImagePuzzleClose()
	local uiState = StoryModule.GetUiStateDic()

	LuaUtility.SetCanvasGroupShowWithGameObject(self.Com_ReturnBtn, uiState[Constant.StoryUI.Return] and uiState[Constant.StoryUI.Return] or true)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.buttonCollectionRoot, uiState[Constant.StoryUI.ButtonCollection] and uiState[Constant.StoryUI.ButtonCollection] or true)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.AutoDialogueRoot, uiState[Constant.StoryUI.AutoDialogue] and uiState[Constant.StoryUI.AutoDialogue] or true)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.toggleRegular.gameObject, uiState[Constant.StoryUI.Regular] and uiState[Constant.StoryUI.Regular] or true)
end

return StoryPanel
