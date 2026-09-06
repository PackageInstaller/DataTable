-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerBuffViewPresentor.lua

module("logic.extensions.waterdraktower.view.WLTowerBuffViewPresentor", package.seeall)

local WLTowerBuffViewPresentor = class("WLTowerBuffViewPresentor", ViewPresentor)

function WLTowerBuffViewPresentor:ctor()
	WLTowerBuffViewPresentor.super.ctor(self)
end

function WLTowerBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WLTowerBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/wltowerbuffview.prefab"
	}
end

function WLTowerBuffViewPresentor:buildViews()
	return {
		WLTowerBuffView.New()
	}
end

return WLTowerBuffViewPresentor
