-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetTalentViewPresentor.lua

module("logic.extensions.bag.view.stack.PetTalentViewPresentor", package.seeall)

local PetTalentViewPresentor = class("PetTalentViewPresentor", ViewWithGuidePresentor)

function PetTalentViewPresentor:ctor()
	PetTalentViewPresentor.super.ctor(self)
end

function PetTalentViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetTalentViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/pettalentview_new.prefab"
	}
end

function PetTalentViewPresentor:buildViews()
	return {
		PetTalentView.New()
	}
end

return PetTalentViewPresentor
