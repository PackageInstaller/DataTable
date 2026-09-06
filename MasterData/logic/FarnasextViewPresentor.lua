-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextViewPresentor.lua

module("logic.extensions.farnas.view.FarnasextViewPresentor", package.seeall)

local FarnasextViewPresentor = class("FarnasextViewPresentor", ViewPresentor)

function FarnasextViewPresentor:ctor()
	FarnasextViewPresentor.super.ctor(self)
end

function FarnasextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FarnasextViewPresentor:dependWhatResources()
	return {
		"ui/views/farnas/farnasextview.prefab"
	}
end

function FarnasextViewPresentor:buildViews()
	return {
		FarnasextView.New()
	}
end

return FarnasextViewPresentor
