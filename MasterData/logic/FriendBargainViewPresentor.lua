-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/view/FriendBargainViewPresentor.lua

module("logic.extensions.bargain.view.FriendBargainViewPresentor", package.seeall)

local FriendBargainViewPresentor = class("FriendBargainViewPresentor", ViewPresentor)

function FriendBargainViewPresentor:ctor()
	FriendBargainViewPresentor.super.ctor(self)
end

function FriendBargainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FriendBargainViewPresentor:dependWhatResources()
	return {
		"ui/views/bargain/friendbargainview.prefab"
	}
end

function FriendBargainViewPresentor:buildViews()
	return {
		FriendBargainView.New()
	}
end

return FriendBargainViewPresentor
