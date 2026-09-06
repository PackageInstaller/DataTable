-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawScoreStateViewPresentor.lua

module("logic.extensions.luckydraw.view.LuckyDrawScoreStateViewPresentor", package.seeall)

local LuckyDrawScoreStateViewPresentor = class("LuckyDrawScoreStateViewPresentor", ViewPresentor)

function LuckyDrawScoreStateViewPresentor:ctor()
	LuckyDrawScoreStateViewPresentor.super.ctor(self)
end

function LuckyDrawScoreStateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyDrawScoreStateViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawscorestateview.prefab"
	}
end

function LuckyDrawScoreStateViewPresentor:buildViews()
	return {
		LuckyDrawScoreStateView.New()
	}
end

return LuckyDrawScoreStateViewPresentor
