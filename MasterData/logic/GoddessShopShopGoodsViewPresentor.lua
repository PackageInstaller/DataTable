-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopShopGoodsViewPresentor.lua

module("logic.extensions.goddessshop.view.GoddessShopShopGoodsViewPresentor", package.seeall)

local GoddessShopShopGoodsViewPresentor = class("GoddessShopShopGoodsViewPresentor", ViewPresentor)

function GoddessShopShopGoodsViewPresentor:ctor()
	GoddessShopShopGoodsViewPresentor.super.ctor(self)
end

function GoddessShopShopGoodsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessShopShopGoodsViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessshop/goddessshopshopgoodsview.prefab"
	}
end

function GoddessShopShopGoodsViewPresentor:buildViews()
	return {
		GoddessShopShopGoodsView.New()
	}
end

return GoddessShopShopGoodsViewPresentor
