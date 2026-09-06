-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawTimeStateAddViewPresentor.lua

module("logic.extensions.luckydraw.view.LuckyDrawTimeStateAddViewPresentor", package.seeall)

local LuckyDrawTimeStateAddViewPresentor = class("LuckyDrawTimeStateAddViewPresentor", ViewPresentor)

function LuckyDrawTimeStateAddViewPresentor:ctor()
	LuckyDrawTimeStateAddViewPresentor.super.ctor(self)
end

function LuckyDrawTimeStateAddViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckyDrawTimeStateAddViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawtimestateaddview.prefab"
	}
end

function LuckyDrawTimeStateAddViewPresentor:buildViews()
	return {
		LuckyDrawTimeStateAddView.New()
	}
end

return LuckyDrawTimeStateAddViewPresentor
