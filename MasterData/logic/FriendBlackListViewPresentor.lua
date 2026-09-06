-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendBlackListViewPresentor.lua

module("logic.extensions.friend.view.FriendBlackListViewPresentor", package.seeall)

local FriendBlackListViewPresentor = class("FriendBlackListViewPresentor", ViewPresentor)

function FriendBlackListViewPresentor:ctor()
	FriendBlackListViewPresentor.super.ctor(self)
end

function FriendBlackListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FriendBlackListViewPresentor:dependWhatResources()
	return {
		"ui/views/friend/friendblacklistview.prefab"
	}
end

function FriendBlackListViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function FriendBlackListViewPresentor:buildViews()
	return {
		FriendBlackListView.New()
	}
end

return FriendBlackListViewPresentor
