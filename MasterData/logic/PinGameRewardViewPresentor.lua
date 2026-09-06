-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameRewardViewPresentor.lua

module("logic.extensions.pingame.view.PinGameRewardViewPresentor", package.seeall)

local PinGameRewardViewPresentor = class("PinGameRewardViewPresentor", ViewPresentor)

function PinGameRewardViewPresentor:ctor()
	PinGameRewardViewPresentor.super.ctor(self)
end

function PinGameRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PinGameRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/pingame/pingamerewardview.prefab"
	}
end

function PinGameRewardViewPresentor:buildViews()
	return {
		PinGameRewardView.New()
	}
end

return PinGameRewardViewPresentor
