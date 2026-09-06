-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/view/PetTrialViewPresentor.lua

module("logic.extensions.pettrial.view.PetTrialViewPresentor", package.seeall)

local PetTrialViewPresentor = class("PetTrialViewPresentor", ViewWithGuidePresentor)

function PetTrialViewPresentor:ctor()
	PetTrialViewPresentor.super.ctor(self)
end

function PetTrialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetTrialViewPresentor:dependWhatResources()
	return {
		"ui/views/pettrial/pettrialview.prefab"
	}
end

function PetTrialViewPresentor:buildViews()
	return {
		PetTrialView.New()
	}
end

return PetTrialViewPresentor
