-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKRankMainViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKRankMainViewPresentor", package.seeall)

local TCKRankMainViewPresentor = class("TCKRankMainViewPresentor", ViewPresentor)

function TCKRankMainViewPresentor:ctor()
	TCKRankMainViewPresentor.super.ctor(self)
end

function TCKRankMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKRankMainViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckrankmainview.prefab"
	}
end

function TCKRankMainViewPresentor:buildViews()
	return {
		TCKRankMainView.New()
	}
end

return TCKRankMainViewPresentor
