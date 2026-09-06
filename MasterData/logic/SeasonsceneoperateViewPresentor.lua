-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonsceneoperateViewPresentor.lua

module("logic.extensions.season.view.SeasonsceneoperateViewPresentor", package.seeall)

local SeasonsceneoperateViewPresentor = class("SeasonsceneoperateViewPresentor", ViewWithGuidePresentor)

function SeasonsceneoperateViewPresentor:ctor()
	SeasonsceneoperateViewPresentor.super.ctor(self)
end

function SeasonsceneoperateViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function SeasonsceneoperateViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonsceneoperateview.prefab"
	}
end

function SeasonsceneoperateViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function SeasonsceneoperateViewPresentor:buildViews()
	return {
		SeasonSceneOperateView.New()
	}
end

return SeasonsceneoperateViewPresentor
