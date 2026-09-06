-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestFmtExtisonViewPresentor.lua

module("logic.extensions.magiccontest.view.MagicContestFmtExtisonViewPresentor", package.seeall)

local MagicContestFmtExtisonViewPresentor = class("MagicContestFmtExtisonViewPresentor", ViewPresentor)

function MagicContestFmtExtisonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicContestFmtExtisonViewPresentor:dependWhatResources()
	return {
		"ui/views/magiccontest/magiccontestfmtextisonview.prefab"
	}
end

function MagicContestFmtExtisonViewPresentor:buildViews()
	return {
		MagicContestFmtExtisonView.New()
	}
end

function MagicContestFmtExtisonViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MagicContestFmtExtisonViewPresentor
