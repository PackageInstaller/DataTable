-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/freescufflle/FreeScufflleWealthChildRankViewPresentor.lua

module("logic.extensions.commontabrank.view.freescufflle.FreeScufflleWealthChildRankViewPresentor", package.seeall)

local FreeScufflleWealthChildRankViewPresentor = class("FreeScufflleWealthChildRankViewPresentor", ViewPresentor)

function FreeScufflleWealthChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScufflleWealthChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/freescuffllewealthchildrankview.prefab"
	}
end

function FreeScufflleWealthChildRankViewPresentor:buildViews()
	return {
		FreeScufflleWealthChildRankView.New()
	}
end

function FreeScufflleWealthChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FreeScufflleWealthChildRankViewPresentor
