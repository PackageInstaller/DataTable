-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/view/DemonDescendBuffShopViewPresentor.lua

module("logic.extensions.demondescend.view.DemonDescendBuffShopViewPresentor", package.seeall)

local DemonDescendBuffShopViewPresentor = class("DemonDescendBuffShopViewPresentor", ViewPresentor)

function DemonDescendBuffShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DemonDescendBuffShopViewPresentor:dependWhatResources()
	return {
		"ui/views/demondescend/demondescendbuffshopview.prefab"
	}
end

function DemonDescendBuffShopViewPresentor:buildViews()
	return {
		DemonDescendBuffShopView.New()
	}
end

return DemonDescendBuffShopViewPresentor
