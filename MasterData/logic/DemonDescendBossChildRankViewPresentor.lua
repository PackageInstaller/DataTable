-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/view/demondescend/DemonDescendBossChildRankViewPresentor.lua

module("logic.extensions.commontabrank.view.demondescend.DemonDescendBossChildRankViewPresentor", package.seeall)

local DemonDescendBossChildRankViewPresentor = class("DemonDescendBossChildRankViewPresentor", ViewPresentor)

function DemonDescendBossChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DemonDescendBossChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/demondescendbosschildrankview.prefab"
	}
end

function DemonDescendBossChildRankViewPresentor:buildViews()
	return {
		DemonDescendBossChildRankView.New()
	}
end

function DemonDescendBossChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return DemonDescendBossChildRankViewPresentor
