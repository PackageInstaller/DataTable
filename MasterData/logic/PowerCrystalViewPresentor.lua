-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/view/PowerCrystalViewPresentor.lua

module("logic.extensions.powercrystal.PowerCrystalViewPresentor", package.seeall)

local PowerCrystalViewPresentor = class("PowerCrystalViewPresentor", ViewWithGuidePresentor)

function PowerCrystalViewPresentor:ctor()
	PowerCrystalViewPresentor.super.ctor(self)
end

function PowerCrystalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PowerCrystalViewPresentor:dependWhatResources()
	return {
		"ui/views/powercrystal/powercrystalview.prefab"
	}
end

function PowerCrystalViewPresentor:buildViews()
	return {
		PowerCrystalView.New()
	}
end

return PowerCrystalViewPresentor
