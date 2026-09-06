-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/showdown/ShowDownTaskFrameViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.dragonpsychicclg.DragonPsychicClgNorTaskFrameViewPresentor", package.seeall)

local DragonPsychicClgNorTaskFrameViewPresentor = class("DragonPsychicClgNorTaskFrameViewPresentor", ViewPresentor)

function DragonPsychicClgNorTaskFrameViewPresentor:ctor()
	DragonPsychicClgNorTaskFrameViewPresentor.super.ctor(self)
end

function DragonPsychicClgNorTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonPsychicClgNorTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/showdown/showdowntaskframeview.prefab"
	}
end

function DragonPsychicClgNorTaskFrameViewPresentor:buildViews()
	return {
		DragonPsychicClgNorTaskFrameView.New()
	}
end

return DragonPsychicClgNorTaskFrameViewPresentor
