-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchdirectViewPresentor.lua

module("logic.extensions.petsearch.view.PetsearchdirectViewPresentor", package.seeall)

local PetsearchdirectViewPresentor = class("PetsearchdirectViewPresentor", ViewPresentor)

function PetsearchdirectViewPresentor:ctor()
	PetsearchdirectViewPresentor.super.ctor(self)
end

function PetsearchdirectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetsearchdirectViewPresentor:dependWhatResources()
	return {
		"ui/views/petsearch/petsearchdirectview.prefab"
	}
end

function PetsearchdirectViewPresentor:buildViews()
	return {
		PetsearchdirectView.New()
	}
end

return PetsearchdirectViewPresentor
