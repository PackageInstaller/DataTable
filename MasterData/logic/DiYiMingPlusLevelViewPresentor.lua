-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/diyimingplus/DiYiMingPlusLevelViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.diyimingplus.DiYiMingPlusLevelViewPresentor", package.seeall)

local DiYiMingPlusLevelViewPresentor = class("DiYiMingPlusLevelViewPresentor", ViewPresentor)

function DiYiMingPlusLevelViewPresentor:ctor()
	DiYiMingPlusLevelViewPresentor.super.ctor(self)
end

function DiYiMingPlusLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiYiMingPlusLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/diyimingplus/diyimingpluslevelview.prefab"
	}
end

function DiYiMingPlusLevelViewPresentor:buildViews()
	return {
		DiYiMingPlusLevelView.New()
	}
end

return DiYiMingPlusLevelViewPresentor
