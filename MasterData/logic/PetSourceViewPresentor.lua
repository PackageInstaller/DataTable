-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetSourceViewPresentor.lua

module("logic.extensions.handbook.view.PetSourceViewPresentor", package.seeall)

local PetSourceViewPresentor = class("PetSourceViewPresentor", ViewPresentor)

function PetSourceViewPresentor:ctor()
	PetSourceViewPresentor.super.ctor(self)
end

function PetSourceViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetSourceViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petsourceview.prefab"
	}
end

function PetSourceViewPresentor:buildViews()
	return {
		PetSourceView.New()
	}
end

return PetSourceViewPresentor
