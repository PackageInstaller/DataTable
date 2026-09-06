-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/view/PetrelationprizeViewPresentor.lua

module("logic.extensions.petrelation.view.PetrelationprizeViewPresentor", package.seeall)

local PetrelationprizeViewPresentor = class("PetrelationprizeViewPresentor", ViewPresentor)

function PetrelationprizeViewPresentor:ctor()
	PetrelationprizeViewPresentor.super.ctor(self)
end

function PetrelationprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetrelationprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/petrelation/petrelationprizeview.prefab"
	}
end

function PetrelationprizeViewPresentor:buildViews()
	return {
		PetrelationPrizeView.New()
	}
end

return PetrelationprizeViewPresentor
