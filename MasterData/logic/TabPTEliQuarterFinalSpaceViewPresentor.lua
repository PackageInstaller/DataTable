-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliQuarterFinalSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliQuarterFinalSpaceViewPresentor", package.seeall)

local TabPTEliQuarterFinalSpaceViewPresentor = class("TabPTEliQuarterFinalSpaceViewPresentor", ViewPresentor)

function TabPTEliQuarterFinalSpaceViewPresentor:ctor()
	TabPTEliQuarterFinalSpaceViewPresentor.super.ctor(self)
end

function TabPTEliQuarterFinalSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTEliQuarterFinalSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabpteliquarterfinalspaceview.prefab"
	}
end

function TabPTEliQuarterFinalSpaceViewPresentor:buildViews()
	return {
		TabPTEliQuarterFinalSpaceView.New()
	}
end

function TabPTEliQuarterFinalSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTEliQuarterFinalSpaceViewPresentor
