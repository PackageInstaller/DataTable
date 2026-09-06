-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/view/HonourTowerSelectViewPresentor.lua

module("logic.extensions.honourtower.view.HonourTowerSelectViewPresentor", package.seeall)

local HonourTowerSelectViewPresentor = class("HonourTowerSelectViewPresentor", ViewPresentor)

function HonourTowerSelectViewPresentor:ctor()
	HonourTowerSelectViewPresentor.super.ctor(self)
end

function HonourTowerSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HonourTowerSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/honourtower/honourtowerselectview.prefab"
	}
end

function HonourTowerSelectViewPresentor:buildViews()
	return {
		HonourTowerSelectView.New()
	}
end

return HonourTowerSelectViewPresentor
