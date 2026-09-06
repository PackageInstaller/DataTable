-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/XiaoNuoGifBoxViewPresentor.lua

module("logic.extensions.caiqingdraw.view.XiaoNuoGifBoxViewPresentor", package.seeall)

local XiaoNuoGifBoxViewPresentor = class("XiaoNuoGifBoxViewPresentor", ViewPresentor)

function XiaoNuoGifBoxViewPresentor:ctor()
	XiaoNuoGifBoxViewPresentor.super.ctor(self)
end

function XiaoNuoGifBoxViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaoNuoGifBoxViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/caiqingdraw/xiaonuogifboxview.prefab"
	}
end

function XiaoNuoGifBoxViewPresentor:buildViews()
	return {
		XiaoNuoGifBoxView.New()
	}
end

return XiaoNuoGifBoxViewPresentor
