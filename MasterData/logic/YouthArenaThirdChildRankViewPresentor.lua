-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChildRankViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChildRankViewPresentor", package.seeall)

local YouthArenaThirdChildRankViewPresentor = class("YouthArenaThirdChildRankViewPresentor", ViewPresentor)

function YouthArenaThirdChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/youtharenathirdchildrankview.prefab"
	}
end

function YouthArenaThirdChildRankViewPresentor:buildViews()
	return {
		YouthArenaThirdChildRankView.New()
	}
end

function YouthArenaThirdChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YouthArenaThirdChildRankViewPresentor
