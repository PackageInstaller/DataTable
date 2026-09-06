-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huanxinqing/view/IceQiBuShopTaskFrameViewPresentor.lua

module("logic.extensions.huanxinqing.view.IceQiBuShopTaskFrameViewPresentor", package.seeall)

local IceQiBuShopTaskFrameViewPresentor = class("IceQiBuShopTaskFrameViewPresentor", ViewPresentor)

function IceQiBuShopTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IceQiBuShopTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/huanxinqing/iceqibushoptaskframeview.prefab"
	}
end

function IceQiBuShopTaskFrameViewPresentor:buildViews()
	return {
		IceQiBuShopTaskFrameView.New()
	}
end

function IceQiBuShopTaskFrameViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return IceQiBuShopTaskFrameViewPresentor
