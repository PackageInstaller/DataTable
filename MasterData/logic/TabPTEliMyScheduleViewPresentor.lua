-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/TabPTEliMyScheduleViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.tab.TabPTEliMyScheduleViewPresentor", package.seeall)

local TabPTEliMyScheduleViewPresentor = class("TabPTEliMyScheduleViewPresentor", ViewPresentor)

function TabPTEliMyScheduleViewPresentor:ctor()
	TabPTEliMyScheduleViewPresentor.super.ctor(self)
end

function TabPTEliMyScheduleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TabPTEliMyScheduleViewPresentor:dependWhatResources()
	return {
		"ui/views/peak/eliminator/tab/tabptelimyscheduleview.prefab"
	}
end

function TabPTEliMyScheduleViewPresentor:buildViews()
	return {
		TabPTEliMyScheduleView.New()
	}
end

function TabPTEliMyScheduleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return TabPTEliMyScheduleViewPresentor
