-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetskindisplayViewPresentor.lua

module("logic.extensions.petskin.view.PetskindisplayViewPresentor", package.seeall)

local PetskindisplayViewPresentor = class("PetskindisplayViewPresentor", ViewPresentor)

function PetskindisplayViewPresentor:ctor()
	PetskindisplayViewPresentor.super.ctor(self)
end

function PetskindisplayViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetskindisplayViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petskindisplayview.prefab"
	}
end

function PetskindisplayViewPresentor:buildViews()
	return {
		PetskindisplayView.New()
	}
end

return PetskindisplayViewPresentor
