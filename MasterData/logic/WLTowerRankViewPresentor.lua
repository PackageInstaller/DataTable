-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerRankViewPresentor.lua

module("logic.extensions.waterdraktower.view.WLTowerRankViewPresentor", package.seeall)

local WLTowerRankViewPresentor = class("WLTowerRankViewPresentor", ViewWithGuidePresentor)

function WLTowerRankViewPresentor:ctor()
	WLTowerRankViewPresentor.super.ctor(self)
end

function WLTowerRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WLTowerRankViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/wltowerrankview.prefab"
	}
end

function WLTowerRankViewPresentor:buildViews()
	return {
		WLTowerRankView.New()
	}
end

return WLTowerRankViewPresentor
