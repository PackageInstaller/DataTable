-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchmainViewPresentor.lua

module("logic.extensions.petsearch.view.PetsearchmainViewPresentor", package.seeall)

local PetsearchmainViewPresentor = class("PetsearchmainViewPresentor", ViewPresentor)

function PetsearchmainViewPresentor:ctor()
	PetsearchmainViewPresentor.super.ctor(self)
end

function PetsearchmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetsearchmainViewPresentor:dependWhatResources()
	return {
		"ui/views/petsearch/petsearchmainview.prefab"
	}
end

function PetsearchmainViewPresentor:buildViews()
	return {
		PetsearchmainView.New()
	}
end

return PetsearchmainViewPresentor
