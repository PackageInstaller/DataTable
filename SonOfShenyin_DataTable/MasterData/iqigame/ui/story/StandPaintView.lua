-- chunkname: @IQIGame\\UI\\Story\\StandPaintView.lua

local StandPaintView = {}

function StandPaintView.New(obj, npcID, storyDialogueCid, dialogueContent, speakCfgId)
	local o = Clone(StandPaintView)

	o:Initialize(obj, npcID, storyDialogueCid, dialogueContent, speakCfgId)

	return o
end

function StandPaintView:Initialize(obj, npcID, storyDialogueCid, dialogueContent, speakCfgId)
	LuaCodeInterface.BindOutlet(obj, self)

	self.gameObject = obj
	self.npcID = npcID
	self.speakCfgId = speakCfgId
	self.standPaintList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StandPaintView:InitComponent()
	self.contentTextBackgroundSource = self.textChatContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.npcNameTextBackgroundSource = self.textName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.SpineMountPointRect = self.SpineMountPoint:GetComponent("RectTransform")
	self.chatBoxRect = self.chatBox:GetComponent("RectTransform")
	self.nameBoxRect = self.nameBox:GetComponent("RectTransform")
	self.imageCanGoNextRect = self.imageCanGoNext:GetComponent("RectTransform")
end

function StandPaintView:InitDelegate()
	function self.setStandPaintAnimationDelegate(npcID, AnimationName, isLoop)
		self:SetStandPaintAnimation(npcID, AnimationName, isLoop)
	end

	function self.addStandPaintAnimationDelegate(npcID, AnimationName, isLoop)
		self:AddStandPaintAnimation(npcID, AnimationName, isLoop)
	end
end

function StandPaintView:AddListener()
	EventDispatcher.AddEventListener(EventID.SetStandPaintAnimationEvent, self.setStandPaintAnimationDelegate)
	EventDispatcher.AddEventListener(EventID.AddStandPaintAnimationEvent, self.addStandPaintAnimationDelegate)
end

function StandPaintView:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.SetStandPaintAnimationEvent, self.setStandPaintAnimationDelegate)
	EventDispatcher.RemoveEventListener(EventID.AddStandPaintAnimationEvent, self.addStandPaintAnimationDelegate)
end

function StandPaintView:Open(storyDialogueCid, npcName, dialogueContent, npcId, speakCfgId)
	self.speakCfgId = speakCfgId

	self:OnOpen(storyDialogueCid, npcName, dialogueContent, npcId)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function StandPaintView:OnOpen(storyDialogueCid, npcName, dialogueContent, npcId)
	self.npcID = npcId

	self:Refresh(storyDialogueCid, npcName, dialogueContent)
end

function StandPaintView:Close()
	self:OnClose()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function StandPaintView:OnClose()
	return
end

function StandPaintView:OnDestroy()
	self.currentStandPaint = nil

	self:RemoveListener()
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	for _, v in pairs(self.standPaintList) do
		GameObject.Destroy(v)
	end

	self.standPaintList = {}

	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

function StandPaintView:Refresh(storyDialogueCid, npcName, dialogueContent)
	self.storyDialogueCid = storyDialogueCid

	local character = BehaviorTreeUtility.GetNPCByNPCID(self.npcID)
	local cfgEntity = CfgUtil.GetCfgCfgElementEntityDataWithID(character.entityConfigID)
	local cfgDialogue = CfgUtil.GetCfgStoryDialogueDataWithID(self.storyDialogueCid)

	if self.currentStandPaint then
		LuaUtility.SetGameObjectShow(self.currentStandPaint, false)

		self.currentStandPaint = nil
	end

	if self.standPaintList[self.npcID] then
		LuaUtility.SetGameObjectShow(self.standPaintList[self.npcID], true)

		self.currentStandPaint = self.standPaintList[self.npcID]

		EventDispatcher.Dispatch(EventID.ConversationStageSetPlayingSpeak, self.speakCfgId, true)
		EventDispatcher.DispatchSingleEvent(EventID.PlayStandPaintAnimationEvent)
	else
		LuaUtility.LoadAsset(self, cfgEntity.Tachie, self.OnStandPaintLoadSuccess)
	end

	local params = CfgUtil.GetPublicParametersData()
	local spineMount, chatBox, nameBox, imageCanGo

	if cfgDialogue.DialogueParam == 1 then
		spineMount = params.SpineMountPoint_1
		chatBox = params.chatBox_1
		nameBox = params.nameBox_1
		imageCanGo = params.imageCanGoNext_1
	elseif cfgDialogue.DialogueParam == 2 then
		spineMount = params.SpineMountPoint_2
		chatBox = params.chatBox_2
		nameBox = params.nameBox_2
		imageCanGo = params.imageCanGoNext_2
	else
		logError(string.format("【配置表】StoryDialogue.csv 立绘对话的对话参数不能为 %s", cfgDialogue.DialogueParam))
	end

	LuaUtility.SetAnchoredPositionWithRectTransform(self.SpineMountPointRect, spineMount.x, spineMount.y)
	LuaUtility.SetAnchoredPositionWithRectTransform(self.chatBoxRect, chatBox.x, chatBox.y)
	LuaUtility.SetAnchoredPositionWithRectTransform(self.nameBoxRect, nameBox.x, nameBox.y)
	LuaUtility.SetAnchoredPositionWithRectTransform(self.imageCanGoNextRect, imageCanGo.x, imageCanGo.y)
	LuaUtility.SetText(self.textName, npcName)
	self.npcNameTextBackgroundSource:SetProgress(1)
	LuaUtility.SetText(self.textChatContent, dialogueContent)
	self.contentTextBackgroundSource:SetProgress(0)
	self:SetCanGoNextShow(false)
end

function StandPaintView:OnStandPaintLoadSuccess(assetName, asset, duration, userData)
	local obj = GameObject.Instantiate(asset, self.SpineMountPoint.transform)

	self.standPaintList[self.npcID] = obj
	self.currentStandPaint = self.standPaintList[self.npcID]

	EventDispatcher.Dispatch(EventID.ConversationStageSetPlayingSpeak, self.speakCfgId, true)
	EventDispatcher.DispatchSingleEvent(EventID.PlayStandPaintAnimationEvent)
end

function StandPaintView:UpdateProgress(progress)
	self.contentTextBackgroundSource:SetProgress(progress)
	self.npcNameTextBackgroundSource:SetProgress(1)
end

function StandPaintView:SetCanGoNextShow(show)
	LuaUtility.SetGameObjectShow(self.imageCanGoNext, show)
end

function StandPaintView:SetStandPaintAnimation(npcID, AnimationName, isLoop)
	if not self.standPaintList[npcID] then
		return
	end

	LuaUtility.SetSkeletonGraphicAnimationWithGameObject(self.standPaintList[npcID], 0, AnimationName, isLoop)
end

function StandPaintView:AddStandPaintAnimation(npcID, AnimationName, isLoop)
	if not self.standPaintList[npcID] then
		return
	end

	LuaUtility.AddSkeletonGraphicAnimationWithGameObject(self.standPaintList[npcID], 0, AnimationName, isLoop)
end

return StandPaintView
