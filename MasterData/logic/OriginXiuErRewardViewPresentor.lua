-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErRewardViewPresentor.lua

module("logic.extensions.originxiuer.view.OriginXiuErRewardViewPresentor", package.seeall)

local OriginXiuErRewardViewPresentor = class("OriginXiuErRewardViewPresentor", ViewPresentor)

function OriginXiuErRewardViewPresentor:ctor()
	OriginXiuErRewardViewPresentor.super.ctor(self)
end

function OriginXiuErRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginXiuErRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/originxiuer/originxiuerrewardview.prefab"
	}
end

function OriginXiuErRewardViewPresentor:buildViews()
	return {
		OriginXiuErRewardView.New()
	}
end

return OriginXiuErRewardViewPresentor
