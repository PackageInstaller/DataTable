-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawPreviewViewPresentor.lua

module("logic.extensions.luckydraw.view.LuckyDrawPreviewViewPresentor", package.seeall)

local LuckyDrawPreviewViewPresentor = class("LuckyDrawPreviewViewPresentor", ViewPresentor)

function LuckyDrawPreviewViewPresentor:ctor()
	LuckyDrawPreviewViewPresentor.super.ctor(self)
end

function LuckyDrawPreviewViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LuckyDrawPreviewViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawpreviewview.prefab"
	}
end

function LuckyDrawPreviewViewPresentor:buildViews()
	return {
		LuckyDrawPreviewView.New()
	}
end

return LuckyDrawPreviewViewPresentor
