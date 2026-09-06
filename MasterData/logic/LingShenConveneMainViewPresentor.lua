-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lingshenconvene/view/LingShenConveneMainViewPresentor.lua

module("logic.extensions.lingshenconvene.view.LingShenConveneMainViewPresentor", package.seeall)

local LingShenConveneMainViewPresentor = class("LingShenConveneMainViewPresentor", ViewPresentor)

function LingShenConveneMainViewPresentor:ctor()
	LingShenConveneMainViewPresentor.super.ctor(self)
end

function LingShenConveneMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LingShenConveneMainViewPresentor:dependWhatResources()
	return {
		"ui/views/lingshenconvene/lingshenconvenemainview.prefab"
	}
end

function LingShenConveneMainViewPresentor:buildViews()
	return {
		LingShenConveneMainView.New()
	}
end

function LingShenConveneMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LingShenConveneMainViewPresentor
