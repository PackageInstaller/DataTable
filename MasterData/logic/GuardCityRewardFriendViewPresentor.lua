-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRewardFriendViewPresentor.lua

module("logic.extensions.guardcity.view.GuardCityRewardFriendViewPresentor", package.seeall)

local GuardCityRewardFriendViewPresentor = class("GuardCityRewardFriendViewPresentor", ViewPresentor)

function GuardCityRewardFriendViewPresentor:ctor()
	GuardCityRewardFriendViewPresentor.super.ctor(self)
end

function GuardCityRewardFriendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuardCityRewardFriendViewPresentor:dependWhatResources()
	return {
		"ui/views/guardcity/guardcityrewardfriendview.prefab"
	}
end

function GuardCityRewardFriendViewPresentor:buildViews()
	return {
		GuardCityRewardFriendView.New()
	}
end

function GuardCityRewardFriendViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GuardCityRewardFriendViewPresentor
