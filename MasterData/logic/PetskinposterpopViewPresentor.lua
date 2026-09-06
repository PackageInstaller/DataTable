-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetskinposterpopViewPresentor.lua

module("logic.extensions.petskin.view.PetskinposterpopViewPresentor", package.seeall)

local PetskinposterpopViewPresentor = class("PetskinposterpopViewPresentor", ViewPresentor)

function PetskinposterpopViewPresentor:ctor()
	PetskinposterpopViewPresentor.super.ctor(self)
end

function PetskinposterpopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinposterpopViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/skin/petskinposterpopview.prefab"
	}
end

function PetskinposterpopViewPresentor:buildViews()
	return {
		PetskinposterpopView.New()
	}
end

return PetskinposterpopViewPresentor
