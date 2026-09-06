-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/MakeSnowmanTaskViewPresentor.lua

module("logic.extensions.eventtasksummary.view.MakeSnowmanTaskViewPresentor", package.seeall)

local MakeSnowmanTaskViewPresentor = class("MakeSnowmanTaskViewPresentor", ViewPresentor)

function MakeSnowmanTaskViewPresentor:ctor()
	MakeSnowmanTaskViewPresentor.super.ctor(self)
end

function MakeSnowmanTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MakeSnowmanTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/makesnowman/makesnowmantaskview.prefab"
	}
end

function MakeSnowmanTaskViewPresentor:buildViews()
	return {
		MakeSnowmanTaskView.New()
	}
end

function MakeSnowmanTaskViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MakeSnowmanTaskViewPresentor
