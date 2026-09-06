-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliOneTwoSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliOneTwoSpaceViewPresentor", package.seeall)

local TabPTEliOneTwoSpaceViewPresentor = class("TabPTEliOneTwoSpaceViewPresentor", ViewPresentor)

function TabPTEliOneTwoSpaceViewPresentor:ctor()
	TabPTEliOneTwoSpaceViewPresentor.super.ctor(self)
end

function TabPTEliOneTwoSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTEliOneTwoSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabptelifinalspaceview.prefab"
	}
end

function TabPTEliOneTwoSpaceViewPresentor:buildViews()
	return {
		TabPTEliOneTwoSpaceView.New()
	}
end

function TabPTEliOneTwoSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTEliOneTwoSpaceViewPresentor
