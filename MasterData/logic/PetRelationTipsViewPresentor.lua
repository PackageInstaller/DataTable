-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/view/PetRelationTipsViewPresentor.lua

module("logic.extensions.petrelation.view.PetRelationTipsViewPresentor", package.seeall)

local PetRelationTipsViewPresentor = class("PetRelationTipsViewPresentor", ViewPresentor)

function PetRelationTipsViewPresentor:ctor()
	PetRelationTipsViewPresentor.super.ctor(self)
end

function PetRelationTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetRelationTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/petrelation/petrelationtipsview.prefab"
	}
end

function PetRelationTipsViewPresentor:buildViews()
	return {
		PetRelationTipsView.New()
	}
end

return PetRelationTipsViewPresentor
