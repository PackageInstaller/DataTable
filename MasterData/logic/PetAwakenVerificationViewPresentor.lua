-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petawakenverification/view/PetAwakenVerificationViewPresentor.lua

module("logic.extensions.petawakenverification.view.PetAwakenVerificationViewPresentor", package.seeall)

local PetAwakenVerificationViewPresentor = class("PetAwakenVerificationViewPresentor", ViewPresentor)

function PetAwakenVerificationViewPresentor:ctor()
	PetAwakenVerificationViewPresentor.super.ctor(self)
end

function PetAwakenVerificationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetAwakenVerificationViewPresentor:dependWhatResources()
	return {
		"ui/views/petawakenverification/petawakenverificationview.prefab"
	}
end

function PetAwakenVerificationViewPresentor:buildViews()
	return {
		PetAwakenVerificationView.New()
	}
end

return PetAwakenVerificationViewPresentor
