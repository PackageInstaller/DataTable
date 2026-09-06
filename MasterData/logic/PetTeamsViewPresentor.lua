-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petassist/view/PetTeamsViewPresentor.lua

module("logic.extensions.petassist.view.PetTeamsViewPresentor", package.seeall)

local PetTeamsViewPresentor = class("PetTeamsViewPresentor", ViewWithGuidePresentor)

function PetTeamsViewPresentor:ctor()
	PetTeamsViewPresentor.super.ctor(self)
end

function PetTeamsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetTeamsViewPresentor:dependWhatResources()
	return {
		"ui/views/petassist/petteamsview.prefab"
	}
end

function PetTeamsViewPresentor:buildViews()
	return {
		PetTeamsView.New()
	}
end

return PetTeamsViewPresentor
