-- chunkname: @IQIGame\\UI\\Story\\StoryChatUIContentView.lua

local StoryChatUIContentView = {}

function StoryChatUIContentView.New(go, mainView)
	local o = Clone(StoryChatUIContentView)

	o:Initialize(go, mainView)

	return o
end

function StoryChatUIContentView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryChatUIContentView:InitComponent()
	self.playerHeadImg = self.playerHeadImg:GetComponent("Image")
	self.npcHeadImg = self.npcHeadImg:GetComponent("Image")
	self.playerChatSizeAdapter = self.playerChatBottomBg:GetComponent(typeof(UISizeAdapter))
	self.npcChatSizeAdapter = self.NpcChatBottomBg:GetComponent(typeof(UISizeAdapter))
end

function StoryChatUIContentView:InitDelegate()
	return
end

function StoryChatUIContentView:AddListener()
	return
end

function StoryChatUIContentView:RemoveListener()
	return
end

function StoryChatUIContentView:OnDestroy()
	self:RemoveListener()
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function StoryChatUIContentView:ResetView()
	LuaUtility.SetGameObjectShow(self.playrChatItem, false)
	LuaUtility.SetGameObjectShow(self.playerChatBottomBg, false)
	LuaUtility.SetGameObjectShow(self.playerInputState, false)
	LuaUtility.SetGameObjectShow(self.npcChatItem, false)
	LuaUtility.SetGameObjectShow(self.NpcChatBottomBg, false)
	LuaUtility.SetGameObjectShow(self.npcInputState, false)
	LuaUtility.SetGameObjectShow(self.historyState, false)
end

function StoryChatUIContentView:Refresh(Data, OptimizedViewsHolder)
	self:ResetView()

	self.Data = Data

	if self.Data.type == Constant.StoryCommunicationType.Chat then
		local cfgDialogue = CfgUtil.GetCfgStoryDialogueDataWithID(self.Data.id)
		local cfgSpeak = CfgUtil.GetCfgStorySpeakNpcDataWithID(cfgDialogue.Speakgroup[1])
		local textComponent, imageComponent

		if cfgSpeak.SpeakNPC == 0 then
			self:_ShowPlayerChat(true)

			textComponent = self.playerChatText
			imageComponent = self.playerHeadImg

			LuaUtility.LoadImage(self, ChapterStageMapUIApi:GetPlayerHeroImagePath(PlayerModule.GetSex()), imageComponent)
		else
			self:_ShowNpcChat(true)

			textComponent = self.npcChatText
			imageComponent = self.npcHeadImg
		end

		local strContent = ConversationModule.GetSpeakNpcContent(cfgSpeak)

		LuaUtility.SetText(textComponent, string.format(strContent, StoryModule.player:GetName()))
		self.playerChatSizeAdapter:UpdateSize()
		self.npcChatSizeAdapter:UpdateSize()

		if cfgSpeak.MessageIcon ~= 0 then
			LuaUtility.LoadImage(self, CfgUtil.GetStoryResourceWithID(cfgSpeak.MessageIcon), imageComponent)
		end
	elseif self.Data.type == Constant.StoryCommunicationType.Option then
		self:_ShowPlayerChat(true)
		LuaUtility.SetText(self.playerChatText, CfgUtil.GetCfgStoryTextDataWithID(self.Data.selectID))
	elseif self.Data.type == Constant.StoryCommunicationType.Line then
		LuaUtility.SetGameObjectShow(self.historyState, true)
	end

	if OptimizedViewsHolder.ItemIndex == self.mainView.insertIndex and self.Data.type == Constant.StoryCommunicationType.Chat then
		self:ShowBubble(Data)
	end
end

function StoryChatUIContentView:_ShowPlayerChat(v)
	LuaUtility.SetGameObjectShow(self.playrChatItem, true)
	LuaUtility.SetGameObjectShow(self.playerChatBottomBg, v)
	LuaUtility.SetGameObjectShow(self.playerInputState, not v)

	if v then
		StoryUIApi:PlayChatUIMessageShowSound()
	end
end

function StoryChatUIContentView:_ShowNpcChat(v)
	LuaUtility.SetGameObjectShow(self.npcChatItem, true)
	LuaUtility.SetGameObjectShow(self.NpcChatBottomBg, v)
	LuaUtility.SetGameObjectShow(self.npcInputState, not v)

	if v then
		StoryUIApi:PlayChatUIMessageShowSound()
	end
end

function StoryChatUIContentView:ShowBubble(Data)
	self:ResetView()

	local cfgDialogue = CfgUtil.GetCfgStoryDialogueDataWithID(Data.id)
	local cfgSpeak = CfgUtil.GetCfgStorySpeakNpcDataWithID(cfgDialogue.Speakgroup[1])

	if cfgSpeak.SpeakNPC == 0 then
		self:_ShowPlayerChat(false)
	else
		self:_ShowNpcChat(false)
	end

	function self.hideBubbleFunction()
		if cfgSpeak.SpeakNPC == 0 then
			self:_ShowPlayerChat(true)
		else
			self:_ShowNpcChat(true)
		end
	end

	self.mainView.lastBubble = self
end

function StoryChatUIContentView:HideBubble()
	if self.hideBubbleFunction then
		self.hideBubbleFunction()
	end
end

return StoryChatUIContentView
