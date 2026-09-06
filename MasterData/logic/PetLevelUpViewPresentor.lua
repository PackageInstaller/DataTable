-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetLevelUpViewPresentor.lua

module("logic.extensions.bag.view.stack.PetLevelUpViewPresentor", package.seeall)

local PetLevelUpViewPresentor = class("PetLevelUpViewPresentor", ViewWithGuidePresentor)

function PetLevelUpViewPresentor:ctor()
	PetLevelUpViewPresentor.super.ctor(self)
end

function PetLevelUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetLevelUpViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petlevelupview_new.prefab"
	}
end

function PetLevelUpViewPresentor:buildViews()
	return {
		PetLevelUpView.New()
	}
end

return PetLevelUpViewPresentor
