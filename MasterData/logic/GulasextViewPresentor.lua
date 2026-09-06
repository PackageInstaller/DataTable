-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/view/GulasextViewPresentor.lua

module("logic.extensions.gulas.view.GulasextViewPresentor", package.seeall)

local GulasextViewPresentor = class("GulasextViewPresentor", ViewPresentor)

function GulasextViewPresentor:ctor()
	GulasextViewPresentor.super.ctor(self)
end

function GulasextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GulasextViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/gulas/gulasextview.prefab"
	}
end

function GulasextViewPresentor:buildViews()
	return {
		GulasextView.New()
	}
end

function GulasextViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GulasextViewPresentor
