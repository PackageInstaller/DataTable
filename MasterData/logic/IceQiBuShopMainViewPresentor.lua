-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/view/IceQiBuShopMainViewPresentor.lua

module("logic.extensions.huanxinqing.view.IceQiBuShopMainViewPresentor", package.seeall)

local IceQiBuShopMainViewPresentor = class("IceQiBuShopMainViewPresentor", ViewPresentor)

function IceQiBuShopMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IceQiBuShopMainViewPresentor:dependWhatResources()
	return {
		"ui/views/huanxinqing/iceqibushopmainview.prefab"
	}
end

function IceQiBuShopMainViewPresentor:buildViews()
	return {
		IceQiBuShopMainView.New()
	}
end

return IceQiBuShopMainViewPresentor
