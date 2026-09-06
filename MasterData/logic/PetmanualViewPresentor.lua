-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petmanual/view/PetmanualViewPresentor.lua

module("logic.extensions.petmanual.view.PetmanualViewPresentor", package.seeall)

local PetmanualViewPresentor = class("PetmanualViewPresentor", ViewPresentor)

function PetmanualViewPresentor:ctor()
	PetmanualViewPresentor.super.ctor(self)
end

function PetmanualViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetmanualViewPresentor:dependWhatResources()
	return {
		"ui/views/petmanual/petmanualview.prefab"
	}
end

function PetmanualViewPresentor:buildViews()
	return {
		PetmanualView.New()
	}
end

return PetmanualViewPresentor
