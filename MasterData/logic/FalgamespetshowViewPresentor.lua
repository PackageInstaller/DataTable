-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalgamespetshowViewPresentor.lua

module("logic.extensions.landlords.view.FalgamespetshowViewPresentor", package.seeall)

local FalgamespetshowViewPresentor = class("FalgamespetshowViewPresentor", ViewPresentor)

function FalgamespetshowViewPresentor:ctor()
	FalgamespetshowViewPresentor.super.ctor(self)
end

function FalgamespetshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalgamespetshowViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falgamespetshowview.prefab"
	}
end

function FalgamespetshowViewPresentor:buildViews()
	return {
		FalgamespetshowView.New()
	}
end

return FalgamespetshowViewPresentor
