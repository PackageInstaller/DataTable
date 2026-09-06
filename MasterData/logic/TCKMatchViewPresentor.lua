-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKMatchViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKMatchViewPresentor", package.seeall)

local TCKMatchViewPresentor = class("TCKMatchViewPresentor", ViewPresentor)

function TCKMatchViewPresentor:ctor()
	TCKMatchViewPresentor.super.ctor(self)
end

function TCKMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckmatchview.prefab"
	}
end

function TCKMatchViewPresentor:buildViews()
	return {
		TCKMatchView.New()
	}
end

return TCKMatchViewPresentor
