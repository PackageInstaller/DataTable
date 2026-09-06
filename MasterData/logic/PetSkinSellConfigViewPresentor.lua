-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/PetSkinSellConfigViewPresentor.lua

module("logic.extensions.firstcharge.view.PetSkinSellConfigViewPresentor", package.seeall)

local PetSkinSellConfigViewPresentor = class("PetSkinSellConfigViewPresentor", ViewPresentor)

function PetSkinSellConfigViewPresentor:ctor()
	PetSkinSellConfigViewPresentor.super.ctor(self)
end

function PetSkinSellConfigViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetSkinSellConfigViewPresentor:dependWhatResources()
	return {
		"ui/views/firstcharge/petskinsaleview.prefab"
	}
end

function PetSkinSellConfigViewPresentor:buildViews()
	return {
		PetSkinSellConfigView.New()
	}
end

return PetSkinSellConfigViewPresentor
