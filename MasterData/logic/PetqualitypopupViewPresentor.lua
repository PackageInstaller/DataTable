-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guidepopup/view/PetqualitypopupViewPresentor.lua

module("logic.extensions.guidepopup.view.PetqualitypopupViewPresentor", package.seeall)

local PetqualitypopupViewPresentor = class("PetqualitypopupViewPresentor", ViewPresentor)

function PetqualitypopupViewPresentor:ctor()
	PetqualitypopupViewPresentor.super.ctor(self)
end

function PetqualitypopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetqualitypopupViewPresentor:dependWhatResources()
	return {
		"ui/views/guidepopup/petqualitypopup.prefab"
	}
end

function PetqualitypopupViewPresentor:buildViews()
	return {
		PetqualitypopupView.New()
	}
end

return PetqualitypopupViewPresentor
