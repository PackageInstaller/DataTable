-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetUpViewPresentor.lua

module("logic.extensions.bag.view.PetUpViewPresentor", package.seeall)

local PetUpViewPresentor = class("PetUpViewPresentor", ViewWithGuidePresentor)

function PetUpViewPresentor:ctor()
	PetUpViewPresentor.super.ctor(self)
end

function PetUpViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetUpViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petupview.prefab"
	}
end

function PetUpViewPresentor:buildViews()
	return {
		PetUpView.New()
	}
end

return PetUpViewPresentor
