-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendWelfareViewPresentor.lua

module("logic.extensions.friend.view.FriendWelfareViewPresentor", package.seeall)

local FriendWelfareViewPresentor = class("FriendWelfareViewPresentor", ViewPresentor)

function FriendWelfareViewPresentor:ctor()
	FriendWelfareViewPresentor.super.ctor(self)
end

function FriendWelfareViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FriendWelfareViewPresentor:dependWhatResources()
	return {
		"ui/views/friend/friendwelfareview.prefab"
	}
end

function FriendWelfareViewPresentor:buildViews()
	return {
		FriendWelfareView.New()
	}
end

return FriendWelfareViewPresentor
