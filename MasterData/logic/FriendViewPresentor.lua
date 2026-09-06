-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendViewPresentor.lua

module("logic.extensions.friend.view.FriendViewPresentor", package.seeall)

local FriendViewPresentor = class("FriendViewPresentor", ViewPresentor)

function FriendViewPresentor:ctor()
	FriendViewPresentor.super.ctor(self)
end

function FriendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FriendViewPresentor:dependWhatResources()
	return {
		"ui/views/friend/friendview_new.prefab"
	}
end

function FriendViewPresentor:buildViews()
	return {
		FriendView.New(),
		FriendChatView.New()
	}
end

return FriendViewPresentor
