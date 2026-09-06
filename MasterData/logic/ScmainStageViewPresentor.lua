-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/ScmainStageViewPresentor.lua

module("logic.extensions.plotcopy.view.ScmainStageViewPresentor", package.seeall)

local ScmainStageViewPresentor = class("ScmainStageViewPresentor", ViewWithGuidePresentor)

function ScmainStageViewPresentor:ctor()
	ScmainStageViewPresentor.super.ctor(self)
end

function ScmainStageViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ScmainStageViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/scmainstageview.prefab"
	}
end

function ScmainStageViewPresentor:buildViews()
	return {
		ScmainStageView.New()
	}
end

function ScmainStageViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ScmainStageViewPresentor
