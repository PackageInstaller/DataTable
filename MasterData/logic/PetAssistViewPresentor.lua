-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/view/PetAssistViewPresentor.lua

module("logic.extensions.petassist.view.PetAssistViewPresentor", package.seeall)

local PetAssistViewPresentor = class("PetAssistViewPresentor", ViewWithGuidePresentor)

function PetAssistViewPresentor:ctor()
	PetAssistViewPresentor.super.ctor(self)
end

function PetAssistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetAssistViewPresentor:dependWhatResources()
	return {
		"ui/views/petassist/petassistview.prefab"
	}
end

function PetAssistViewPresentor:buildViews()
	return {
		PetAssistView.New()
	}
end

return PetAssistViewPresentor
