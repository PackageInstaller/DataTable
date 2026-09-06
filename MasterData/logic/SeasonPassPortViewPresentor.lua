-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassPortViewPresentor.lua

module("logic.extensions.season.view.SeasonPassPortViewPresentor", package.seeall)

local SeasonPassPortViewPresentor = class("SeasonPassPortViewPresentor", ViewPresentor)

function SeasonPassPortViewPresentor:ctor()
	SeasonPassPortViewPresentor.super.ctor(self)
end

function SeasonPassPortViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonPassPortViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonpassportview.prefab"
	}
end

function SeasonPassPortViewPresentor:buildViews()
	return {
		SeasonPassPortView.New()
	}
end

function SeasonPassPortViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonPassPortViewPresentor
