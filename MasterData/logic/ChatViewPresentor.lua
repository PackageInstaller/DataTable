-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatViewPresentor.lua

module("logic.extensions.chat.view.ChatViewPresentor", package.seeall)

local ChatViewPresentor = class("ChatViewPresentor", ViewPresentor)

function ChatViewPresentor:ctor()
	ChatViewPresentor.super.ctor(self)
end

function ChatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChatViewPresentor:dependWhatResources()
	return {
		"ui/views/chat/chatview.prefab"
	}
end

function ChatViewPresentor:buildViews()
	return {
		NewChatView.New(),
		ChannelChatTableView.New()
	}
end

function ChatViewPresentor:playEnterAnimation()
	local anim = self.mainGO:GetComponent("Animator")

	if anim then
		anim:Play("chat_enter")
	end

	self:_onEnterAnimationDone()
end

function ChatViewPresentor:playCloseAnimation()
	local anim = self.mainGO:GetComponent("Animator")

	if anim then
		anim:Play("chat_exit")
	end

	settimer(0.1, self._onCloseAnimationDone, self, false)
end

return ChatViewPresentor
