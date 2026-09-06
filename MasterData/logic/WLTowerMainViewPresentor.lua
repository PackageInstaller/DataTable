-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerMainViewPresentor.lua

module("logic.extensions.waterdraktower.view.WLTowerMainViewPresentor", package.seeall)

local WLTowerMainViewPresentor = class("WLTowerMainViewPresentor", ViewPresentor)

function WLTowerMainViewPresentor:ctor()
	WLTowerMainViewPresentor.super.ctor(self)
end

function WLTowerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function WLTowerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/wltowermainview.prefab"
	}
end

function WLTowerMainViewPresentor:buildViews()
	return {
		WLTowerMainView.New()
	}
end

return WLTowerMainViewPresentor
