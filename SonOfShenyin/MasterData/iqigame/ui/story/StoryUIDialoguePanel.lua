-- chunkname: @IQIGame\\UI\\Story\\StoryUIDialoguePanel.lua

local StoryUIDialoguePanel = class(nil, BaseChildrenPanel)
local SpeakView = require("IQIGame.UI.Story.SpeakView")
local AsideView = require("IQIGame.UI.Story.AsideView")
local standPaintView = require("IQIGame.UI.Story.StandPaintView")
local propertyFill = {
	Speed = "_Speed",
	Mask = "_jiange"
}

function StoryUIDialoguePanel.New(go, mainView)
	local o = Clone(StoryUIDialoguePanel)

	o:Initialize(go, mainView)

	return o
end

function StoryUIDialoguePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryUIDialoguePanel:InitMembers()
	self.speaks = {}
end

function StoryUIDialoguePanel:InitComponent()
	self.confirmConversationLongButton = self.ConfirmConversationButton:GetComponent(typeof(LongButton))
	self.MaterialFill = self.imageFill:GetComponent("MeshRenderer").material
	self.MaterialBackground = self.imageBackground:GetComponent("MeshRenderer").material

	self:SetConfirmButtonShow(false)
end

function StoryUIDialoguePanel:InitDelegate()
	function self.delegateConfirmConversation()
		self:ConfirmConversation()
	end

	function self.SetConfirmButtonShowEvent(show)
		self:SetConfirmButtonShow(show)
	end
end

function StoryUIDialoguePanel:AddListener()
	self.confirmConversationLongButton.onClick:AddListener(self.delegateConfirmConversation)
	EventDispatcher.AddEventListener(EventID.StorySetConfirmButtonShowEvent, self.SetConfirmButtonShowEvent)
end

function StoryUIDialoguePanel:RemoveListener()
	self.confirmConversationLongButton.onClick:RemoveListener(self.delegateConfirmConversation)
	EventDispatcher.RemoveEventListener(EventID.StorySetConfirmButtonShowEvent, self.SetConfirmButtonShowEvent)
end

function StoryUIDialoguePanel:OnDestroy()
	self:RemoveListener()

	for _, v in pairs(self.speaks) do
		v:OnDestroy()
	end
end

function StoryUIDialoguePanel:ConfirmConversation()
	EventDispatcher.Dispatch(EventID.BehaviorTreeNPCConfirmConversation)
end

local startSpeedTime = CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.StoryMultipleSpeedTime) / 1000

function StoryUIDialoguePanel:OnOnConfirmLongClickDown(timer)
	if self.isSpeed then
		return
	end

	if not self.dLongClickStartTime then
		self.dLongClickStartTime = timer

		self:SetMultipleSpeedShow(true)
	end

	local t = timer - self.dLongClickStartTime
	local v = math.MapClamped(t, 0, startSpeedTime, 0, 1)

	self:SetSpeedProgress(v)

	if v >= 1 then
		self:OnLongClickEnable()

		return
	end
end

function StoryUIDialoguePanel:OnLongClickEnable()
	self.isSpeed = true
	Time.timeScale = LuaUtility.GetBehaviorGlobalFloatVariables(Constant.BehaviorGlobalDefine.StoryMultipleSpeed)

	local v = 10 / Time.timeScale

	self.MaterialFill:SetFloat(propertyFill.Speed, v)
	self.MaterialBackground:SetFloat(propertyFill.Speed, v)

	ConversationModule.isAuto = true

	self.mainView:RefreshAutoSpeakShow()
end

function StoryUIDialoguePanel:OnConfirmLongClickEnd()
	self.isSpeed = false
	self.dLongClickStartTime = nil

	self:SetSpeedProgress(0)
	self:SetMultipleSpeedShow(false)
	self.MaterialFill:SetFloat(propertyFill.Speed, 0)
	self.MaterialBackground:SetFloat(propertyFill.Speed, 0)

	if not StoryModule.StoryManager.MultipleSpeedNoChange then
		Time.timeScale = 1
	end
end

function StoryUIDialoguePanel:OnOpen()
	self:SetMultipleSpeedShow(false)
	self:DisposeSpeaks()
end

function StoryUIDialoguePanel:DisposeSpeaks()
	for _, v in pairs(self.speaks) do
		v:OnDestroy()
	end

	self.speaks = {}
end

function StoryUIDialoguePanel:GetSpeakID(type, npcID)
	local speaksID

	if type == Constant.StoryDialogueType.Conversation then
		speaksID = npcID
	elseif type == Constant.StoryDialogueType.IntroNarration then
		speaksID = -2
	elseif type == Constant.StoryDialogueType.StandPaint then
		speaksID = -1
	else
		logError("【剧情】没有对话类型:" .. type)
	end

	return speaksID
end

function StoryUIDialoguePanel:AddSpeak(ShowSpeakViewParam)
	self:UpdateOrCreateSpeakView(ShowSpeakViewParam)
end

function StoryUIDialoguePanel:RemoveSpeak(dialogueType, npcID)
	local speakID = self:GetSpeakID(dialogueType, npcID)

	if self.speaks[speakID] then
		self.speaks[speakID]:Close()
	end
end

function StoryUIDialoguePanel:UpdateSpeak(dialogueType, npcID, progress)
	local speakID = self:GetSpeakID(dialogueType, npcID)

	if self.speaks[speakID] then
		self.speaks[speakID]:UpdateProgress(progress)
	end
end

function StoryUIDialoguePanel:SetSpeakCanGoNextShow(dialogueType, npcID, show)
	local speakID = self:GetSpeakID(dialogueType, npcID)

	if self.speaks[speakID] then
		self.speaks[speakID]:SetCanGoNextShow(show)
	end
end

function StoryUIDialoguePanel:UpdateOrCreateSpeakView(ShowSpeakViewParam)
	if not self.speaks then
		self.speaks = {}
	end

	local storyDialogueConfig = CfgUtil.GetCfgStoryDialogueDataWithID(ShowSpeakViewParam.storyDialogueCid)
	local speakId = self:GetSpeakID(storyDialogueConfig.DialogueType, ShowSpeakViewParam.npcID)

	if not self.speaks[speakId] then
		self:_CreateSpeakView(ShowSpeakViewParam)
	end

	if self.speaks[speakId] then
		local view = self.speaks[speakId]

		view:Open(ShowSpeakViewParam.storyDialogueCid, ShowSpeakViewParam.npcName, ShowSpeakViewParam.dialogueContent, ShowSpeakViewParam.npcID, ShowSpeakViewParam.speakCfgId)
	end
end

function StoryUIDialoguePanel:_CreateSpeakView(ShowSpeakViewParam)
	local storyDialogueConfig = CfgUtil.GetCfgStoryDialogueDataWithID(ShowSpeakViewParam.storyDialogueCid)

	if storyDialogueConfig.DialogueType == Constant.StoryDialogueType.Conversation then
		local obj = GameObject.Instantiate(self.speakPanelPrefab, self.conversationViews.transform)

		self.speaks[self:GetSpeakID(storyDialogueConfig.DialogueType, ShowSpeakViewParam.npcID)] = SpeakView.New(obj, ShowSpeakViewParam.npcID, ShowSpeakViewParam.npcName, ShowSpeakViewParam.storyDialogueCid, ShowSpeakViewParam.dialogueContent, self.mainView:GetCanvas(), ShowSpeakViewParam.speakCfgId)
	elseif storyDialogueConfig.DialogueType == Constant.StoryDialogueType.IntroNarration then
		local obj = GameObject.Instantiate(self.asidePanelPrefab, self.AsideConversationViews.transform)

		self.speaks[self:GetSpeakID(storyDialogueConfig.DialogueType, ShowSpeakViewParam.npcID)] = AsideView.New(obj, ShowSpeakViewParam.npcID, ShowSpeakViewParam.npcName, ShowSpeakViewParam.storyDialogueCid, ShowSpeakViewParam.dialogueContent, ShowSpeakViewParam.speakCfgId)
	elseif storyDialogueConfig.DialogueType == Constant.StoryDialogueType.StandPaint then
		local obj = GameObject.Instantiate(self.StandingPaintingPrefab, self.conversationViews.transform)

		self.speaks[self:GetSpeakID(storyDialogueConfig.DialogueType, ShowSpeakViewParam.npcID)] = standPaintView.New(obj, ShowSpeakViewParam.npcID, ShowSpeakViewParam.storyDialogueCid, ShowSpeakViewParam.dialogueContent, ShowSpeakViewParam.speakCfgId)
	end
end

function StoryUIDialoguePanel:StartConversation(ShowSpeakViewParam)
	self:AddSpeak(ShowSpeakViewParam)
	LuaUtility.PlaySoundWithID(22000002)
end

function StoryUIDialoguePanel:SetConfirmButtonShow(show)
	LuaUtility.SetGameObjectShow(self.ConfirmConversationButton, show)
end

function StoryUIDialoguePanel:SetMultipleSpeedShow(show)
	LuaUtility.SetGameObjectShow(self.multipleSpeed, show)

	self.isMultipleSpeedShow = show
end

function StoryUIDialoguePanel:SetSpeedProgress(num)
	self.MaterialFill:SetFloat(propertyFill.Mask, 1 - num)
end

return StoryUIDialoguePanel
