-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopWealthViewPresentor.lua

module("logic.extensions.goddessshop.view.GoddessShopWealthViewPresentor", package.seeall)

local GoddessShopWealthViewPresentor = class("GoddessShopWealthViewPresentor", ViewPresentor)

function GoddessShopWealthViewPresentor:ctor()
	GoddessShopWealthViewPresentor.super.ctor(self)
end

function GoddessShopWealthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessShopWealthViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessshop/goddessshopwealthview.prefab"
	}
end

function GoddessShopWealthViewPresentor:buildViews()
	return {
		GoddessShopWealthView.New()
	}
end

return GoddessShopWealthViewPresentor
