-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskinpreview/view/PetskinpreViewPresentor.lua

module("logic.extensions.petskinpreview.view.PetskinpreViewPresentor", package.seeall)

local PetskinpreViewPresentor = class("PetskinpreViewPresentor", ViewPresentor)

function PetskinpreViewPresentor:ctor()
	PetskinpreViewPresentor.super.ctor(self)
end

function PetskinpreViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetskinpreViewPresentor:dependWhatResources()
	return {
		"ui/views/petskinpreview/petskinpreview.prefab"
	}
end

function PetskinpreViewPresentor:buildViews()
	return {
		PetskinpreView.New()
	}
end

return PetskinpreViewPresentor
