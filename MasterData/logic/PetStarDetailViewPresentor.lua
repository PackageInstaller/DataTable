-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/PetStarDetailViewPresentor.lua

module("logic.extensions.starequipment.view.PetStarDetailViewPresentor", package.seeall)

local PetStarDetailViewPresentor = class("PetStarDetailViewPresentor", ViewPresentor)

function PetStarDetailViewPresentor:ctor()
	PetStarDetailViewPresentor.super.ctor(self)
end

function PetStarDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetStarDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/starequipment/petstardetailview.prefab"
	}
end

function PetStarDetailViewPresentor:buildViews()
	return {
		PetStarDetailView.New()
	}
end

return PetStarDetailViewPresentor
