-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpMapEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpMapEventViewPresentor", package.seeall)

local ExpMapEventViewPresentor = class("ExpMapEventViewPresentor", ViewPresentor)

function ExpMapEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpMapEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/expmapeventview.prefab"
	}
end

function ExpMapEventViewPresentor:buildViews()
	return {
		ExpMapEventView.New()
	}
end

return ExpMapEventViewPresentor
