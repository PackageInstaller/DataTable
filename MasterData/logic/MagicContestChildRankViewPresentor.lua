-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/magiccontest/MagicContestChildRankViewPresentor.lua

module("logic.extensions.commontabrank.view.magiccontest.MagicContestChildRankViewPresentor", package.seeall)

local MagicContestChildRankViewPresentor = class("MagicContestChildRankViewPresentor", ViewPresentor)

function MagicContestChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicContestChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/magiccontestchildrankview.prefab"
	}
end

function MagicContestChildRankViewPresentor:buildViews()
	return {
		MagicContestChildRankView.New()
	}
end

function MagicContestChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MagicContestChildRankViewPresentor
