-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/view/IceQiBuShopChildViewPresentor.lua

module("logic.extensions.huanxinqing.view.IceQiBuShopChildViewPresentor", package.seeall)

local IceQiBuShopChildViewPresentor = class("IceQiBuShopChildViewPresentor", ViewPresentor)

function IceQiBuShopChildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IceQiBuShopChildViewPresentor:dependWhatResources()
	return {
		"ui/views/huanxinqing/iceqibushopchildview.prefab"
	}
end

function IceQiBuShopChildViewPresentor:buildViews()
	return {
		IceQiBuShopChildView.New()
	}
end

function IceQiBuShopChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return IceQiBuShopChildViewPresentor
