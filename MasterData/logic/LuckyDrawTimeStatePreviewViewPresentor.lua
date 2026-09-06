-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawTimeStatePreviewViewPresentor.lua

module("logic.extensions.luckydraw.view.LuckyDrawTimeStatePreviewViewPresentor", package.seeall)

local LuckyDrawTimeStatePreviewViewPresentor = class("LuckyDrawTimeStatePreviewViewPresentor", ViewPresentor)

function LuckyDrawTimeStatePreviewViewPresentor:ctor()
	LuckyDrawTimeStatePreviewViewPresentor.super.ctor(self)
end

function LuckyDrawTimeStatePreviewViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyDrawTimeStatePreviewViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawtimestateview_preview.prefab"
	}
end

function LuckyDrawTimeStatePreviewViewPresentor:buildViews()
	return {
		LuckyDrawTimeStatePreviewView.New()
	}
end

return LuckyDrawTimeStatePreviewViewPresentor
