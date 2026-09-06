-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/view/FinalEchoRankViewPresentor.lua

module("logic.extensions.finalecho.view.FinalEchoRankViewPresentor", package.seeall)

local FinalEchoRankViewPresentor = class("FinalEchoRankViewPresentor", ViewPresentor)

function FinalEchoRankViewPresentor:ctor()
	FinalEchoRankViewPresentor.super.ctor(self)
end

function FinalEchoRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FinalEchoRankViewPresentor:dependWhatResources()
	return {
		"ui/views/finalecho/finalechorankview.prefab"
	}
end

function FinalEchoRankViewPresentor:buildViews()
	return {
		FinalEchoRankView.New()
	}
end

function FinalEchoRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FinalEchoRankViewPresentor
