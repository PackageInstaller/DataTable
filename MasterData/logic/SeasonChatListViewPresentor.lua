-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/SeasonChatListViewPresentor.lua

module("logic.extensions.sendflower.view.SeasonChatListViewPresentor", package.seeall)

local SeasonChatListViewPresentor = class("SeasonChatListViewPresentor", ViewWithGuidePresentor)

function SeasonChatListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonChatListViewPresentor:dependWhatResources()
	return {
		"ui/views/chat/chatview.prefab"
	}
end

function SeasonChatListViewPresentor:buildViews()
	return {
		SeasonChatListView.New(),
		SeasonChatTableView.New()
	}
end

function SeasonChatListViewPresentor:playEnterAnimation()
	local anim = self.mainGO:GetComponent("Animator")

	if anim then
		anim:Play("chat_enter")
	end

	self:_onEnterAnimationDone()
end

function SeasonChatListViewPresentor:playCloseAnimation()
	local anim = self.mainGO:GetComponent("Animator")

	if anim then
		anim:Play("chat_exit")
	end

	settimer(0.1, self._onCloseAnimationDone, self, false)
end

return SeasonChatListViewPresentor
