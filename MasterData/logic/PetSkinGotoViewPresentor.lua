-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/petskinsell/PetSkinGotoViewPresentor.lua

module("logic.extensions.firstcharge.view.petskinsell.PetSkinGotoViewPresentor", package.seeall)

local PetSkinGotoViewPresentor = class("PetSkinGotoViewPresentor", ViewPresentor)

function PetSkinGotoViewPresentor:ctor()
	PetSkinGotoViewPresentor.super.ctor(self)
end

function PetSkinGotoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetSkinGotoViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/petskingotoview.prefab"
	}
end

function PetSkinGotoViewPresentor:buildViews()
	return {
		PetSkinGotoView.New()
	}
end

return PetSkinGotoViewPresentor
