-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/view/TimedialogueViewPresentor.lua

module("logic.extensions.timecapsule.view.TimedialogueViewPresentor", package.seeall)

local TimedialogueViewPresentor = class("TimedialogueViewPresentor", ViewPresentor)

function TimedialogueViewPresentor:ctor()
	TimedialogueViewPresentor.super.ctor(self)
end

function TimedialogueViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TimedialogueViewPresentor:dependWhatResources()
	return {
		"ui/views/dialogue/dialogueview.prefab"
	}
end

function TimedialogueViewPresentor:buildViews()
	return {
		TimedialogueView.New()
	}
end

return TimedialogueViewPresentor
