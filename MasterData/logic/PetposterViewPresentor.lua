-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petposter/view/PetposterViewPresentor.lua

module("logic.extensions.petposter.view.PetposterViewPresentor", package.seeall)

local PetposterViewPresentor = class("PetposterViewPresentor", ViewPresentor)

function PetposterViewPresentor:ctor()
	PetposterViewPresentor.super.ctor(self)
end

function PetposterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetposterViewPresentor:dependWhatResources()
	return {
		"ui/views/petposter/petposterview.prefab"
	}
end

function PetposterViewPresentor:buildViews()
	return {
		PetposterView.New()
	}
end

return PetposterViewPresentor
