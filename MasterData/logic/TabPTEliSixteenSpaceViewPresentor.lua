-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliSixteenSpaceViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliSixteenSpaceViewPresentor", package.seeall)

local TabPTEliSixteenSpaceViewPresentor = class("TabPTEliSixteenSpaceViewPresentor", ViewPresentor)

function TabPTEliSixteenSpaceViewPresentor:ctor()
	TabPTEliSixteenSpaceViewPresentor.super.ctor(self)
end

function TabPTEliSixteenSpaceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTEliSixteenSpaceViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/space/tabptelisixteenspaceview.prefab"
	}
end

function TabPTEliSixteenSpaceViewPresentor:buildViews()
	return {
		TabPTEliSixteenSpaceView.New()
	}
end

function TabPTEliSixteenSpaceViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTEliSixteenSpaceViewPresentor
