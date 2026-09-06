-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckydrawViewPresentor.lua

module("logic.extensions.luckydraw.view.LuckydrawViewPresentor", package.seeall)

local LuckydrawViewPresentor = class("LuckydrawViewPresentor", ViewPresentor)

function LuckydrawViewPresentor:ctor()
	LuckydrawViewPresentor.super.ctor(self)
end

function LuckydrawViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckydrawViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawview.prefab"
	}
end

function LuckydrawViewPresentor:buildViews()
	return {
		LuckyDrawView.New()
	}
end

function LuckydrawViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return LuckydrawViewPresentor
