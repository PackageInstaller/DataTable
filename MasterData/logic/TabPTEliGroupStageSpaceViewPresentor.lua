-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliGroupStageSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliGroupStageSpaceViewPresentor", package.seeall)

local TabPTEliGroupStageSpaceViewPresentor = class("TabPTEliGroupStageSpaceViewPresentor", ViewPresentor)

function TabPTEliGroupStageSpaceViewPresentor:ctor()
	TabPTEliGroupStageSpaceViewPresentor.super.ctor(self)
end

function TabPTEliGroupStageSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTEliGroupStageSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabpteligroupstagespaceview.prefab"
	}
end

function TabPTEliGroupStageSpaceViewPresentor:buildViews()
	return {
		TabPTEliGroupStageSpaceView.New()
	}
end

function TabPTEliGroupStageSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTEliGroupStageSpaceViewPresentor
