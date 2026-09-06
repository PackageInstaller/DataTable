-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetRingLvupViewPresentor.lua

module("logic.extensions.bag.view.stack.PetRingLvupViewPresentor", package.seeall)

local PetRingLvupViewPresentor = class("PetRingLvupViewPresentor", ViewPresentor)

function PetRingLvupViewPresentor:ctor()
	PetRingLvupViewPresentor.super.ctor(self)
end

function PetRingLvupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetRingLvupViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petringlvupview.prefab"
	}
end

function PetRingLvupViewPresentor:buildViews()
	return {
		PetRingLvupView.New()
	}
end

return PetRingLvupViewPresentor
