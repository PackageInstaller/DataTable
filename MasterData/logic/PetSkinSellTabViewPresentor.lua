-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/petskinsell/PetSkinSellTabViewPresentor.lua

module("logic.extensions.firstcharge.view.petskinsell.PetSkinSellTabViewPresentor", package.seeall)

local PetSkinSellTabViewPresentor = class("PetSkinSellTabViewPresentor", ViewPresentor)

function PetSkinSellTabViewPresentor:ctor()
	PetSkinSellTabViewPresentor.super.ctor(self)
end

function PetSkinSellTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetSkinSellTabViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/petskinselltabview.prefab"
	}
end

function PetSkinSellTabViewPresentor:buildViews()
	return {
		PetSkinSellTabView.New()
	}
end

function PetSkinSellTabViewPresentor:_onEnterAnimationDone()
	PetSkinSellTabViewPresentor.super._onEnterAnimationDone(self)
	GlobalModel.instance:visibleMainCamera(true)
end

return PetSkinSellTabViewPresentor
