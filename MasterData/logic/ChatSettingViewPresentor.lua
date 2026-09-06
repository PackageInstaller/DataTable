-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatSettingViewPresentor.lua

module("logic.extensions.chat.view.ChatSettingViewPresentor", package.seeall)

local ChatSettingViewPresentor = class("ChatSettingViewPresentor", ViewPresentor)

function ChatSettingViewPresentor:ctor()
	ChatSettingViewPresentor.super.ctor(self)
end

function ChatSettingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ChatSettingViewPresentor:dependWhatResources()
	return {
		"ui/views/chat/chatsettingview.prefab"
	}
end

function ChatSettingViewPresentor:buildViews()
	return {
		ChatSettingView.New()
	}
end

return ChatSettingViewPresentor
