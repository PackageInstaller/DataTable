-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/freescufflle/FreeScuffllePkChildRankViewPresentor.lua

module("logic.extensions.commontabrank.view.freescufflle.FreeScuffllePkChildRankViewPresentor", package.seeall)

local FreeScuffllePkChildRankViewPresentor = class("FreeScuffllePkChildRankViewPresentor", ViewPresentor)

function FreeScuffllePkChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FreeScuffllePkChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/freescuffllepkchildrankview.prefab"
	}
end

function FreeScuffllePkChildRankViewPresentor:buildViews()
	return {
		FreeScuffllePkChildRankView.New()
	}
end

function FreeScuffllePkChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return FreeScuffllePkChildRankViewPresentor
