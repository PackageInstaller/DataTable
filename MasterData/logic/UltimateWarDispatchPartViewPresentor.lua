-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarDispatchPartViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarDispatchPartViewPresentor", package.seeall)

local UltimateWarDispatchPartViewPresentor = class("UltimateWarDispatchPartViewPresentor", ViewPresentor)

function UltimateWarDispatchPartViewPresentor:ctor()
	UltimateWarDispatchPartViewPresentor.super.ctor(self)
end

function UltimateWarDispatchPartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarDispatchPartViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewardispatchpartview.prefab"
	}
end

function UltimateWarDispatchPartViewPresentor:buildViews()
	return {
		UltimateWarDispatchPartView.New()
	}
end

return UltimateWarDispatchPartViewPresentor
