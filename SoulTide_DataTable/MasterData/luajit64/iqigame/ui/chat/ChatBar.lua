-- chunkname: @IQIGame\\UI\\Chat\\ChatBar.lua

local ChatBar = {}

function ChatBar.New(view)
	local obj = Clone(ChatBar)

	obj:Init(view)

	return obj
end

function ChatBar:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfContent = self.goContent:GetComponent("Text")
	self.btnChat = self.goBtnChat:GetComponent("Button")

	self.goSignRedPoint:SetActive(false)

	function self.onClickBtnChatDelegate()
		self:OnClickBtnChat()
	end

	function self.onResponseChatMsgDelegate(chatMsgData)
		self:OnResponseChatMsg(chatMsgData)
	end

	function self.onNoticeNewPrivateChatMsgDelegate()
		self:OnNewPrivateChatMsg()
	end
end

function ChatBar:Refresh()
	local chatMsgData = ChatModule.GetLastSystemMsg()

	if chatMsgData ~= nil then
		self:ShowLastChatMsg(chatMsgData)
	end

	self:OnAddListeners()
end

function ChatBar:OnHide()
	self:OnRemoveListeners()
end

function ChatBar:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function ChatBar:OnAddListeners()
	self:OnRemoveListeners()
	self.btnChat.onClick:AddListener(self.onClickBtnChatDelegate)
	EventDispatcher.AddEventListener(EventID.ResponseChatMsg, self.onResponseChatMsgDelegate)
	EventDispatcher.AddEventListener(EventID.NoticeNewPrivateChatMsg, self.onNoticeNewPrivateChatMsgDelegate)
end

function ChatBar:OnRemoveListeners()
	self.btnChat.onClick:RemoveListener(self.onClickBtnChatDelegate)
	EventDispatcher.RemoveEventListener(EventID.ResponseChatMsg, self.onResponseChatMsgDelegate)
	EventDispatcher.RemoveEventListener(EventID.NoticeNewPrivateChatMsg, self.onNoticeNewPrivateChatMsgDelegate)
end

function ChatBar:OnResponseChatMsg(chatMsgData)
	self:ShowLastChatMsg(chatMsgData)
end

function ChatBar:OnNewPrivateChatMsg()
	if UIModule.HasUI(Constant.UIControllerName.ChatUI) or UIModule.IsLoadingUI(Constant.UIControllerName.ChatUI) then
		return
	end

	self.goSignRedPoint:SetActive(true)
end

function ChatBar:OnClickBtnChat()
	UIModule.Open(Constant.UIControllerName.ChatUI, Constant.UILayer.DefaultUI)
	self.goSignRedPoint:SetActive(false)
end

function ChatBar:ShowLastChatMsg(chatMsgData)
	local content = chatMsgData.content

	if chatMsgData.channel ~= ChatModule.CHANNEL_SYSTEM then
		content = WarnStrFunc:warningStrGsub(chatMsgData.content)

		local cfgEmoticonData

		if #content >= 3 and #content <= 6 then
			for str in string.gmatch(content, "#(%d+)#") do
				cfgEmoticonData = CfgChatEmoticonTable[tonumber(str)]

				if cfgEmoticonData ~= nil then
					content = MainUIApi:GetString("ChatEmotionText")

					break
				end
			end
		end
	end

	local playerName = ""

	if chatMsgData.channel ~= ChatModule.CHANNEL_SYSTEM and chatMsgData.channel ~= ChatModule.CHANNEL_LOOP_SYSTEM and chatMsgData.sender ~= nil then
		playerName = chatMsgData.sender.pName
	end

	self.tfContent.text = MainUIApi:GetString("ChatContent", chatMsgData.channel, playerName, content)
end

return ChatBar
