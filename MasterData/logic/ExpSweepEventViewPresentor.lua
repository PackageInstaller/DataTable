-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpSweepEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpSweepEventViewPresentor", package.seeall)

local ExpSweepEventViewPresentor = class("ExpSweepEventViewPresentor", ViewPresentor)

function ExpSweepEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpSweepEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/exprevivesweepview.prefab"
	}
end

function ExpSweepEventViewPresentor:buildViews()
	return {
		ExpSweepEventView.New()
	}
end

return ExpSweepEventViewPresentor
