-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/TabPTEliVotePlateMainViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.TabPTEliVotePlateMainViewPresentor", package.seeall)

local TabPTEliVotePlateMainViewPresentor = class("TabPTEliVotePlateMainViewPresentor", ViewPresentor)

function TabPTEliVotePlateMainViewPresentor:ctor()
	TabPTEliVotePlateMainViewPresentor.super.ctor(self)
end

function TabPTEliVotePlateMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTEliVotePlateMainViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/tabptelivoteplatemainview.prefab"
	}
end

function TabPTEliVotePlateMainViewPresentor:buildViews()
	return {
		TabPTEliVotePlateMainView.New()
	}
end

function TabPTEliVotePlateMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTEliVotePlateMainViewPresentor
