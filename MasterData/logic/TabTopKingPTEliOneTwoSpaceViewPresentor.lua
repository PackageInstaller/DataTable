-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/topkingspace/TabTopKingPTEliOneTwoSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.topkingspace.TabTopKingPTEliOneTwoSpaceViewPresentor", package.seeall)

local TabTopKingPTEliOneTwoSpaceViewPresentor = class("TabTopKingPTEliOneTwoSpaceViewPresentor", ViewPresentor)

function TabTopKingPTEliOneTwoSpaceViewPresentor:ctor()
	TabTopKingPTEliOneTwoSpaceViewPresentor.super.ctor(self)
end

function TabTopKingPTEliOneTwoSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabTopKingPTEliOneTwoSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabptelifinalspaceview.prefab"
	}
end

function TabTopKingPTEliOneTwoSpaceViewPresentor:buildViews()
	return {
		TabTopKingPTEliOneTwoSpaceView.New()
	}
end

function TabTopKingPTEliOneTwoSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabTopKingPTEliOneTwoSpaceViewPresentor
