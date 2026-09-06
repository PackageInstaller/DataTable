-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/diyimingplus/DiYiMingPlusMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.diyimingplus.DiYiMingPlusMainViewPresentor", package.seeall)

local DiYiMingPlusMainViewPresentor = class("DiYiMingPlusMainViewPresentor", ViewPresentor)

function DiYiMingPlusMainViewPresentor:ctor()
	DiYiMingPlusMainViewPresentor.super.ctor(self)
end

function DiYiMingPlusMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiYiMingPlusMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/diyimingplus/diyimingplusmainview.prefab"
	}
end

function DiYiMingPlusMainViewPresentor:buildViews()
	return {
		DiYiMingPlusMainView.New()
	}
end

return DiYiMingPlusMainViewPresentor
