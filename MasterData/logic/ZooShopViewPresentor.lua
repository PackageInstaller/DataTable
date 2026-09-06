-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooShopViewPresentor.lua

module("logic.extensions.zoo.view.ZooShopViewPresentor", package.seeall)

local ZooShopViewPresentor = class("ZooShopViewPresentor", ViewPresentor)

function ZooShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ZooShopViewPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zooshopview.prefab"
	}
end

function ZooShopViewPresentor:buildViews()
	return {
		ZooShopView.New()
	}
end

return ZooShopViewPresentor
