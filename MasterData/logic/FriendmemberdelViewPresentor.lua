-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendmemberdelViewPresentor.lua

module("logic.extensions.friend.view.FriendmemberdelViewPresentor", package.seeall)

local FriendmemberdelViewPresentor = class("FriendmemberdelViewPresentor", ViewPresentor)

function FriendmemberdelViewPresentor:ctor()
	FriendmemberdelViewPresentor.super.ctor(self)
end

function FriendmemberdelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FriendmemberdelViewPresentor:dependWhatResources()
	return {
		"ui/views/friend/friendmemberdelview.prefab"
	}
end

function FriendmemberdelViewPresentor:buildViews()
	return {
		FriendmemberdelView.New()
	}
end

return FriendmemberdelViewPresentor
