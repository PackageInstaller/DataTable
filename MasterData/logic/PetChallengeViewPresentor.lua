-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/PetChallengeViewPresentor.lua

module("logic.extensions.legend.view.PetChallengeViewPresentor", package.seeall)

local PetChallengeViewPresentor = class("PetChallengeViewPresentor", ViewPresentor)

function PetChallengeViewPresentor:ctor()
	PetChallengeViewPresentor.super.ctor(self)
end

function PetChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/petchallengeview.prefab"
	}
end

function PetChallengeViewPresentor:buildViews()
	return {
		PetChallengeView.New()
	}
end

return PetChallengeViewPresentor
