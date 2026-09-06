-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopShopInvestViewPresentor.lua

module("logic.extensions.goddessshop.view.GoddessShopShopInvestViewPresentor", package.seeall)

local GoddessShopShopInvestViewPresentor = class("GoddessShopShopInvestViewPresentor", ViewPresentor)

function GoddessShopShopInvestViewPresentor:ctor()
	GoddessShopShopInvestViewPresentor.super.ctor(self)
end

function GoddessShopShopInvestViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessShopShopInvestViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessshop/goddessshopshopinvestview.prefab"
	}
end

function GoddessShopShopInvestViewPresentor:buildViews()
	return {
		GoddessShopShopInvestView.New()
	}
end

return GoddessShopShopInvestViewPresentor
