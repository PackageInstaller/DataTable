-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopShopViewPresentor.lua

module("logic.extensions.goddessshop.view.GoddessShopShopViewPresentor", package.seeall)

local GoddessShopShopViewPresentor = class("GoddessShopShopViewPresentor", ViewPresentor)

function GoddessShopShopViewPresentor:ctor()
	GoddessShopShopViewPresentor.super.ctor(self)
end

function GoddessShopShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessShopShopViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessshop/goddessshopshopview.prefab"
	}
end

function GoddessShopShopViewPresentor:buildViews()
	return {
		GoddessShopShopView.New()
	}
end

return GoddessShopShopViewPresentor
