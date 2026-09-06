-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextfailViewPresentor.lua

module("logic.extensions.farnas.view.FarnasextfailViewPresentor", package.seeall)

local FarnasextfailViewPresentor = class("FarnasextfailViewPresentor", ViewPresentor)

function FarnasextfailViewPresentor:ctor()
	FarnasextfailViewPresentor.super.ctor(self)
end

function FarnasextfailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FarnasextfailViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasextfailview.prefab"
	}
end

function FarnasextfailViewPresentor:buildViews()
	return {
		FarnasextfailView.New()
	}
end

return FarnasextfailViewPresentor
