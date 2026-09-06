-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/nuoya/NuoyaMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.nuoya.NuoyaMainViewPresentor", package.seeall)

local NuoyaMainViewPresentor = class("NuoyaMainViewPresentor", ViewPresentor)

function NuoyaMainViewPresentor:ctor()
	NuoyaMainViewPresentor.super.ctor(self)
end

function NuoyaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NuoyaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/nuoya/nuoyamainview.prefab"
	}
end

function NuoyaMainViewPresentor:buildViews()
	return {
		NuoyaMainView.New()
	}
end

return NuoyaMainViewPresentor
