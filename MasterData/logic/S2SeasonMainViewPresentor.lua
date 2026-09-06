-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/S2SeasonMainViewPresentor.lua

module("logic.extensions.sendflower.view.S2SeasonMainViewPresentor", package.seeall)

local S2SeasonMainViewPresentor = class("S2SeasonMainViewPresentor", ViewWithGuidePresentor)

function S2SeasonMainViewPresentor:ctor()
	S2SeasonMainViewPresentor.super.ctor(self)
end

function S2SeasonMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function S2SeasonMainViewPresentor:dependWhatResources()
	return {
		"ui/views/season/s2_seasonmainview.prefab"
	}
end

function S2SeasonMainViewPresentor:buildViews()
	return {
		SeasonMainView.New(),
		SeasonTeamsView.New(),
		SeasonS2TopView.New()
	}
end

function S2SeasonMainViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return S2SeasonMainViewPresentor
