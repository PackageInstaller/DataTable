-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetTalentUpViewPresentor.lua

module("logic.extensions.bag.view.stack.PetTalentUpViewPresentor", package.seeall)

local PetTalentUpViewPresentor = class("PetTalentUpViewPresentor", ViewWithGuidePresentor)

function PetTalentUpViewPresentor:ctor()
	PetTalentUpViewPresentor.super.ctor(self)
end

function PetTalentUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetTalentUpViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/pettalentupview.prefab"
	}
end

function PetTalentUpViewPresentor:buildViews()
	return {
		PetTalentUpView.New()
	}
end

return PetTalentUpViewPresentor
