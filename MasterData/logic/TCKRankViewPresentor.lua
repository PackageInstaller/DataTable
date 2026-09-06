-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKRankViewPresentor.lua

module("logic.extensions.teenchampionking.view.TCKRankViewPresentor", package.seeall)

local TCKRankViewPresentor = class("TCKRankViewPresentor", ViewPresentor)

function TCKRankViewPresentor:ctor()
	TCKRankViewPresentor.super.ctor(self)
end

function TCKRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TCKRankViewPresentor:dependWhatResources()
	return {
		"ui/views/teenchampionking/tckrankview.prefab"
	}
end

function TCKRankViewPresentor:buildViews()
	return {
		TCKRankView.New()
	}
end

function TCKRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TCKRankViewPresentor
