-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopMainViewPresentor.lua

module("logic.extensions.goddessshop.view.GoddessShopMainViewPresentor", package.seeall)

local GoddessShopMainViewPresentor = class("GoddessShopMainViewPresentor", ViewPresentor)

function GoddessShopMainViewPresentor:ctor()
	GoddessShopMainViewPresentor.super.ctor(self)
end

function GoddessShopMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddessShopMainViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessshop/goddessshopmainview.prefab"
	}
end

function GoddessShopMainViewPresentor:buildViews()
	return {
		GoddessShopMainView.New()
	}
end

return GoddessShopMainViewPresentor
