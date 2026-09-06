-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/topkingspace/TabTopKingPTEliQuarterFinalSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.topkingspace.TabTopKingPTEliQuarterFinalSpaceViewPresentor", package.seeall)

local TabTopKingPTEliQuarterFinalSpaceViewPresentor = class("TabTopKingPTEliQuarterFinalSpaceViewPresentor", ViewPresentor)

function TabTopKingPTEliQuarterFinalSpaceViewPresentor:ctor()
	TabTopKingPTEliQuarterFinalSpaceViewPresentor.super.ctor(self)
end

function TabTopKingPTEliQuarterFinalSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabTopKingPTEliQuarterFinalSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabpteliquarterfinalspaceview.prefab"
	}
end

function TabTopKingPTEliQuarterFinalSpaceViewPresentor:buildViews()
	return {
		TabTopKingPTEliQuarterFinalSpaceView.New()
	}
end

function TabTopKingPTEliQuarterFinalSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabTopKingPTEliQuarterFinalSpaceViewPresentor
