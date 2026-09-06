-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/topkingspace/TabTopKingPTEliGroupStageSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.topkingspace.TabTopKingPTEliGroupStageSpaceViewPresentor", package.seeall)

local TabTopKingPTEliGroupStageSpaceViewPresentor = class("TabTopKingPTEliGroupStageSpaceViewPresentor", ViewPresentor)

function TabTopKingPTEliGroupStageSpaceViewPresentor:ctor()
	TabTopKingPTEliGroupStageSpaceViewPresentor.super.ctor(self)
end

function TabTopKingPTEliGroupStageSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabTopKingPTEliGroupStageSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabpteligroupstagespaceview.prefab"
	}
end

function TabTopKingPTEliGroupStageSpaceViewPresentor:buildViews()
	return {
		TabTopKingPTEliGroupStageSpaceView.New()
	}
end

function TabTopKingPTEliGroupStageSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabTopKingPTEliGroupStageSpaceViewPresentor
