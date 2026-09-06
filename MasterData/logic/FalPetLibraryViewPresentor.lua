-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalPetLibraryViewPresentor.lua

module("logic.extensions.landlords.view.FalPetLibraryViewPresentor", package.seeall)

local FalPetLibraryViewPresentor = class("FalPetLibraryViewPresentor", ViewPresentor)

function FalPetLibraryViewPresentor:ctor()
	FalPetLibraryViewPresentor.super.ctor(self)
end

function FalPetLibraryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalPetLibraryViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falpetlibraryview.prefab"
	}
end

function FalPetLibraryViewPresentor:buildViews()
	return {
		FalPetLibraryView.New()
	}
end

return FalPetLibraryViewPresentor
