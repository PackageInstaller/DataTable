-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpRandomEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpRandomEventViewPresentor", package.seeall)

local ExpRandomEventViewPresentor = class("ExpRandomEventViewPresentor", ViewPresentor)

function ExpRandomEventViewPresentor:ctor()
	ExpRandomEventViewPresentor.super.ctor(self)
end

function ExpRandomEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpRandomEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/randomeventview.prefab"
	}
end

function ExpRandomEventViewPresentor:buildViews()
	return {
		ExpRandomEventView.New()
	}
end

return ExpRandomEventViewPresentor
