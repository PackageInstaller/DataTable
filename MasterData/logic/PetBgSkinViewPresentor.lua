-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bgskin/view/PetBgSkinViewPresentor.lua

module("logic.extensions.bgskin.view.PetBgSkinViewPresentor", package.seeall)

local PetBgSkinViewPresentor = class("PetBgSkinViewPresentor", ViewPresentor)

function PetBgSkinViewPresentor:ctor()
	PetBgSkinViewPresentor.super.ctor(self)
end

function PetBgSkinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetBgSkinViewPresentor:dependWhatResources()
	return {
		"ui/views/bgskin/petbgskinview.prefab"
	}
end

function PetBgSkinViewPresentor:buildViews()
	return {
		PetBgSkinView.New()
	}
end

return PetBgSkinViewPresentor
