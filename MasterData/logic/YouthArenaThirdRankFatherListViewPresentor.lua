-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdRankFatherListViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdRankFatherListViewPresentor", package.seeall)

local YouthArenaThirdRankFatherListViewPresentor = class("YouthArenaThirdRankFatherListViewPresentor", ViewPresentor)

function YouthArenaThirdRankFatherListViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdRankFatherListViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/commontabrankfatherlistview.prefab"
	}
end

function YouthArenaThirdRankFatherListViewPresentor:buildViews()
	return {
		YouthArenaThirdRankFatherListView.New()
	}
end

function YouthArenaThirdRankFatherListViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YouthArenaThirdRankFatherListViewPresentor
