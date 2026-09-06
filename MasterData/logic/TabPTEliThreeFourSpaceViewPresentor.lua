-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliThreeFourSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliThreeFourSpaceViewPresentor", package.seeall)

local TabPTEliThreeFourSpaceViewPresentor = class("TabPTEliThreeFourSpaceViewPresentor", ViewPresentor)

function TabPTEliThreeFourSpaceViewPresentor:ctor()
	TabPTEliThreeFourSpaceViewPresentor.super.ctor(self)
end

function TabPTEliThreeFourSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTEliThreeFourSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabptelifinalspaceview.prefab"
	}
end

function TabPTEliThreeFourSpaceViewPresentor:buildViews()
	return {
		TabPTEliThreeFourSpaceView.New()
	}
end

function TabPTEliThreeFourSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTEliThreeFourSpaceViewPresentor
