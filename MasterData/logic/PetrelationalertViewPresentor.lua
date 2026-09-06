-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/view/PetrelationalertViewPresentor.lua

module("logic.extensions.petrelation.view.PetrelationalertViewPresentor", package.seeall)

local PetrelationalertViewPresentor = class("PetrelationalertViewPresentor", ViewPresentor)

function PetrelationalertViewPresentor:ctor()
	PetrelationalertViewPresentor.super.ctor(self)
end

function PetrelationalertViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function PetrelationalertViewPresentor:dependWhatResources()
	return {
		"ui/views/petrelation/petrelationalertview.prefab"
	}
end

function PetrelationalertViewPresentor:buildViews()
	return {
		PetrelationAlertView.New()
	}
end

return PetrelationalertViewPresentor
