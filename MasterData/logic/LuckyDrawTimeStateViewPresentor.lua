-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawTimeStateViewPresentor.lua

module("logic.extensions.luckydraw.view.LuckyDrawTimeStateViewPresentor", package.seeall)

local LuckyDrawTimeStateViewPresentor = class("LuckyDrawTimeStateViewPresentor", ViewPresentor)

function LuckyDrawTimeStateViewPresentor:ctor()
	LuckyDrawTimeStateViewPresentor.super.ctor(self)
end

function LuckyDrawTimeStateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyDrawTimeStateViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawtimestateview.prefab"
	}
end

function LuckyDrawTimeStateViewPresentor:buildViews()
	return {
		LuckyDrawTimeStateView.New()
	}
end

return LuckyDrawTimeStateViewPresentor
