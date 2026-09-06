-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetskinposterViewPresentor.lua

module("logic.extensions.petskin.view.PetskinposterViewPresentor", package.seeall)

local PetskinposterViewPresentor = class("PetskinposterViewPresentor", ViewPresentor)

function PetskinposterViewPresentor:ctor()
	PetskinposterViewPresentor.super.ctor(self)
end

function PetskinposterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinposterViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/skin/petskinposterview.prefab"
	}
end

function PetskinposterViewPresentor:buildViews()
	return {
		PetskinposterView.New()
	}
end

return PetskinposterViewPresentor
