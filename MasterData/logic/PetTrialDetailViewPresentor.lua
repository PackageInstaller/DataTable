-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/view/PetTrialDetailViewPresentor.lua

module("logic.extensions.pettrial.view.PetTrialDetailViewPresentor", package.seeall)

local PetTrialDetailViewPresentor = class("PetTrialDetailViewPresentor", ViewWithGuidePresentor)

function PetTrialDetailViewPresentor:ctor()
	PetTrialDetailViewPresentor.super.ctor(self)
end

function PetTrialDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetTrialDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/pettrial/pettrialdetailview.prefab"
	}
end

function PetTrialDetailViewPresentor:buildViews()
	return {
		PetTrialDetailView.New()
	}
end

return PetTrialDetailViewPresentor
