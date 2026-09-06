-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pricebreakdiscount/view/femalegod/FemaleGodShopMainViewPresentor.lua

module("logic.extensions.femalegod.view.FemaleGodShopMainViewPresentor", package.seeall)

local FemaleGodShopMainViewPresentor = class("FemaleGodShopMainViewPresentor", ViewPresentor)

function FemaleGodShopMainViewPresentor:ctor()
	FemaleGodShopMainViewPresentor.super.ctor(self)
end

function FemaleGodShopMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FemaleGodShopMainViewPresentor:dependWhatResources()
	return {
		"ui/views/pricebreakdiscount/femalegodshopmainview.prefab"
	}
end

function FemaleGodShopMainViewPresentor:buildViews()
	return {
		FemaleGodShopMainView.New()
	}
end

function FemaleGodShopMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FemaleGodShopMainViewPresentor
