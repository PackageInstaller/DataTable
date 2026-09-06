-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenBossPrizeViewPresentor.lua

module("logic.extensions.halloweenguest.view.HalloweenBossPrizeViewPresentor", package.seeall)

local HalloweenBossPrizeViewPresentor = class("HalloweenBossPrizeViewPresentor", ViewWithGuidePresentor)

function HalloweenBossPrizeViewPresentor:ctor()
	HalloweenBossPrizeViewPresentor.super.ctor(self)
end

function HalloweenBossPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HalloweenBossPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/halloweenguest/halloweenbossprizeview.prefab"
	}
end

function HalloweenBossPrizeViewPresentor:buildViews()
	return {
		HalloweenBossPrizeView.New()
	}
end

return HalloweenBossPrizeViewPresentor
