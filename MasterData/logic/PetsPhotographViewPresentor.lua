-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/PetsPhotographViewPresentor.lua

module("logic.extensions.petshandbook.view.PetsPhotographViewPresentor", package.seeall)

local PetsPhotographViewPresentor = class("PetsPhotographViewPresentor", ViewPresentor)

function PetsPhotographViewPresentor:ctor()
	PetsPhotographViewPresentor.super.ctor(self)
end

function PetsPhotographViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetsPhotographViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/handbookpetsview.prefab"
	}
end

function PetsPhotographViewPresentor:buildViews()
	return {
		PetsPhotographView.New()
	}
end

return PetsPhotographViewPresentor
