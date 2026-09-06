-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/share/view/FriendSelectViewPresentor.lua

module("logic.extensions.share.view.FriendSelectViewPresentor", package.seeall)

local FriendSelectViewPresentor = class("FriendSelectViewPresentor", ViewPresentor)

function FriendSelectViewPresentor:ctor()
	FriendSelectViewPresentor.super.ctor(self)
end

function FriendSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FriendSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/share/friendselectview.prefab"
	}
end

function FriendSelectViewPresentor:buildViews()
	return {
		FriendSelectView.New()
	}
end

return FriendSelectViewPresentor
