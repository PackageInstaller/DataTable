-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatEmojiViewPresentor.lua

module("logic.extensions.chat.view.ChatEmojiViewPresentor", package.seeall)

local ChatEmojiViewPresentor = class("ChatEmojiViewPresentor", ViewPresentor)

function ChatEmojiViewPresentor:ctor()
	ChatEmojiViewPresentor.super.ctor(self)
end

function ChatEmojiViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ChatEmojiViewPresentor:dependWhatResources()
	return {
		"ui/views/chat/chatemojiview.prefab"
	}
end

function ChatEmojiViewPresentor:buildViews()
	return {
		ChatEmojiView.New()
	}
end

return ChatEmojiViewPresentor
