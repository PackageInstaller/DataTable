-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petposter/view/PetpostershowViewPresentor.lua

module("logic.extensions.petposter.view.PetpostershowViewPresentor", package.seeall)

local PetpostershowViewPresentor = class("PetpostershowViewPresentor", ViewPresentor)

function PetpostershowViewPresentor:ctor()
	PetpostershowViewPresentor.super.ctor(self)
end

function PetpostershowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetpostershowViewPresentor:dependWhatResources()
	return {
		"ui/views/petposter/petpostershowview_new.prefab"
	}
end

function PetpostershowViewPresentor:buildViews()
	return {
		PetpostershowView.New()
	}
end

return PetpostershowViewPresentor
