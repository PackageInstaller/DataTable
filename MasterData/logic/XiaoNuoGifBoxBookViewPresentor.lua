-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/caiqingdraw/view/XiaoNuoGifBoxBookViewPresentor.lua

module("logic.extensions.caiqingdraw.view.XiaoNuoGifBoxBookViewPresentor", package.seeall)

local XiaoNuoGifBoxBookViewPresentor = class("XiaoNuoGifBoxBookViewPresentor", ViewPresentor)

function XiaoNuoGifBoxBookViewPresentor:ctor()
	XiaoNuoGifBoxBookViewPresentor.super.ctor(self)
end

function XiaoNuoGifBoxBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaoNuoGifBoxBookViewPresentor:dependWhatResources()
	return {
		"ui/views/activity/caiqingdraw/xiaonuogifboxbookview.prefab"
	}
end

function XiaoNuoGifBoxBookViewPresentor:buildViews()
	return {
		XiaoNuoGifBoxBookView.New()
	}
end

return XiaoNuoGifBoxBookViewPresentor
