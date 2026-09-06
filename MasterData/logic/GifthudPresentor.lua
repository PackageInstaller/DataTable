-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paytempt/view/GifthudPresentor.lua

module("logic.extensions.paytempt.view.GifthudPresentor", package.seeall)

local GifthudPresentor = class("GifthudPresentor", ViewPresentor)

function GifthudPresentor:ctor()
	GifthudPresentor.super.ctor(self)
end

function GifthudPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GifthudPresentor:dependWhatResources()
	return {
		"ui/views/activity/paytempt/gifthudview.prefab"
	}
end

function GifthudPresentor:buildViews()
	return {
		GifthudView.New()
	}
end

function GifthudPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return GifthudPresentor
