-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/TabPTEliBaseMainViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.TabPTEliBaseMainViewPresentor", package.seeall)

local TabPTEliBaseMainViewPresentor = class("TabPTEliBaseMainViewPresentor", ViewPresentor)

function TabPTEliBaseMainViewPresentor:ctor()
	TabPTEliBaseMainViewPresentor.super.ctor(self)
end

function TabPTEliBaseMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTEliBaseMainViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/tabptelibasemainview.prefab"
	}
end

function TabPTEliBaseMainViewPresentor:buildViews()
	return {
		TabPTEliBaseMainView.New()
	}
end

return TabPTEliBaseMainViewPresentor
