-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/PetStarLvupViewPresentor.lua

module("logic.extensions.starequipment.view.PetStarLvupViewPresentor", package.seeall)

local PetStarLvupViewPresentor = class("PetStarLvupViewPresentor", ViewPresentor)

function PetStarLvupViewPresentor:ctor()
	PetStarLvupViewPresentor.super.ctor(self)
end

function PetStarLvupViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetStarLvupViewPresentor:dependWhatResources()
	return {
		"ui/views/starequipment/petstarlvupview.prefab"
	}
end

function PetStarLvupViewPresentor:buildViews()
	return {
		PetStarLvupView.New()
	}
end

return PetStarLvupViewPresentor
