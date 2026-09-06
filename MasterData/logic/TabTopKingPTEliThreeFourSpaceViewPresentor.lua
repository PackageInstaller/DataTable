-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/topkingspace/TabTopKingPTEliThreeFourSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.topkingspace.TabTopKingPTEliThreeFourSpaceViewPresentor", package.seeall)

local TabTopKingPTEliThreeFourSpaceViewPresentor = class("TabTopKingPTEliThreeFourSpaceViewPresentor", ViewPresentor)

function TabTopKingPTEliThreeFourSpaceViewPresentor:ctor()
	TabTopKingPTEliThreeFourSpaceViewPresentor.super.ctor(self)
end

function TabTopKingPTEliThreeFourSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabTopKingPTEliThreeFourSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabptelifinalspaceview.prefab"
	}
end

function TabTopKingPTEliThreeFourSpaceViewPresentor:buildViews()
	return {
		TabTopKingPTEliThreeFourSpaceView.New()
	}
end

function TabTopKingPTEliThreeFourSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabTopKingPTEliThreeFourSpaceViewPresentor
