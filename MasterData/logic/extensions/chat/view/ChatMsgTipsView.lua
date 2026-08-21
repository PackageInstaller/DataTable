-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatMsgTipsView.lua

module("logic.extensions.chat.view.ChatMsgTipsView", package.seeall)

local M = class("ChatMsgTipsView", ViewComponent)
local PrefixList = {
	[GameEnum.ChannelTypeEnum.Friend] = "私聊",
	[GameEnum.ChannelTypeEnum.Team] = "队伍",
	[GameEnum.ChannelTypeEnum.Guild] = "公会"
}

function M:buildUI()
	self._chatPosGo = self:getGo("main_view_1405446183")
	self._chatTopGo = goutil.findChild(self._chatPosGo, "chat_top")

	self._chatTopGo:SetActive(false)

	self._btnClick = UIComponentType.ButtonAdapter(self._chatTopGo)
	self._txtChat = goutil.findChildTextComponent(self._chatTopGo, "txtChat")
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickEvt, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	self._params = self:getFirstParam()

	GlobalDispatcher:addEventListener(EventType.CHAT_NEW_MESSAGE_TIPS, self._handleNewMsgTips, self)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.CHAT_NEW_MESSAGE_TIPS, self._handleNewMsgTips, self)
end

function M:destroyUI()
	return
end

function M:_onClickEvt()
	local channelType = self._params.channelType
	local targetId = self._params.targetId

	ChatMainFacade.instance:openChatMainView(channelType, targetId)
	self:_closeSelf()
end

function M:_closeSelf()
	removetimer(self._closeSelf, self)
	self._chatTopGo:SetActive(false)
end

function M:_handleNewMsgTips(e, params)
	self._params = params

	removetimer(self._closeSelf, self)

	local time = ConstConfig.instance:getNumValueByKey("ChatMsgTipsShowTime")

	settimer(time, self._closeSelf, self, false)
	self._chatTopGo:SetActive(true)
	self:_refreshContent()
end

local function nameStrTest(str)
	if string.nilorempty(str) then
		return false
	else
		return str
	end
end

function M:_refreshContent()
	local channelType = self._params.channelType
	local targetId = self._params.targetId
	local msgMo = ChatModel.instance:getLastMsg(channelType, targetId)
	local name = nameStrTest(msgMo:getShowAlias()) or nameStrTest(msgMo:getShowNickName()) or lang("tip_unkonw")
	local content = msgMo:getContent()
	local msgType = msgMo:getMessageType()

	if msgType == GameEnum.MessageTypeEnum.Emoji then
		local emojiId = tonumber(content)
		local emojiCfg = ChatConfig.instance:getEmojiCfg(emojiId)

		if channelType == GameEnum.ChannelTypeEnum.Friend then
			self._txtChat.text = string.format("%s:[%s]", name, emojiCfg.name)
		else
			self._txtChat.text = string.format("[%s]", emojiCfg.name)
		end
	else
		local maxWidth = 370

		if channelType == GameEnum.ChannelTypeEnum.Friend then
			content = string.format("%s:%s", name, content)
		end

		ChatUtil.adaptForFixedWidth(self._txtChat, content, maxWidth)
	end
end

return M
