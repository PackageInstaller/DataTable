-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/WLTowerTipsViewPresentor.lua

module("logic.extensions.waterdraktower.view.WLTowerTipsViewPresentor", package.seeall)

local WLTowerTipsViewPresentor = class("WLTowerTipsViewPresentor", ViewPresentor)

function WLTowerTipsViewPresentor:ctor()
	WLTowerTipsViewPresentor.super.ctor(self)
end

function WLTowerTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function WLTowerTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/waterdraktower/wltowertipsview.prefab"
	}
end

function WLTowerTipsViewPresentor:buildViews()
	return {
		WLTowerTipsView.New()
	}
end

return WLTowerTipsViewPresentor
