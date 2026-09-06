-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpReviveEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpReviveEventViewPresentor", package.seeall)

local ExpReviveEventViewPresentor = class("ExpReviveEventViewPresentor", ViewPresentor)

function ExpReviveEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpReviveEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/expreviveeventview.prefab"
	}
end

function ExpReviveEventViewPresentor:buildViews()
	return {
		ExpReviveEventView.New()
	}
end

return ExpReviveEventViewPresentor
