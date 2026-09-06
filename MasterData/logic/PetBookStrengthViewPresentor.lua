-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetBookStrengthViewPresentor.lua

module("logic.extensions.handbook.view.PetBookStrengthViewPresentor", package.seeall)

local PetBookStrengthViewPresentor = class("PetBookStrengthViewPresentor", ViewPresentor)

function PetBookStrengthViewPresentor:ctor()
	PetBookStrengthViewPresentor.super.ctor(self)
end

function PetBookStrengthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetBookStrengthViewPresentor:dependWhatResources()
	return {
		"ui/views/handbook/petbookstrengthview.prefab"
	}
end

function PetBookStrengthViewPresentor:buildViews()
	return {
		PetBookStrengthView.New()
	}
end

return PetBookStrengthViewPresentor
