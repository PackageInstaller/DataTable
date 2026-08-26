-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/fingergame/ChatRoomFingerGamePromptView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.fingergame.ChatRoomFingerGamePromptView", package.seeall)

local ChatRoomFingerGamePromptView = class("ChatRoomFingerGamePromptView", BaseView)

function ChatRoomFingerGamePromptView:onInitView()
	self._txttext = gohelper.findChildTextMesh(self.viewGO, "#txt_text")
end

function ChatRoomFingerGamePromptView:addEvents()
	return
end

function ChatRoomFingerGamePromptView:onOpen()
	self._txttext.text = self.viewParam.tipStr
end

function ChatRoomFingerGamePromptView:onClose()
	return
end

function ChatRoomFingerGamePromptView:onDestroyView()
	return
end

return ChatRoomFingerGamePromptView
