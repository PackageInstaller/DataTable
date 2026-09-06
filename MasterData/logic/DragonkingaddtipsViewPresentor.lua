-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonkingaddtipsViewPresentor.lua

module("logic.extensions.dragonking.view.DragonkingaddtipsViewPresentor", package.seeall)

local DragonkingaddtipsViewPresentor = class("DragonkingaddtipsViewPresentor", ViewPresentor)

function DragonkingaddtipsViewPresentor:ctor()
	DragonkingaddtipsViewPresentor.super.ctor(self)
end

function DragonkingaddtipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonkingaddtipsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/dragonking/dragonkingaddtipsview.prefab"
	}
end

function DragonkingaddtipsViewPresentor:buildViews()
	return {
		DragonkingaddtipsView.New()
	}
end

return DragonkingaddtipsViewPresentor
