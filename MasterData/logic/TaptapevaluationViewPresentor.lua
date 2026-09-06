-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/TaptapevaluationViewPresentor.lua

module("logic.extensions.activitypopup.view.TaptapevaluationViewPresentor", package.seeall)

local TaptapevaluationViewPresentor = class("TaptapevaluationViewPresentor", ViewPresentor)

function TaptapevaluationViewPresentor:ctor()
	TaptapevaluationViewPresentor.super.ctor(self)
end

function TaptapevaluationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TaptapevaluationViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/taptapevaluationview.prefab"
	}
end

function TaptapevaluationViewPresentor:buildViews()
	return {
		TaptapevaluationView.New()
	}
end

return TaptapevaluationViewPresentor
