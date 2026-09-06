-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetSkinEnterEffectSetViewPresentor.lua

module("logic.extensions.petskin.view.PetSkinEnterEffectSetViewPresentor", package.seeall)

local PetSkinEnterEffectSetViewPresentor = class("PetSkinEnterEffectSetViewPresentor", ViewPresentor)

function PetSkinEnterEffectSetViewPresentor:ctor()
	PetSkinEnterEffectSetViewPresentor.super.ctor(self)
end

function PetSkinEnterEffectSetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PetSkinEnterEffectSetViewPresentor:dependWhatResources()
	return {
		"ui/views/bag/petskinentereffectsetview.prefab"
	}
end

function PetSkinEnterEffectSetViewPresentor:buildViews()
	return {
		PetSkinEnterEffectSetView.New()
	}
end

return PetSkinEnterEffectSetViewPresentor
