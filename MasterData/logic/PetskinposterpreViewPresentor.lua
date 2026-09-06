-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/view/PetskinposterpreViewPresentor.lua

module("logic.extensions.petskinpreview.view.PetskinposterpreViewPresentor", package.seeall)

local PetskinposterpreViewPresentor = class("PetskinposterpreViewPresentor", ViewPresentor)

function PetskinposterpreViewPresentor:ctor()
	PetskinposterpreViewPresentor.super.ctor(self)
end

function PetskinposterpreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinposterpreViewPresentor:dependWhatResources()
	return {
		"ui/views/petskinpreview/petskinposterpreview.prefab"
	}
end

function PetskinposterpreViewPresentor:buildViews()
	return {
		PetskinposterpreView.New()
	}
end

return PetskinposterpreViewPresentor
