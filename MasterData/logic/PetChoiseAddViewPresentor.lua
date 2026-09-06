-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/view/PetChoiseAddViewPresentor.lua

module("logic.extensions.petassist.view.PetChoiseAddViewPresentor", package.seeall)

local PetChoiseAddViewPresentor = class("PetChoiseAddViewPresentor", ViewWithGuidePresentor)

function PetChoiseAddViewPresentor:ctor()
	PetChoiseAddViewPresentor.super.ctor(self)
end

function PetChoiseAddViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetChoiseAddViewPresentor:dependWhatResources()
	return {
		"ui/views/petassist/petchoiseaddview.prefab"
	}
end

function PetChoiseAddViewPresentor:buildViews()
	return {
		PetChoiseAddView.New()
	}
end

return PetChoiseAddViewPresentor
