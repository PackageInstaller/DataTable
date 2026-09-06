-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendAddViewPresentor.lua

module("logic.extensions.friend.view.FriendAddViewPresentor", package.seeall)

local FriendAddViewPresentor = class("FriendAddViewPresentor", ViewPresentor)

function FriendAddViewPresentor:ctor()
	FriendAddViewPresentor.super.ctor(self)
end

function FriendAddViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FriendAddViewPresentor:dependWhatResources()
	return {
		"ui/views/friend/friendaddview_new.prefab",
		ItemFriendAdd.ResPath
	}
end

function FriendAddViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function FriendAddViewPresentor:buildViews()
	return {
		FriendAddView.New()
	}
end

return FriendAddViewPresentor
