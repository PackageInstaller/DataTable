-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventDispatchShopViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvEventDispatchShopViewPresentor", package.seeall)

local DomAdvEventDispatchShopViewPresentor = class("DomAdvEventDispatchShopViewPresentor", ViewPresentor)

function DomAdvEventDispatchShopViewPresentor:ctor()
	DomAdvEventDispatchShopViewPresentor.super.ctor(self)
end

function DomAdvEventDispatchShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvEventDispatchShopViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadveventdispatchshopview.prefab"
	}
end

function DomAdvEventDispatchShopViewPresentor:buildViews()
	return {
		DomAdvEventDispatchShopView.New()
	}
end

return DomAdvEventDispatchShopViewPresentor
