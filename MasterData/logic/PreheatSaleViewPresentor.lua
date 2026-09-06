-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preheatsale/view/PreheatSaleViewPresentor.lua

module("logic.extensions.preheatsale.view.PreheatSaleViewPresentor", package.seeall)

local PreheatSaleViewPresentor = class("PreheatSaleViewPresentor", ViewPresentor)

function PreheatSaleViewPresentor:ctor()
	PreheatSaleViewPresentor.super.ctor(self)
end

function PreheatSaleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PreheatSaleViewPresentor:dependWhatResources()
	return {
		"ui/views/preheatsale/preheatsaleview.prefab"
	}
end

function PreheatSaleViewPresentor:buildViews()
	return {
		PreheatSaleView.New()
	}
end

return PreheatSaleViewPresentor
