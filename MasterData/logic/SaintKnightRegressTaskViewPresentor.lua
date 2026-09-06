-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressTaskViewPresentor.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressTaskViewPresentor", package.seeall)

local SaintKnightRegressTaskViewPresentor = class("SaintKnightRegressTaskViewPresentor", ViewPresentor)

function SaintKnightRegressTaskViewPresentor:ctor()
	SaintKnightRegressTaskViewPresentor.super.ctor(self)
end

function SaintKnightRegressTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SaintKnightRegressTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightregress/saintknightregresstaskview.prefab"
	}
end

function SaintKnightRegressTaskViewPresentor:buildViews()
	return {
		SaintKnightRegressTaskView.New()
	}
end

return SaintKnightRegressTaskViewPresentor
