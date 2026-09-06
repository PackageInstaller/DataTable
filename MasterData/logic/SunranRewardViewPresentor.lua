-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranRewardViewPresentor.lua

module("logic.extensions.sunranbattle.view.SunranRewardViewPresentor", package.seeall)

local SunranRewardViewPresentor = class("SunranRewardViewPresentor", ViewWithGuidePresentor)

function SunranRewardViewPresentor:ctor()
	SunranRewardViewPresentor.super.ctor(self)
end

function SunranRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SunranRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/sunranbattle/sunranrewardview.prefab"
	}
end

function SunranRewardViewPresentor:buildViews()
	return {
		SunranRewardView.New()
	}
end

return SunranRewardViewPresentor
