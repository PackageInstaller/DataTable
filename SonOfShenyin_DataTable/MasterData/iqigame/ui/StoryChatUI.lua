-- chunkname: @IQIGame\\UI\\StoryChatUI.lua

local StoryChatUI = {}

StoryChatUI = Base:Extend("StoryChatUI", "IQIGame.Onigao.UI.StoryChatUI", StoryChatUI)

local StoryChatUIRoleItemClass = require("IQIGame.UI.Story.StoryChatUIRoleItem")
local StoryChatUIContentViewClass = require("IQIGame.UI.Story.StoryChatUIContentView")
local StoryChatOptionViewViewClass = require("IQIGame.UI.Story.StoryChatOptionView")

function StoryChatUI:OnInit()
	self:InitDelegate()
	self:InitComponent()
	self:InitMembers()
end

function StoryChatUI:InitDelegate()
	function self.DelegateOnClickinputBtn()
		self:OnClickinputBtn()
	end

	function self.DelegateOnClickbackToNewBtn()
		self:OnClickbackToNewBtn()
	end

	function self.DelegateOnClickcloseBtn()
		self:OnClickcloseBtn()
	end

	function self.performanceChatEvent(AddCommunicationChatPerformanceTask)
		self:ChatPerformanceStart(AddCommunicationChatPerformanceTask)
	end

	function self.performanceOptionEvent(AddCommunicationOptionPerformance)
		self:ShowOptions(AddCommunicationOptionPerformance)
	end

	function self.delegateOnClickSendBtn()
		self:OnClickSendBtn()
	end

	function self.currentSelectRefreshEvent()
		if self.currentSelectRole then
			self:SelectGroup(self.currentSelectRole.groupId)
		end
	end

	function self.delegateOnClickButtonSkip()
		self:OnClickButtonSkip()
	end
end

function StoryChatUI:InitComponent()
	self.chattingRecordsScroll = self.chattingRecordsScroll:GetComponent("OptimizedScrollRect")

	self.chattingRecordsScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateChatScroll(OptimizedParams, OptimizedViewsHolder)
	end)
	self.chattingRecordsScroll:RegisterRebuildLayoutDueToScrollViewSizeChange(function()
		self:RebuildLayoutDueToScrollViewSizeChange()
	end)
	self.chattingRecordsScroll:RegisterActionItemRemoveOrAdd(function(shiftedViewsHolder, oldIndex, wasInsert, removeOrInsertIndex)
		self:ActionItemRemoveOrAdd(shiftedViewsHolder, oldIndex, wasInsert, removeOrInsertIndex)
	end)

	self.optionalChatContentRect = self.optionalChatContent:GetComponent("RectTransform")
	self.optionalChatContentImage = self.optionalChatContent:GetComponent("Image")
end

function StoryChatUI:InitMembers()
	self.roleItemViewList = {}
	self.chatDataModule = {}
	self.chatViewList = {}
	self.optionViewList = {}
end

function StoryChatUI:OnOpen(userData)
	self:CollectionData(userData)
	self:RefreshRoleView()
	self:SelectGroup(self.selectGroupID)
	self.chattingRecordsScroll:SetGoButtonEnable()

	if userData and userData.StartCommunicationTask then
		EventDispatcher.Dispatch(EventID.StoryChatUIOpenEvent, userData.StartCommunicationTask)
	end
end

function StoryChatUI:OnClose(userData)
	self.isChatting = false
	self.currentShowChatData = nil

	if self.AddCommunicationChatPerformanceTask then
		self.AddCommunicationChatPerformanceTask:SetComplete()

		self.AddCommunicationChatPerformanceTask = nil
	end
end

function StoryChatUI:OnAddListeners()
	self.inputBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickinputBtn)
	self.backToNewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickbackToNewBtn)
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickcloseBtn)
	self.sendBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickSendBtn)
	self.ButtonSkip:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSkip)
	EventDispatcher.AddEventListener(EventID.StoryChatPerformanceStart, self.performanceChatEvent)
	EventDispatcher.AddEventListener(EventID.StoryChatUIOptionEvent, self.performanceOptionEvent)
	EventDispatcher.AddEventListener(EventID.StoryChatUIRefreshSelect, self.currentSelectRefreshEvent)
end

function StoryChatUI:OnRemoveListeners()
	self.inputBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickinputBtn)
	self.backToNewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickbackToNewBtn)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickcloseBtn)
	self.sendBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickSendBtn)
	self.ButtonSkip:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSkip)
	EventDispatcher.RemoveEventListener(EventID.StoryChatPerformanceStart, self.performanceChatEvent)
	EventDispatcher.RemoveEventListener(EventID.StoryChatUIOptionEvent, self.performanceOptionEvent)
	EventDispatcher.RemoveEventListener(EventID.StoryChatUIRefreshSelect, self.currentSelectRefreshEvent)
end

function StoryChatUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isChatting then
		self:_OnChatting()
	end
end

function StoryChatUI:OnDestroy()
	for i = 1, #self.roleItemViewList do
		self.roleItemViewList[i]:OnDestroy()
	end

	for i = 1, #self.chatViewList do
		self.chatViewList[i]:OnDestroy()
	end

	for i = 1, #self.optionViewList do
		self.optionViewList[i]:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function StoryChatUI:GetPreloadAssetPaths()
	return nil
end

function StoryChatUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function StoryChatUI:IsManualShowOnOpen(userData)
	return false
end

function StoryChatUI:GetBGM(userData)
	return nil
end

function StoryChatUI:OnPause()
	return
end

function StoryChatUI:OnResume()
	return
end

function StoryChatUI:OnCover()
	return
end

function StoryChatUI:OnReveal()
	return
end

function StoryChatUI:OnRefocus(userData)
	return
end

function StoryChatUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function StoryChatUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function StoryChatUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function StoryChatUI:OnClickButtonSkip()
	if not self.canClickSkip then
		return
	end

	if self.lastBubble then
		self.lastBubble:HideBubble()

		self.lastBubble = nil
	end

	self:ShowNextChat()
end

function StoryChatUI:OnClickinputBtn()
	return
end

function StoryChatUI:OnClickbackToNewBtn()
	return
end

function StoryChatUI:OnClickcloseBtn()
	if self.isPerformance then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, "演示中不允许操作")

		return
	end

	UIModule.CloseSelf(self)
end

function StoryChatUI:UpdateChatScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.chatDataModule[index + 1]

	if not self.chatViewList[instanceID] then
		self.chatViewList[instanceID] = StoryChatUIContentViewClass.New(viewGameObject, self)
	end

	self.chatViewList[instanceID]:Refresh(data, OptimizedViewsHolder)
end

function StoryChatUI:CollectionData(userData)
	self.selectGroupID = userData and userData.selectGroupID or nil

	if not self.selectGroupID then
		self.selectGroupID = self.roleItemViewList[1] and self.roleItemViewList[1].groupId or nil
	end

	self.isPerformance = userData and userData.isPerformance or false

	LuaUtility.SetGameObjectShow(self.chatState, false)
	LuaUtility.SetGameObjectShow(self.ButtonSkip, false)

	self.optionalChatContentImage.enabled = false

	self.chattingRecordsScroll:SetDragEnabled(true)
end

function StoryChatUI:RefreshChatScroll(data)
	self.chatDataModule = data

	self.chattingRecordsScroll:RefreshByItemCount(#self.chatDataModule)
	Timer.New(function()
		self.chattingRecordsScroll:SetNormalizedPosition(0)
	end, 0.01, 1):Start()
end

function StoryChatUI:RefreshRoleView()
	local data = StoryModule.GetSavedCommunicationData()
	local index = 1

	for i = 1, #data do
		local view

		if i > #self.roleItemViewList then
			local o = GameObject.Instantiate(self.roleDialogItemParent, self.roleDialogGrid.transform)
			local v = StoryChatUIRoleItemClass.New(o, self)

			self.roleItemViewList[i] = v
		end

		view = self.roleItemViewList[i]

		view:Refresh(data[i])
		view:Show()

		index = i
	end

	for i = index + 1, #self.roleItemViewList do
		self.roleItemViewList[i]:Hide()
	end
end

function StoryChatUI:SelectGroup(groupId)
	local roleItemView

	for _, v in pairs(self.roleItemViewList) do
		if v.groupId == groupId then
			roleItemView = v

			break
		end
	end

	if not roleItemView then
		logError("【通信信息】没有找到头像组 ID = " .. groupId)

		return
	end

	if self.currentSelectRole then
		self.currentSelectRole:SetSelect(false)
	end

	self.currentSelectRole = roleItemView

	self.currentSelectRole:SetSelect(true)
	self:ShowChatGroupDetailsImmediately(groupId)
	LuaUtility.SetGameObjectShow(self.backToNewBtn, false)
end

function StoryChatUI:ShowChatGroupDetailsImmediately(index)
	local communicationData = StoryModule.GetSavedCommunicationData()
	local len = #communicationData
	local data

	for i = 1, len do
		if communicationData[i].index == index then
			data = communicationData[i]

			break
		end
	end

	if not data then
		logError("【通信信息】没有 GroupId = " .. index .. "的通信对话数据")

		return
	end

	local chatData = data.chatData

	self:RefreshChatScroll(StoryModule.ConvertToChatScrollData(chatData))
end

function StoryChatUI:ChatPerformanceStart(AddCommunicationChatPerformanceTask)
	self.chattingRecordsScroll:SetGoButtonUnEnable()

	local needShow = StoryModule.GetNeedShowCommunicationData()

	self.currentDialogueStartID = needShow.id
	self.currentShowChatData = StoryModule.ConvertToChatScrollData(needShow)
	self.AddCommunicationChatPerformanceTask = AddCommunicationChatPerformanceTask

	self:ShowNextChat(true)
end

function StoryChatUI:ShowNextChat(isFirst)
	if isFirst then
		self.currentShowIndex = 1
	else
		self.currentShowIndex = self.currentShowIndex + 1
	end

	if self.currentShowIndex > #self.currentShowChatData then
		self:OnChatOver()

		return
	end

	if self.lastBubble then
		self.lastBubble:HideBubble()
	end

	table.insert(self.chatDataModule, self.currentShowChatData[self.currentShowIndex])

	local CfgDialogue = CfgUtil.GetCfgStoryDialogueDataWithID(self.currentShowChatData[self.currentShowIndex].id)
	local CfgSpeak = CfgUtil.GetCfgStorySpeakNpcDataWithID(self.currentShowChatData[self.currentShowIndex].id)
	local strContent = ConversationModule.GetSpeakNpcContent(CfgSpeak)
	local strLen = string.len(strContent)

	self.currentSpanTime = CfgDialogue.Staytime == 0 and strLen * ConversationModule.autoCharacterSpeed or CfgDialogue.Staytime
	self.canClickSkipTime = CfgDialogue.skiptime == 0 and CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.StorySkipConversationTime) / 1000 or CfgDialogue.skiptime
	self.hideBubbleTime = strLen * CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.StoryChatBubbleCharacterTime) / 1000
	self.dTime = Time.time
	self.isChatting = true
	self.insertIndex = #self.chatDataModule - 1
	self.canClickSkip = false

	self.chattingRecordsScroll:SetDragEnabled(false)
	self.chattingRecordsScroll:InsertItems(#self.chatDataModule - 1, 1, false, true)
	self.chattingRecordsScroll:SetNormalizedPosition(0)
	LuaUtility.SetGameObjectShow(self.ButtonSkip, true)
end

function StoryChatUI:_OnChatting()
	if Time.time - self.dTime > self.currentSpanTime then
		self:ShowNextChat()
	end

	if Time.time - self.dTime > self.canClickSkipTime then
		self.canClickSkip = true
	end

	if Time.time - self.dTime > self.hideBubbleTime and self.lastBubble then
		self.lastBubble:HideBubble()

		self.lastBubble = nil
	end
end

function StoryChatUI:OnChatOver()
	self.isChatting = false
	self.currentShowChatData = {}
	self.insertIndex = -1
	self.lastBubble = nil

	LuaUtility.SetGameObjectShow(self.ButtonSkip, false)

	local showCfg = StoryModule.GetNeedShowCommunicationData()

	StoryModule.AddCommunicationChatData(showCfg.GroupID, showCfg.type, showCfg.id)

	if self.AddCommunicationChatPerformanceTask then
		self.AddCommunicationChatPerformanceTask:SetComplete()

		self.AddCommunicationChatPerformanceTask = nil
	end
end

function StoryChatUI:ShowOptions(AddCommunicationOptionPerformance)
	self.optionalChatContentImage.enabled = true
	self.AddCommunicationOptionPerformance = AddCommunicationOptionPerformance

	local needShow = StoryModule.GetNeedShowCommunicationData()
	local cfgOption = CfgUtil.GetCfgStoryOptionDataWithID(needShow.id)
	local index

	for i = 1, #cfgOption.Options do
		if i > #self.optionViewList then
			local o = GameObject.Instantiate(self.optionalChatItem, self.optionalChatContent.transform)
			local v = StoryChatOptionViewViewClass.New(o, self)

			self.optionViewList[i] = v
		end

		self.optionViewList[i]:Show()
		self.optionViewList[i]:Refresh(cfgOption.Options[i])

		index = i
	end

	for i = index + 1, #self.optionViewList do
		self.optionViewList[i]:Hide()
	end

	LuaUtility.SetText(self.textInput, "")
	LuaUtility.SetGameObjectShow(self.chatState, true)
	self.chattingRecordsScroll:SetDragEnabled(true)
	Timer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.optionalChatContentRect)
		LuaUtility.SetSizeDeltaYWithGameObject(self.chattingRecordsScroll.gameObject, 508 - self.optionalChatContentRect.sizeDelta.y)
		LuaUtility.PlayAnimation(self.optionalChatPanel, "optionalChatPanel")
	end, 0.01, 1):Start()
end

function StoryChatUI:OnOptionClick(selectView)
	if self.currentSelectView == selectView then
		return
	end

	if self.currentSelectView then
		self.currentSelectView:SetSelect(false)
	end

	self.currentSelectView = selectView

	self.currentSelectView:SetSelect(true)
	LuaUtility.SetText(self.textInput, CfgUtil.GetCfgStoryTextDataWithID(self.currentSelectView.Data))

	self.optionalChatContentImage.enabled = false
end

function StoryChatUI:OnClickSendBtn()
	if self.isAnimation then
		return
	end

	StoryUIApi:PlayChatUISendSound()
	coroutine.start(function()
		LuaUtility.PlayAnimation(self.chatState, "sendBtn_click")

		self.isAnimation = true

		coroutine.wait(1.2)

		for i = 1, #self.optionViewList do
			self.optionViewList[i]:Hide()
		end

		LuaUtility.SetGameObjectShow(self.chatState, false)
		coroutine.wait(0.01)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.optionalChatContentRect)
		LuaUtility.SetSizeDeltaYWithGameObject(self.chattingRecordsScroll.gameObject, 508)

		if self.AddCommunicationOptionPerformance then
			self.AddCommunicationOptionPerformance:SetComplete(self.currentSelectView.Data)
		end

		self.currentSelectView = nil
		self.isAnimation = false
	end)
end

function StoryChatUI:RebuildLayoutDueToScrollViewSizeChange()
	self.chattingRecordsScroll:SetNormalizedPosition(0)
end

function StoryChatUI:ActionItemRemoveOrAdd(shiftedViewsHolder, oldIndex, wasInsert, removeOrInsertIndex)
	local instanceID = shiftedViewsHolder.instanceID
	local index = shiftedViewsHolder.ItemIndex
	local data = self.chatDataModule[index + 1]

	if wasInsert then
		self.chatViewList[instanceID]:ShowBubble(data)
	end
end

return StoryChatUI
