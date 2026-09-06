-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/petskinsell/PetSkinSellChangeViewPresentor.lua

module("logic.extensions.firstcharge.view.petskinsell.PetSkinSellChangeViewPresentor", package.seeall)

local PetSkinSellChangeViewPresentor = class("PetSkinSellChangeViewPresentor", ViewPresentor)

function PetSkinSellChangeViewPresentor:ctor()
	PetSkinSellChangeViewPresentor.super.ctor(self)
end

function PetSkinSellChangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetSkinSellChangeViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/petskinsellchangeview.prefab"
	}
end

function PetSkinSellChangeViewPresentor:buildViews()
	return {
		PetSkinSellChangeView.New()
	}
end

function PetSkinSellChangeViewPresentor:_onEnterAnimationDone()
	PetSkinSellChangeViewPresentor.super._onEnterAnimationDone(self)
	GlobalModel.instance:visibleMainCamera(true)
end

return PetSkinSellChangeViewPresentor
