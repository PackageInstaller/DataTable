-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchFriendshipViewPresentor.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchFriendshipViewPresentor", package.seeall)

local TianYanMatchFriendshipViewPresentor = class("TianYanMatchFriendshipViewPresentor", ViewPresentor)

function TianYanMatchFriendshipViewPresentor:ctor()
	TianYanMatchFriendshipViewPresentor.super.ctor(self)
end

function TianYanMatchFriendshipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianYanMatchFriendshipViewPresentor:dependWhatResources()
	return {
		"ui/views/tianyanmatch/tianyanmatchfriendshipview.prefab"
	}
end

function TianYanMatchFriendshipViewPresentor:buildViews()
	return {
		TianYanMatchFriendshipView.New()
	}
end

return TianYanMatchFriendshipViewPresentor
