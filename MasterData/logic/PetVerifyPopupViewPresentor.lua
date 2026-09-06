-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petverify/view/PetVerifyPopupViewPresentor.lua

module("logic.extensions.petverify.view.PetVerifyPopupViewPresentor", package.seeall)

local PetVerifyPopupViewPresentor = class("PetVerifyPopupViewPresentor", ViewPresentor)

function PetVerifyPopupViewPresentor:ctor()
	PetVerifyPopupViewPresentor.super.ctor(self)
end

function PetVerifyPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetVerifyPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/petverify/petverifypopupview.prefab"
	}
end

function PetVerifyPopupViewPresentor:buildViews()
	return {
		PetVerifyPopupView.New()
	}
end

return PetVerifyPopupViewPresentor
