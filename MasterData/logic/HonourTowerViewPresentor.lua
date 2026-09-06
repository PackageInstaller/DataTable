-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/view/HonourTowerViewPresentor.lua

module("logic.extensions.honourtower.view.HonourTowerViewPresentor", package.seeall)

local HonourTowerViewPresentor = class("HonourTowerViewPresentor", ViewPresentor)

function HonourTowerViewPresentor:ctor()
	HonourTowerViewPresentor.super.ctor(self)
end

function HonourTowerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HonourTowerViewPresentor:dependWhatResources()
	return {
		"ui/views/honourtower/honourtowerview.prefab"
	}
end

function HonourTowerViewPresentor:buildViews()
	return {
		HonourTowerView.New()
	}
end

return HonourTowerViewPresentor
