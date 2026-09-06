-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerRewardViewPresentor.lua

module("logic.extensions.waterdraktower.view.WLTowerRewardViewPresentor", package.seeall)

local WLTowerRewardViewPresentor = class("WLTowerRewardViewPresentor", ViewPresentor)

function WLTowerRewardViewPresentor:ctor()
	WLTowerRewardViewPresentor.super.ctor(self)
end

function WLTowerRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WLTowerRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/wltowerrewardview.prefab"
	}
end

function WLTowerRewardViewPresentor:buildViews()
	return {
		WLTowerRewardView.New()
	}
end

return WLTowerRewardViewPresentor
