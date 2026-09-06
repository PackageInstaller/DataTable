-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onekeyunloadpet/view/OneKeyUnloadPetViewPresentor.lua

module("logic.extensions.onekeyunloadpet.view.OneKeyUnloadPetViewPresentor", package.seeall)

local OneKeyUnloadPetViewPresentor = class("OneKeyUnloadPetViewPresentor", ViewPresentor)

function OneKeyUnloadPetViewPresentor:ctor()
	OneKeyUnloadPetViewPresentor.super.ctor(self)
end

function OneKeyUnloadPetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OneKeyUnloadPetViewPresentor:dependWhatResources()
	return {
		"ui/views/onekeyunloadpet/onekeyunloadpetview.prefab"
	}
end

function OneKeyUnloadPetViewPresentor:buildViews()
	return {
		OneKeyUnloadPetView.New()
	}
end

return OneKeyUnloadPetViewPresentor
